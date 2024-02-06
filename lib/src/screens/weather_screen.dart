import 'package:flutter/material.dart';
import 'package:weather_app/src/models/weather_data.dart';
import 'package:weather_app/src/services/toggle_data.dart';
import 'package:weather_app/src/services/weather_api.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  bool showInCelsius = false;
  late Future<Daily> futureDaily;
  late ToggleDatabase toggleDatabase;

  @override
  void initState() {
    super.initState();
    toggleDatabase = ToggleDatabase();
    toggleDatabase.initDatabase();
    futureDaily = WeatherApi().fetchDailyWeather();

    _loadToggleState();
  }

  void _loadToggleState() async {
    await toggleDatabase.initDatabase();
    bool savedToggleState = await toggleDatabase.getToggleState();
    setState(() {
      showInCelsius = savedToggleState;
    });
  }

  void _saveToggleState() async {
    await toggleDatabase.initDatabase();
    await toggleDatabase.saveToggleState(showInCelsius);
  }

  onLogoutPressed() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        surfaceTintColor: Colors.black,
        backgroundColor: Colors.white,
        title: const Text('Are you sure want to Logout?'),
        content: const Text('You want to login after you logot from the page'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Color.fromARGB(255, 203, 16, 3)),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, "/welcome"),
            child: const Text(
              'Log Out',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Weather Details"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            Switch(
              activeColor: Colors.blueAccent,
              value: showInCelsius,
              onChanged: (val) {
                setState(() {
                  showInCelsius = val;
                  _saveToggleState();
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: onLogoutPressed,
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () {
            return futureDaily;
          },
          child: FutureBuilder<Daily>(
            future: futureDaily,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('No Data available'));
              } else if (!snapshot.hasData) {
                return const Center(child: Text('No data available'));
              } else {
                Daily daily = snapshot.data!;

                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          child: Column(
                            children: [
                              Text(
                                showInCelsius
                                    ? '${daily.temperature}°C'
                                    : '${_celsiusToFahrenheit(daily.temperature)}°F',
                                style: const TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 28, 157, 221)),
                              ),
                              Text(
                                "Pressure:${daily.pressure}",
                                style: const TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueGrey),
                              ),
                              Text(
                                "Humidity:${daily.humidity}",
                                style: const TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueGrey),
                              ),
                              Text(
                                "Clouds:${daily.clouds}",
                                style: const TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueGrey),
                              ),
                              Text(
                                "Wind speed:${daily.windSpeed}",
                                style: const TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueGrey),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }
            },
          ),
        ));
  }

  double _celsiusToFahrenheit(double celsius) {
    return (celsius * 9 / 5) + 32;
  }
}
