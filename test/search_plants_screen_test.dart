import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cis350/plant.dart'; // Adjust import path as per your project
import 'package:cis350/plant_details_screen.dart'; // Adjust import path as per your project
import 'package:cis350/search_plants_screen.dart'; // Adjust import path as per your project

void main() {
  group('SearchPlantsScreen', () {
    // Mocking rootBundle for tests
    setUpAll(() {
      TestWidgetsFlutterBinding.ensureInitialized();
      // Mock rootBundle responses for the test
      const MethodChannel('plugins.flutter.io/path_provider')
          .setMockMethodCallHandler((MethodCall methodCall) async {
        return '.';
      });
      const MethodChannel('plugins.flutter.io/assets')
          .setMockMethodCallHandler((MethodCall methodCall) async {
        return ByteData.sublistView(Uint8List.fromList(utf8.encode('[]')));
      });
    });

    testWidgets('fetchPlants should populate plantList',
        (WidgetTester tester) async {
      // Mocking the JSON response
      final List<dynamic> mockPlantsJson = [
        {
          'commonName': 'Sunflower',
          'scientificName': 'Helianthus annuus',
          'family': 'Asteraceae',
          'plantType': 'Annual',
          'matureSize': 'Up to 3m tall',
          'sunNeeds': 'Full Sun',
          'soilNeeds': 'Well-drained',
          'waterNeeds': 'Regular',
          'flowerColor': 'Yellow',
          'idealTemperature': '70-85°F',
          'nativeContinent': 'North America',
          'toxicity': 'Non-toxic',
          'notes': 'Attracts bees and butterflies.'
        },
        // Add more mock plants as needed
      ];

      // Mock the rootBundle loadString method to return the mock data
      const MethodChannel('plugins.flutter.io/assets')
          .setMockMethodCallHandler((MethodCall methodCall) async {
        return json.encode(mockPlantsJson);
      });

      // Set up the SearchPlantsScreen
      await tester.pumpWidget(MaterialApp(
        home: SearchPlantsScreen(),
      ));

      // Trigger the fetchPlants method
      final searchPlantsState = tester
          .state<SearchPlantsScreenState>(find.byType(SearchPlantsScreenState));
      await searchPlantsState.fetchPlants();

      // Verify that the _plantList is populated
      expect(searchPlantsState.plantList.length, mockPlantsJson.length);
    });

    testWidgets('Filtering should update filteredList',
        (WidgetTester tester) async {
      final List<Plant> mockPlants = [
        Plant(
          commonName: 'Sunflower',
          scientificName: 'Helianthus annuus',
          family: 'Asteraceae',
          plantType: 'Annual',
          matureSize: 'Up to 3m tall',
          sunNeeds: 'Full Sun',
          soilNeeds: 'Well-drained',
          waterNeeds: 'Regular',
          flowerColor: 'Yellow',
          idealTemperature: '70-85°F',
          nativeContinent: 'North America',
          toxicity: 'Non-toxic',
          notes: 'Attracts bees and butterflies.',
        ),
        // Add more mock plants as needed
      ];

      await tester.pumpWidget(MaterialApp(
        home: SearchPlantsScreen(),
      ));

      final searchPlantsState = tester
          .state<SearchPlantsScreenState>(find.byType(SearchPlantsScreenState));

      // Set the _plantList in the state
      searchPlantsState.setState(() {
        searchPlantsState.plantList = mockPlants;
        searchPlantsState.filteredList = mockPlants;
      });

      // Trigger the filtering with a search text
      await tester.enterText(find.byType(TextField), 'sunflower');
      await tester.pump();

      // Verify that _filteredList is updated
      expect(searchPlantsState.filteredList.length, 1);
      expect(searchPlantsState.filteredList.first.commonName, 'Sunflower');
    });

    testWidgets('Navigation to PlantDetailsScreen',
        (WidgetTester tester) async {
      final List<Plant> mockPlants = [
        Plant(
          commonName: 'Sunflower',
          scientificName: 'Helianthus annuus',
          family: 'Asteraceae',
          plantType: 'Annual',
          matureSize: 'Up to 3m tall',
          sunNeeds: 'Full Sun',
          soilNeeds: 'Well-drained',
          waterNeeds: 'Regular',
          flowerColor: 'Yellow',
          idealTemperature: '70-85°F',
          nativeContinent: 'North America',
          toxicity: 'Non-toxic',
          notes: 'Attracts bees and butterflies.',
        ),
        // Add more mock plants as needed
      ];

      await tester.pumpWidget(MaterialApp(
        home: SearchPlantsScreen(),
      ));

      final searchPlantsState = tester
          .state<SearchPlantsScreenState>(find.byType(SearchPlantsScreenState));

      // Set the _plantList in the state
      searchPlantsState.setState(() {
        searchPlantsState.plantList = mockPlants;
        searchPlantsState.filteredList = mockPlants;
      });

      // Tap on the ListTile to navigate to PlantDetailsScreen
      await tester.tap(find.text('Sunflower'));
      await tester.pumpAndSettle();

      // Verify that PlantDetailsScreen is pushed
      expect(find.byType(PlantDetailsScreen), findsOneWidget);
    });
  });
}
