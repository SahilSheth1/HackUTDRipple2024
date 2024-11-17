// main.dart
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
        primarySwatch: Colors.blue,
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
          'A pair of residential towers covered with thousands of trees and plants. The “Vertical Forest” concept helps improve air quality and provides a green urban oasis.',
      price: '\$85 Million',
      rating: 4,
    ),
    Building(
  name: 'Bullitt',
  imagePath: 'assets/bullitt.jpg',
  address: '1501 E Madison St, Seattle, WA 98122, USA',
  description:
      'One of the greenest commercial buildings in the world, designed to be fully sustainable with solar panels, rainwater collection, and composting toilets. It aims for a zero-carbon footprint.',
  price: '\$32.5 Million',
  rating: 4,
),
Building(
  name: 'Bryant Park',
  imagePath: 'assets/bryant_park.jpg',
  address: '41 W 40th St, New York, NY 10018, USA',
  description:
      'A famous public park in Manhattan surrounded by high-rise buildings. It’s known for its open spaces, gardens, and year-round events, like winter ice skating.',
  price: 'N/A',
  rating: 4,
),
Building(
  name: 'Caesars Palace',
  imagePath: 'assets/ceasars_palace.jpg',
  address: '3570 S Las Vegas Blvd, Las Vegas, NV 89109, USA',
  description:
      'An iconic luxury hotel and casino on the Las Vegas Strip, known for its Roman-inspired architecture, grand entertainment venues, and lavish decor.',
  price: '\$200 Million',
  rating: 4,
),
Building(
  name: 'Edge',
  imagePath: 'assets/edge.jpg',
  address: '30 Hudson Yards, New York, NY 10001, USA',
  description:
      'A glass observation deck located at Hudson Yards, offering stunning 360-degree views of Manhattan. It’s one of the highest outdoor observation platforms in the Western Hemisphere.',
  price: '\$25 Billion',
  rating: 4,
),
Building(
  name: 'Empire State',
  imagePath: 'assets/empire_state.jpg',
  address: '350 5th Ave, New York, NY 10118, USA',
  description:
      'An iconic Art Deco skyscraper in Manhattan, once the tallest building in the world. It’s a symbol of New York City and famous for its observation decks.',
  price: '\$600 Million',
  rating: 4,
),
Building(
  name: 'Shard',
  imagePath: 'assets/shard.jpg',
  address: '32 London Bridge St, London SE1 9SG, UK',
  description:
      'A distinctive glass skyscraper that resembles a shard of glass, making it the tallest building in Western Europe. It houses offices, apartments, restaurants, and a viewing gallery.',
  price: '\$2 Billion',
  rating: 4,
),
Building(
  name: 'Trump Tower',
  imagePath: 'assets/trump_tower.jpg',
  address: '721 5th Ave, New York, NY 10022, USA',
  description:
      'A mixed-use skyscraper in Manhattan, featuring luxury residences, offices, and high-end retail. Known for its distinctive reflective glass facade and opulent interiors.',
  price: '\$900 Million',
  rating: 4,
),
    // ... Add the rest of your buildings here
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
        actions: [
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
          ? const Center(
              child: Text(
                "No more buildings! Press refresh to start over.",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
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
