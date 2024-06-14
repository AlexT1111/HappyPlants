import 'package:flutter/material.dart';

/// Declares MyLocationScreen state.
class MyLocationScreen extends StatefulWidget {
  @override
  MyLocationScreenState createState() => MyLocationScreenState();
}

/// Creates My Location page of Happy Plants App, navigated to by selectable region on Home screen.
class MyLocationScreenState extends State<MyLocationScreen> {
  // Provides list of general continent selections.
  final List<String> continents = [
    'Africa',
    'Asia',
    'Europe',
    'North America',
    'Oceania',
    'South America'
  ];
  // Initialize location selection.
  String selectedContinent = '';

  /// Designs My Location screen with location selections for app user to provide input.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Location')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: continents.map((continent) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              // Saves app user location selection.
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedContinent = continent;
                  });
                  Navigator.pop(context, continent);
                },
                style: ElevatedButton.styleFrom(
                  primary: selectedContinent == continent ? Colors.green : null,
                  minimumSize: Size(300, 60),
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                ),
                child: Text(
                  continent,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
