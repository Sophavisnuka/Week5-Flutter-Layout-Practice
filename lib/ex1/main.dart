import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

void main() {
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
          title: const Text('My Hobbies', 
            style: TextStyle(
              color: Colors.white
              )
            ),
          backgroundColor: Colors.red,
        ),
        body: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              HobbyCard(icon: Icons.travel_explore, title: 'Traveling'),
              HobbyCard(icon: Icons.skateboarding, title: 'Skating', backgroundColor: Colors.green)
            ],
          ),
        ),
      ),
    );
  }
}

class HobbyCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color? backgroundColor;

  const HobbyCard({
    super.key,
    required this.icon,
    required this.title,
    this.backgroundColor = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: backgroundColor,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 50,
            color: Colors.white,
          ),
          SizedBox(width: 20),
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}