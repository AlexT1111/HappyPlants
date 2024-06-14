import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'plant.dart';
import 'plant_details_screen.dart';

/// Declares SearchPlantsScreen state.
class SearchPlantsScreen extends StatefulWidget {
  @override
  SearchPlantsScreenState createState() => SearchPlantsScreenState();
}

/// Creates Search Plants page of Happy Plants App, navigated to by selectable region on Home screen.
class SearchPlantsScreenState extends State<SearchPlantsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<Plant> plantList = [];
  List<Plant> filteredList = [];
  List<String> _options = [
    'Family',
    'Lomariopsidaceae',
    'Asparagaceae',
    'Mint',
    'Lamiaceae',
    'Moraceae',
    'Malvaceae',
    'Araliaceae',
    'Cactaceae',
    'Araceae',
    'Oleaceae',
    'Asphodelaceae'
  ];
  String _selectedOption = 'Family';

  /// Calls initialization state.
  @override
  void initState() {
    super.initState();
    _fetchPlants();
  }

  Future<void> _fetchPlants() async {
    final plants = await fetchPlants();
    setState(() {
      plantList = plants;
      filteredList = plants;
    });
  }

  // Design filtering for search screen by name and by family.
  void _filterList() {
    String searchText = _textController.text.toLowerCase();
    String selectedFamily = _selectedOption.toLowerCase();

    setState(() {
      filteredList = plantList.where((plant) {
        bool matchesSearchText =
            plant.commonName.toLowerCase().contains(searchText) ||
                plant.scientificName.toLowerCase().contains(searchText);
        bool matchesFamily = selectedFamily == 'family' ||
            selectedFamily == 'unknown' ||
            plant.family.toLowerCase().contains(selectedFamily);
        return matchesSearchText && matchesFamily;
      }).toList();
    });
  }

  /// Designs a Search Plants page including full list of plant selections, search bar for plant name, and dropdown menu for plant family filtering.
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Container(
          height: 40,
          decoration: BoxDecoration(
              color: const Color(0xffF5F5F5),
              borderRadius: BorderRadius.circular(5)),
          child: Row(children: [
            Expanded(
              child: TextField(
                controller: _textController,
                decoration: InputDecoration(
                  prefixIcon: IconButton(
                    icon: Icon(
                      Icons.search_rounded,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () => FocusScope.of(context).unfocus(),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.clear_rounded,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () {
                      _textController.text = "";
                      _filterList();
                    },
                  ),
                  hintText: 'Search...',
                  border: InputBorder.none,
                ),
                onChanged: (text) => _filterList(),
                onSubmitted: (text) => _filterList(),
              ),
            ),
          ]),
        ),
        actions: [
          DropdownButton<String>(
            value: _selectedOption,
            onChanged: (String? newValue) {
              setState(() {
                _selectedOption = newValue!;
                _filterList();
              });
            },
            items: _options.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColorDark,
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          screenSize.height * 0.05,
          screenSize.height * 0.1,
          screenSize.height * 0.05,
          0,
        ),
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: _scrollController,
          itemCount: filteredList.length,
          shrinkWrap: true,
          padding: const EdgeInsets.only(bottom: 10),
          itemBuilder: (BuildContext context, int index) {
            final plant = filteredList[index];
            return Card(
              child: ListTile(
                title: Text(plant.commonName),
                subtitle: Text(plant.scientificName),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlantDetailsScreen(plant: plant),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

// Grab resultant plants based on filtering.
Future<List<Plant>> fetchPlants() async {
  final String response =
      await rootBundle.loadString('assets/HAPPYPLANTS.plants.json');
  final List<dynamic> data = json.decode(response);
  return data.map((json) => Plant.fromJson(json)).toList();
}
