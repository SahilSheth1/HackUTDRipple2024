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
    {'name': 'House 1', 'image': 'https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'},
    {'name': 'House 2', 'image': 'https://via.placeholder.com/300/2'},
    {'name': 'House 3', 'image': 'https://via.placeholder.com/300/3'},
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
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        houses[index]['image'],
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        houses[index]['name'],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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
