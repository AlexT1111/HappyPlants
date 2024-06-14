import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'search_plants_screen.dart';
import 'my_location_screen.dart';
import 'plants_by_location_screen.dart';

/// Declares Home state.
class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

/// Creates Home page of Happy Plants App.
class _HomeState extends State<Home> {
  String selectedContinent = '';

  void _navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    ).then((result) {
      // Saves app user location if it has been selected.
      if (result != null && result is String) {
        setState(() {
          selectedContinent = result;
        });
      }
    });
  }

  /// Designs Home screen with text fields and selectable regions.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 5,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    // Designs Home screen text field at top of page.
                    child: Text(
                      "Welcome to Happy Plants!",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Image.asset(
                    'images/plantlogo.png',
                    height: 50.0,
                    width: 50.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Let's improve your green thumb.",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                // Designs primary selectable regions: Search Plants, My Location, and Plants by Location.
                children: [
                  InkWell(
                    onTap: () =>
                        _navigateToScreen(context, SearchPlantsScreen()),
                    child: ListTile(
                      leading: FaIcon(FontAwesomeIcons.magnifyingGlass),
                      title: Text("Search Plants"),
                      trailing: Text("->"),
                    ),
                  ),
                  InkWell(
                    onTap: () => _navigateToScreen(context, MyLocationScreen()),
                    child: ListTile(
                      leading: FaIcon(FontAwesomeIcons.earth),
                      title: Text("My Location"),
                      trailing: Text("->"),
                    ),
                  ),
                  InkWell(
                    onTap: () => _navigateToScreen(
                      context,
                      PlantsByLocationScreen(
                          selectedContinent: selectedContinent),
                    ),
                    child: ListTile(
                      leading: FaIcon(FontAwesomeIcons.sunPlantWilt),
                      title: Text("Plants by Location"),
                      trailing: Text("->"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
