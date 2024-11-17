// building_details.dart
import 'package:flutter/material.dart';
import 'building.dart';

class BuildingDetails extends StatelessWidget {
  final Building building;

  const BuildingDetails({Key? key, required this.building}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Determine dialog width based on screen size
    final double dialogWidth = MediaQuery.of(context).size.width * 0.8;
    final double imageHeight = 100; // Reduced height
    SizedBox(
      height: imageHeight,
      width: dialogWidth - 32, // Adjust for padding/margin if necessary
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          building.imagePath,
          width: dialogWidth - 32,
          height: imageHeight,
          fit: BoxFit
              .cover, // You can change this to BoxFit.fill, BoxFit.contain, etc.
        ),
      ),
    );

    return AlertDialog(
      title: Text(building.name),
      content: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight:
              MediaQuery.of(context).size.height * 0.7, // 70% of screen height
          maxWidth: dialogWidth,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox to force image size
              SizedBox(
                height: imageHeight,
                width:
                    dialogWidth - 32, // Adjust for padding/margin if necessary
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    building.imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Address: ${building.address}",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              Text(
                "Description: ${building.description}",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                "Price: ${building.price}",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    index < building.rating
                        ? Icons.whatshot
                        : Icons.whatshot_outlined,
                    color: Colors.red,
                  );
                }),
              ),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Close"),
        ),
      ],
    );
  }
}
