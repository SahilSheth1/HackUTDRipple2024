import 'package:flutter/material.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:google_fonts/google_fonts.dart';
import 'building.dart';
import 'building_card.dart';
import 'liked_buildings_page.dart';
import 'landing_page.dart';

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
        textTheme: GoogleFonts.interTextTheme(
          Theme.of(context).textTheme,
        ),
        appBarTheme: AppBarTheme(
          titleTextStyle: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        extensions: [
          TextStyleExtension(
            displayLarge: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF003F2D),
            ),
            displayMedium: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF003F2D),
            ),
            bodyLarge: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: const Color(0xFF003F2D).withOpacity(0.9),
            ),
            bodyMedium: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: const Color(0xFF003F2D).withOpacity(0.7),
            ),
          ),
        ],
      ),
      home: const LandingPage(),
    );
  }
}

class TextStyleExtension extends ThemeExtension<TextStyleExtension> {
  final TextStyle displayLarge;
  final TextStyle displayMedium;
  final TextStyle bodyLarge;
  final TextStyle bodyMedium;

  TextStyleExtension({
    required this.displayLarge,
    required this.displayMedium,
    required this.bodyLarge,
    required this.bodyMedium,
  });

  @override
  ThemeExtension<TextStyleExtension> copyWith({
    TextStyle? displayLarge,
    TextStyle? displayMedium,
    TextStyle? bodyLarge,
    TextStyle? bodyMedium,
  }) {
    return TextStyleExtension(
      displayLarge: displayLarge ?? this.displayLarge,
      displayMedium: displayMedium ?? this.displayMedium,
      bodyLarge: bodyLarge ?? this.bodyLarge,
      bodyMedium: bodyMedium ?? this.bodyMedium,
    );
  }

  @override
  ThemeExtension<TextStyleExtension> lerp(
    ThemeExtension<TextStyleExtension>? other,
    double t,
  ) {
    if (other is! TextStyleExtension) {
      return this;
    }
    return TextStyleExtension(
      displayLarge: TextStyle.lerp(displayLarge, other.displayLarge, t)!,
      displayMedium: TextStyle.lerp(displayMedium, other.displayMedium, t)!,
      bodyLarge: TextStyle.lerp(bodyLarge, other.bodyLarge, t)!,
      bodyMedium: TextStyle.lerp(bodyMedium, other.bodyMedium, t)!,
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
      name: 'Empire State Building',
      imagePath: 'assets/empire_state.jpg',
      address: '350 5th Ave, New York, NY 10118',
      description: 
          'An iconic 102-story skyscraper in Manhattan known for its Art Deco style and observation deck',
      price: '\$1.89 Billion',
      rating: 4,
      energyEfficiencyTip: 'Implementing smart window shading systems could further reduce energy consumption by optimizing natural lighting',
    ),
    Building(
      name: 'Willis Tower',
      imagePath: 'assets/willis.jpg',
      address: '233 S Wacker Dr, Chicago, IL 60606',
      description:
          'One of the tallest buildings in the U.S., boasting 108 floors and a glass skydeck offering stunning city views',
      price: '\$1.3 Billion',
      rating: 3,
      energyEfficiencyTip: 'Upgrading to high-efficiency HVAC systems and smart building management could reduce energy use',
    ),
    Building(
      name: 'Bryant Park',
      imagePath: 'assets/bryant_park.jpg',
      address: '41 W 40th St, New York, NY 10018, USA',
      description:
          'A famous public park in Manhattan surrounded by high-rise buildings. Its known for its open spaces, gardens, and year-round events, like winter ice skating.',
      price: '\$18 Million',
      rating: 3,
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
      energyEfficiencyTip: 'Triple-pane glass and advanced thermal insulation reduce heating and cooling needs by 35%.',
    ),
    Building(
      name: 'One World Trade Center',
      imagePath: 'assets/oneWorld.jpg',
      address: '285 Fulton St, New York, NY 10007',
      description:
          'A symbol of resilience, this 104-story skyscraper is the tallest building in the Western Hemisphere',
      price: '\$4 Billion',
      rating: 5,
      energyEfficiencyTip: 'Incorporating solar panels on rooftops and unused spaces could further offset its carbon footprint',
    ),
    Building(
      name: 'Space Needle',
      imagePath: 'assets/spaceNeedle.jpg',
      address: '400 Broad St, Seattle, WA 98109',
      description:
          'A futuristic observation tower offering panoramic views of Seattle and its surrounding landscapes',
      price: '\$100 Million',
      rating: 3,
      energyEfficiencyTip: 'Using energy-efficient LED lighting for nighttime illumination can save electricity.',
    ),
    Building(
      name: 'Trump Tower',
      imagePath: 'assets/trump_tower.jpg',
      address: '721 5th Ave, New York, NY 10022, USA',
      description:
          'A mixed-use skyscraper in Manhattan, featuring luxury residences, offices, and high-end retail. Known for its distinctive reflective glass facade and opulent interiors.',
      price: '\$900 Million',
      rating: 2,
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
    final textStyles = Theme.of(context).extension<TextStyleExtension>()!;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'EcoMatch',
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
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
                SnackBar(
                  content: Text(
                    "Restarted the swipe order",
                    style: GoogleFonts.inter(),
                  ),
                ),
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
                  Text(
                    "No more buildings!",
                    style: textStyles.displayLarge,
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
                      textStyle: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                      ),
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