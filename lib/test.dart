import 'package:flutter/material.dart';
import 'package:swipe_cards/swipe_cards.dart';

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
  final List<Map<String, dynamic>> houses = [
    {'name': 'House 1'},
    {'name': 'House 2'},
    {'name': 'House 3'},
  ];

  late MatchEngine _matchEngine;
  final List<SwipeItem> _swipeItems = [];

  @override
  void initState() {
    super.initState();

    // Adding swipe items for each house
    for (var house in houses) {
      _swipeItems.add(SwipeItem(
        content: house,
        likeAction: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Liked ${house['name']}"),
              duration: const Duration(milliseconds: 500),
            ),
          );
        },
        nopeAction: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Disliked ${house['name']}"),
              duration: const Duration(milliseconds: 500),
            ),
          );
        },
      ));
    }

    // Initializing MatchEngine with swipe items
    _matchEngine = MatchEngine(swipeItems: _swipeItems);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('House Swiper'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Swipe left to dislike, right to like'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
      ),
      body: SwipeCards(
        matchEngine: _matchEngine,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 4,
            margin: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                houses[index]['name'],
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          );
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
