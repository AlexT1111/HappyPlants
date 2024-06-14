import 'package:flutter/material.dart';
import 'plant.dart';

/// Creates page that displays selected plant's details.
class PlantDetailsScreen extends StatelessWidget {
  final Plant plant;

  const PlantDetailsScreen({Key? key, required this.plant}) : super(key: key);

  /// Designs individual plant detail's screen, with plant name title bar and organized associated details.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(plant.commonName),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Scientific Name: ${plant.scientificName}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text('Family: ${plant.family}'),
            SizedBox(height: 8.0),
            Text('Plant Type: ${plant.plantType}'),
            SizedBox(height: 8.0),
            Text('Mature Size: ${plant.matureSize}'),
            SizedBox(height: 8.0),
            Text('Sun Needs: ${plant.sunNeeds}'),
            SizedBox(height: 8.0),
            Text('Soil Needs: ${plant.soilNeeds}'),
            SizedBox(height: 8.0),
            Text('Water Needs: ${plant.waterNeeds}'),
            SizedBox(height: 8.0),
            Text('Flower Color: ${plant.flowerColor}'),
            SizedBox(height: 8.0),
            Text('Ideal Temperature: ${plant.idealTemperature}'),
            SizedBox(height: 8.0),
            Text('Native Continent: ${plant.nativeContinent}'),
            SizedBox(height: 8.0),
            Text('Toxicity: ${plant.toxicity}'),
            SizedBox(height: 8.0),
            Text('Notes: ${plant.notes}'),
          ],
        ),
      ),
    );
  }
}
