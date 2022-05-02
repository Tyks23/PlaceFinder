import 'package:flutter/material.dart';
import 'screens/places_screen.dart';

void main() {

  const primaryColor = Color(0xffd7ae9c);

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

  String _typeValue = "";
  bool _photoValue = false;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PlaceFinder"),
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
            DropdownButton(
              hint: _typeValue.isEmpty
                  ? const Text('Type')
                  : Text(
                _typeValue,
                style: const TextStyle(color: Colors.blue),
              ),
              isExpanded: true,
              iconSize: 30.0,
              style: const TextStyle(color: Colors.blue),
              items: ['Sushi', 'Burger', 'Pizza', "Pasta"].map(
                    (val) {
                  return DropdownMenuItem<String>(
                    value: val,
                    child: Text(val),
                  );
                },
              ).toList(),
              onChanged: (val) {
                setState(
                      () {
                    _typeValue = val.toString();
                  },
                );
              },
            ),
              CheckboxListTile(
                title: const Text("Show place photo"),
                  value: _photoValue,
                  onChanged: (bool? value){
                    setState(() {
                      _photoValue = value!;
                    });
              }),
              ElevatedButton(
                child: const Text('Search'),
                onPressed: () {
                  if(_typeValue.isNotEmpty && locationController.text.isNotEmpty){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  PlacesScreen(location: locationController, category: _typeValue, photo: _photoValue)),
                    );
                  }
                },
              ),
            ],
          ),
        ));
  }
}
