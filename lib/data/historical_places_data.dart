import '../models/destination.dart';
import '../models/historical_place.dart';

// ============================================================
// POLONNARUWA
// ============================================================

final Destination polonnaruwa = Destination(
  name: 'Polonnaruwa',
  location: 'Polonnaruwa, North Central Province',
  description:
      'Polonnaruwa is one of Sri Lanka’s most important ancient cities, famous for its impressive ruins, temples, statues, and ancient irrigation systems.',
  image: 'assets/images/polonnaruwa.png',
  popularAttractions: [
    'Gal Viharaya',
    'Royal Palace',
    'Rankoth Vehera',
    'Lankathilaka Image House',
    'Parakrama Samudraya',
  ],
);

final List<HistoricalPlace> polonnaruwaPlaces = [
  HistoricalPlace(
    name: 'Gal Viharaya',
    destination: 'Polonnaruwa',
    description:
        'Gal Viharaya is one of the most famous monuments in Polonnaruwa, known for its remarkable Buddha statues carved directly into a large granite rock.',
    location: 'Polonnaruwa, Sri Lanka',
    image: 'assets/images/gal_viharaya.png',
  ),

  HistoricalPlace(
    name: 'Royal Palace',
    destination: 'Polonnaruwa',
    description:
        'The Royal Palace is an important archaeological monument within the ancient city of Polonnaruwa and reflects the grandeur of the city’s royal history.',
    location: 'Polonnaruwa, Sri Lanka',
    image: 'assets/images/royal_palace.png',
  ),

  HistoricalPlace(
    name: 'Rankoth Vehera',
    destination: 'Polonnaruwa',
    description:
        'Rankoth Vehera is a large ancient stupa and one of the most impressive religious monuments in the ancient city of Polonnaruwa.',
    location: 'Polonnaruwa, Sri Lanka',
    image: 'assets/images/rankoth_vehera.png',
  ),

  HistoricalPlace(
    name: 'Lankathilaka Image House',
    destination: 'Polonnaruwa',
    description:
        'Lankathilaka Image House is a historic Buddhist monument featuring a large image-house structure and remarkable ancient architectural details.',
    location: 'Polonnaruwa, Sri Lanka',
    image: 'assets/images/lankathilaka.png',
  ),

  HistoricalPlace(
    name: 'Parakrama Samudraya',
    destination: 'Polonnaruwa',
    description:
        'Parakrama Samudraya is a vast ancient reservoir associated with King Parakramabahu I and is a remarkable example of Sri Lanka’s historic irrigation engineering.',
    location: 'Polonnaruwa, Sri Lanka',
    image: 'assets/images/parakrama_samudraya.png',
  ),
];

// ============================================================
// JAFFNA
// ============================================================

final Destination jaffna = Destination(
  name: 'Jaffna',
  location: 'Jaffna, Northern Province',
  description:
      'Jaffna is a culturally rich destination in northern Sri Lanka, known for its historic landmarks, Hindu temples, colonial heritage, beaches, and unique island landscapes.',
  image: 'assets/images/jaffna.png',
  popularAttractions: [
    'Nallur Kandaswamy Kovil',
    'Jaffna Fort',
    'Jaffna Public Library',
    'Casuarina Beach',
    'Delft Island',
  ],
);

final List<HistoricalPlace> jaffnaPlaces = [
  HistoricalPlace(
    name: 'Nallur Kandaswamy Kovil',
    destination: 'Jaffna',
    description:
        'Nallur Kandaswamy Kovil is one of the most important Hindu temples in Jaffna and is an important centre of religious and cultural heritage.',
    location: 'Nallur, Jaffna, Sri Lanka',
    image: 'assets/images/nallur_kandaswamy.png',
  ),

  HistoricalPlace(
    name: 'Jaffna Fort',
    destination: 'Jaffna',
    description:
        'Jaffna Fort is a historic coastal fortification that reflects the colonial history of northern Sri Lanka.',
    location: 'Jaffna, Sri Lanka',
    image: 'assets/images/jaffna_fort.png',
  ),

  HistoricalPlace(
    name: 'Jaffna Public Library',
    destination: 'Jaffna',
    description:
        'Jaffna Public Library is an important cultural landmark in the city and is recognised for its architectural and cultural significance.',
    location: 'Jaffna, Sri Lanka',
    image: 'assets/images/jaffna_library.png',
  ),

  HistoricalPlace(
    name: 'Casuarina Beach',
    destination: 'Jaffna',
    description:
        'Casuarina Beach is a peaceful coastal destination known for its clear waters, sandy shoreline, and relaxed atmosphere.',
    location: 'Karainagar, Jaffna, Sri Lanka',
    image: 'assets/images/casuarina_beach.png',
  ),

  HistoricalPlace(
    name: 'Delft Island',
    destination: 'Jaffna',
    description:
        'Delft Island is a unique island destination known for its distinctive landscapes, historic ruins, coral walls, and cultural heritage.',
    location: 'Delft Island, Jaffna, Sri Lanka',
    image: 'assets/images/delft_island.png',
  ),
];

