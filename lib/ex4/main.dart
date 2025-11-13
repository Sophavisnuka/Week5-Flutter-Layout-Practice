import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

void main () {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MyApp(), // Wrap your app
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Colors.blue,
          title: Text('Weather App', style: TextStyle(color: Colors.white)),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: IconButton(
                icon: Icon(Icons.menu, color: Colors.white),
                iconSize: 30,
                onPressed: () {},
                // Text("Press me"),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              WeatherCard(weather: WeatherCondition.sunny, startColor: Colors.purple, endColor: Colors.deepPurple),
              WeatherCard(weather: WeatherCondition.cloudy, startColor: Colors.green, endColor: Colors.lightGreen),
              WeatherCard(weather: WeatherCondition.rainy, startColor: Colors.red, endColor: const Color.fromARGB(255, 202, 13, 0)),
              WeatherCard(weather: WeatherCondition.snowy, startColor: Colors.yellow, endColor: const Color.fromARGB(255, 255, 149, 0)),
            ],
          ),
        ),
      ),
    );
  }
}

enum WeatherCondition {
  sunny('Phnom Penh', 'Min 10.0°C', 'Max 30.0°C', '12.2°C' ,'../../assets/ex4/cloudy.png'),
  cloudy('Paris', 'Min 10.0°C', 'Max 40.0°C', '22.2°C' ,'../../assets/ex4/sunnyCloudy.png'),
  rainy('Rome', 'Min 10.0°C', 'Max 40.0°C', '45.2°C' ,'../../assets/ex4/sunny.png'),
  snowy('Toulouse', 'Min 10.0°C', 'Max 40.0°C', '45.2°C' ,'../../assets/ex4/veryCloudy.png');

  final String cityName;
  final String minTemp;
  final String maxTemp;
  final String currentTemp;
  final String imageUrl;

  const WeatherCondition(
    this.cityName,
    this.minTemp,
    this.maxTemp,
    this.currentTemp,
    this.imageUrl,
  );
}

class WeatherCard extends StatelessWidget {

  final WeatherCondition weather;
  final Color startColor;
  final Color endColor;
  
  const WeatherCard({
    super.key,
    required this.weather,
    required this.startColor,
    required this.endColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: PhysicalModel(
        color: Colors.transparent,
        shadowColor: Colors.black,
        elevation: 8,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                colors: [startColor, endColor],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(weather.imageUrl),
                      radius: 25,
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(weather.cityName, style: TextStyle(fontSize: 20, color: Colors.white)),
                        Text(weather.minTemp, style: TextStyle(fontSize: 10, color: Colors.white)),
                        Text(weather.maxTemp, style: TextStyle(fontSize: 10, color: Colors.white)),
                      ],
                    ),
                  ],
                ),
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      right: -35,
                      child: Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.2),
                        ),
                      ),
                    ),
                    Text(weather.currentTemp, style: TextStyle(fontSize: 30, color: Colors.white)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}