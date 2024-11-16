// lib/main.dart

import 'package:flutter/material.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'house.dart';
import 'house_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'House Swiper',
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
  final List<House> houses = [
    House(
      name: 'Cozy Cottage',
      imageUrl:
          'https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
      address: '123 Maple Street',
      energyEfficiency: 'A',
      cost: 250000.00,
      boomRating: 4,
    ),
    House(
      name: 'Modern Villa',
      imageUrl:
          'https://images.pexels.com/photos/1643389/pexels-photo-1643389.jpeg?auto=compress&cs=tinysrgb&w=600',
      address: '456 Oak Avenue',
      energyEfficiency: 'B',
      cost: 750000.00,
      boomRating: 5,
    ),
    House(
      name: 'Urban Apartment',
      imageUrl:
          'https://images.pexels.com/photos/439391/pexels-photo-439391.jpeg?auto=compress&cs=tinysrgb&w=600',
      address: '789 Pine Road',
      energyEfficiency: 'C',
      cost: 300000.00,
      boomRating: 3,
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
                return HouseCard(house: houses[index]);
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
