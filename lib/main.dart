// lib/main.dart

import 'package:flutter/material.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'building.dart';
import 'building_card.dart';

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
      home: const HouseSwipePage(),
    );
  }
}

class HouseSwipePage extends StatefulWidget {
  const HouseSwipePage({super.key});

  @override
  State<HouseSwipePage> createState() => _HouseSwipePageState();
}

class _HouseSwipePageState extends State<HouseSwipePage> {
  final List<Building> houses = [
    Building(
      'Bosco Verticale',
      'assets/bosco_verticale.jpg',
      'Via Gaetano de Castillia, 11, 20124 Milan, Italy',
      'A pair of residential towers covered with thousands of trees and plants. The “Vertical Forest” concept helps improve air quality and provides a green urban oasis',
      '\$85 Million',
      4,
    ),
    Building(
      'Bullitt',
      'assets/bullitt.jpg',
      '41 W 40th St, New York, NY 10018, USA',
      'A famous public park in Manhattan surrounded by high-rise buildings. It’s known for its open spaces, gardens, and year-round events, like winter ice skating',
      'N/A',
      4,
    ),
    Building(
      'Bryant Park',
      'assets/bryant_park.jpg',
      '1501 E Madison St, Seattle, WA 98122, USA',
      'One of the greenest commercial buildings in the world, designed to be fully sustainable with solar panels, rainwater collection, and composting toilets. It aims for a zero-carbon footprint',
      '\$32.5 Million',
      4,
    ),
    Building(
      'Ceasars Palace',
      'assets/ceasars_palace.jpg',
      '3570 S Las Vegas Blvd, Las Vegas, NV 89109, USA',
      'An iconic luxury hotel and casino on the Las Vegas Strip, known for its Roman-inspired architecture, grand entertainment venues, and lavish decor',
      '\$200 Million',
      4,
    ),
    Building(
      'Edge',
      'assets/edge.jpg',
      '30 Hudson Yards, New York, NY 10001, USA',
      'A glass observation deck located at Hudson Yards, offering stunning 360-degree views of Manhattan. It’s one of the highest outdoor observation platforms in the Western Hemisphere',
      '\$25 Billion',
      4,
    ),
    Building(
      'Empire State',
      'assets/empire_state.jpg',
      '350 5th Ave, New York, NY 10118, USA',
      'An iconic Art Deco skyscraper in Manhattan, once the tallest building in the world. It’s a symbol of New York City and famous for its observation decks',
      '\$600 Million',
      4,
    ),
    Building(
      'Shard',
      'assets/shard.jpg',
      '32 London Bridge St, London SE1 9SG, UK',
      'A distinctive glass skyscraper that resembles a shard of glass, making it the tallest building in Western Europe. It houses offices, apartments, restaurants, and a viewing gallery',
      '\$2 Billion',
      4,
    ),
    Building(
      'Trump Tower',
      'assets/trump_tower.jpg',
      '721 5th Ave, New York, NY 10022, USA',
      'A mixed-use skyscraper in Manhattan, featuring luxury residences, offices, and high-end retail. Known for its distinctive reflective glass facade and opulent interiors',
      '\$900 Million',
      4,
    ),
  ];

  late MatchEngine _matchEngine;
  List<SwipeItem> _swipeItems = [];

  @override
  void initState() {
    super.initState();
    initializeSwipeItems();
  }

  void initializeSwipeItems() {
    _swipeItems = [];
    for (var house in houses) {
      _swipeItems.add(SwipeItem(
        content: house,
        likeAction: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Liked ${house.name}"),
              duration: const Duration(milliseconds: 500),
            ),
          );
        },
        nopeAction: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Disliked ${house.name}"),
              duration: const Duration(milliseconds: 500),
            ),
          );
        },
      ));
    }
    _matchEngine = MatchEngine(swipeItems: _swipeItems);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('House Swiper'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              initializeSwipeItems();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Restarted the swipe order")),
              );
            },
          ),
        ],
      ),
      body: _swipeItems.isEmpty
          ? const Center(
              child: Text("No more houses! Press reset to start over."),
            )
          : SwipeCards(
              matchEngine: _matchEngine,
              itemBuilder: (BuildContext context, int index) {
                return BuildingCard(building: houses[index]);
              },
              onStackFinished: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("No more houses!")),
                );
              },
            ),
    );
  }
}
