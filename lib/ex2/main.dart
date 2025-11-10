import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

enum ButtonType { primary, secondary, disabled }
enum IconPosition { left, right }

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
          title: const Text('Custom Buttons')
        ),
        body: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomButton(icon: Icons.check, label: 'Submit', type: ButtonType.primary),
              CustomButton(icon: Icons.timelapse, label: 'Time', type: ButtonType.secondary),
              CustomButton(icon: Icons.account_tree, label: 'Account', type: ButtonType.disabled, position: IconPosition.right),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final ButtonType type;
  final IconPosition? position;

  const CustomButton({
    super.key,
    required this.icon,
    required this.label,
    required this.type,
    this.position = IconPosition.left,
  });

  // helper to get color based on button type
  Color getButtonColor() {
    switch (type) {
      case ButtonType.primary:
        return Colors.blue;
      case ButtonType.secondary:
        return Colors.green;
      case ButtonType.disabled:
        return Colors.grey;
    }
  }
  // helper method to build the row children
  List<Widget> rowPosition () {
    final iconWidget = Icon(icon, size: 30, color: Colors.white);
    final textWidget = Text(label, style: TextStyle(color: Colors.white, fontSize: 20));
    final spacing = SizedBox(width: 10);
    if (position == IconPosition.left) {
      return [iconWidget, spacing, textWidget];
    } else {
      return [textWidget, spacing, iconWidget];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: getButtonColor(),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: rowPosition(),
      ),
    );
  }
}