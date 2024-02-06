import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
              height: 400,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/82143.jpg')),
              )),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Welcome to Your App",
                  style: TextStyle(
                    color: Color.fromARGB(255, 21, 195, 243),
                    fontSize: 35,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Gap(20),
                const Text(
                  "Your Weather App provides real-time weather updates and forecasts. Stay informed about the current temperature, weather conditions, humidity, and wind speed. Plan your day with accurate weather data at your fingertips.",
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Color.fromARGB(255, 86, 86, 86)),
                ),
                const Gap(30),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                      Color.fromARGB(255, 0, 191, 244),
                    )),
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Tap to Login",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          Gap(10),
                          Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.white,
                            size: 15,
                          )
                        ],
                      ),
                    ),
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
