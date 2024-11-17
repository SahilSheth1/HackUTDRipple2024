import 'package:flutter/material.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'building.dart';
import 'building_card.dart';
import 'liked_buildings_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Building Swiper',
      theme: ThemeData(
        primaryColor: const Color(0xFF003F2D),
        primarySwatch: Colors.green,
      ),
      home: const BuildingSwipePage(),
    );
  }
}

class BuildingSwipePage extends StatefulWidget {
  const BuildingSwipePage({super.key});

  @override
  State<BuildingSwipePage> createState() => _BuildingSwipePageState();
}

class _BuildingSwipePageState extends State<BuildingSwipePage> {
  final List<Building> buildings = [
    Building(
      name: 'Bosco Verticale',
      imagePath: 'assets/bosco_verticale.jpg',
      address: 'Via Gaetano de Castillia, 11, 20124 Milan, Italy',
      description:
          'A pair of residential towers covered with thousands of trees and plants. The "Vertical Forest" concept helps improve air quality and provides a green urban oasis.',
      price: '\$85 Million',
      rating: 5,
      boomDescription: '',
      energyEfficiencyTip: 'The vertical forest design naturally regulates building temperature, reducing heating and cooling costs by up to 30%.',
    ),
    Building(
      name: 'Bullitt',
      imagePath: 'assets/bullitt.jpg',
      address: '1501 E Madison St, Seattle, WA 98122, USA',
      description:
          'One of the greenest commercial buildings in the world, designed to be fully sustainable with solar panels, rainwater collection, and composting toilets. It aims for a zero-carbon footprint.',
      price: '\$32.5 Million',
      rating: 5,
      boomDescription: '',
      energyEfficiencyTip: 'Solar panels and geothermal wells provide 60% more energy than the building consumes annually.',
    ),
    Building(
      name: 'Bryant Park',
      imagePath: 'assets/bryant_park.jpg',
      address: '41 W 40th St, New York, NY 10018, USA',
      description:
          'A famous public park in Manhattan surrounded by high-rise buildings. Its known for its open spaces, gardens, and year-round events, like winter ice skating.',
      price: 'N/A',
      rating: 3,
      boomDescription: '',
      energyEfficiencyTip: 'LED lighting systems and smart irrigation reduce energy consumption by 25% compared to traditional park systems.',
    ),
    Building(
      name: 'Caesars Palace',
      imagePath: 'assets/ceasars_palace.jpg',
      address: '3570 S Las Vegas Blvd, Las Vegas, NV 89109, USA',
      description:
          'An iconic luxury hotel and casino on the Las Vegas Strip, known for its Roman-inspired architecture, grand entertainment venues, and lavish decor.',
      price: '\$200 Million',
      rating: 2,
      boomDescription: '',
      energyEfficiencyTip: 'Implementation of smart HVAC systems could reduce energy consumption by 40% in gaming areas.',
    ),
    Building(
      name: 'Edge',
      imagePath: 'assets/edge.jpg',
      address: '30 Hudson Yards, New York, NY 10001, USA',
      description:
          'A glass observation deck located at Hudson Yards, offering stunning 360-degree views of Manhattan. Its one of the highest outdoor observation platforms in the Western Hemisphere.',
      price: '\$25 Billion',
      rating: 4,
      boomDescription: '',
      energyEfficiencyTip: 'Triple-pane glass and advanced thermal insulation reduce heating and cooling needs by 35%.',
    ),
    Building(
      name: 'Empire State',
      imagePath: 'assets/empire_state.jpg',
      address: '350 5th Ave, New York, NY 10118, USA',
      description:
          'An iconic Art Deco skyscraper in Manhattan, once the tallest building in the world. Its a symbol of New York City and famous for its observation decks.',
      price: '\$600 Million',
      rating: 3,
      boomDescription: '',
      energyEfficiencyTip: 'Recent retrofitting with energy-efficient windows and lighting systems reduced energy consumption by 38%.',
    ),
    Building(
      name: 'Shard',
      imagePath: 'assets/shard.jpg',
      address: '32 London Bridge St, London SE1 9SG, UK',
      description:
          'A distinctive glass skyscraper that resembles a shard of glass, making it the tallest building in Western Europe. It houses offices, apartments, restaurants, and a viewing gallery.',
      price: '\$2 Billion',
      rating: 4,
      boomDescription: '',
      energyEfficiencyTip: 'Advanced facade design and heat recovery systems reduce energy consumption by 30% compared to conventional buildings.',
    ),
    Building(
      name: 'Trump Tower',
      imagePath: 'assets/trump_tower.jpg',
      address: '721 5th Ave, New York, NY 10022, USA',
      description:
          'A mixed-use skyscraper in Manhattan, featuring luxury residences, offices, and high-end retail. Known for its distinctive reflective glass facade and opulent interiors.',
      price: '\$900 Million',
      rating: 2,
      boomDescription: '',
      energyEfficiencyTip: 'Upgrading to modern HVAC systems and LED lighting could reduce energy usage by 45%.',
    ),
  ];

  final List<Building> likedBuildings = [];
  late MatchEngine _matchEngine;
  List<SwipeItem> _swipeItems = [];

  @override
  void initState() {
    super.initState();
    initializeSwipeItems();
  }

  void initializeSwipeItems() {
    _swipeItems = buildings.map((building) {
      return SwipeItem(
        content: building,
        likeAction: () {
          setState(() {
            if (!likedBuildings.contains(building)) {
              likedBuildings.add(building);
            }
          });
        },
        nopeAction: () {},
      );
    }).toList();

    _matchEngine = MatchEngine(swipeItems: _swipeItems);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Building Swiper'),
        backgroundColor: const Color(0xFF003F2D),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            tooltip: 'View Liked Buildings',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LikedBuildingsPage(
                    likedBuildings: likedBuildings,
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Restart Swipe Order',
            onPressed: () {
              setState(() {
                initializeSwipeItems();
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Restarted the swipe order")),
              );
            },
          ),
        ],
      ),
      body: _swipeItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.home_work,
                    size: 64,
                    color: const Color(0xFF003F2D).withOpacity(0.5),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "No more buildings!",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF003F2D),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        initializeSwipeItems();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF003F2D),
                    ),
                    child: const Text("Start Over"),
                  ),
                ],
              ),
            )
          : SwipeCards(
              matchEngine: _matchEngine,
              itemBuilder: (BuildContext context, int index) {
                return BuildingCard(building: _swipeItems[index].content);
              },
              onStackFinished: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LikedBuildingsPage(
                      likedBuildings: likedBuildings,
                    ),
                  ),
                );
              },
            ),
    );
  }
}