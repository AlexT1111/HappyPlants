import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'plant.dart';
import 'plant_details_screen.dart';

/// Creates Plants by Location page of Happy Plants App, navigated to by selectable region on Home screen.
class PlantsByLocationScreen extends StatelessWidget {
  final String? selectedContinent;
  final Future<List<Plant>> plantsList = fetchPlants();

  PlantsByLocationScreen({this.selectedContinent});

  // Designs page to display plants filtered by app user location selection made on My Location page.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Plants by Location')),
      body: Column(
        children: [
          // Display app user location selection.
          if (selectedContinent != null && selectedContinent!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Your Location: $selectedContinent',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          // Request app user selection in My Location page to develop results.
          if (selectedContinent == null || selectedContinent!.isEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Please enter a continent in the My Location tab.',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
            ),
          // Display filtered plant results based on app user location selection in My Location page.
          if (selectedContinent != null && selectedContinent!.isNotEmpty)
            Expanded(
              child: FutureBuilder<List<Plant>>(
                future: plantsList,
                builder: (context, snapshot) {
                  // Provide results whether or not applicable for app user location selection.
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No plants found.'));
                  } else {
                    final filteredPlants = filterPlantsByLocation(
                        snapshot.data!, selectedContinent!);
                    return ListView.builder(
                      itemCount: filteredPlants.length,
                      itemBuilder: (context, index) {
                        final plant = filteredPlants[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PlantDetailsScreen(plant: plant),
                              ),
                            );
                          },
                          child: ListTile(
                            title: Text(plant.commonName),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
        ],
      ),
    );
  }
}

/// Filter  and return resultant plants based on app user selection on My Location page.
List<Plant> filterPlantsByLocation(
    List<Plant> plants, String selectedContinent) {
  final normalizedSelectedContinent =
      selectedContinent.replaceAll(' ', '').toLowerCase();

  return plants.where((plant) {
    final normalizedNativeContinent =
        plant.nativeContinent.replaceAll(' ', '').toLowerCase();
    return normalizedNativeContinent.contains(normalizedSelectedContinent);
  }).toList();
}

/// Attain plant details from .json assets file.
Future<List<Plant>> fetchPlants() async {
  final String response =
      await rootBundle.loadString('assets/HAPPYPLANTS.plants.json');
  final List<dynamic> data = json.decode(response);
  return data.map((json) => Plant.fromJson(json)).toList();
}
