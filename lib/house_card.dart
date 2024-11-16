// lib/house_card.dart

import 'package:flutter/material.dart';
import 'house.dart';

class HouseCard extends StatelessWidget {
  final House house;

  const HouseCard({Key? key, required this.house}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Image.network(
            house.imageUrl,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 16),
          Text(
            house.name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text("Address: ${house.address}"),
          Text("Energy Efficiency: ${house.energyEfficiency}"),
          Text("Cost: \$${house.cost.toStringAsFixed(2)}"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return Icon(
                index < house.boomRating ? Icons.whatshot : Icons.whatshot_outlined,
                color: Colors.red,
              );
            }),
          ),
        ],
      ),
    );
  }
}
