class Plant {
  final String commonName;
  final String scientificName;
  final String family;
  final String plantType;
  final String matureSize;
  final String sunNeeds;
  final String soilNeeds;
  final String waterNeeds;
  final String flowerColor;
  final String idealTemperature;
  final String nativeContinent;
  final String toxicity;
  final String notes;

  Plant({
    required this.commonName,
    required this.scientificName,
    required this.family,
    required this.plantType,
    required this.matureSize,
    required this.sunNeeds,
    required this.soilNeeds,
    required this.waterNeeds,
    required this.flowerColor,
    required this.idealTemperature,
    required this.nativeContinent,
    required this.toxicity,
    required this.notes,
  });

  factory Plant.fromJson(Map<String, dynamic> json) {
    // Validate required fields
    if (!json.containsKey('commonName') ||
        !json.containsKey('scientificName') ||
        !json.containsKey('family') ||
        !json.containsKey('plantType') ||
        !json.containsKey('matureSize') ||
        !json.containsKey('sunNeeds') ||
        !json.containsKey('soilNeeds') ||
        !json.containsKey('waterNeeds') ||
        !json.containsKey('flowerColor') ||
        !json.containsKey('idealTemperature') ||
        !json.containsKey('nativeContinent') ||
        !json.containsKey('toxicity') ||
        !json.containsKey('notes')) {
      throw ArgumentError('Missing required fields in JSON');
    }

    return Plant(
      commonName: json['commonName'],
      scientificName: json['scientificName'],
      family: json['family'],
      plantType: json['plantType'],
      matureSize: json['matureSize'],
      sunNeeds: json['sunNeeds'],
      soilNeeds: json['soilNeeds'],
      waterNeeds: json['waterNeeds'],
      flowerColor: json['flowerColor'],
      idealTemperature: json['idealTemperature'],
      nativeContinent: json['nativeContinent'],
      toxicity: json['toxicity'],
      notes: json['notes'],
    );
  }
}
