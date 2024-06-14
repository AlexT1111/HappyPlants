import 'package:flutter_test/flutter_test.dart';
import 'package:cis350/plant.dart'; // Replace with actual import path

void main() {
  group('Plant.fromJson', () {
    test('should create a Plant object from JSON', () {
      // Arrange
      Map<String, dynamic> json = {
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
      };

      // Act
      Plant plant = Plant.fromJson(json);

      // Assert
      expect(plant.commonName, 'Sunflower');
      expect(plant.scientificName, 'Helianthus annuus');
      expect(plant.family, 'Asteraceae');
      expect(plant.plantType, 'Annual');
      expect(plant.matureSize, 'Up to 3m tall');
      expect(plant.sunNeeds, 'Full Sun');
      expect(plant.soilNeeds, 'Well-drained');
      expect(plant.waterNeeds, 'Regular');
      expect(plant.flowerColor, 'Yellow');
      expect(plant.idealTemperature, '70-85°F');
      expect(plant.nativeContinent, 'North America');
      expect(plant.toxicity, 'Non-toxic');
      expect(plant.notes, 'Attracts bees and butterflies.');
    });

    test(
        'fromJson should throw an ArgumentError if a required field is missing',
        () {
      // Arrange
      Map<String, dynamic> incompleteJson = {
        // Missing 'commonName'
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
      };

      // Act & Assert
      expect(() => Plant.fromJson(incompleteJson), throwsArgumentError);
    });
  });
}
