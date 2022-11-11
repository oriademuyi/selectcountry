import 'dart:convert';

import 'package:countrylist/model/getdata.dart';
import 'package:countrylist/screen/detailsPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class Homep_page extends StatefulWidget {
  const Homep_page({Key? key}) : super(key: key);

  @override
  State<Homep_page> createState() => _Homep_pageState();
}

class _Homep_pageState extends State<Homep_page> {
  bool opencontinent = false;
  bool opentimezone = false;
  bool darkmood = false;
  bool checkbocliked = false;
  bool checkbocliked1 = false;
  bool checkbocliked2 = false;
  bool checkbocliked3 = false;
  bool checkbocliked4 = false;
  bool checkbocliked5 = false;
  bool checkbocliked6 = false;
  bool checkbocliked7 = false;
  List<Countrylist>? countries;

  fetchCountry() async {
    final response =
        await http.get(Uri.parse('https://restcountries.com/v3.1/all'));

    if (response.statusCode == 200) {
      print(response.body);
      var county_name = countrylistFromJson(response.body);
      setState(() {
        countries = county_name;
        countries!
            .sort((a, b) => a.name!.official!.compareTo(b.name!.official!));
      });
      // return county_name;
      // return Countrylist.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load country');
    }
  }

  @override
  void initState() {
    fetchCountry();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkmood ? Color(0xFF020F24) : Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/backgorund.jpg',
                  height: 80,
                  width: 100,
                ),
                IconButton(
                    onPressed: () {
                      fetchCountry();
                      setState(() {
                        darkmood = !darkmood;
                      });
                    },
                    icon: Icon(
                      darkmood ? Icons.dark_mode : Icons.wb_sunny,
                      color: darkmood ? Colors.white : Colors.black,
                    )),
              ],
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              color: darkmood ? Color(0xFF1E2C41) : Color(0xFFF2F4F7),
              height: 50.0,
              child: Row(
                children: <Widget>[
                  Flexible(
                    flex: 2,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 11.0),
                      decoration: InputDecoration(
                          contentPadding:
                              new EdgeInsets.symmetric(vertical: 0.0),
                          border: InputBorder.none,
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(0.0),
                            child: Icon(
                              Icons.search,
                              color: Color(0xFF77808D),
                            ),
                          ),
                          hintText: 'Search Country',
                          hintStyle: TextStyle(
                              fontSize: 15.0, color: Color(0xFF77808D))),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade200)),
                    child: Row(
                      children: [
                        Icon(Icons.language,
                            color: darkmood ? Colors.white : Colors.black),
                        SizedBox(width: 10),
                        InkWell(
                          onTap: () {
                            fetchCountry();
                          },
                          child: Text(
                            "EN",
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: darkmood ? Colors.white : Colors.black),
                          ),
                        ),
                      ],
                    )),
                Container(
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade200)),
                  child: Row(
                    children: [
                      Icon(Icons.filter_alt_outlined,
                          color: darkmood ? Colors.white : Colors.black),
                      SizedBox(width: 10),
                      InkWell(
                        onTap: () {
                          showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return StatefulBuilder(builder:
                                  (BuildContext context,
                                      StateSetter
                                          setState /*You can rename this!*/) {
                                return Container(
                                  height:
                                      opencontinent || opentimezone ? 800 : 250,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: Colors.white,
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Filters',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  opentimezone = false;
                                                  opencontinent = false;
                                                },
                                                child: Icon(
                                                  Icons.cancel,
                                                  color: Colors.grey,
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(height: 15),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Continent',
                                                style: TextStyle(
                                                    fontWeight: opencontinent
                                                        ? FontWeight.bold
                                                        : FontWeight.normal),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    opencontinent =
                                                        !opencontinent;
                                                    opentimezone = false;
                                                  });
                                                },
                                                child: Icon(
                                                  opencontinent
                                                      ? Icons.expand_less
                                                      : Icons.expand_more,
                                                  color: Colors.grey,
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(height: 15),
                                          opencontinent
                                              ? Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("Africa"),
                                                        InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              checkbocliked =
                                                                  !checkbocliked;
                                                            });
                                                          },
                                                          child: Icon(
                                                            checkbocliked
                                                                ? Icons
                                                                    .check_box_rounded
                                                                : Icons
                                                                    .check_box_outline_blank,
                                                            color: checkbocliked
                                                                ? Colors.black
                                                                : Colors.grey,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 12),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("Antarctica"),
                                                        InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              checkbocliked1 =
                                                                  !checkbocliked1;
                                                            });
                                                          },
                                                          child: Icon(
                                                            checkbocliked1
                                                                ? Icons
                                                                    .check_box_rounded
                                                                : Icons
                                                                    .check_box_outline_blank,
                                                            color:
                                                                checkbocliked1
                                                                    ? Colors
                                                                        .black
                                                                    : Colors
                                                                        .grey,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 12),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("Asia"),
                                                        InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              checkbocliked2 =
                                                                  !checkbocliked2;
                                                            });
                                                          },
                                                          child: Icon(
                                                            checkbocliked2
                                                                ? Icons
                                                                    .check_box_rounded
                                                                : Icons
                                                                    .check_box_outline_blank,
                                                            color:
                                                                checkbocliked2
                                                                    ? Colors
                                                                        .black
                                                                    : Colors
                                                                        .grey,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 12),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("Australia"),
                                                        InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              checkbocliked3 =
                                                                  !checkbocliked;
                                                            });
                                                          },
                                                          child: Icon(
                                                            checkbocliked3
                                                                ? Icons
                                                                    .check_box_rounded
                                                                : Icons
                                                                    .check_box_outline_blank,
                                                            color:
                                                                checkbocliked3
                                                                    ? Colors
                                                                        .black
                                                                    : Colors
                                                                        .grey,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 12),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("Europe"),
                                                        InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              checkbocliked4 =
                                                                  !checkbocliked4;
                                                            });
                                                          },
                                                          child: Icon(
                                                            checkbocliked4
                                                                ? Icons
                                                                    .check_box_rounded
                                                                : Icons
                                                                    .check_box_outline_blank,
                                                            color:
                                                                checkbocliked4
                                                                    ? Colors
                                                                        .black
                                                                    : Colors
                                                                        .grey,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 12),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("North America"),
                                                        InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              checkbocliked5 =
                                                                  !checkbocliked5;
                                                            });
                                                          },
                                                          child: Icon(
                                                            checkbocliked5
                                                                ? Icons
                                                                    .check_box_rounded
                                                                : Icons
                                                                    .check_box_outline_blank,
                                                            color:
                                                                checkbocliked5
                                                                    ? Colors
                                                                        .black
                                                                    : Colors
                                                                        .grey,
                                                          ),
                                                        ),
                                                      ],
                                                    ),

                                                    // Row(
                                                    //   mainAxisAlignment:
                                                    //       MainAxisAlignment
                                                    //           .spaceBetween,
                                                    //   children: [
                                                    //     Text("South America"),
                                                    //     InkWell(
                                                    //       onTap: () {
                                                    //         setState(() {
                                                    //           checkbocliked6 =
                                                    //               !checkbocliked6;
                                                    //         });
                                                    //       },
                                                    //       child: Icon(
                                                    //         checkbocliked6
                                                    //             ? Icons
                                                    //                 .check_box_rounded
                                                    //             : Icons
                                                    //                 .check_box_outline_blank,
                                                    //         color:
                                                    //             checkbocliked6
                                                    //                 ? Colors
                                                    //                     .black
                                                    //                 : Colors
                                                    //                     .grey,
                                                    //       ),
                                                    //     ),
                                                    //   ],
                                                    // ),
                                                  ],
                                                )
                                              : Container(),
                                          SizedBox(height: 20),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'TimeZone',
                                                style: TextStyle(
                                                    fontWeight: opentimezone
                                                        ? FontWeight.bold
                                                        : FontWeight.normal),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    opentimezone =
                                                        !opentimezone;
                                                    opencontinent = false;
                                                  });
                                                },
                                                child: Icon(
                                                  opentimezone
                                                      ? Icons.expand_less
                                                      : Icons.expand_more,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          opentimezone
                                              ? Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("GMT+1:00"),
                                                        InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              checkbocliked =
                                                                  !checkbocliked;
                                                            });
                                                          },
                                                          child: Icon(
                                                            checkbocliked
                                                                ? Icons
                                                                    .check_box_rounded
                                                                : Icons
                                                                    .check_box_outline_blank,
                                                            color: checkbocliked
                                                                ? Colors.black
                                                                : Colors.grey,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 12),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("GMT+2:00"),
                                                        InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              checkbocliked1 =
                                                                  !checkbocliked1;
                                                            });
                                                          },
                                                          child: Icon(
                                                            checkbocliked1
                                                                ? Icons
                                                                    .check_box_rounded
                                                                : Icons
                                                                    .check_box_outline_blank,
                                                            color:
                                                                checkbocliked1
                                                                    ? Colors
                                                                        .black
                                                                    : Colors
                                                                        .grey,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 12),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("GMT+3:00"),
                                                        InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              checkbocliked2 =
                                                                  !checkbocliked2;
                                                            });
                                                          },
                                                          child: Icon(
                                                            checkbocliked2
                                                                ? Icons
                                                                    .check_box_rounded
                                                                : Icons
                                                                    .check_box_outline_blank,
                                                            color:
                                                                checkbocliked2
                                                                    ? Colors
                                                                        .black
                                                                    : Colors
                                                                        .grey,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 12),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("GMT+4:00"),
                                                        InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              checkbocliked3 =
                                                                  !checkbocliked;
                                                            });
                                                          },
                                                          child: Icon(
                                                            checkbocliked3
                                                                ? Icons
                                                                    .check_box_rounded
                                                                : Icons
                                                                    .check_box_outline_blank,
                                                            color:
                                                                checkbocliked3
                                                                    ? Colors
                                                                        .black
                                                                    : Colors
                                                                        .grey,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 12),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("GMT+5:00"),
                                                        InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              checkbocliked4 =
                                                                  !checkbocliked4;
                                                            });
                                                          },
                                                          child: Icon(
                                                            checkbocliked4
                                                                ? Icons
                                                                    .check_box_rounded
                                                                : Icons
                                                                    .check_box_outline_blank,
                                                            color:
                                                                checkbocliked4
                                                                    ? Colors
                                                                        .black
                                                                    : Colors
                                                                        .grey,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              : Container(),
                                          SizedBox(height: 20),
                                          opencontinent || opentimezone
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 20,
                                                                right: 20,
                                                                top: 10,
                                                                bottom: 10),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5)),
                                                          border: Border.all(
                                                              width: 1,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        child: Text("Rest")),
                                                    Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 20,
                                                                right: 20,
                                                                top: 10,
                                                                bottom: 10),
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xffF66C03),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5)),
                                                          border: Border.all(
                                                              width: 1,
                                                              color: Color(
                                                                  0xffF66C03)),
                                                        ),
                                                        child: Text(
                                                            "Show Result")),
                                                  ],
                                                )
                                              : Container()
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                            },
                          );
                        },
                        child: Text(
                          "Filter",
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: darkmood ? Colors.white : Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(itemBuilder: (context, index) {
                return ListTile(
                  title: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => countDetails(
                                name: countries![index].name!.official!,
                                population:
                                    countries![index].population.toString(),
                                region: countries![index].region.toString(),
                                capital: countries![index].capital.toString(),
                                motto: countries![index].demonyms.toString(),
                                officaillabuage:
                                    countries![index].languages.toString(),
                                ethicgroup: countries![index].subregion,
                                relgion: countries![index].region.toString(),
                                government: countries![index].status.toString(),
                                independece:
                                    countries![index].independent.toString(),
                                area: countries![index].area.toString(),
                                currency:
                                    countries![index].currencies.toString(),
                                GDP: countries![index].gini.toString(),
                                timezone:
                                    countries![index].timezones.toString(),
                                dateformat: countries![index].cca2.toString(),
                                dailingcode: countries![index].cca3,
                                drivingside: countries![index].ccn3,
                                data: countries![index].flags!.png!),
                          ));
                      print(countries![index].name!.official!);
                      print(countries![index].population);
                      print(countries![index].region);
                      print(countries![index].capital);
                      print(countries![index].languages);
                      print(countries![index]);
                      print(
                        countries![index].flags!.png!,
                      );
                    },
                    child: Text(
                      countries![index].name!.official!,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: darkmood ? Colors.white : Colors.black),
                    ),
                  ),
                  subtitle: Text(
                      countries![index].capital!.isEmpty
                          ? ""
                          : countries![index].capital![0],
                      style: TextStyle(
                          fontSize: 12,
                          color: darkmood ? Colors.white : Colors.grey)),
                  leading: Container(
                      // decoration: BoxDecoration(
                      //   borderRadius: BorderRadius.circular(1000),
                      // ),
                      width: 40,
                      child: Image.network(
                        countries![index].flags!.png!,
                      )),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
