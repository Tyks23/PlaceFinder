import 'package:flutter/material.dart';
import 'screens/places_screen.dart';

void main() {
  runApp(const MaterialApp(
    home: LandingScreen(),
  ));
}

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  _LandingScreen createState() => _LandingScreen();
}

class _LandingScreen extends State<LandingScreen> {


  TextEditingController locationController = TextEditingController();
  TextEditingController categoryController = TextEditingController();


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Place Finder'),
      ),
        body: Container(
          margin: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Column(
            children: [
              TextField(
                controller: locationController,
                decoration: const InputDecoration(
                    hintText: "Location....", labelText: 'Location'),
              ),
              TextField(
                controller: categoryController,
                decoration: const InputDecoration(
                    hintText: "Category....", labelText: 'Category'),
              ),
              ElevatedButton(
                child: const Text('Find restos'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  PlacesScreen(location: locationController, category: categoryController)),
                  );
                },
              ),
            ],
          ),
        ));
  }
}
