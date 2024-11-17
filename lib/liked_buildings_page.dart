import 'package:flutter/material.dart';
import 'building.dart';
import 'api_service.dart';
import 'building_details.dart';

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
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth < 600 ? 1 : screenWidth < 1200 ? 2 : 3;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Liked Buildings'),
        backgroundColor: const Color(0xFF003F2D),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF003F2D),
              ),
            )
          : widget.likedBuildings.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.favorite_border,
                        size: 64,
                        color: const Color(0xFF003F2D).withOpacity(0.5),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'No liked buildings yet',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF003F2D),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Start exploring to find your favorite buildings',
                        style: TextStyle(
                          fontSize: 16,
                          color: const Color(0xFF003F2D).withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                )
              : CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.all(16.0),
                      sliver: SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          mainAxisSpacing: 16.0,
                          crossAxisSpacing: 16.0,
                          childAspectRatio: 0.85,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final building = widget.likedBuildings[index];
                            return GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) =>
                                      BuildingDetails(building: building),
                                );
                              },
                              child: Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                          top: Radius.circular(16)),
                                      child: Image.asset(
                                        building.imagePath,
                                        height: 200,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            building.name,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF003F2D),
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
                                            children: List.generate(
                                              5,
                                              (index) => Icon(
                                                index < building.rating
                                                    ? Icons.whatshot
                                                    : Icons.whatshot_outlined,
                                                color: Colors.red,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          childCount: widget.likedBuildings.length,
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }
}