// ============================================================
// DOWN SOUTH
// ============================================================

final Destination downSouth = Destination(
  name: 'Down South',
  location: 'Southern Province, Sri Lanka',
  description:
      'Down South brings together Sri Lanka’s coastal beauty, colonial heritage, historic forts, temples, traditional crafts, and fascinating cultural landmarks.',
  image: 'assets/images/down_south.png',
  popularAttractions: [
    'Galle Dutch Fort & Lighthouse',
    'Mulgirigala Rock Temple',
    'Kushta Raja Gala',
    'Star Fort (Matara)',
    'Ariyapala Masks Museum',
  ],
);

final List<HistoricalPlace> downSouthPlaces = [
  HistoricalPlace(
    name: 'Galle Dutch Fort & Lighthouse',
    destination: 'Down South',
    description:
        'Galle Dutch Fort is a historic fortified city overlooking the Indian Ocean, featuring colonial architecture, old streets, ramparts, and the famous Galle Lighthouse.',
    location: 'Galle, Sri Lanka',
    image: 'assets/images/galle_fort.png',
  ),

  HistoricalPlace(
    name: 'Mulgirigala Rock Temple',
    destination: 'Down South',
    description:
        'Mulgirigala Rock Temple is an ancient Buddhist temple complex located on a large natural rock and is known for its historic caves, murals, and religious monuments.',
    location: 'Tangalle, Sri Lanka',
    image: 'assets/images/mulgirigala.png',
  ),

  HistoricalPlace(
    name: 'Kushta Raja Gala',
    destination: 'Down South',
    description:
        'Kushta Raja Gala is a historic rock-cut statue located near Weligama and is an interesting example of the region’s archaeological heritage.',
    location: 'Weligama, Sri Lanka',
    image: 'assets/images/kushta_raja_gala.png',
  ),

  HistoricalPlace(
    name: 'Star Fort (Matara)',
    destination: 'Down South',
    description:
        'Star Fort is a distinctive Dutch fortification in Matara, built in a six-pointed star shape as part of the historic coastal defence system.',
    location: 'Matara, Sri Lanka',
    image: 'assets/images/star_fort.png',
  ),

  HistoricalPlace(
    name: 'Ariyapala Masks Museum',
    destination: 'Down South',
    description:
        'Ariyapala Masks Museum in Ambalangoda showcases traditional Sri Lankan masks, craftsmanship, folklore, and cultural traditions of the southern region.',
    location: 'Ambalangoda, Sri Lanka',
    image: 'assets/images/ariyapala_masks.png',
  ),
];

// ============================================================
// ANURADHAPURA
// ============================================================

final Destination anuradhapura = Destination(
  name: 'Anuradhapura',
  location: 'North Central Province',
  description:
      'Anuradhapura is one of the oldest continuously inhabited cities in the world and a UNESCO World Heritage Site. Renowned for its colossal stupas, ancient temples, sacred Bodhi tree, and remarkable ancient irrigation systems.',
  image: 'assets/images/anuradhapura.png',
  popularAttractions: [
    'Ruwanwelisaya',
    'Sri Maha Bodhi',
    'Thuparamaya',
    'Abhayagiri',
    'Jetavanaramaya',
  ],
);

final List<HistoricalPlace> anuradhapuraPlaces = [
  HistoricalPlace(
    name: 'Ruwanwelisaya',
    destination: 'Anuradhapura',
    description: 'A magnificent stupa and one of the world\'s tallest ancient monuments.',
    location: 'Anuradhapura, Sri Lanka',
    image: 'assets/images/anuradhapura.png',
  ),
  HistoricalPlace(
    name: 'Sri Maha Bodhi',
    destination: 'Anuradhapura',
    description: 'The sacred fig tree, said to be a sapling from the historical Bodhi tree under which Buddha became enlightened.',
    location: 'Anuradhapura, Sri Lanka',
    image: 'assets/images/Auradapura 2.png',
  ),
  HistoricalPlace(
    name: 'Thuparamaya',
    destination: 'Anuradhapura',
    description: 'The first Buddhist temple in Sri Lanka.',
    location: 'Anuradhapura, Sri Lanka',
    image: 'assets/images/thuparamaya.png',
  ),
  HistoricalPlace(
    name: 'Abhayagiri',
    destination: 'Anuradhapura',
    description: 'A major monastery site of Mahayana, Theravada and Vajrayana Buddhism.',
    location: 'Anuradhapura, Sri Lanka',
    image: 'assets/images/anurapura 5.png',
  ),
  HistoricalPlace(
    name: 'Jetavanaramaya',
    destination: 'Anuradhapura',
    description: 'A prominent ancient stupa in the ruins of Jetavana monastery.',
    location: 'Anuradhapura, Sri Lanka',
    image: 'assets/images/jetavanaramaya.png',
  ),
];

// ============================================================
// KANDY
// ============================================================

