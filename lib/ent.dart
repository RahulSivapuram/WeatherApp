import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weatherapp/home.dart';

class Ent extends StatelessWidget {
  const Ent({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.blue),
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width / 1.5,
            child: Image.asset(
              "lib/assets/weather.png",
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(
            height: 190,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => Home(),
                ),
              );
            },
            child: Container(
              height: 50,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Text(
                  "Get Started",
                  style: GoogleFonts.poppins(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
