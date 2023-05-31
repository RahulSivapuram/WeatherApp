import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;
import 'package:weatherapp/wmodel.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController input = TextEditingController();
  WeatherModel? ref;
  bool _isloading = false;
  @override
  Widget build(BuildContext context) {
    late var n = ref!.main!.temp ?? 0;
    return Material(
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.black,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: MediaQuery.of(context).size.width / 1.1,
                  child: TextField(
                    controller: input,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 131, 36, 67)),
                  onPressed: () async {
                    setState(() {
                      _isloading = true;
                    });
                    ref = await get(input.text);
                    setState(() {
                      _isloading = false;
                    });
                    print(ref!.main!.temp);
                  },
                  child: _isloading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          "Submit",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),

          //

          //
          Container(
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Stack(
              children: [
                /*
                n > 100
                    ? Image.asset(
                        "lib/assets/summer.jpg",
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        "lib/assets/normal.jpg",
                        fit: BoxFit.cover,
                      ),
                    */
                //
                //
                Positioned(
                  top: 50,
                  right: 340,
                  child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.red,
                      )),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 200, right: 150, left: 10),
                  child: Text(
                    "${ref?.main?.temp ?? "error"} F",
                    style: GoogleFonts.poppins(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 50),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

get(String? input) async {
  var url =
      "https://api.openweathermap.org/data/2.5/weather?q=$input&APPID=43ea6baaad7663dc17637e22ee6f78f2";

  final result = await http.get(Uri.parse(url));
  var resultbody = result.body;
  try {
    if (result.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(resultbody));
    }
  } catch (e) {
    throw Exception();
  }
}
