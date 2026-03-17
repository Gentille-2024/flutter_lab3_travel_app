import '../models/destination.dart';

// ============================================================
// Hard-Coded Travel Data
// All images, text, lists, prices, and ratings are defined here.
// This file is imported by screens to populate the UI.
// ============================================================

class TravelData {
  // ---------- Categories for horizontal scrolling ----------
  static const List<Map<String, String>> categories = [
    {'icon': '🏖️', 'label': 'Beaches'},
    {'icon': '🏔️', 'label': 'Mountains'},
    {'icon': '🏙️', 'label': 'Cities'},
    {'icon': '🏛️', 'label': 'Historic'},
    {'icon': '🌴', 'label': 'Tropical'},
    {'icon': '❄️', 'label': 'Winter'},
    {'icon': '🏕️', 'label': 'Adventure'},
    {'icon': '🍷', 'label': 'Culinary'},
  ];

  // ---------- Destinations list ----------
  static const List<Destination> destinations = [
    Destination(
      id: 'd1',
      name: 'Santorini',
      country: 'Greece',
      description:
          'Santorini is one of the Cyclades islands in the Aegean Sea. '
          'It was devastated by a volcanic eruption in the 16th century BC, '
          'forever shaping its rugged landscape. The white-washed, cubiform '
          'houses of its two principal towns, Fira and Oia, cling to cliffs '
          'above an underwater caldera. They overlook the sea, small islands '
          'to the west, and beaches made up of black, red, and white lava '
          'pebbles. Santorini offers breathtaking sunsets, delicious cuisine, '
          'and a rich history waiting to be explored by every traveler.',
      imageAsset: 'assets/images/santorini.jpg',
      rating: 4.8,
      price: 1299.99,
      category: 'Beaches',
      isFavorite: true,
      highlights: [
        'Iconic blue-domed churches',
        'Spectacular sunset views from Oia',
        'Volcanic black sand beaches',
        'Ancient ruins of Akrotiri',
      ],
    ),
    Destination(
      id: 'd2',
      name: 'Kyoto',
      country: 'Japan',
      description:
          'Kyoto, once the capital of Japan, is a city on the island of Honshu. '
          'It is famous for its numerous classical Buddhist temples, gardens, '
          'imperial palaces, Shinto shrines, and traditional wooden houses. '
          'The city is also known for formal traditions such as kaiseki dining '
          'and geisha entertainers. During spring, cherry blossoms transform '
          'the city into a pink wonderland, while autumn brings fiery red and '
          'gold foliage that frames every ancient structure beautifully.',
      imageAsset: 'assets/images/kyoto.jpg',
      rating: 4.9,
      price: 1499.99,
      category: 'Historic',
      highlights: [
        'Fushimi Inari shrine with 10,000 torii gates',
        'Traditional tea ceremonies',
        'Bamboo Grove in Arashiyama',
        'Geisha district of Gion',
      ],
    ),
    Destination(
      id: 'd3',
      name: 'Swiss Alps',
      country: 'Switzerland',
      description:
          'The Swiss Alps are a major natural feature of Switzerland, covering '
          'roughly 60% of the country. They offer world-class skiing, hiking, '
          'and mountaineering. Picturesque villages nestled among towering '
          'peaks provide a fairy-tale setting year-round. Crystal-clear lakes, '
          'lush green meadows, and charming chalets make every visit an '
          'unforgettable experience. The panoramic train rides through the Alps '
          'are considered among the most scenic rail journeys in the world.',
      imageAsset: 'assets/images/swiss_alps.jpg',
      rating: 4.7,
      price: 1899.99,
      category: 'Mountains',
      isFavorite: true,
      highlights: [
        'World-class skiing and snowboarding',
        'Scenic Glacier Express train ride',
        'Charming alpine villages',
        'Pristine hiking trails',
      ],
    ),
    Destination(
      id: 'd4',
      name: 'Bali',
      country: 'Indonesia',
      description:
          'Bali is an Indonesian island known for its forested volcanic '
          'mountains, iconic rice paddies, beaches, and coral reefs. The '
          'island is home to religious sites such as cliff-side Uluwatu Temple. '
          'To the south, the beach-side city of Kuta has lively bars, while '
          'Seminyak and Sanur offer calmer beach retreats. Ubud, set among '
          'terraced rice paddies and steep ravines, is the island\'s cultural '
          'heart with a famous art market and monkey forest sanctuary.',
      imageAsset: 'assets/images/bali.jpg',
      rating: 4.6,
      price: 999.99,
      category: 'Tropical',
      highlights: [
        'Tegallalang rice terraces',
        'Sacred Monkey Forest Sanctuary',
        'Stunning Uluwatu Temple',
        'World-class surfing beaches',
      ],
    ),
    Destination(
      id: 'd5',
      name: 'Paris',
      country: 'France',
      description:
          'Paris, France\'s capital, is a major European city and a global '
          'center for art, fashion, gastronomy, and culture. Its 19th-century '
          'cityscape is crisscrossed by wide boulevards and the River Seine. '
          'Beyond such landmarks as the Eiffel Tower and the Gothic Notre-Dame '
          'cathedral, the city is known for its cafe culture and designer '
          'boutiques along the Rue du Faubourg Saint-Honoré. Paris offers an '
          'unmatched blend of history, romance, and modern sophistication.',
      imageAsset: 'assets/images/paris.jpg',
      rating: 4.5,
      price: 1199.99,
      category: 'Cities',
      highlights: [
        'The iconic Eiffel Tower',
        'Louvre Museum art collection',
        'Charming Montmartre district',
        'Seine river cruises',
      ],
    ),
    Destination(
      id: 'd6',
      name: 'Machu Picchu',
      country: 'Peru',
      description:
          'Machu Picchu is a 15th-century Incan citadel situated on a mountain '
          'ridge 2,430 metres above sea level in the Cusco Region of Peru. '
          'Most archaeologists believe that it was built as an estate for the '
          'Inca emperor Pachacuti. Often referred to as the Lost City of the '
          'Incas, it is the most familiar icon of Inca civilization. The site '
          'was declared a UNESCO World Heritage Site and attracts hundreds of '
          'thousands of visitors every year seeking adventure and history.',
      imageAsset: 'assets/images/machu_picchu.jpg',
      rating: 4.9,
      price: 1599.99,
      category: 'Adventure',
      isFavorite: true,
      highlights: [
        'Ancient Incan citadel',
        'Inca Trail multi-day hike',
        'Breathtaking mountain scenery',
        'UNESCO World Heritage Site',
      ],
    ),
  ];

  // ---------- Featured destinations (subset) ----------
  static List<Destination> get featuredDestinations =>
      destinations.where((d) => d.isFavorite).toList();

  // ---------- Filter by category ----------
  static List<Destination> getByCategory(String category) =>
      destinations.where((d) => d.category == category).toList();
}
