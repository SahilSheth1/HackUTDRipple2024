import 'package:flutter/material.dart';
import 'building.dart';

class BuildingCard extends StatelessWidget {
  final Building building;

  const BuildingCard({Key? key, required this.building}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the screen width to calculate the image size
    final screenWidth = MediaQuery.of(context).size.width;
    // Calculate image size (70% of screen width)
    final imageSize = screenWidth * 0.35;

    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Center the image
            Center(
              child: SizedBox(
                width: imageSize,
                height: imageSize,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    building.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(
                            Icons.error_outline,
                            size: 40,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        color: Colors.grey[200],
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Information section
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  building.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  "Address: ${building.address}",
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Description: ${building.description}",
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Cost: ${building.cost}",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return Icon(
                      index < building.boomRating ? Icons.whatshot : Icons.whatshot_outlined,
                      color: Colors.red,
                      size: 28,
                    );
                  }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}