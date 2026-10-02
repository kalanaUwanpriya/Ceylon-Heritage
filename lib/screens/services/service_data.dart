class ServicePlace {
  final String name;

  final String type;

  final double? rating;

  final String location;

  final String mapUrl;

  final String imagePath;

  final String description;
  final List<String> galleryImages;

  const ServicePlace({
    required this.name,

    required this.type,

    this.rating,

    required this.location,

    required this.mapUrl,

    this.imagePath = '',

    this.description = '',
    this.galleryImages = const [],
  });
}

class ServiceData {
  static List<ServicePlace> getPlaces(String city, String category) {
    return _places[city]?[category] ?? [];
  }

  static final Map<String, Map<String, List<ServicePlace>>> _places = {
    // =========================================================

    // ANURADHAPURA

    // =========================================================
    'Anuradhapura': {
      'Accommodation': [
        ServicePlace(
          name: 'Heritage Hotel Anuradhapura',

          type: 'Hotel',

          rating: 4.3,

          location: 'Galwala Road, Pothanegama',

          mapUrl: 'https://maps.app.goo.gl/TqTeMuCYa987M6pC8',

          imagePath:
              'assets/images/services/anuradhapura/Heritage Hotel Anuradhapura.jpg',

          description:
              'Heritage Hotel Anuradhapura is an accommodation option in Galwala Road, Pothanegama, providing visitors with a convenient place to stay while exploring nearby attractions.',
        ),

        ServicePlace(
          name: 'Rajarata Hotel - Anuradhapura',

          type: 'Hotel',

          rating: 4.1,

          location: 'Rowing Club Road',

          mapUrl: 'https://maps.app.goo.gl/s96hzHhuDnszSGXbA',

          imagePath:
              'assets/images/services/anuradhapura/Rajarata Hotel - Anuradhapura.jpg',

          description:
              'Rajarata Hotel - Anuradhapura is an accommodation option in Rowing Club Road, providing visitors with a convenient place to stay while exploring nearby attractions.',
        ),

        ServicePlace(
          name: 'DELMOND Lake',

          type: 'Hotel',

          rating: 4.9,

          location: 'Lake Road',

          mapUrl: 'https://maps.app.goo.gl/8534w7iTRhNMo4dm6',

          imagePath: 'assets/images/services/anuradhapura/DELMOND Lake.jpg',

          description:
              'DELMOND Lake is an accommodation option in Lake Road, providing visitors with a convenient place to stay while exploring nearby attractions.',
        ),

        ServicePlace(
          name: 'Hotel Alakamanda',

          type: 'Hotel',

          rating: 4.2,

          location: 'Nagasena Mawatha',

          mapUrl: 'https://maps.app.goo.gl/swe7qv97P6PMFwFi8',

          imagePath: 'assets/images/services/anuradhapura/Hotel Alakamanda.jpg',

          description:
              'Hotel Alakamanda is an accommodation option in Nagasena Mawatha, providing visitors with a convenient place to stay while exploring nearby attractions.',
        ),

        ServicePlace(
          name: 'The Lake Forest Hotel',

          type: 'Hotel',

          rating: 4.4,

          location: 'Tissa Wewa Lane, Pothanegama',

          mapUrl: 'https://maps.app.goo.gl/gdUmr2hXG7HNRe3z8',

          imagePath:
              'assets/images/services/anuradhapura/The Lake Forest Hotel.jpg',

          description:
              'The Lake Forest Hotel is an accommodation option in Tissa Wewa Lane, Pothanegama, providing visitors with a convenient place to stay while exploring nearby attractions.',
        ),

        ServicePlace(
          name: 'Rajarata Family Resort',

          type: 'Resort',

          rating: 4.6,

          location: 'Jaffna Junction Road',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Rajarata+Family+Resort+Anuradhapura',

          imagePath:
              'assets/images/services/anuradhapura/Rajarata Family Resort.jpg',

          description:
              'Rajarata Family Resort is an accommodation option in Jaffna Junction Road, providing visitors with a convenient place to stay while exploring nearby attractions.',
        ),
      ],

      'Food & Restaurants': [
        ServicePlace(
          name: 'Little Paradise Restaurant Anuradhapura',

          type: 'Restaurant',

          rating: 4.8,

          location: 'Godage Mawatha',

          mapUrl: 'https://maps.app.goo.gl/qd4jGeCATa5LDb6BA',

          imagePath:
              'assets/images/services/anuradhapura/Little Paradise Restaurant Anuradhapura.jpg',

          description:
              'Little Paradise Restaurant Anuradhapura is a dining option in Godage Mawatha, offering visitors a convenient place to stop for a meal during their journey.',
        ),

        ServicePlace(
          name: 'Bro Restaurant',

          type: 'Family Restaurant',

          rating: 4.6,

          location: 'Agbo 16th',

          mapUrl: 'https://maps.app.goo.gl/DvwkBPtJAoV5zPMd8',

          imagePath: 'assets/images/services/anuradhapura/Bro Restaurant.jpg',

          description:
              'Bro Restaurant is a dining option in Agbo 16th, offering visitors a convenient place to stop for a meal during their journey.',
        ),

        ServicePlace(
          name: 'Seedevi Family Restaurant',

          type: 'Restaurant',

          rating: 4.0,

          location: 'Jayanthi Mawatha',

          mapUrl: 'https://maps.app.goo.gl/ZFiaNPf1YHb7Pt9W6',

          imagePath:
              'assets/images/services/anuradhapura/Seedevi Family Restaurant.jpg',

          description:
              'Seedevi Family Restaurant is a dining option in Jayanthi Mawatha, offering visitors a convenient place to stop for a meal during their journey.',
        ),

        ServicePlace(
          name: 'Sorriso Restaurant',

          type: 'Restaurant',

          rating: 4.8,

          location: 'Maithripala Senanayake Mawatha',

          mapUrl: 'https://maps.app.goo.gl/GzVpSejhqmYANkuv8',

          imagePath:
              'assets/images/services/anuradhapura/Sorriso Restaurant.jpg',

          description:
              'Sorriso Restaurant is a dining option in Maithripala Senanayake Mawatha, offering visitors a convenient place to stop for a meal during their journey.',
        ),

        ServicePlace(
          name: 'Palhena Village Restaurant',

          type: 'Restaurant',

          rating: 4.5,

          location: 'Freeman Road',

          mapUrl: 'https://maps.app.goo.gl/KWwKQV63BKurfpCGA',

          imagePath:
              'assets/images/services/anuradhapura/Palhena Village Restaurant.jpg',

          description:
              'Palhena Village Restaurant is a dining option in Freeman Road, offering visitors a convenient place to stop for a meal during their journey.',
        ),

        ServicePlace(
          name: 'Kings Town Restaurant',

          type: 'Sri Lankan Restaurant',

          rating: 4.9,

          location: 'Anuradhapura',

          mapUrl: 'https://maps.app.goo.gl/kGpUNxgM4RaUiMQ4A',

          imagePath:
              'assets/images/services/anuradhapura/Kings Town Restaurant.jpg',

          description:
              'Kings Town Restaurant is a dining option in Anuradhapura, offering visitors a convenient place to stop for a meal during their journey.',
        ),
      ],

      'Parking': [
        ServicePlace(
          name: 'Sri Maha Bodhi Vehicle Park',

          type: 'Parking Lot',

          location: 'Sri Maha Bodhi Eastern Entrance',

          mapUrl: 'https://maps.app.goo.gl/JMXmKGdurFpNjN9XA',

          imagePath:
              'assets/images/services/anuradhapura/Sri Maha Bodhi Vehicle Park.jpg',

          description:
              'Sri Maha Bodhi Vehicle Park is a parking location in Sri Maha Bodhi Eastern Entrance, providing a convenient place for visitors to leave their vehicle while exploring nearby attractions.',
        ),

        ServicePlace(
          name: 'Udamaluwa Parking',

          type: 'Parking Lot',

          rating: 4.5,

          location: 'Mihindu Mawatha',

          mapUrl: 'https://maps.app.goo.gl/BzJwfrhVMWPmArK39',

          imagePath:
              'assets/images/services/anuradhapura/Udamaluwa parking.jpg',

          description:
              'Udamaluwa Parking is a parking location in Mihindu Mawatha, providing a convenient place for visitors to leave their vehicle while exploring nearby attractions.',
        ),

        ServicePlace(
          name: 'Thuparamaya Parking Lot',

          type: 'Parking Lot',

          rating: 5.0,

          location: 'Thuparama Mawatha',

          mapUrl: 'https://maps.app.goo.gl/GQ9fUNSrEkWupUuB9',

          imagePath:
              'assets/images/services/anuradhapura/Thuparamaya parking lot.jpg',

          description:
              'Thuparamaya Parking Lot is a parking location in Thuparama Mawatha, providing a convenient place for visitors to leave their vehicle while exploring nearby attractions.',
        ),

        ServicePlace(
          name: 'Isurumuniya Car Park',

          type: 'Parking Lot',

          rating: 5.0,

          location: 'Isurumuniya',

          mapUrl: 'https://maps.app.goo.gl/53fNTD2yFS5Gsaug9',

          imagePath:
              'assets/images/services/anuradhapura/Isurumuniya car park.jpg',

          description:
              'Isurumuniya Car Park is a parking location in Isurumuniya, providing a convenient place for visitors to leave their vehicle while exploring nearby attractions.',
        ),

        ServicePlace(
          name: 'Car Park',

          type: 'Parking Lot',

          location: 'Anuradhapura',

          mapUrl: 'https://maps.app.goo.gl/Pb3dECDXnDBm5qX87',

          imagePath: 'assets/images/services/anuradhapura/Car Park.jpg',

          description:
              'Car Park is a parking location in Anuradhapura, providing a convenient place for visitors to leave their vehicle while exploring nearby attractions.',
        ),

        ServicePlace(
          name: 'Free Parking Slot',

          type: 'Parking Lot',

          rating: 4.0,

          location: 'Maithripala Senanayake Mawatha',

          mapUrl: 'https://maps.app.goo.gl/kux5QWgsmmY42ywD7',

          imagePath:
              'assets/images/services/anuradhapura/Free Parking slot.jpg',

          description:
              'Free Parking Slot is a parking location in Maithripala Senanayake Mawatha, providing a convenient place for visitors to leave their vehicle while exploring nearby attractions.',
        ),
      ],

      'Health Services': [
        ServicePlace(
          name: 'Teaching Hospital - Anuradhapura',

          type: 'Government Hospital',

          rating: 4.2,

          location: 'Harischandra Mawatha',

          mapUrl: 'https://maps.app.goo.gl/5CMnTVeJtZfTJj2XA',

          imagePath:
              'assets/images/services/anuradhapura/Teaching Hospital - Anuradhapura.jpg',

          description:
              'Teaching Hospital - Anuradhapura is a healthcare location in Harischandra Mawatha, helping visitors identify a nearby place for medical or health-related services when needed.',
        ),

        ServicePlace(
          name: 'Apollo Hospital - Anuradhapura',

          type: 'Private Hospital',

          rating: 5.0,

          location: 'Pubudupura Road',

          mapUrl: 'https://maps.app.goo.gl/Hv8krjDsgd9mVqXn7',

          imagePath: 'assets/images/services/anuradhapura/Apollo Hospital.jpg',

          description:
              'Apollo Hospital - Anuradhapura is a healthcare location in Pubudupura Road, helping visitors identify a nearby place for medical or health-related services when needed.',
        ),

        ServicePlace(
          name: 'Durdans Medical Centre - Anuradhapura',

          type: 'Medical Centre',

          rating: 2.6,

          location: 'Kada 50',

          mapUrl: 'https://maps.app.goo.gl/2itVTUscg3TmXsMR7',

          imagePath:
              'assets/images/services/anuradhapura/Durdans Medical Centre.jpg',

          description:
              'Durdans Medical Centre - Anuradhapura is a healthcare location in Kada 50, helping visitors identify a nearby place for medical or health-related services when needed.',
        ),

        ServicePlace(
          name: 'Suwa Shanthi Hospital',

          type: 'Hospital',

          rating: 2.7,

          location: 'Maithripala Senanayake Mawatha',

          mapUrl: 'https://maps.app.goo.gl/P5QxE3ocU2Y6NfQE9',

          imagePath:
              'assets/images/services/anuradhapura/Suwa Shanthi Hospital.jpg',

          description:
              'Suwa Shanthi Hospital is a healthcare location in Maithripala Senanayake Mawatha, helping visitors identify a nearby place for medical or health-related services when needed.',
        ),

        ServicePlace(
          name: 'Arogya Medical Centre',

          type: 'Medical Centre',

          rating: 5.0,

          location: 'Freeman Mawatha',

          mapUrl: 'https://maps.app.goo.gl/sqEqk7qzjeMW6pHh8',

          imagePath:
              'assets/images/services/anuradhapura/Arogya Medical Centre.png',

          description:
              'Arogya Medical Centre is a healthcare location in Freeman Mawatha, helping visitors identify a nearby place for medical or health-related services when needed.',
        ),

        ServicePlace(
          name: 'Provincial Ayurveda Hospital',

          type: 'Ayurvedic Hospital',

          location: 'Anuradhapura',

          mapUrl: 'https://maps.app.goo.gl/2szFaF6PDaT6QspB6',

          imagePath:
              'assets/images/services/anuradhapura/Provincial Ayurveda Hospital.jpg',

          description:
              'Provincial Ayurveda Hospital is a healthcare location in Anuradhapura, helping visitors identify a nearby place for medical or health-related services when needed.',
        ),
      ],
    },

    // =========================================================

    // POLONNARUWA

    // =========================================================
    'Polonnaruwa': {
      'Accommodation': [
        ServicePlace(
          name: 'EKHO Lake House',

          type: 'Hotel',

          rating: 4.5,

          location: 'Pothgul Mawatha',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=EKHO+Lake+House+Polonnaruwa+Sri+Lanka',

          imagePath: 'assets/images/services/polonnaruwa/EKHO Lake House.jpg',

          description:
              'EKHO Lake House is an accommodation option in Pothgul Mawatha, providing visitors with a convenient place to stay while exploring nearby attractions.',
        ),

        ServicePlace(
          name: 'Hotel Sudu Araliya',

          type: 'Hotel',

          rating: 3.9,

          location: 'Parakrama Samudra Area',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Hotel+Sudu+Araliya+Polonnaruwa+Sri+Lanka',

          imagePath:
              'assets/images/services/polonnaruwa/Hotel Sudu Araliya.jpg',

          description:
              'Hotel Sudu Araliya is an accommodation option in Parakrama Samudra Area, providing visitors with a convenient place to stay while exploring nearby attractions.',
        ),

        ServicePlace(
          name: 'Hotel Lake Park',

          type: 'Hotel',

          rating: 4.3,

          location: 'Deewara Mawatha',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Hotel+Lake+Park+Polonnaruwa+Sri+Lanka',

          imagePath: 'assets/images/services/polonnaruwa/Hotel Lake Park.jpg',

          description:
              'Hotel Lake Park is an accommodation option in Deewara Mawatha, providing visitors with a convenient place to stay while exploring nearby attractions.',
        ),

        ServicePlace(
          name: 'Sunrise Lake Resort',

          type: 'Resort',

          rating: 4.9,

          location: 'Parakumgama',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Sunrise+Lake+Resort+Polonnaruwa+Sri+Lanka',

          imagePath:
              'assets/images/services/polonnaruwa/Sunrise Lake Resort.jpg',

          description:
              'Sunrise Lake Resort is an accommodation option in Parakumgama, providing visitors with a convenient place to stay while exploring nearby attractions.',
        ),

        ServicePlace(
          name: 'Hotel Sanhida Polonnaruwa',

          type: 'Hotel',

          rating: 5.0,

          location: '2nd Canal',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Hotel+Sanhida+Polonnaruwa+Sri+Lanka',

          imagePath: 'assets/images/services/polonnaruwa/Hotel Sanhida.jpg',

          description:
              'Hotel Sanhida Polonnaruwa is an accommodation option in 2nd Canal, providing visitors with a convenient place to stay while exploring nearby attractions.',
        ),

        ServicePlace(
          name: 'Giritale Hotel',

          type: 'Hotel',

          rating: 3.9,

          location: 'Giritale',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Giritale+Hotel+Polonnaruwa+Sri+Lanka',

          imagePath: 'assets/images/services/polonnaruwa/Giritale Hotel.jpg',

          description:
              'Giritale Hotel is an accommodation option in Giritale, providing visitors with a convenient place to stay while exploring nearby attractions.',
        ),
      ],

      'Food & Restaurants': [
        ServicePlace(
          name: 'Priyamali Gedara',

          type: 'Sri Lankan Restaurant',

          rating: 4.9,

          location: 'Polonnaruwa',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Priyamali+Gedara+Polonnaruwa',

          imagePath: 'assets/images/services/polonnaruwa/Priyamali Gedara.jpg',

          description:
              'Priyamali Gedara is a dining option in Polonnaruwa, offering visitors a convenient place to stop for a meal during their journey.',
        ),

        ServicePlace(
          name: 'Jaga Food',

          type: 'Restaurant',

          rating: 4.9,

          location: 'Polonnaruwa',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Jaga+Food+Polonnaruwa',

          imagePath: 'assets/images/services/polonnaruwa/Jaga Food.jpg',

          description:
              'Jaga Food is a dining option in Polonnaruwa, offering visitors a convenient place to stop for a meal during their journey.',
        ),

        ServicePlace(
          name: 'Kubura Restaurant',

          type: 'Restaurant',

          rating: 4.9,

          location: 'Polonnaruwa',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Kubura+Restaurant+Polonnaruwa',

          imagePath: 'assets/images/services/polonnaruwa/Kubura restaurant.jpg',

          description:
              'Kubura Restaurant is a dining option in Polonnaruwa, offering visitors a convenient place to stop for a meal during their journey.',
        ),

        ServicePlace(
          name: 'Pabalu Mandapa - Authentic Sinhala Cuisine',

          type: 'Sri Lankan Restaurant',

          rating: 4.9,

          location: 'Polonnaruwa',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Pabalu+Mandapa+Polonnaruwa',

          imagePath: 'assets/images/services/polonnaruwa/Pabalu Mandapa.jpg',

          description:
              'Pabalu Mandapa - Authentic Sinhala Cuisine is a dining option in Polonnaruwa, offering visitors a convenient place to stop for a meal during their journey.',
        ),

        ServicePlace(
          name: 'Dine Home Restaurant',

          type: 'Family Restaurant',

          rating: 4.8,

          location: 'Polonnaruwa',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Dine+Home+Restaurant+Polonnaruwa',

          imagePath:
              'assets/images/services/polonnaruwa/Dine Home Restaurant.jpg',

          description:
              'Dine Home Restaurant is a dining option in Polonnaruwa, offering visitors a convenient place to stop for a meal during their journey.',
        ),

        ServicePlace(
          name: 'Ariya Rest House Restaurant',

          type: 'Restaurant',

          rating: 4.5,

          location: 'Polonnaruwa',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Ariya+Rest+House+Polonnaruwa+Sri+Lanka',

          imagePath:
              'assets/images/services/polonnaruwa/Ariya Rest House Restaurant.jpg',

          description:
              'Ariya Rest House Restaurant is a dining option in Polonnaruwa, offering visitors a convenient place to stop for a meal during their journey.',
        ),
      ],

      'Parking': [
        ServicePlace(
          name: 'Vatadage Parking',

          type: 'Public Parking',

          rating: 5.0,

          location: 'Polonnaruwa',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Vatadage+Parking+Polonnaruwa',

          imagePath: 'assets/images/services/polonnaruwa/Vatadage parking.jpg',

          description:
              'Vatadage Parking is a parking location in Polonnaruwa, providing a convenient place for visitors to leave their vehicle while exploring nearby attractions.',
        ),

        ServicePlace(
          name: 'Ancient Technology Museum & Wax Museum Car Park',

          type: 'Public Parking',

          rating: 5.0,

          location: 'Polonnaruwa',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Ancient+Technology+Museum+Car+Park+Polonnaruwa',

          imagePath:
              'assets/images/services/polonnaruwa/Ancient Technology car park.jpg',

          description:
              'Ancient Technology Museum & Wax Museum Car Park is a parking location in Polonnaruwa, providing a convenient place for visitors to leave their vehicle while exploring nearby attractions.',
        ),

        ServicePlace(
          name: 'Gal Vihara Parking',

          type: 'Parking',

          location: 'Gal Vihara',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Gal+Vihara+Parking+Polonnaruwa',

          imagePath:
              'assets/images/services/polonnaruwa/Gal Vihara Parking.jpg',

          description:
              'Gal Vihara Parking is a parking location in Gal Vihara, providing a convenient place for visitors to leave their vehicle while exploring nearby attractions.',
        ),

        ServicePlace(
          name: 'Polonnaruwa Ancient City Parking',

          type: 'Parking',

          location: 'Ancient City',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Polonnaruwa+Ancient+City+Parking',

          imagePath:
              'assets/images/services/polonnaruwa/Polonnaruwa Ancient City Parking.jpg',

          description:
              'Polonnaruwa Ancient City Parking is a parking location in Ancient City, providing a convenient place for visitors to leave their vehicle while exploring nearby attractions.',
        ),

        ServicePlace(
          name: 'Parakrama Samudra Parking Area',

          type: 'Parking',

          location: 'Parakrama Samudra',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Parakrama+Samudra+Parking+Polonnaruwa',

          imagePath:
              'assets/images/services/polonnaruwa/Parakrama Samudra Parking.jpg',

          description:
              'Parakrama Samudra Parking Area is a parking location in Parakrama Samudra, providing a convenient place for visitors to leave their vehicle while exploring nearby attractions.',
        ),

        ServicePlace(
          name: 'Car Parking Area',

          type: 'Parking Lot',

          rating: 1.0,

          location: 'Samagi Mawatha',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Car+Parking+Area+Samagi+Mawatha+Polonnaruwa',

          imagePath: 'assets/images/services/polonnaruwa/Car Parking Area.jpg',

          description:
              'Car Parking Area is a parking location in Samagi Mawatha, providing a convenient place for visitors to leave their vehicle while exploring nearby attractions.',
        ),
      ],

      'Health Services': [
        ServicePlace(
          name: 'District General Hospital Polonnaruwa',

          type: 'Government Hospital',

          rating: 4.3,

          location: 'Polonnaruwa',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=District+General+Hospital+Polonnaruwa',

          imagePath:
              'assets/images/services/polonnaruwa/District General Hospital Polonnaruwa.jpg',

          description:
              'District General Hospital Polonnaruwa is a healthcare location in Polonnaruwa, helping visitors identify a nearby place for medical or health-related services when needed.',
        ),

        ServicePlace(
          name: 'National Nephrology Hospital',

          type: 'Hospital',

          rating: 4.7,

          location: 'Polonnaruwa',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=National+Nephrology+Hospital+Polonnaruwa',

          imagePath:
              'assets/images/services/polonnaruwa/National Nephrology Hospital.jpg',

          description:
              'National Nephrology Hospital is a healthcare location in Polonnaruwa, helping visitors identify a nearby place for medical or health-related services when needed.',
        ),

        ServicePlace(
          name: 'Venus Lanka Hospital',

          type: 'Private Hospital',

          rating: 3.1,

          location: 'Polonnaruwa',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Venus+Lanka+Hospital+Polonnaruwa',

          imagePath:
              'assets/images/services/polonnaruwa/Venus Lanka Hospital.jpg',

          description:
              'Venus Lanka Hospital is a healthcare location in Polonnaruwa, helping visitors identify a nearby place for medical or health-related services when needed.',
        ),

        ServicePlace(
          name: 'Neerogya Health Care',

          type: 'Hospital',

          location: 'Polonnaruwa',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Neerogya+Health+Care+Polonnaruwa',

          imagePath:
              'assets/images/services/polonnaruwa/Neerogya Health Care.jpg',

          description:
              'Neerogya Health Care is a healthcare location in Polonnaruwa, helping visitors identify a nearby place for medical or health-related services when needed.',
        ),

        ServicePlace(
          name: 'Medicare Hospital Polonnaruwa',

          type: 'Hospital',

          location: 'Polonnaruwa',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Medicare+Hospital+Polonnaruwa',

          imagePath: 'assets/images/services/polonnaruwa/Medicare Hospital.jpg',

          description:
              'Medicare Hospital Polonnaruwa is a healthcare location in Polonnaruwa, helping visitors identify a nearby place for medical or health-related services when needed.',
        ),

        ServicePlace(
          name: 'Ayurvedic Hospital Polonnaruwa',

          type: 'Ayurvedic Hospital',

          location: 'Polonnaruwa',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Ayurvedic+Hospital+Polonnaruwa',

          imagePath:
              'assets/images/services/polonnaruwa/Ayurvedic Hospital.jpg',

          description:
              'Ayurvedic Hospital Polonnaruwa is a healthcare location in Polonnaruwa, helping visitors identify a nearby place for medical or health-related services when needed.',
        ),
      ],
    },

    // =========================================================

    // KANDY

    // =========================================================
    'Kandy': {
      'Accommodation': [
        ServicePlace(
          name: 'The Grand Kandyan Hotel',

          type: 'Hotel',

          rating: 4.4,

          location: 'Kandy',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=The+Grand+Kandyan+Hotel+Kandy',

          imagePath: 'assets/images/services/kandy/The Grand Kandyan Hotel.jpg',

          description:
              'The Grand Kandyan Hotel is an accommodation option in Kandy, providing visitors with a convenient place to stay while exploring nearby attractions.',
        ),

        ServicePlace(
          name: "Queen's Hotel Kandy",

          type: 'Hotel',

          rating: 3.7,

          location: 'Kandy',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Queens+Hotel+Kandy',

          imagePath: "assets/images/services/kandy/Queen's Hotel Kandy.jpg",

          description:
              'Queen\'s Hotel Kandy is an accommodation option in Kandy, providing visitors with a convenient place to stay while exploring nearby attractions.',
        ),

        ServicePlace(
          name: 'Hotel Suisse Kandy',

          type: 'Hotel',

          rating: 4.0,

          location: 'Kandy',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Hotel+Suisse+Kandy',

          imagePath: 'assets/images/services/kandy/Hotel Suisse Kandy.jpg',

          description:
              'Hotel Suisse Kandy is an accommodation option in Kandy, providing visitors with a convenient place to stay while exploring nearby attractions.',
        ),

        ServicePlace(
          name: 'Radisson Hotel Kandy',

          type: 'Hotel',

          rating: 4.7,

          location: 'Kandy',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Radisson+Hotel+Kandy',

          imagePath: 'assets/images/services/kandy/Radisson Hotel Kandy.jpeg',

          description:
              'Radisson Hotel Kandy is an accommodation option in Kandy, providing visitors with a convenient place to stay while exploring nearby attractions.',
        ),

        ServicePlace(
          name: "Earl's Regency Kandy",

          type: 'Hotel',

          location: 'Kandy',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Earls+Regency+Kandy',

          imagePath: "assets/images/services/kandy/Earl's Regency Kandy.jpg",

          description:
              'Earl\'s Regency Kandy is an accommodation option in Kandy, providing visitors with a convenient place to stay while exploring nearby attractions.',
        ),

        ServicePlace(
          name: 'The Swiss Residence Kandy',

          type: 'Hotel',

          rating: 3.9,

          location: 'Kandy',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=The+Swiss+Residence+Kandy',

          imagePath:
              'assets/images/services/kandy/The Swiss Residence Kandy.jpg',

          description:
              'The Swiss Residence Kandy is an accommodation option in Kandy, providing visitors with a convenient place to stay while exploring nearby attractions.',
        ),
      ],

      'Food & Restaurants': [
        ServicePlace(
          name: 'Slightly Chilled Lounge Bar & Restaurant',

          type: 'Restaurant',

          location: 'Kandy',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Slightly+Chilled+Kandy',

          imagePath:
              'assets/images/services/kandy/Slightly Chilled Lounge Bar & Restaurant.jpg',

          description:
              'Slightly Chilled Lounge Bar & Restaurant is a dining option in Kandy, offering visitors a convenient place to stop for a meal during their journey.',
        ),

        ServicePlace(
          name: 'Balaji Dosai',

          type: 'Restaurant',

          rating: 4.1,

          location: 'Kandy',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Balaji+Dosai+Kandy',

          imagePath: 'assets/images/services/kandy/Balaji Dosai.jpg',

          description:
              'Balaji Dosai is a dining option in Kandy, offering visitors a convenient place to stop for a meal during their journey.',
        ),

        ServicePlace(
          name: 'Cafe Divine Street',

          type: 'Restaurant',

          rating: 4.2,

          location: 'Kandy',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Cafe+Divine+Street+Kandy',

          imagePath: 'assets/images/services/kandy/Cafe Divine Street.jpg',

          description:
              'Cafe Divine Street is a dining option in Kandy, offering visitors a convenient place to stop for a meal during their journey.',
        ),

        ServicePlace(
          name: 'The Empire Cafe',

          type: 'Restaurant',

          rating: 4.1,

          location: 'Kandy',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=The+Empire+Cafe+Kandy',

          imagePath: 'assets/images/services/kandy/The Empire Cafe.png',

          description:
              'The Empire Cafe is a dining option in Kandy, offering visitors a convenient place to stop for a meal during their journey.',
        ),

        ServicePlace(
          name: 'WorldSpice KCC',

          type: 'Restaurant',

          rating: 4.4,

          location: 'Kandy City Centre',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=WorldSpice+KCC+Kandy',

          imagePath: 'assets/images/services/kandy/WorldSpice KCC.jpeg',

          description:
              'WorldSpice KCC is a dining option in Kandy City Centre, offering visitors a convenient place to stop for a meal during their journey.',
        ),

        ServicePlace(
          name: 'Cafe Secret Alley',

          type: 'Restaurant',

          rating: 4.7,

          location: 'Kandy',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Cafe+Secret+Alley+Kandy',

          imagePath: 'assets/images/services/kandy/Cafe Secret Alley.jpg',

          description:
              'Cafe Secret Alley is a dining option in Kandy, offering visitors a convenient place to stop for a meal during their journey.',
        ),
      ],

      'Parking': [
        ServicePlace(
          name: 'Kandy City Centre Car Park',

          type: 'Parking',

          location: 'Kandy City Centre',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Kandy+City+Centre+Car+Park',

          imagePath:
              'assets/images/services/kandy/Kandy city center car park.jpg',

          description:
              'Kandy City Centre Car Park is a parking location in Kandy City Centre, providing a convenient place for visitors to leave their vehicle while exploring nearby attractions.',
        ),

        ServicePlace(
          name: 'Kandy Municipal Car Park',

          type: 'Parking',

          location: 'Kandy',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Kandy+Municipal+Car+Park',

          imagePath:
              'assets/images/services/kandy/Kandy Municipal car park.png',

          description:
              'Kandy Municipal Car Park is a parking location in Kandy, providing a convenient place for visitors to leave their vehicle while exploring nearby attractions.',
        ),

        ServicePlace(
          name: 'Temple of the Tooth Parking Area',

          type: 'Parking',

          location: 'Temple of the Tooth, Kandy',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Temple+of+the+Tooth+Parking+Kandy',

          imagePath:
              'assets/images/services/kandy/Temple of the Tooth Parking Area.png',

          description:
              'Temple of the Tooth Parking Area is a parking location in Temple of the Tooth, Kandy, providing a convenient place for visitors to leave their vehicle while exploring nearby attractions.',
        ),

        ServicePlace(
          name: 'Bogambara Parking Area',

          type: 'Parking',

          location: 'Bogambara, Kandy',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Bogambara+Parking+Area+Kandy',

          imagePath: 'assets/images/services/kandy/Bogambara Parking Area.jpg',

          description:
              'Bogambara Parking Area is a parking location in Bogambara, Kandy, providing a convenient place for visitors to leave their vehicle while exploring nearby attractions.',
        ),

        ServicePlace(
          name: 'Kandy Railway Station Parking',

          type: 'Parking',

          location: 'Kandy Railway Station',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Kandy+Railway+Station+Parking',

          imagePath:
              'assets/images/services/kandy/Kandy Railway Station Parking.png',

          description:
              'Kandy Railway Station Parking is a parking location in Kandy Railway Station, providing a convenient place for visitors to leave their vehicle while exploring nearby attractions.',
        ),

        ServicePlace(
          name: 'Bahirawakanda Temple Parking',

          type: 'Parking',

          location: 'Bahirawakanda, Kandy',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Bahirawakanda+Temple+Parking+Kandy',

          imagePath:
              'assets/images/services/kandy/Bahirawakanda Temple Parking.png',

          description:
              'Bahirawakanda Temple Parking is a parking location in Bahirawakanda, Kandy, providing a convenient place for visitors to leave their vehicle while exploring nearby attractions.',
        ),
      ],

      'Health Services': [
        ServicePlace(
          name: 'National Hospital Kandy',

          type: 'Government Hospital',

          rating: 4.1,

          location: 'Kandy',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=National+Hospital+Kandy',

          imagePath: 'assets/images/services/kandy/National Hospital Kandy.png',

          description:
              'National Hospital Kandy is a healthcare location in Kandy, helping visitors identify a nearby place for medical or health-related services when needed.',
        ),

        ServicePlace(
          name: 'Asiri Hospital Kandy',

          type: 'Private Hospital',

          rating: 3.8,

          location: 'Kandy',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Asiri+Hospital+Kandy',

          imagePath: 'assets/images/services/kandy/Asiri Hospital Kandy.jpg',

          description:
              'Asiri Hospital Kandy is a healthcare location in Kandy, helping visitors identify a nearby place for medical or health-related services when needed.',
        ),

        ServicePlace(
          name: 'Suwasevana Hospital Kandy',

          type: 'Private Hospital',

          rating: 2.8,

          location: 'Kandy',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Suwasevana+Hospital+Kandy',

          imagePath:
              'assets/images/services/kandy/Suwasevana Hospital Kandy.jpg',

          description:
              'Suwasevana Hospital Kandy is a healthcare location in Kandy, helping visitors identify a nearby place for medical or health-related services when needed.',
        ),

        ServicePlace(
          name: 'Kandy Nursing Home',

          type: 'Hospital',

          rating: 3.5,

          location: 'Kandy',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Kandy+Nursing+Home',

          imagePath: 'assets/images/services/kandy/Kandy Nursing Home.png',

          description:
              'Kandy Nursing Home is a healthcare location in Kandy, helping visitors identify a nearby place for medical or health-related services when needed.',
        ),

        ServicePlace(
          name: 'Lakeside Adventist Hospital',

          type: 'Hospital',

          rating: 3.4,

          location: 'Kandy',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Lakeside+Adventist+Hospital+Kandy',

          imagePath:
              'assets/images/services/kandy/Lakeside Adventist Hospital.jpg',

          description:
              'Lakeside Adventist Hospital is a healthcare location in Kandy, helping visitors identify a nearby place for medical or health-related services when needed.',
        ),

        ServicePlace(
          name: "Sirimavo Bandaranaike Specialized Children's Hospital",

          type: 'Hospital',

          location: 'Kandy',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Sirimavo+Bandaranaike+Specialized+Childrens+Hospital+Kandy',

          imagePath:
              'assets/images/services/kandy/Sirimavo Bandaranaike Hospital.jpeg',

          description:
              'Sirimavo Bandaranaike Specialized Children\'s Hospital is a healthcare location in Kandy, helping visitors identify a nearby place for medical or health-related services when needed.',
        ),
      ],
    },

    // =========================================================

    // JAFFNA

    // =========================================================
    'Jaffna': {
      'Accommodation': [
        ServicePlace(
          name: 'Jetwing Jaffna',

          type: 'Hotel',

          rating: 4.3,

          location: 'Jaffna',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Jetwing+Jaffna',

          imagePath: 'assets/images/services/jaffna/jetwing Jaffna.jpg',

          description:
              'Jetwing Jaffna is an accommodation option in Jaffna, providing visitors with a convenient place to stay while exploring nearby attractions.',
        ),

        ServicePlace(
          name: 'North Gate Jaffna',

          type: 'Hotel',

          rating: 4.6,

          location: 'Jaffna',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=North+Gate+Jaffna',

          imagePath: 'assets/images/services/jaffna/North Gate Jaffna.jpg',

          description:
              'North Gate Jaffna is an accommodation option in Jaffna, providing visitors with a convenient place to stay while exploring nearby attractions.',
        ),

        ServicePlace(
          name: 'The Thinnai Jaffna',

          type: 'Hotel',

          rating: 4.4,

          location: 'Jaffna',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=The+Thinnai+Jaffna',

          imagePath: 'assets/images/services/jaffna/The Thinnai Jaffna.jpg',

          description:
              'The Thinnai Jaffna is an accommodation option in Jaffna, providing visitors with a convenient place to stay while exploring nearby attractions.',
        ),

        ServicePlace(
          name: 'Valampuri Hotel',

          type: 'Hotel',

          rating: 3.9,

          location: 'Jaffna',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Valampuri+Hotel+Jaffna',

          imagePath: 'assets/images/services/jaffna/Valampuri Hotel.jpg',

          description:
              'Valampuri Hotel is an accommodation option in Jaffna, providing visitors with a convenient place to stay while exploring nearby attractions.',
        ),

        ServicePlace(
          name: 'Green Grass Hotel & Restaurant',

          type: 'Hotel',

          rating: 3.7,

          location: 'Jaffna',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Green+Grass+Hotel+Jaffna',

          imagePath:
              'assets/images/services/jaffna/Green Grass Hotel & Restaurant.jpeg',

          description:
              'Green Grass Hotel & Restaurant is an accommodation option in Jaffna, providing visitors with a convenient place to stay while exploring nearby attractions.',
        ),

        ServicePlace(
          name: 'Tilko Jaffna City Hotel',

          type: 'Hotel',

          location: 'Jaffna',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Tilko+Jaffna+City+Hotel',

          imagePath:
              'assets/images/services/jaffna/Tilko Jaffna City Hotel.jpg',

          description:
              'Tilko Jaffna City Hotel is an accommodation option in Jaffna, providing visitors with a convenient place to stay while exploring nearby attractions.',
        ),
      ],

      'Food & Restaurants': [
        ServicePlace(
          name: 'Malayan Cafe',

          type: 'Restaurant',

          rating: 4.0,

          location: 'Jaffna',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Malayan+Cafe+Jaffna',

          imagePath: 'assets/images/services/jaffna/Malayan Cafe.png',

          description:
              'Malayan Cafe is a dining option in Jaffna, offering visitors a convenient place to stop for a meal during their journey.',
        ),

        ServicePlace(
          name: 'Mangos Indian Veg',

          type: 'Restaurant',

          rating: 4.0,

          location: 'Jaffna',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Mangos+Indian+Veg+Jaffna',

          imagePath: 'assets/images/services/jaffna/Mangos Indian Veg.jpg',

          description:
              'Mangos Indian Veg is a dining option in Jaffna, offering visitors a convenient place to stop for a meal during their journey.',
        ),

        ServicePlace(
          name: 'Nallur Bhavan',

          type: 'Restaurant',

          rating: 4.0,

          location: 'Jaffna',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Nallur+Bhavan+Jaffna',

          imagePath: 'assets/images/services/jaffna/Nallur Bhavan.png',

          description:
              'Nallur Bhavan is a dining option in Jaffna, offering visitors a convenient place to stop for a meal during their journey.',
        ),

        ServicePlace(
          name: 'Cosy Restaurant',

          type: 'Restaurant',

          rating: 3.7,

          location: 'Jaffna',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Cosy+Restaurant+Jaffna',

          imagePath: 'assets/images/services/jaffna/Cosy Restaurant.jpg',

          description:
              'Cosy Restaurant is a dining option in Jaffna, offering visitors a convenient place to stop for a meal during their journey.',
        ),

        ServicePlace(
          name: 'Lingan Cream House',

          type: 'Restaurant',

          rating: 4.1,

          location: 'Jaffna',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Lingan+Cream+House+Jaffna',

          imagePath: 'assets/images/services/jaffna/Lingan Cream House.jpg',

          description:
              'Lingan Cream House is a dining option in Jaffna, offering visitors a convenient place to stop for a meal during their journey.',
        ),

        ServicePlace(
          name: 'Green Grass Restaurant',

          type: 'Restaurant',

          location: 'Jaffna',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Green+Grass+Restaurant+Jaffna',

          imagePath: 'assets/images/services/jaffna/Green Grass Restaurant.jpg',

          description:
              'Green Grass Restaurant is a dining option in Jaffna, offering visitors a convenient place to stop for a meal during their journey.',
        ),
      ],

      'Parking': [
        ServicePlace(
          name: 'Jaffna Fort Parking Area',

          type: 'Parking',

          location: 'Jaffna Fort',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Jaffna+Fort+Parking',

          imagePath:
              'assets/images/services/jaffna/Jaffna Fort Parking Area.jpg',

          description:
              'Jaffna Fort Parking Area is a parking location in Jaffna Fort, providing a convenient place for visitors to leave their vehicle while exploring nearby attractions.',
        ),

        ServicePlace(
          name: 'Nallur Kandaswamy Temple Parking',

          type: 'Parking',

          location: 'Nallur, Jaffna',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Nallur+Kandaswamy+Temple+Parking',

          imagePath:
              'assets/images/services/jaffna/Nallur Kandaswamy Temple Parking.jpg',

          description:
              'Nallur Kandaswamy Temple Parking is a parking location in Nallur, Jaffna, providing a convenient place for visitors to leave their vehicle while exploring nearby attractions.',
        ),

        ServicePlace(
          name: 'Jaffna Railway Station Parking',

          type: 'Parking',

          location: 'Jaffna Railway Station',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Jaffna+Railway+Station+Parking',

          imagePath:
              'assets/images/services/jaffna/Jaffna Railway Station Parking.jpg',

          description:
              'Jaffna Railway Station Parking is a parking location in Jaffna Railway Station, providing a convenient place for visitors to leave their vehicle while exploring nearby attractions.',
        ),

        ServicePlace(
          name: 'Jaffna Public Library Parking',

          type: 'Parking',

          location: 'Jaffna Public Library',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Jaffna+Public+Library+Parking',

          imagePath:
              'assets/images/services/jaffna/Jaffna Public Library Parking.jpg',

          description:
              'Jaffna Public Library Parking is a parking location in Jaffna Public Library, providing a convenient place for visitors to leave their vehicle while exploring nearby attractions.',
        ),

        ServicePlace(
          name: 'Jaffna Bus Stand Parking',

          type: 'Parking',

          location: 'Jaffna Bus Stand',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Jaffna+Bus+Stand+Parking',

          imagePath:
              'assets/images/services/jaffna/Jaffna Bus Stand Parking.jpg',

          description:
              'Jaffna Bus Stand Parking is a parking location in Jaffna Bus Stand, providing a convenient place for visitors to leave their vehicle while exploring nearby attractions.',
        ),

        ServicePlace(
          name: 'Jaffna Market Parking',

          type: 'Parking',

          location: 'Jaffna Market',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Jaffna+Market+Parking',

          imagePath: 'assets/images/services/jaffna/Jaffna Market Parking.jpg',

          description:
              'Jaffna Market Parking is a parking location in Jaffna Market, providing a convenient place for visitors to leave their vehicle while exploring nearby attractions.',
        ),
      ],

      'Health Services': [
        ServicePlace(
          name: 'Teaching Hospital Jaffna',

          type: 'Government Hospital',

          rating: 4.1,

          location: 'Jaffna',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Teaching+Hospital+Jaffna',

          imagePath:
              'assets/images/services/jaffna/Teaching Hospital Jaffna.jpg',

          description:
              'Teaching Hospital Jaffna is a healthcare location in Jaffna, helping visitors identify a nearby place for medical or health-related services when needed.',
        ),

        ServicePlace(
          name: 'Northern Central Hospital',

          type: 'Private Hospital',

          rating: 2.6,

          location: 'Jaffna',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Northern+Central+Hospital+Jaffna',

          imagePath:
              'assets/images/services/jaffna/Northern Central Hospital.jpeg',

          description:
              'Northern Central Hospital is a healthcare location in Jaffna, helping visitors identify a nearby place for medical or health-related services when needed.',
        ),

        ServicePlace(
          name: 'New Yarl Hospital',

          type: 'Hospital',

          rating: 3.4,

          location: 'Jaffna',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=New+Yarl+Hospital+Jaffna',

          imagePath: 'assets/images/services/jaffna/New Yarl Hospital.jpg',

          description:
              'New Yarl Hospital is a healthcare location in Jaffna, helping visitors identify a nearby place for medical or health-related services when needed.',
        ),

        ServicePlace(
          name: 'STS Hospital Jaffna',

          type: 'Hospital',

          location: 'Jaffna',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=STS+Hospital+Jaffna',

          imagePath: 'assets/images/services/jaffna/STS Hospital Jaffna.jpg',

          description:
              'STS Hospital Jaffna is a healthcare location in Jaffna, helping visitors identify a nearby place for medical or health-related services when needed.',
        ),

        ServicePlace(
          name: 'Philip Nursing Home',

          type: 'Hospital',

          location: 'Jaffna',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Philip+Nursing+Home+Jaffna',

          imagePath: 'assets/images/services/jaffna/Philip Nursing Home.jpg',

          description:
              'Philip Nursing Home is a healthcare location in Jaffna, helping visitors identify a nearby place for medical or health-related services when needed.',
        ),

        ServicePlace(
          name: 'Divisional Hospital Chavakachcheri',

          type: 'Government Hospital',

          location: 'Chavakachcheri',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Divisional+Hospital+Chavakachcheri',

          imagePath:
              'assets/images/services/jaffna/Divisional Hospital Chavakachcheri.jpg',

          description:
              'Divisional Hospital Chavakachcheri is a healthcare location in Chavakachcheri, helping visitors identify a nearby place for medical or health-related services when needed.',
        ),
      ],
    },

    // =========================================================

    // DOWN SOUTH

    // =========================================================
    'Down South': {
      'Accommodation': [
        ServicePlace(
          name: 'Jetwing Lighthouse - Galle',

          type: 'Hotel',

          rating: 4.5,

          location: 'Galle',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Jetwing+Lighthouse+Galle',

          imagePath: 'assets/images/services/downsouth/Jetwing Lighthouse.png',

          description:
              'Jetwing Lighthouse - Galle is an accommodation option in Galle, providing visitors with a convenient place to stay while exploring nearby attractions.',
        ),

        ServicePlace(
          name: 'Le Grand Galle',

          type: 'Hotel',

          rating: 4.5,

          location: 'Galle',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Le+Grand+Galle',

          imagePath: 'assets/images/services/downsouth/Le Grand Galle.jpg',

          description:
              'Le Grand Galle is an accommodation option in Galle, providing visitors with a convenient place to stay while exploring nearby attractions.',
        ),

        ServicePlace(
          name: 'The Heritage Hotel Galle Fort',

          type: 'Hotel',

          rating: 4.5,

          location: 'Galle Fort',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=The+Heritage+Hotel+Galle+Fort',

          imagePath:
              'assets/images/services/downsouth/The Heritage Hotel Galle Fort.jpg',

          description:
              'The Heritage Hotel Galle Fort is an accommodation option in Galle Fort, providing visitors with a convenient place to stay while exploring nearby attractions.',
        ),

        ServicePlace(
          name: 'Araliya Beach Resort & Spa - Unawatuna',

          type: 'Resort',

          rating: 4.3,

          location: 'Unawatuna',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Araliya+Beach+Resort+Unawatuna',

          imagePath:
              'assets/images/services/downsouth/Araliya Beach Resort & Spa.jpg',

          description:
              'Araliya Beach Resort & Spa - Unawatuna is an accommodation option in Unawatuna, providing visitors with a convenient place to stay while exploring nearby attractions.',
        ),

        ServicePlace(
          name: 'Weligama Bay Marriott Resort & Spa',

          type: 'Resort',

          rating: 4.6,

          location: 'Weligama',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Weligama+Bay+Marriott+Resort',

          imagePath:
              'assets/images/services/downsouth/Weligama Bay Marriott Resort & Spa.jpg',

          description:
              'Weligama Bay Marriott Resort & Spa is an accommodation option in Weligama, providing visitors with a convenient place to stay while exploring nearby attractions.',
        ),

        ServicePlace(
          name: 'Mandara Resort Mirissa',

          type: 'Resort',

          rating: 4.1,

          location: 'Mirissa',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Mandara+Resort+Mirissa',

          imagePath:
              'assets/images/services/downsouth/Mandara Resort Mirissa.jpg',

          description:
              'Mandara Resort Mirissa is an accommodation option in Mirissa, providing visitors with a convenient place to stay while exploring nearby attractions.',
        ),
      ],

      'Food & Restaurants': [
        ServicePlace(
          name: 'The Tuna & The Crab - Galle Fort',

          type: 'Restaurant',

          rating: 4.3,

          location: 'Galle Fort',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=The+Tuna+and+The+Crab+Galle',

          imagePath:
              'assets/images/services/downsouth/The Tuna & The Crab – Galle Fort.jpg',

          description:
              'The Tuna & The Crab - Galle Fort is a dining option in Galle Fort, offering visitors a convenient place to stop for a meal during their journey.',
        ),

        ServicePlace(
          name: "Pedlar's Inn Cafe - Galle Fort",

          type: 'Restaurant',

          rating: 4.2,

          location: 'Galle Fort',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Pedlars+Inn+Cafe+Galle',

          imagePath:
              "assets/images/services/downsouth/Pedlar's Inn Cafe – Galle Fort.jpg",

          description:
              'Pedlar\'s Inn Cafe - Galle Fort is a dining option in Galle Fort, offering visitors a convenient place to stop for a meal during their journey.',
        ),

        ServicePlace(
          name: 'A Minute by Tuk Tuk - Galle Fort',

          type: 'Restaurant',

          rating: 4.2,

          location: 'Galle Fort',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=A+Minute+by+Tuk+Tuk+Galle',

          imagePath:
              'assets/images/services/downsouth/A Minute by Tuk Tuk – Galle Fort.jpg',

          description:
              'A Minute by Tuk Tuk - Galle Fort is a dining option in Galle Fort, offering visitors a convenient place to stop for a meal during their journey.',
        ),

        ServicePlace(
          name: 'Wijaya Beach Restaurant - Unawatuna',

          type: 'Restaurant',

          rating: 4.1,

          location: 'Unawatuna',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Wijaya+Beach+Restaurant+Unawatuna',

          imagePath:
              'assets/images/services/downsouth/Wijaya Beach Restaurant.jpg',

          description:
              'Wijaya Beach Restaurant - Unawatuna is a dining option in Unawatuna, offering visitors a convenient place to stop for a meal during their journey.',
        ),

        ServicePlace(
          name: 'Zephyr Restaurant & Bar - Mirissa',

          type: 'Restaurant',

          location: 'Mirissa',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Zephyr+Restaurant+Mirissa',

          imagePath:
              'assets/images/services/downsouth/Zephyr Restaurant & Bar.jpg',

          description:
              'Zephyr Restaurant & Bar - Mirissa is a dining option in Mirissa, offering visitors a convenient place to stop for a meal during their journey.',
        ),

        ServicePlace(
          name: 'Dewmini Roti Shop - Mirissa',

          type: 'Restaurant',

          rating: 4.5,

          location: 'Mirissa',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Dewmini+Roti+Shop+Mirissa',

          imagePath: 'assets/images/services/downsouth/Dewmini Roti Shop.jpg',

          description:
              'Dewmini Roti Shop - Mirissa is a dining option in Mirissa, offering visitors a convenient place to stop for a meal during their journey.',
        ),
      ],

      'Parking': [
        ServicePlace(
          name: 'Galle Fort Parking',

          type: 'Parking',

          location: 'Galle Fort',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Galle+Fort+Parking',

          imagePath: 'assets/images/services/downsouth/Galle Fort Parking.jpg',

          description:
              'Galle Fort Parking is a parking location in Galle Fort, providing a convenient place for visitors to leave their vehicle while exploring nearby attractions.',
        ),

        ServicePlace(
          name: 'Galle Fort Court Square Parking',

          type: 'Parking',

          location: 'Galle Fort',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Galle+Fort+Court+Square+Parking',

          imagePath:
              'assets/images/services/downsouth/Galle Fort Court Square Parking.jpg',

          description:
              'Galle Fort Court Square Parking is a parking location in Galle Fort, providing a convenient place for visitors to leave their vehicle while exploring nearby attractions.',
        ),

        ServicePlace(
          name: 'Galle Railway Station Parking',

          type: 'Parking',

          location: 'Galle Railway Station',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Galle+Railway+Station+Parking',

          imagePath:
              'assets/images/services/downsouth/Galle Railway Station Parking.jpg',

          description:
              'Galle Railway Station Parking is a parking location in Galle Railway Station, providing a convenient place for visitors to leave their vehicle while exploring nearby attractions.',
        ),

        ServicePlace(
          name: 'Unawatuna Beach Parking',

          type: 'Parking',

          location: 'Unawatuna',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Unawatuna+Beach+Parking',

          imagePath:
              'assets/images/services/downsouth/Unawatuna Beach Parking.jpg',

          description:
              'Unawatuna Beach Parking is a parking location in Unawatuna, providing a convenient place for visitors to leave their vehicle while exploring nearby attractions.',
        ),

        ServicePlace(
          name: 'Mirissa Beach Parking',

          type: 'Parking',

          location: 'Mirissa',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Mirissa+Beach+Parking',

          imagePath:
              'assets/images/services/downsouth/Mirissa Beach Parking.jpg',

          description:
              'Mirissa Beach Parking is a parking location in Mirissa, providing a convenient place for visitors to leave their vehicle while exploring nearby attractions.',
        ),

        ServicePlace(
          name: 'Weligama Beach Parking',

          type: 'Parking',

          location: 'Weligama',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Weligama+Beach+Parking',

          imagePath:
              'assets/images/services/downsouth/Weligama Beach Parking.jpg',

          description:
              'Weligama Beach Parking is a parking location in Weligama, providing a convenient place for visitors to leave their vehicle while exploring nearby attractions.',
        ),
      ],

      'Health Services': [
        ServicePlace(
          name: 'Teaching Hospital Karapitiya',

          type: 'Government Hospital',

          location: 'Karapitiya, Galle',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Teaching+Hospital+Karapitiya',

          imagePath:
              'assets/images/services/downsouth/Teaching Hospital Karapitiya.jpg',

          description:
              'Teaching Hospital Karapitiya is a healthcare location in Karapitiya, Galle, helping visitors identify a nearby place for medical or health-related services when needed.',
        ),

        ServicePlace(
          name: 'Asiri Hospital Galle',

          type: 'Private Hospital',

          rating: 3.9,

          location: 'Galle',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Asiri+Hospital+Galle',

          imagePath:
              'assets/images/services/downsouth/Asiri Hospital Galle.jpg',

          description:
              'Asiri Hospital Galle is a healthcare location in Galle, helping visitors identify a nearby place for medical or health-related services when needed.',
        ),

        ServicePlace(
          name: 'Co-operative Hospital Galle',

          type: 'Hospital',

          rating: 2.2,

          location: 'Galle',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Co-operative+Hospital+Galle',

          imagePath:
              'assets/images/services/downsouth/Co-operative Hospital Galle.jpg',

          description:
              'Co-operative Hospital Galle is a healthcare location in Galle, helping visitors identify a nearby place for medical or health-related services when needed.',
        ),

        ServicePlace(
          name: 'District General Hospital Matara',

          type: 'Government Hospital',

          location: 'Matara',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=District+General+Hospital+Matara',

          imagePath:
              'assets/images/services/downsouth/District General Hospital Matara.jpg',

          description:
              'District General Hospital Matara is a healthcare location in Matara, helping visitors identify a nearby place for medical or health-related services when needed.',
        ),

        ServicePlace(
          name: 'Asiri Hospital Matara',

          type: 'Private Hospital',

          rating: 4.2,

          location: 'Matara',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Asiri+Hospital+Matara',

          imagePath:
              'assets/images/services/downsouth/Asiri Hospital Matara.jpg',

          description:
              'Asiri Hospital Matara is a healthcare location in Matara, helping visitors identify a nearby place for medical or health-related services when needed.',
        ),

        ServicePlace(
          name: 'New Philip Hospital Kalutara',

          type: 'Hospital',

          location: 'Kalutara',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=New+Philip+Hospital+Kalutara',

          imagePath:
              'assets/images/services/downsouth/New Philip Hospital Kalutara.jpg',

          description:
              'New Philip Hospital Kalutara is a healthcare location in Kalutara, helping visitors identify a nearby place for medical or health-related services when needed.',
        ),
      ],
    },

    // =========================================================

    // DAMBULLA

    // =========================================================
    'Dambulla': {
      'Accommodation': [
        ServicePlace(
          name: 'Heritance Kandalama',

          type: 'Hotel',

          rating: 4.7,

          location: 'Kandalama',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Heritance+Kandalama',

          imagePath: 'assets/images/services/dambulla/Heritance Kandalama.jpg',

          description:
              'Heritance Kandalama is an accommodation option in Kandalama, providing visitors with a convenient place to stay while exploring nearby attractions.',
        ),

        ServicePlace(
          name: 'Jetwing Lake Dambulla',

          type: 'Hotel',

          rating: 4.7,

          location: 'Dambulla',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Jetwing+Lake+Dambulla',

          imagePath:
              'assets/images/services/dambulla/Jetwing Lake Dambulla.jpg',

          description:
              'Jetwing Lake Dambulla is an accommodation option in Dambulla, providing visitors with a convenient place to stay while exploring nearby attractions.',
        ),

        ServicePlace(
          name: 'The Paradise Resort & Spa Dambulla',

          type: 'Resort',

          location: 'Dambulla',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=The+Paradise+Resort+Dambulla',

          imagePath:
              'assets/images/services/dambulla/The Paradise Resort & Spa Dambulla.jpg',

          description:
              'The Paradise Resort & Spa Dambulla is an accommodation option in Dambulla, providing visitors with a convenient place to stay while exploring nearby attractions.',
        ),

        ServicePlace(
          name: 'Tropical Life Resort & Spa',

          type: 'Resort',

          rating: 4.5,

          location: 'Dambulla',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Tropical+Life+Resort+Dambulla',

          imagePath:
              'assets/images/services/dambulla/Tropical Life Resort & Spa.jpg',

          description:
              'Tropical Life Resort & Spa is an accommodation option in Dambulla, providing visitors with a convenient place to stay while exploring nearby attractions.',
        ),

        ServicePlace(
          name: 'Rangiri Dambulla Resort',

          type: 'Resort',

          rating: 4.4,

          location: 'Dambulla',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Rangiri+Dambulla+Resort',

          imagePath:
              'assets/images/services/dambulla/Rangiri Dambulla Resort.jpg',

          description:
              'Rangiri Dambulla Resort is an accommodation option in Dambulla, providing visitors with a convenient place to stay while exploring nearby attractions.',
        ),

        ServicePlace(
          name: 'Sundaras Resort & Spa',

          type: 'Resort',

          location: 'Dambulla',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Sundaras+Resort+Dambulla',

          imagePath:
              'assets/images/services/dambulla/Sundaras Resort & Spa.jpg',

          description:
              'Sundaras Resort & Spa is an accommodation option in Dambulla, providing visitors with a convenient place to stay while exploring nearby attractions.',
        ),
      ],

      'Food & Restaurants': [
        ServicePlace(
          name: 'Rangiri Luuv Restaurant',

          type: 'Restaurant',

          rating: 4.8,

          location: 'Dambulla',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Rangiri+Luuv+Restaurant+Dambulla',

          imagePath:
              'assets/images/services/dambulla/Rangiri Luuv Restaurant.jpg',

          description:
              'Rangiri Luuv Restaurant is a dining option in Dambulla, offering visitors a convenient place to stop for a meal during their journey.',
        ),

        ServicePlace(
          name: 'Bamboo Restaurant Dambulla',

          type: 'Restaurant',

          rating: 4.6,

          location: 'Dambulla',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Bamboo+Restaurant+Dambulla',

          imagePath: 'assets/images/services/dambulla/Bamboo Restaurant.jpg',

          description:
              'Bamboo Restaurant Dambulla is a dining option in Dambulla, offering visitors a convenient place to stop for a meal during their journey.',
        ),

        ServicePlace(
          name: 'Cafe Kirikopi',

          type: 'Restaurant',

          rating: 4.9,

          location: 'Dambulla',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Cafe+Kirikopi+Dambulla',

          imagePath: 'assets/images/services/dambulla/Cafe Kirikopi.jpg',

          description:
              'Cafe Kirikopi is a dining option in Dambulla, offering visitors a convenient place to stop for a meal during their journey.',
        ),

        ServicePlace(
          name: 'Ketha Addara Restaurant',

          type: 'Restaurant',

          rating: 5.0,

          location: 'Dambulla',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Ketha+Addara+Restaurant+Dambulla',

          imagePath:
              'assets/images/services/dambulla/Ketha Addara Restaurant.jpeg',

          description:
              'Ketha Addara Restaurant is a dining option in Dambulla, offering visitors a convenient place to stop for a meal during their journey.',
        ),

        ServicePlace(
          name: 'Lantharuma Restaurant',

          type: 'Restaurant',

          rating: 4.9,

          location: 'Dambulla',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Lantharuma+Restaurant+Dambulla',

          imagePath:
              'assets/images/services/dambulla/Lantharuma Restaurant.jpg',

          description:
              'Lantharuma Restaurant is a dining option in Dambulla, offering visitors a convenient place to stop for a meal during their journey.',
        ),

        ServicePlace(
          name: 'Eleven Restaurant',

          type: 'Restaurant',

          rating: 4.7,

          location: 'Dambulla',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Eleven+Restaurant+Dambulla',

          imagePath: 'assets/images/services/dambulla/Eleven Restaurant.jpg',

          description:
              'Eleven Restaurant is a dining option in Dambulla, offering visitors a convenient place to stop for a meal during their journey.',
        ),
      ],

      'Parking': [
        ServicePlace(
          name: 'Dambulla Cave Temple Parking',

          type: 'Parking',

          location: 'Dambulla Cave Temple',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Dambulla+Cave+Temple+Parking',

          imagePath:
              'assets/images/services/dambulla/Dambulla Cave Temple Parking.jpg',

          description:
              'Dambulla Cave Temple Parking is a parking location in Dambulla Cave Temple, providing a convenient place for visitors to leave their vehicle while exploring nearby attractions.',
        ),

        ServicePlace(
          name: 'Golden Temple Parking',

          type: 'Parking',

          location: 'Golden Temple, Dambulla',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Golden+Temple+Dambulla+Parking',

          imagePath:
              'assets/images/services/dambulla/Golden Temple Parking.jpg',

          description:
              'Golden Temple Parking is a parking location in Golden Temple, Dambulla, providing a convenient place for visitors to leave their vehicle while exploring nearby attractions.',
        ),

        ServicePlace(
          name: 'Dambulla Dedicated Economic Centre Parking',

          type: 'Parking',

          location: 'Dambulla',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Dambulla+Dedicated+Economic+Centre+Parking',

          imagePath:
              'assets/images/services/dambulla/Dambulla Dedicated Economic Centre Parking.jpg',

          description:
              'Dambulla Dedicated Economic Centre Parking is a parking location in Dambulla, providing a convenient place for visitors to leave their vehicle while exploring nearby attractions.',
        ),

        ServicePlace(
          name: 'Rangiri Dambulla Stadium Parking',

          type: 'Parking',

          location: 'Rangiri Dambulla Stadium',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Rangiri+Dambulla+Stadium+Parking',

          imagePath:
              'assets/images/services/dambulla/Rangiri Dambulla Stadium Parking.jpg',

          description:
              'Rangiri Dambulla Stadium Parking is a parking location in Rangiri Dambulla Stadium, providing a convenient place for visitors to leave their vehicle while exploring nearby attractions.',
        ),

        ServicePlace(
          name: 'Dambulla Bus Stand Parking',

          type: 'Parking',

          rating: 4.0,

          location: 'Dambulla Bus Stand',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Dambulla+Bus+Stand+Parking',

          imagePath:
              'assets/images/services/dambulla/Dambulla Bus Stand Parking.png',

          description:
              'Dambulla Bus Stand Parking is a parking location in Dambulla Bus Stand, providing a convenient place for visitors to leave their vehicle while exploring nearby attractions.',
        ),

        ServicePlace(
          name: 'Ibbankatuwa Megalithic Tombs Parking',

          type: 'Parking',

          location: 'Ibbankatuwa',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Ibbankatuwa+Megalithic+Tombs+Parking',

          imagePath:
              'assets/images/services/dambulla/Ibbankatuwa Megalithic Tombs Parking.png',

          description:
              'Ibbankatuwa Megalithic Tombs Parking is a parking location in Ibbankatuwa, providing a convenient place for visitors to leave their vehicle while exploring nearby attractions.',
        ),
      ],

      'Health Services': [
        ServicePlace(
          name: 'Base Hospital Dambulla',

          type: 'Government Hospital',

          location: 'Dambulla',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Base+Hospital+Dambulla',

          imagePath:
              'assets/images/services/dambulla/Base Hospital Dambulla.jpg',

          description:
              'Base Hospital Dambulla is a healthcare location in Dambulla, helping visitors identify a nearby place for medical or health-related services when needed.',
        ),

        ServicePlace(
          name: 'Dambulla Hospital',

          type: 'Hospital',

          location: 'Dambulla',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Dambulla+Hospital',
          description:
              'Dambulla Hospital is a healthcare location in Dambulla, helping visitors identify a nearby place for medical or health-related services when needed.',
        ),

        ServicePlace(
          name: 'Dambulla Medical Centre',

          type: 'Medical Centre',

          location: 'Dambulla',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Dambulla+Medical+Centre',

          imagePath:
              'assets/images/services/dambulla/Dambulla Medical Centre.jpg',

          description:
              'Dambulla Medical Centre is a healthcare location in Dambulla, helping visitors identify a nearby place for medical or health-related services when needed.',
        ),

        ServicePlace(
          name: 'Suwapiyasa Medical Centre Dambulla',

          type: 'Medical Centre',

          location: 'Dambulla',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Suwapiyasa+Medical+Centre+Dambulla',

          imagePath:
              'assets/images/services/dambulla/Suwapiyasa Medical Centre.jpg',

          description:
              'Suwapiyasa Medical Centre Dambulla is a healthcare location in Dambulla, helping visitors identify a nearby place for medical or health-related services when needed.',
        ),

        ServicePlace(
          name: 'Ayurvedic Hospital Dambulla',

          type: 'Hospital',

          location: 'Dambulla',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Ayurvedic+Hospital+Dambulla',

          imagePath:
              'assets/images/services/dambulla/Ayurvedic Hospital Dambulla.jpg',

          description:
              'Ayurvedic Hospital Dambulla is a healthcare location in Dambulla, helping visitors identify a nearby place for medical or health-related services when needed.',
        ),

        ServicePlace(
          name: 'Medical Centre - Dambulla Town',

          type: 'Medical Centre',

          location: 'Dambulla Town',

          mapUrl:
              'https://www.google.com/maps/search/?api=1&query=Medical+Centre+Dambulla+Town',
          description:
              'Medical Centre - Dambulla Town is a healthcare location in Dambulla Town, helping visitors identify a nearby place for medical or health-related services when needed.',
        ),
      ],
    },
  };
}