final Destination kandy = Destination(
  name: 'Kandy',
  location: 'Central Province',
  description:
      'Kandy is a major city in the Central Province of Sri Lanka, situated in the midst of hills in the Kandy plateau, the last kingdom of the Sri Lankan kings. It is a UNESCO World Heritage Site and home to the sacred Temple of the Tooth Relic.',
  image: 'assets/images/kandy_main.jpg',
  popularAttractions: [
    'Sri Dalada Maligawa',
    'Bahirawakanda Buddha Statue',
    'Ehalepola Wax Museum',
    'Gadaladeniya Vihara',
    'Lankathilaka Vihara',
  ],
);

final List<HistoricalPlace> kandyPlaces = [
  HistoricalPlace(
    name: 'Sri Dalada Maligawa',
    destination: 'Kandy',
    description:
        'Sri Dalada Maligawa, or the Temple of the Sacred Tooth Relic, is a Buddhist temple in the city of Kandy. It is one of the most sacred places of worship in the Buddhist world and houses the relic of the tooth of the Buddha.',
    location: 'Kandy, Sri Lanka',
    image: 'assets/images/kandy.png',
  ),

  HistoricalPlace(
    name: 'Bahirawakanda Buddha Statue',
    destination: 'Kandy',
    description:
        'The Bahirawakanda Buddha Statue is a large white sitting Buddha statue located on the top of Bahirawakanda hill in Kandy. It offers panoramic views of the city and is a prominent landmark visible from across Kandy.',
    location: 'Kandy, Sri Lanka',
    image: 'assets/images/bahirawakanda_buddha.jpg',
  ),

  HistoricalPlace(
    name: 'Ehalepola Wax Museum',
    destination: 'Kandy',
    description:
        'The Ehalepola Wax Museum is a cultural museum in Kandy that commemorates the story of Ehalepola Nilame and showcases life-size wax figures depicting significant moments in the last Kandyan kingdom.',
    location: 'Kandy, Sri Lanka',
    image: 'assets/images/ehalepola_wax_museum.jpg',
  ),

  HistoricalPlace(
    name: 'Gadaladeniya Viharaya',
    destination: 'Kandy',
    description:
        'Gadaladeniya Vihara is an ancient Buddhist temple built in the 14th century. It features a unique blend of South Indian and Sri Lankan architectural styles and is one of the remarkable medieval temples near Kandy.',
    location: 'Gadaladeniya, Kandy, Sri Lanka',
    image: 'assets/images/gadaladeniya_vihara.jpg',
  ),

  HistoricalPlace(
    name: 'Lankathilaka Viharaya',
    destination: 'Kandy',
    description:
        'Lankathilaka Vihara is a magnificent ancient Buddhist temple built in the 14th century during the reign of King Bhuvanekabahu IV. It stands on a rock and is known for its impressive multi-storey structure and ancient carvings.',
    location: 'Lankathilaka, Kandy, Sri Lanka',
    image: 'assets/images/lankathilaka_vihara.jpg',
  ),
];

// ============================================================
// DAMBULLA
// ============================================================

final Destination dambulla = Destination(
  name: 'Dambulla',
  location: 'Central Province',
  description:
      'Dambulla is a historic city in Sri Lanka, famous for the UNESCO World Heritage Site Dambulla Cave Temple. It is renowned for its ancient rock temples, rich cultural heritage, archaeological sites and natural beauty.',
  image: 'assets/images/dambulla.png',
  popularAttractions: [
    'Dambulla Cave Temple',
    'Sigiriya Rock Fortress',
    'Ibbankatuwa Megalithic Tombs',
  ],
);

final List<HistoricalPlace> dambullaPlaces = [
  HistoricalPlace(
    name: 'Dambulla Cave Temple',
    destination: 'Dambulla',
    description:
        'Dambulla Cave Temple is a UNESCO World Heritage Site and the largest, best-preserved cave temple complex in Sri Lanka, featuring 153 Buddha statues and ancient murals spanning 2,100 square metres.',
    location: 'Dambulla, Sri Lanka',
    image: 'assets/images/dambulla_cave_temple.jpg',
  ),

  HistoricalPlace(
    name: 'Sigiriya Rock Fortress',
    destination: 'Dambulla',
    description:
        'Sigiriya is an ancient rock fortress and palace ruin built by King Kashyapa. Rising 200 metres above the surrounding jungle, it is a UNESCO World Heritage Site and one of the best-preserved examples of ancient urban planning.',
    location: 'Sigiriya, Sri Lanka',
    image: 'assets/images/sigiriya_rock_fortress.jpg',
  ),

  HistoricalPlace(
    name: 'Ibbankatuwa Megalithic Tombs',
    destination: 'Dambulla',
    description:
        'Ibbankatuwa Megalithic Tombs is a prehistoric burial site near Dambulla, containing ancient megalithic tombs dating back to the Iron Age. It is an important archaeological site that reveals early human settlements in Sri Lanka.',
    location: 'Dambulla, Sri Lanka',
    image: 'assets/images/ibbankatuwa_megalithic_tombs.jpg',
  ),
];

// ============================================================
// ALL DESTINATIONS
// ============================================================

final List<Destination> destinations = [anuradhapura, polonnaruwa, jaffna, downSouth, kandy, dambulla];

