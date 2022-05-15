import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  String _typeValue = "";

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    var primaryColor = const Color(0xffd7ae9c);
    var buttonColor = const Color(0xff795548);
    return Scaffold(
        backgroundColor: primaryColor,
        body: Container(
          margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 50.00),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 50.0),
                child: const Text('PlaceFinder',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: '',
                      fontSize: 42,
                    )),
              ),
              TextField(
                controller: locationController,
                decoration: const InputDecoration(
                  labelText: 'Location',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors
                        .white, //background color of dropdown button//border of dropdown button
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: DropdownButton(
                    hint: _typeValue.isEmpty
                        ? const Text('Type')
                        : Text(
                            _typeValue,
                            style: const TextStyle(color: Colors.black),
                          ),
                    isExpanded: true,
                    icon: const Icon(Icons.keyboard_arrow_down,
                        color: Colors.grey),
                    iconSize: 30.0,
                    style: const TextStyle(color: Colors.black),
                    items: [
                      'Buffet',
                      'Burger',
                      'Fusion',
                      'Kebab',
                      'Pasta',
                      'Pizza',
                      'Sushi',
                      'Tapas'
                    ].map(
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
                ),
              ),

              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(buttonColor),
                  fixedSize: MaterialStateProperty.all(const Size(160, 46)),
                ),
                child: const Text(
                  'Search',
                  style: TextStyle(fontSize: 24),
                ),
                onPressed: () {
                  if (_typeValue.isNotEmpty &&
                      locationController.text.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PlacesScreen(
                              location: locationController,
                              category: _typeValue,
                             )),
                    );
                  }
                },
              ),
            ],
          ),
        ));
  }
}
