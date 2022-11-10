import 'dart:convert';

import 'package:countrylist/model/getdata.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Homep_page extends StatefulWidget {
  const Homep_page({Key? key}) : super(key: key);

  @override
  State<Homep_page> createState() => _Homep_pageState();
}

class _Homep_pageState extends State<Homep_page> {
  bool darkmood = false;
  Future<Countrylist> fetchCountry() async {
    final response =
        await http.get(Uri.parse('https://restcountries.com/v3.1/all'));

    if (response.statusCode == 200) {
      print(response.body);
      print("print it ${Countrylist.fromJson(jsonDecode(response.body)).tld}");
      return Countrylist.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load country');
    }
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
                        Text(
                          "EN",
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: darkmood ? Colors.white : Colors.black),
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
                        Text(
                          "Filter",
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: darkmood ? Colors.white : Colors.black),
                        ),
                      ],
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
