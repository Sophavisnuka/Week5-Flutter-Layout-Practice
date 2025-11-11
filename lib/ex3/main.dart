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
        backgroundColor: Colors.blue,
        appBar: AppBar(
          centerTitle: false,
          title: const Text('Products')
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CardComponent(product: Product.dart),
              CardComponent(product: Product.flutter),
              CardComponent(product: Product.firebase),
            ],
          ),
        ),
      ),
    );
  }
}

enum Product {
  dart('Dart', '../../assets/ex3/dart.png', 'The best object language'),
  flutter('Flutter', '../../assets/ex3/flutter.png', 'The best mobile widget library'),
  firebase('Firebase', '../../assets/ex3/firebase.png', 'The best cloud database');

  final String title;
  final String description;
  final String imageUrl;

  const Product(
    this.title, 
    this.imageUrl, 
    this.description
  );
}

class CardComponent extends StatelessWidget {
  
  final Product product;

  const CardComponent({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              product.imageUrl,
              width: 50,
            ),
            Text(
              product.title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(product.description),
          ],
        ),
      )
    );
  }
}