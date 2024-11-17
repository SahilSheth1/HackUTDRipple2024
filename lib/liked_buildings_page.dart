// liked_buildings_page.dart
import 'package:flutter/material.dart';
import 'building.dart';
import 'api_service.dart';

class LikedBuildingsPage extends StatefulWidget {
  final List<Building> likedBuildings;

  const LikedBuildingsPage({Key? key, required this.likedBuildings})
      : super(key: key);

  @override
  _LikedBuildingsPageState createState() => _LikedBuildingsPageState();
}

class _LikedBuildingsPageState extends State<LikedBuildingsPage> {
  List<dynamic> apiResults = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchApiResults();
  }

  Future<void> fetchApiResults() async {
    final results = await ApiService.fetchApiData(widget.likedBuildings);
    setState(() {
      apiResults = results;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Liked Buildings'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // Navigate back to the swipe page
            },
          ),
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  if (widget.likedBuildings.isEmpty)
                    const ListTile(
                      title: Text('No liked buildings.'),
                    )
                  else
                    ...widget.likedBuildings.map((building) => ListTile(
                          leading: Image.asset(
                            building.imagePath,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(building.name),
                          subtitle: Text(building.address),
                        )),
                  const Divider(),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'API Results:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  if (apiResults.isEmpty)
                    const ListTile(
                      title: Text('No API results to display.'),
                    )
                  else
                    ...apiResults.map((result) => ListTile(
                          title: Text(result['title']),
                          subtitle: Text(result['body']),
                        )),
                ],
              ));
  }
}
