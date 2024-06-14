import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cis350/plant.dart'; // Replace with actual import path
import 'package:cis350/plant_details_screen.dart'; // Replace with actual import path

void main() {
  testWidgets('PlantDetailsScreen widget test', (WidgetTester tester) async {
    // Mock Plant object with sample data
    Plant testPlant = Plant(
      commonName: 'Sunflower',
      scientificName: 'Helianthus annuus',
      family: 'Asteraceae',
      plantType: 'Annual',
      matureSize: '3-10 feet tall',
      sunNeeds: 'Full Sun',
      soilNeeds: 'Well-drained soil',
      waterNeeds: 'Regular watering',
      flowerColor: 'Yellow',
      idealTemperature: '70-85°F (21-29°C)',
      nativeContinent: 'North America',
      toxicity: 'Non-toxic',
      notes: 'One of the most popular garden flowers.',
    );

    // Build PlantDetailsScreen widget with mock data
    await tester.pumpWidget(MaterialApp(
      home: PlantDetailsScreen(plant: testPlant),
    ));

    // Await a frame after pumping the widget
    await tester.pump();

    // Verify if the widget renders correctly
    expect(find.text('Sunflower'), findsOneWidget); // Check for common name
    expect(find.text('Helianthus annuus'),
        findsOneWidget); // Check for scientific name
    expect(find.text('Family: Asteraceae'), findsOneWidget); // Check for family
    expect(find.text('Plant Type: Annual'),
        findsOneWidget); // Check for plant type
    expect(find.text('Mature Size: 3-10 feet tall'),
        findsOneWidget); // Check for mature size
    expect(find.text('Sun Needs: Full Sun'),
        findsOneWidget); // Check for sun needs
    expect(find.text('Soil Needs: Well-drained soil'),
        findsOneWidget); // Check for soil needs
    expect(find.text('Water Needs: Regular watering'),
        findsOneWidget); // Check for water needs
    expect(find.text('Flower Color: Yellow'),
        findsOneWidget); // Check for flower color
    expect(find.text('Ideal Temperature: 70-85°F (21-29°C)'),
        findsOneWidget); // Check for ideal temperature
    expect(find.text('Native Continent: North America'),
        findsOneWidget); // Check for native continent
    expect(
        find.text('Toxicity: Non-toxic'), findsOneWidget); // Check for toxicity
    expect(find.text('Notes: One of the most popular garden flowers.'),
        findsOneWidget); // Check for notes
  });
}
