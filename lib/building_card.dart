// building_card.dart
import 'package:flutter/material.dart';
import 'building.dart';

class BuildingCard extends StatelessWidget {
  final Building building;

  const BuildingCard({Key? key, required this.building}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          // SizedBox to constrain the image size
          SizedBox(
            height: 300, // <-- Change this value to adjust the image height
            width: double.infinity, // Makes the image take up the full width of the card
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(4.0)),
              child: Image.asset(
                building.imagePath,
                fit: BoxFit.cover, // Adjusts how the image fits into the space
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              building.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Text(building.address),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(building.description),
          ),
          Text('Price: ${building.price}'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              building.rating,
              (index) => const Icon(Icons.star, color: Colors.amber),
            ),
          ),
        ],
      ),
    );
  }
}
