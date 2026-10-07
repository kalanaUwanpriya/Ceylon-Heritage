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

          galleryImages: [
            'https://www.heritagehotel.lk/img/Pool/1.png',
            'https://www.heritagehotel.lk/img/rooms/4.jpg',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSmVkwjcX2CJH1jrgYB5AMqZ_UZHt1uCSFRE6lhLDOJNexuyoqpOdR9Mr05&s=10',
            'https://pix10.agoda.net/property/69566959/0/d419cc92e609d4932b8743c8af7a74f1.jpeg?ce=2&s=414x232',
          ],
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

          galleryImages: [
            'https://rajaratahotel.lk/images/pool-view-1.jpg',
            'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0e/1c/d7/4b/rajarata-hotel.jpg?w=900&h=500&s=1',
            'https://cf.bstatic.com/xdata/images/hotel/max1024x768/892462885.jpg?k=f35802bc1c5019b294f396e4187942cc5bc374c6812a3e956a368bc200aa3e42&o=',
            'https://rajaratahotel.lk/images/Lobby-1.jpg',
            'https://images.trvl-media.com/lodging/12000000/11850000/11848600/11848595/71afafe8.jpg?impolicy=resizecrop&rw=575&rh=575&ra=fill',
          ],
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

          galleryImages: [
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ7UuV4bESWL1PnmDRaJxJQm8KqRV2_OV3dXzFd7vx69qOeV2jsZ0Ixyida&s=10',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQK78WMkw_LSRmpwTpyeRcIvbhV2Ty_0HTaDZe-9mvfYT9_mY7rUUKWZAs&s=10',
            'https://q-xx.bstatic.com/xdata/images/hotel/max500/518963583.jpg?k=d17d8c9acb9ee4104c3eca31c56e08947484aa2a36253fe53f2804d1d75bbcd1&o=',
            'https://content.skyscnr.com/available/2321972130/2321972130_WxH.jpg',
            'https://cf.bstatic.com/xdata/images/hotel/max1024x768/876986813.jpg?k=a7390c19bcde0b0a82966a2df425b6fb977e5cedb477d5977d49c4070cbf22d5&o=',
          ],
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

          galleryImages: [
            'https://cf.bstatic.com/xdata/images/hotel/max1024x768/737093388.jpg?k=621d75b2805caee2bc0d5253909e09882fc6671063637692e6ac05ef6594c791&o=',
            'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/18/72/27/f5/hotel-alakamanda.jpg?w=900&h=500&s=1',
            'https://cf.bstatic.com/xdata/images/hotel/max1024x768/210730405.jpg?k=5ebe72b4751b7417995d6980acae8409100b6d93ce8e0a2e200b0b003d04ba74&o=',
            'https://d29x2fs0pkfwqm.cloudfront.net/property_photos/large/44873780/bfe045767f8511e8bd8a020471db6fe0_large.jpg',
            'https://pix10.agoda.net/hotelImages/315680/0/d6fd3955ea6e34e59bedd000f6578ba9.jpg?ce=2&s=414x232',
            'https://q-xx.bstatic.com/xdata/images/hotel/840x460/737093897.jpg?k=53bf01e74085b0de0a0e1463292ba20cc56bfbba438bf58f6449f2a8b04adaf7&o=&a=1925256',
          ],
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

          galleryImages: [
            'https://cf.bstatic.com/xdata/images/hotel/max1024x768/327325762.jpg?k=65e37fd1841049889fdb42d16323fa082f02b43abf623595fed55086d3af3c44&o=',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQYsAm_FbfixmUeXcU7a0TVu0CosVy21mFU0V79DGwV5iL7T6RzEbySUNY&s=10',
            'https://lakeforesthotel.com/wp-content/uploads/2015/02/the-lake-forest-hotel-anuradhapura-sri-lanka-family-suites-full-750x370.jpg',
            'https://lakeforesthotel.com/wp-content/uploads/2021/05/the-lake-forest-hotel-room-forest-view-04-500x500.jpg',
            'https://lakeforesthotel.com/wp-content/uploads/2021/05/the-lake-forest-hotel-cart-page-cover.jpg',
          ],
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

          galleryImages: [
            'https://cf.bstatic.com/xdata/images/hotel/max1024x768/382636890.jpg?k=d7ab86ae823df175dbed20976ab1340588575691f80aacb2993c89de5f076c28&o=',
            'https://images.trvl-media.com/lodging/17000000/16540000/16530400/16530327/85b38eff.jpg?impolicy=resizecrop&rw=575&rh=575&ra=fill',
            'https://pix10.agoda.net/hotelImages/1061931/-1/57fc9e0f7b1fa84da19bf150161b2bd3.jpg?ce=0&s=414x232',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTP_b-BF_kyDlJ5RNCFIEhq-5fEnOBfoKdOkVaHMiPH4XHuyKyZIFDDcEd3&s=10',
          ],
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

          galleryImages: [
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTjzrAclSYBefj1RcQSWhZGxITOHQhes3AfbYldiRg7f_StWjEKQ7ai9O7r&s=10',
            'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/30/b4/5e/0d/caption.jpg?w=1100&h=1100&s=1',
            'https://d3fphkxyf5o5bm.cloudfront.net/image-resize/format=webp,w=720/Q524tReNnAnmuqp47hOEhGz3KcaVCkbo4ZXDl0AEIF',
          ],
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

          galleryImages: [
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQSX47yPVwTYB-UAPGjklq3p24-yQEI6heOi4zwdEy8nw&s=10',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTErKUnS3MjbsuKn8wFluYO8dLEf7b_DSEwxL2kgUPC8M0UEky_7bhsSro1&s=10',
            'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/32/07/90/53/bro-restaurant-anuradhapura.jpg?w=1200&h=1200&s=1',
            'https://menueka.com/wp-content/uploads/2023/08/Menueka.com-Bro-Restaurant-3.jpg',
          ],
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

          galleryImages: [
            'https://seedevirestaurant.com/wp-content/uploads/2023/05/seedevi-wedding-hall-anuradhapura_571_737.webp',
            'https://seedevirestaurant.com/wp-content/uploads/2023/05/pubs-in-anuradhapura_458_518.webp',
            'https://seedevirestaurant.com/wp-content/uploads/2023/05/cafe_in_anuradhapura_MAR_2944.webp',
          ],
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

          galleryImages: [
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUCkV7-uB9Pj-pLMnYp4wRGQp04DdZqO2SNC2kZZkQCWvE-kN-wWtjylc&s=10',
            'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/2f/7a/f0/78/sorriso.jpg?w=500&h=-1&s=1',
            'https://cdn.phuket.net/bucket/directory/size/600/400/2025/06/202506060701_qaHB_003.jpeg',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQa8yjICDuUj_Hr9eoEizkqa522TVh1QrOvgAr6m6m22pTLclOvKxMAoD6M&s=10',
          ],
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

          galleryImages: [
            'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/2e/41/f1/1f/new-dining-area.jpg?w=1200&h=1200&s=1',
            'https://media-cdn.tripadvisor.com/media/photo-s/19/be/26/61/palhena-restaurant-opened.jpg',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYAgrP-8AnQ6dG8axqIPf3u_0F-sC0PlvqKr2FQHvjbdyJW6etjrReDn4&s=10',
          ],
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

          galleryImages: [
            'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/31/ea/d2/b7/special-kings-town-rice.jpg?w=900&h=900&s=1',
            'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/31/ea/d2/bf/lunch-menu-rice-with.jpg?w=900&h=900&s=1',
          ],
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

          galleryImages: [
            'https://cf.bstatic.com/xdata/images/hotel/max1024x768/711012940.jpg?k=81b1d9d1b9c8e42076e8666b1ad558e29828572930d1973ab2b47577b50fcdc3&o=',
            'https://cf.bstatic.com/xdata/images/hotel/max1024x768/426525015.jpg?k=b8360f0a2792173093c22fc65f44bcd0141fddd3d84281bc7d88120d4e8798fe&o=',
            'https://cf.bstatic.com/xdata/images/hotel/max1024x768/426525076.jpg?k=0f348e7498d0d041447ae598856263cb5a80a84e24286531ae079e669b3324ec&o=',
            'https://www.chcplc.com/wp-content/uploads/2021/08/lake-house-ekho.jpg',
            'https://pix10.agoda.net/hotelImages/646/646935/646935_17030810560051422825.jpg?va=1&ca=6&ce=1&s=414x232',
            'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0e/d0/6b/14/the-royal-suite.jpg?w=900&h=500&s=1',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS2uGb1PSNBpz0k2-NhsauJJkAu5t8ORZsJ77fDBflyGxv6zsePrqMNlfFd&s=10',
          ],
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

          galleryImages: [
            'https://cf.bstatic.com/xdata/images/hotel/max1024x768/182078629.jpg?k=7e8657d8dc8ab04c9cde565ef20ae765d14f91f0fe4c4ba8f0a5e0f4649f1464&o=',
            'https://q-xx.bstatic.com/xdata/images/hotel/max500/420504830.jpg?k=0e3690d5f458e0748a3c67004632024285367e3493ab3b3382cb2241259bf5a9&o=',
            'https://do6raq9h04ex.cloudfront.net/sites/6/2024/06/hotel-sudu-araliya-srilanka-hotel-dining-tree-1920x900-1.jpg',
            'https://q-xx.bstatic.com/xdata/images/hotel/max500/420504839.jpg?k=c63a264bb4b14239c8ef8fce606957e36462c9a023428718bcc0484c9e6c0ae6&o=',
            'https://do6raq9h04ex.cloudfront.net/sites/6/2021/08/800x915-presidential-suite-new-1.jpg',
            'https://do6raq9h04ex.cloudfront.net/sites/6/2021/04/deluxe-gallery-thumb-3.jpg',
            'https://q-xx.bstatic.com/xdata/images/hotel/max500/182078643.jpg?k=e2e62743a3a2ab908c22b54916c8db3f4e39ab01c8196bdc076d869be9e6ddf8&o=',
            'https://do6raq9h04ex.cloudfront.net/sites/6/2024/06/lake-view-1920x900-1.jpg',
          ],
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

          galleryImages: [
            'https://cf.bstatic.com/xdata/images/hotel/max1024x768/503661569.jpg?k=c92e9ce04afcb1884f1eabad557ccc8db4e09a8f4fe8ea617cc27515b0d53840&o=',
            'https://a.otcdn.com/imglib/hotelphotos/0/8/4649/hotel-lake-park-polonnaruwa-20231218090749839300.webp',
            'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/32/a9/cc/37/caption.jpg?w=1000&h=1000&s=1',
            'https://pix10.agoda.net/hotelImages/400/400946/400946_16091919230046627644.jpg?ca=6&ce=1&s=414x232',
          ],
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

          galleryImages: [
            'https://cf.bstatic.com/xdata/images/hotel/max1024x768/766322830.jpg?k=f03fa882daf16754aa4e104509dcdc221947b6e2f9e6fa8839ac77c9658cd146&o=',
            'https://q-xx.bstatic.com/xdata/images/hotel/840x460/766323362.jpg?k=13e68510a333e81f976f7922bfa72d85343cc479e7b5f829924a3035f9b4ef81&o=',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQgadz1KbP9--VzwbRd_Fp2cWrK3cXJVBwkujAW771a37I8cS9nNgK1FmI9&s=10',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR6y0e0suqaJz5u3UleEZitV7-VHO2lJHWejdm4yd_Y-8ZP2ez1UgQFAAJZ&s=10',
          ],
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

          galleryImages: [
            'https://cf.bstatic.com/xdata/images/hotel/max1024x768/648018185.jpg?k=ba4a69005b56b246b6a80091027021cf809a3b7f2d5f644cdcabf116f9e5583d&o=',
            'https://q-xx.bstatic.com/xdata/images/hotel/max500/663379992.jpg?k=bed0a3224af7b937f7e74f84ed6bb05f350f3b6a8c43ed554e1ae6ba4aabc3d0&o=&a=2195102',
            'https://content.skyscnr.com/available/2115432891/2115432891_WxH.jpg',
            'https://q-xx.bstatic.com/xdata/images/hotel/840x460/672864242.jpg?k=a571aa277481ec875c2470012613b0a082a5d841d4eea77269089f9685db1a3f&o=&a=1925256',
            'https://lh3.googleusercontent.com/proxy/WMdxyrH4in10EoVTjKuW3bx2Lv0UeqUdGfNs9sE4i4hILSVV1l3YvT6zZssuPqwp0WQeJQ_NIh7rf3tR0TKCavGYvCgi77l6E4l9h_EIeJSjBhz59rc479KwpqE5NbYC9vKQvDB-rIfo8on5PJZxALKTMV1fPw=w624-h312-n-k',
          ],
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

          galleryImages: [
            'https://q-xx.bstatic.com/xdata/images/hotel/max500/825824421.jpg?k=313b013beb9106353b130489d3deecbe09846d9e1f13bb7e506ca430205fb2de&o=',
            'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/2a/1e/0d/95/agbo-hotel.jpg?w=1200&h=-1&s=1',
            'https://pix10.agoda.net/hotelImages/263/263039/263039_120109121526146.jpg?va=1&ca=0&ce=1&s=414x232',
            'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/34/54/ec/20/caption.jpg?w=900&h=500&s=1',
            'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/34/54/ec/28/caption.jpg?w=900&h=500&s=1',
          ],
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

          galleryImages: [
            'https://media-cdn.tripadvisor.com/media/photo-s/2b/56/8e/1c/caption.jpg',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS28RqtMY278UObOQH22SWOMmwVsIQ6SgQQ5CtgntUI65rZTZJxTdQlZ14&s=10',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRJwCCTP70lufDunYuf4MF2TtmW421uGaYtAepCuIidnX8eIhJi6iYNtj8r&s=10',
          ],
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

          galleryImages: [
            'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/16/2e/11/6f/jaga-food.jpg?w=500&h=-1&s=1',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ44fC-BmyaUbFSx15NLYyVENvYyrwUcPuAiX-TjSsfZJop3_sEEg2s4u0&s=10',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRIp99_9RNWXShn6sTQGOcmj5VROc8NBAUuDadS_hfjv7fnFOLQFPP1xAWe&s=10',
          ],
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

          galleryImages: [
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3T6nk814Aca5lsPDp6f7eCwDunR-Tc6L0rr_Ud1QAXkNfyDL1iiCS2jba&s=10',
            'https://q-xx.bstatic.com/xdata/images/hotel/max500/187278173.jpg?k=e59f2f917bd2ec9fbea121289a7a02cb5b250bd30e62710d67348674b0f1b30c&o=',
            'https://q-xx.bstatic.com/xdata/images/hotel/max500/187278160.jpg?k=b22184c53ccd6378a5c05bf690ee8298aef72db28fa2ec891035e0e755e5fc02&o=',
          ],
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

          galleryImages: [
            'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/28/d4/20/13/feel-the-difference-of.jpg?w=1200&h=1200&s=1',
            'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/2b/1e/ff/9e/caption.jpg?w=1000&h=1000&s=1',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR-ZW11eu4FjA6CNaV83V75fUfStUOncX-Nbyvams4-E2dhTMwvWsTUyukC&s=10',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRy1WFtDwITXav3OQMoMQcJ67fNM0Fz1X7tonqF-DLo-P4yyCxQXMStCpc&s=10',
          ],
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

          galleryImages: [
            'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/2b/05/19/96/shop-front.jpg?w=1200&h=1200&s=1',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTuBNgpsxX1PiR_yrDMFuxIYgGsvQu-tEfOifNtMKr4wOiGzMRjcpRf-xHE&s=10',
            'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/2d/41/a4/83/caption.jpg?w=700&h=700&s=1',
          ],
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

          galleryImages: [
            'https://q-xx.bstatic.com/xdata/images/hotel/max500/393244805.jpg?k=77da8a0fa63ccfb427ba72f0ac4828850489e845ae2779e5629cd9ecedf84fca&o=',
            'https://cf.bstatic.com/xdata/images/hotel/max1024x768/265486111.jpg?k=a8df82f5928fbbb313150a76f10d0a61ba602c3247aebe485d433ab92dad6a54&o=',
            'https://q-xx.bstatic.com/xdata/images/hotel/max500/265488236.jpg?k=52ed1351dbcf3c90c52d2b70a0cb3b8785523070dfd7ef0ef24de289833738ff&o=',
          ],
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

          galleryImages: [
            'https://cf.bstatic.com/xdata/images/hotel/max1024x768/84970651.jpg?k=dbbd231a11c6db6a641857fb8fc164c3d3c273a9fd66f28b14acbc66174c2b62&o=',
            'https://media.expedia.com/hotels/13000000/12340000/12331100/12331083/7acd0a80_z.jpg',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShIgTiYq4TUGrkZ4JD0kiHi_O03Y0_Jj5DBQeZWO0A-WQDOBtvisQbDcTO&s=10',
            'https://pix10.agoda.net/hotelImages/734/734551/734551_17090812500056147800.jpg?ca=6&ce=1&s=414x232',
            'https://q-xx.bstatic.com/xdata/images/hotel/max500/84970610.jpg?k=b188be1aae1c460c9b29ba00fab12c18954722ed05dd19cd3148aa0d01d0abf6&o=',
            'https://pix10.agoda.net/hotelImages/734551/-1/d424ac429f117d0c80c885c67edb8207.jpg?ca=7&ce=1&s=414x232',
          ],
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

          galleryImages: [
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQBjqc5rUcvyfFuRTmYuqrdHDAlqiwGRNuYueFETDEoKIQG3CWXnqhj6IB0&s=10',
            'https://cf.bstatic.com/xdata/images/hotel/max1024x768/742954797.jpg?k=c7fb85b602096a94eda6f0006c7d211359a5f615aed1333e972fe1bc9a62b280&o=',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvoWrpOwjuZZvAYsM2rOp_qm7jMF9VaRoneaKWgXM3VKIr4rPlG1U-Im0&s=10',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS33dBhmwpCKyt8QHQSXpGpY3yAYda5HMBwncDR5DCTufV2pWHpwb3eKnFe&s=10',
          ],
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

          galleryImages: [
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3tIerbLXynvBSsrG8zNlLleOSoy4MqOn3n_sB4-nxtnMLCgnQ53Vkaoql&s=10',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQFBXy7IYMEjDPbmR54mGMLvuqHaozBHhnsGaQWy9EQeAnrtrjdC_vw1kx2&s=10',
            'https://cf.bstatic.com/xdata/images/hotel/max1024x768/701827840.jpg?k=599d47d8a9dec241df16aa993224590eb5c7f4def9d6d98d086a6d2294a10d5c&o=',
            'https://pix10.agoda.net/hotelImages/76757/0/1e1ac219b6dbf69800b6e8c9850f0baf.jpg?ce=2&s=414x232',
            'https://images.trvl-media.com/lodging/13000000/12230000/12230000/12229991/dfa0ad68.jpg?impolicy=resizecrop&rw=575&rh=575&ra=fill',
            'https://pix10.agoda.net/hotelImages/76757/0/248df47b19d2dbb5430babb013777683.jpg?ce=2&s=414x232',
            'https://www.chcplc.com/wp-content/uploads/2021/08/hotelsuisse-kandy-accommodation.jpg',
          ],
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

          galleryImages: [
            'https://pix10.agoda.net/hotelImages/31540710/0/0a9f112caed9a371b4207dc7c2419d4a.jpeg?ce=2&s=414x232',
            'https://media.radissonhotels.net/image/radisson-hotel-kandy/exterior/16256-124733-f75010924_3xl.jpg?impolicy=HomeHero',
            'https://images.trvl-media.com/lodging/11000000/10450000/10442700/10442617/w3840h2156x0y4-e9855878.jpg?impolicy=resizecrop&rw=575&rh=575&ra=fill',
            'https://images.trvl-media.com/lodging/11000000/10450000/10442700/10442617/c8d17458.jpg?impolicy=resizecrop&rw=575&rh=575&ra=fill',
            'https://foto.hrsstatic.com/fotos/0/2/800/458/80/000000/http%3A%2F%2Ffoto-origin.hrsstatic.com%2Ffoto%2Fdms%2F789142%2FAMADEUS%2F8fa7e82fd7c840778e11bb1193ed2301.jpeg/fc329d6796502dccc8bca9d43e9cf67d/512%2C341/6/Radisson_Hotel_Kandy-Kandy-Room-12-789142.jpg',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREOEeeI6xeHoaXgK4xo9xXSveOeMJm_Ux-M55VuetJ_zKc2-_8Ar_NX4d3&s=10',
            'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/07/e1/d6/1d/ozo-kandy-sri-lanka.jpg?w=900&h=500&s=1',
          ],
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

          galleryImages: [
            'https://d3a2q5al71qg9.cloudfront.net/sites/2/2021/01/Slide4.jpg',
            'https://d3a2q5al71qg9.cloudfront.net/sites/2/2021/01/Slide2.jpg',
            'https://d3a2q5al71qg9.cloudfront.net/sites/2/2021/01/Slide1.jpg',
            'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/1b/86/b6/7d/earl-s-regency-hotel.jpg?w=900&h=500&s=1',
            'https://d3a2q5al71qg9.cloudfront.net/sites/2/2021/01/1-8.jpg',
            'https://pix10.agoda.net/hotelImages/66613/-1/369f48b6a38d1d09725399e9469c7f28.jpg?va=1&ca=6&ce=1&s=414x232',
            'https://d3a2q5al71qg9.cloudfront.net/sites/2/2021/01/1-4.jpg',
          ],
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

          galleryImages: [
            'https://media.timeout.com/images/101889485/image.jpg',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR4GMTNF0XmTMj1UnQyWquEy8wNpfcJHrtKfIIzLBPtbHKZ1rKejbMKO18&s=10',
            'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0f/b7/5d/6a/swiss-residence.jpg?w=900&h=500&s=1',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwXHDj46HQMcIVyw5i6Eb5auc4QHyJ4RTGrdmoeqtf9Q&s=10',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSgHi1Q_a0_tyagq7r_HQEb4IMzhvCAxInL8QVYfV0bjCsZaC9PQ8CY_pw&s=10',
          ],
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

          galleryImages: [
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQnehpfVhfXU5M8h4TGAsfB6y_xLH3R6fqpP4jmo3KWPGs-PnZkJfmBHc1&s=10',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR5aJV7x1olaa3yWNjeTqkGrgUmfNQ1M-EfP5kDlZC4hgSeJujAEVZXsr1o&s=10',
            'https://d2kihw5e8drjh5.cloudfront.net/eyJidWNrZXQiOiJ1dGEtaW1hZ2VzIiwia2V5IjoicGxhY2VfaW1nL25yX1BSNjNOUlJPN3A1ZXZZTzFIR0EiLCJlZGl0cyI6eyJyZXNpemUiOnsid2lkdGgiOjY0MCwiaGVpZ2h0Ijo2NDAsImZpdCI6Imluc2lkZSJ9LCJyb3RhdGUiOm51bGwsInRvRm9ybWF0IjogIndlYnAifX0=',
          ],
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

          galleryImages: [
            'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/28/14/15/ab/storefront.jpg?w=900&h=500&s=1',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT9lddyQ_5490rmw3ku9Hd4ApkskdCS3A19qzSf5UcjeUBJ7TNWKsysqaA&s=10',
            'https://media-cdn.tripadvisor.com/media/photo-s/0c/0f/8a/a3/20160715-180347-largejpg.jpg',
          ],
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

          galleryImages: [
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTLhmG58R33mh-83m4D85wQMWn3ihnwR8DT21aKoGQyI-MwjKuDKbemzKU&s=10',
            'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/12/83/d7/c5/cafe-divine-street.jpg?w=1000&h=1000&s=1',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTks0vBwCh-MEx-ZtqGfi7cllJ5kqsUQGUdQ4HsNW2WCKenLjSC_Ghz3PY5&s=10',
          ],
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

          galleryImages: [
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQcYqYk4BLwz075asgj2Hj9wptsB7c95zlLTWbmZ64GqCVcLc9k7hW1EK4&s=10',
            'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/30/61/3a/64/caption.jpg?w=1100&h=1100&s=1',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSMM2MTCySe5YEbOvZKPwDE4By1uSskLUnkZdg0O6aLYLpZ2B5xR4DIVEs&s=10',
            'https://media.timeout.com/images/102044059/750/422/image.jpg',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ4M-08BYjl9DG6mGhtzSnmmLsILku_Wr7vBrXH1m47UdiSAaNXGIdvAt6L&s=10',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQfkiJWu0Jo6NgPuxEJLxv4nMLqskQPQh_jeFNAIkkbahURfQ9EJk0c5iI&s=10',
          ],
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

          galleryImages: [
            'https://ceylonpages.lk/wp-content/uploads/2025/03/World-Spicejpg_gallery_7343.jpeg',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOt1vXwmK_aqD3GhmWPnGV7zkKvIdy1dhVvHZlXC58VFnThGMKhuAOVc3A&s=10',
            'https://ceylonpages.lk/wp-content/uploads/2025/03/World-Spice-Ijpg_gallery_7343-1024x768.jpeg',
            'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/31/c1/8c/bb/caption.jpg?w=200&h=200&s=1',
          ],
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

          galleryImages: [
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAkBPBL67TXHrtbp0Q_4Tyd8GVUcJJQDqG-Om50XTang5ZAQJGssqmRn8&s=10',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJIajEzpiI4K1Owd-nsdT9THHPwK91jUwQublTIrrycQ&s',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwjEAqA1Zs2hn20K71fobUGBwGcE3Zqag--NR6m-3pWw&s=10',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQL-tjvxnV0RqfXNoO3APNNVHCT02OAZFdLcc0eP_4GGrXgEfb3_nULzLc&s=10',
          ],
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

          galleryImages: [
            'https://ak-d.tripcdn.com/images/220j0v000000jov6j41DF_R_960_660_R5_D.webp',
            'https://www.jetwinghotels.com/jetwingjaffna/wp-content/uploads/sites/11/2024/11/Jewing-Jaffna-1200x630-1.jpg',
            'https://www.jetwinghotels.com/jetwingjaffna/wp-content/uploads/sites/11/2024/10/Deluxe-Room-600x400-1.jpg',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRnrdkmeVvsYFpLOvoVUW_-970wjz9thTHlsMvggMsbrMto02Fw-i0ZjzA&s=10',
            'https://media-cdn.tripadvisor.com/media/photo-s/14/21/eb/23/lobby.jpg',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTLSf8fSlFkrrC4XmpZhjoJdydUzFhOxRoOme7gmnOtMLBuQvwCPPROcCPI&s=10',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNkhjfkgClohlasXJ8aztailgBHA1bXGTfPU7Glq9ANCnb9vuA4facgYQ&s=10',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQyvTqpOOJ4_6KDEDY9G6ilS7lZ4YGMNvUyqfl13N9pfEtqGYm-Th0xI0cD&s=10',
          ],
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

          galleryImages: [
            'https://cf.bstatic.com/xdata/images/hotel/max1024x768/139168307.jpg?k=94f0de215c35fcd2ef3533409d73e64dfcaf2b89d3d844eccd7082bf2bd8a924&o=',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSuOckxGHQP82xRH21syAmq1B4q_m6ACsnaK9whxgad7Z6MzQOxb_tgdNSS&s=10',
            'https://images.trvl-media.com/lodging/23000000/22280000/22276500/22276412/7cad70a3.jpg?impolicy=resizecrop&rw=575&rh=575&ra=fill',
            'https://cf.bstatic.com/xdata/images/hotel/max1024x768/147962572.jpg?k=bc7fb2d061cea0330bba601acb020b22f721d5cb41c48b698ce63581849cce27&o=',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR-9t_cAyQZ5mq8QOKTW8vc7okMiu_IHsxN8oxmkpUOj5BydHfvth-3Lwo&s=10',
            'https://images.trvl-media.com/lodging/23000000/22280000/22276500/22276412/a1350efc.jpg?impolicy=resizecrop&rw=575&rh=575&ra=fill',
          ],
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

          galleryImages: [
            'https://q-xx.bstatic.com/xdata/images/hotel/max500/584960348.jpg?k=da52a3e0ce8a7635d491bc1e55112bbc9b8ba2cb0bf50a95fec515ff17a48450&o=',
            'https://thethinnai.com/wp-content/uploads/2017/07/Blog1-1.jpg',
            'https://cf.bstatic.com/xdata/images/hotel/max1024x768/584958242.jpg?k=1089d8d75ec651d5ce8a0219c29223b91fb9524dcca5f6c35163030791aa3474&o=',
            'https://cf.bstatic.com/xdata/images/hotel/max1024x768/584956139.jpg?k=65f0be30eaa4b0a691b08d713711039e2d235be36d45daab7d60425dbb313795&o=',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTAKL7v7O_SrmkkbyB0_6iJjWPbU3EFymm91tY24M3T0fZay2svQZtnPaLT&s=10',
            'https://q-xx.bstatic.com/xdata/images/hotel/max500/584960192.jpg?k=9e87695af88681011e79b3e50f33696b3d136d58436eefc4855657e778909322&o=',
          ],
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

          galleryImages: [
            'https://r-xx.bstatic.com/xdata/images/hotel/1200x630/171034872.jpg?k=6269f8c83290d5fd6f4d71db08758352be8d90f481242753a8905acca18e7eab&o=',
            'https://cf.bstatic.com/xdata/images/hotel/max1024x768/276739123.jpg?k=692a7bb7a306ac3a33e9291b56b7abe79b0e090a158f9e71b48ac15e54688b67&o=',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrs_t_CrKI7LI3pjmku0zeZYKjvJJNDE1maJHv921WET-wKl1TNbsaWs0B&s=10',
            'https://pix10.agoda.net/hotelImages/869409/-1/fef7b8419262561402863ef8c4f44505.jpg?ca=7&ce=1&s=414x232',
            'https://cf.bstatic.com/xdata/images/hotel/max1024x768/47569997.jpg?k=865f9566dc6aae63148c6a8ceac14c161710a6ad05ee71e2ccc757ebc795ba6b&o=',
          ],
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

          galleryImages: [
            'https://pix10.agoda.net/hotelImages/409399/0/b3f79ecae772c57566dc8e0a7f764d9b.jpeg?va=1&ce=3&s=414x232',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR-n0X8Qii3JcA-5_SCdedHmFaSr8iuFP4MdLQU8E-R1ocmidC_UfnQ_dHT&s=10',
            'https://pix10.agoda.net/hotelImages/409/409399/409399_16082919320045895809.jpg?va=1&ca=6&ce=1&s=414x232',
            'https://cf.bstatic.com/xdata/images/hotel/max1024x768/171033880.jpg?k=6aada965834e211fe6c59604c436f558cd95fc34d89787478495fd3a8f74de24&o=',
            'https://q-xx.bstatic.com/xdata/images/hotel/max500/171033985.jpg?k=1971263c658bdb52a99c653e00930e5c3536add80080ac0c537840034a055f74&o=',
            'https://cf.bstatic.com/xdata/images/hotel/max1024x768/171029877.jpg?k=01b6e9ae1ab835a193e33a8a3f00b0bfe6b48786d47242a2c41c518de20f061f&o=',
          ],
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

          galleryImages: [
            'https://pix10.agoda.net/hotelImages/400552/0/b93f3b253d254e0693f9d9ab85458591.jpeg?ce=0&s=414x232',
            'https://q-xx.bstatic.com/xdata/images/hotel/max500/550582059.jpg?k=0a4bc61f452350447c0facb58ded36df80d53e9d21697eeaeaf240180fa19b3d&o=',
            'https://pix10.agoda.net/hotelImages/400552/-1/daa7568a01a29048cc0709ab98ea9910.jpg?ca=9&ce=1&s=414x232',
            'https://q-xx.bstatic.com/xdata/images/hotel/max500/551291466.jpg?k=3c243dfbd0cd9b7cd25700a3f5b70bb4d404ab5a9a34a759b904ca44310fed2c&o=',
            'https://q-xx.bstatic.com/xdata/images/hotel/max500/550616287.jpg?k=bfc3ad57fb6bedf2a1556b3522df4b183fbdfd2074ef514c6357762b0ad9fbf6&o=',
          ],
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

          galleryImages: [
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRoLqus6qKOBVJVcx8gBPFTj5C86hxyoOgcvOEAqD596HvL-bRV9TWtdXo&s=10',
            'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/08/dc/d8/2b/malayan-cafe.jpg?w=600&h=-1&s=1',
            'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0c/1a/c3/26/wanted-to-try-everything.jpg?w=800&h=800&s=1',
          ],
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

          galleryImages: [
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRlkk-xNyw_WcWC2EKDYlPyRs1wf681Uy4sEkX6bjgx-AeFX69dpKdMTbLt&s=10',
            'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/2e/b3/83/4f/caption.jpg?w=400&h=300&s=1',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSkjZrV9DRyl2woqJQ98izBJMaudmyDl346qGjm6D8_vouVHK_9lL2ID6Pp&s=10',
          ],
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

          galleryImages: [
            'https://media.evendo.com/locations-resized/RestaurantImages/550x400/b7936ab3-07ef-4878-808f-3a395ad31be4',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmtlBMC9fSjmbSI3DsdKu1Odv6nE0GqCzOELpFOJ6Hd0xVBWu1PRHIg6o&s=10',
            'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0e/10/4d/11/photo1jpg.jpg?w=200&h=200&s=1',
          ],
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

          galleryImages: [
            'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/11/97/e8/7c/photo0jpg.jpg?w=1200&h=-1&s=1',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9PbX7JwBUNiV7Z-xnz5jSB19cetZ9GjeuJTh3W2xzR-ZEG6PHwkn7KCc9&s=10',
            'https://cf.bstatic.com/xdata/images/hotel/max1024x768/781774024.jpg?k=f4093923b541c56e0c1fce07b312463f5d3959674bd6057306484343341d6cbb&o=',
            'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/15/2b/be/60/cosy-restaurant.jpg?w=400&h=300&s=1',
          ],
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

          galleryImages: [
            'https://lingancreamhouse.lk/assets/about-banner-hQ2yl19B.png',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS4vYcY_O5zniVUe_X8ipjcpDN_DB9geBQ0bz45yO1Bf4fATA0VKbmpKtxk&s=10',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRCqYGMtaxhrtcJnsLTJ_OC57zzrfQQuXcPiTwPAKMyvRk2ICl8Q5Tzmyvo&s=10',
          ],
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

          galleryImages: [
            'https://cf.bstatic.com/xdata/images/hotel/max1024x768/171033967.jpg?k=61cdcdf1edd6dc7aef1b7391b368c2c08ed22b86943619883a35b81693d296a8&o=',
            'https://q-xx.bstatic.com/xdata/images/hotel/max500/171034442.jpg?k=d632b47a7bd2ce44a28cb41edeeb3acbb507a7d10c8ade1f7ca8fabc5ad3ad4a&o=',
            'https://media-cdn.tripadvisor.com/media/photo-s/04/4d/6f/d0/green-grass-hotel.jpg',
          ],
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

          galleryImages: [
            'https://cf.bstatic.com/xdata/images/hotel/max1024x768/490937419.jpg?k=db375a7f6605f58e61e5c215e67b123fb574b467d15a784387c7b2b04cc272c0&o=',
            'https://cf.bstatic.com/xdata/images/hotel/max1024x768/255502043.jpg?k=d71dfa9a82aa57cab6037dec16e669155264b933b6f635f3a0da19e6a391df10&o=',
            'https://www.jetwinghotels.com/jetwinglighthouse/wp-content/uploads/sites/10/2025/08/Themed-Suites-1040x580-1.jpg',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQBdf8CVASww_vil0LAJOIoPI6qQw8wkMSBzey0qDbTYFJ74-U4LyOoOK0&s=10',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS3jk3XjGgwg1dKfwy8ahgll8RgO70DFaKFQtosXCZRYjWKp5MRQqyAif_c&s=10',
            'https://q-xx.bstatic.com/xdata/images/hotel/max500/481222380.jpg?k=950ee66a06d8c4eaa245bc79ca900e749a456ca66351117f90431f0751ee1e84&o=',
            'https://www.jetwinghotels.com/jetwinglighthouse/wp-content/uploads/sites/10/2024/11/Jewing-Lighthouse-1200x630-1.jpg',
          ],
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

          galleryImages: [
            'https://pix10.agoda.net/property/77029028/0/368533503244d5a4c8c1e6cc1cb8ba58.jpeg?va=1&ce=2&s=414x232',
            'https://q-xx.bstatic.com/xdata/images/hotel/max500/675815795.jpg?k=98eb15060781fdfccbddb55f54a354199c599ef3a4bc0d4f67ea9b0d6398d444&o=',
            'https://d3eklcfi2wom17.cloudfront.net/2023/12/Super-Deluxe-Room-feature-800x800-1.jpg',
            'https://static51.com-hotel.com/uploads/hotel/72433/photo/le-grand-galle-by-asia-leisure_15688741851.jpg',
            'https://images.trvl-media.com/lodging/25000000/24020000/24010700/24010679/2d766e8c.jpg?impolicy=resizecrop&rw=575&rh=575&ra=fill',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWuWAVgaK1KzfTYjFekGPQFkTI2z3VT6p2oyez7zDwrgDqrkgIDXJvBJs&s=10',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTyY6cyPUouCr6X-PcjGYHFNydsJy9nMedEZ2qDOUIFzgDuDPxLlUxx4g&s=10',
          ],
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

          galleryImages: [
            'https://cf.bstatic.com/xdata/images/hotel/max1024x768/164564814.jpg?k=d43e671673262eb2c98a06cc1b3712e9e519b1df9a15cf2f30c119d173ae0084&o=',
            'https://cf.bstatic.com/xdata/images/hotel/max1024x768/261977399.jpg?k=f4d82500296faca109952d7689d7fb1340facd67c3597d8bc9f5d563534fed6e&o=',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTWnx3dYWnZVdozfHqcznkqETN6-WQuRCfrhlswSrraf5WBhyTgEGh-1x4&s=10',
            'https://cf.bstatic.com/xdata/images/hotel/max1024x768/164564926.jpg?k=29ccf77c4135b5beda1b7c62c08c1b3786fd4467130b3141cc7992e274c5ac71&o=',
            'https://cf.bstatic.com/xdata/images/hotel/max1024x768/261982676.jpg?k=555ae2e119c663ccc6b9247d0e147b60c22df1fe0308cf60a4c82dad442e3999&o=',
          ],
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

          galleryImages: [
            'https://pix10.agoda.net/hotelImages/31041806/0/068e95b2d30c775170552c22f1660067.jpg?va=1&ce=0&s=414x232',
            'https://pix10.agoda.net/hotelImages/31041806/-1/b9f60356cf185a6536ad407364a03119.jpg?va=1&ce=0&s=414x232',
            'https://cf.bstatic.com/xdata/images/hotel/max1024x768/561419536.jpg?k=35f16a9a3ffee6b952a81ad7346a321afe4b99ec26cdaaed4e0c9f14d0cd3f7d&o=',
            'https://do6raq9h04ex.cloudfront.net/sites/2/2024/06/beach-club-intro-feat-1.jpg',
            'https://do6raq9h04ex.cloudfront.net/sites/2/2024/06/deluxe-list-feat-1.jpg',
            'https://do6raq9h04ex.cloudfront.net/sites/2/2024/06/contact-mob-banner.jpg',
          ],
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

          galleryImages: [
            'https://ik.imgkit.net/3vlqs5axxjf/external/https://www.cfmedia.vfmleonardo.com/imageRepo/2/0/210/445/717/gJBwPPpe60OhFmVAwjbCQ_aerial-35109_O.jpg?tr=w-1200%2Cfo-auto',
            'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/11/1b/58/f9/poolside.jpg?w=900&h=500&s=1',
            'https://cf.bstatic.com/xdata/images/hotel/max1024x768/437361439.jpg?k=75ca6f4c13d8d6f258495685bb32c2fb5e665bd5590996b1643953a7bad1aa7f&o=',
            'https://cache.marriott.com/content/dam/marriott-renditions/CMBMC/cmbmc-suite-0041-hor-wide.jpg?output-quality=70&interpolation=progressive-bilinear&downsize=1336px:*',
            'https://pix10.agoda.net/hotelImages/5546545/995532282/2ae91819a55ac2638671a04e67af719a.jpeg?va=1&ce=0&s=414x232',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQyv5sq_vmSOaRVoplJbUxG4nxFvbpIdmqzNL6t2fO4MA&s',
            'https://images.trvl-media.com/lodging/20000000/19420000/19413500/19413442/1677449c.jpg?impolicy=resizecrop&rw=575&rh=575&ra=fill',
            'https://q-xx.bstatic.com/xdata/images/hotel/max500/818950707.jpg?k=797aeca6da468f4f4ed49ce22484dac95fe226c2517e3af66f22dd60c1868e93&o=',
          ],
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

          galleryImages: [
            'https://cf.bstatic.com/xdata/images/hotel/max1024x768/73241181.jpg?k=8e3ce973665c205beef7d64da5d1ea7b02b563644e2f82b1dd8fdb8f0042cb87&o=',
            'https://cf.bstatic.com/xdata/images/hotel/max1024x768/73240878.jpg?k=ff6537a25e15f9ac77a60f08a12f5d1d75c4fb77f4d107ffb91aebc112f4e2b0&o=',
            'https://q-xx.bstatic.com/xdata/images/hotel/max500/73240738.jpg?k=d006d78a3210d98d2f5d5416aacd0bd3ec010662611692b5c2edd2ab8881601b&o=',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPKMH27sHYUAm9KQ7FLd3X2yvkw9YQrGoqCed9ExOf5EN-c5O8pTAiDFyT&s=10',
            'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/16/a7/60/8f/mandara-resort.jpg?w=900&h=-1&s=1',
          ],
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

          galleryImages: [
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRY6AS9Uxk2RKzDooEXfhWhzgoWXYTMaUGA11pDCkQNnUqYOAabc8NRVA0&s=10',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQR5FFSbCWKRPCcEC7TUG89KDyKIV52wAf36FCJAzi0W687VG3ehDJqFxc&s=10',
            'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/2d/4b/0e/aa/caption.jpg?w=1100&h=1100&s=1',
          ],
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

          galleryImages: [
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQWXp64ZbeDa2L4qBf1iF4XhFVao8_0FxU7jldGzhw5w8El7C3l6avR6Hw_&s=10',
            'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/05/87/61/11/pedlar-s-inn-cafe.jpg?w=900&h=500&s=1',
            'https://c8.alamy.com/comp/P446HE/pedlars-inn-cafe-galle-fort-sri-lanka-P446HE.jpg',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRGwZZrYcDujfvV_38NY1UISMv5x5eecYZnP5BYV-KXs1e6fAskMNaXcsft&s=10',
          ],
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

          galleryImages: [
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhFuY7fLJIm5cBOUlC8nySTdt2i_Yi8GF5DKwN5QQSXUn5AOT9pSna8OJM&s=10',
            'https://silvertraveladvisor.com/wp-content/uploads/2022/03/IMG_8360-2-scaled-1.jpg',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSDjP6vgZjebmkPcUYK81e5rxxQvp674RjBOgt05860xvo6l1CW0rAC5yI&s=10',
          ],
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

          galleryImages: [
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJOjeaTTgpFka1q-2lxFZ5l-F4pugNywVYF8CM6_dlmnQS-sNsQf3QK8TO&s=10',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRClTbEGeGjgw3SQxYtqO3zh6YzwEh8ElDUsrREKkWoO8Dg-mjLd40cAv0&s=10',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRXUAMj0NhFLM4UEXT9uS3ocHcTew2Mn0IeA81iXWGqm3Cm7JFNkfo2Eps&s=10',
          ],
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

          galleryImages: [
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQiNgOPd6iQKpUG5A0cLBRtQFlPvcvH6ZvtJegEOmkriQPMlUl8P5Hx_NtF&s=10',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRXq5t-7L0GlyuKsTlFUVFSTYzdr-xwqk-C_2XBWvUXuD2weppTjulPoEY&s=10',
            'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/2a/20/0c/f8/paradise-entrance.jpg?w=900&h=500&s=1',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSOl1d3PeQWmji6Tq8yrp8Wb9BhthATFsT_-rhcpWaft5605MHAg7EjMXUe&s=10',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcReUy2ONb3OObOGBksxHWPIfm3FSHugIYfrHbDTj6tiEOE8ltyW1qIcQBA&s=10',
          ],
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

          galleryImages: [
            'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/2e/43/96/3c/caption.jpg?w=900&h=500&s=1',
            'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/21/d5/c6/56/dewmini-roti-shop.jpg?w=1200&h=1200&s=1',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsONZQurGWcdoGBlMrqSh2WkOdUyxd30jcpkg9W1AUuTZO1UjgXUlSoJHq&s=10',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQuJk3qsToUh3gFaCOqdhDxVXYaY9W9sAFO_oWRXCqODQ&s',
          ],
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

          galleryImages: [
            'https://cf.bstatic.com/xdata/images/hotel/max1024x768/34687318.jpg?k=76cc5b29b46c9e95814271db622f8ce20030cc266d29818b451242f5c6e955c1&o=',
            'https://q-xx.bstatic.com/xdata/images/hotel/max500/106858415.jpg?k=9f83ea4aa80de551967cf5526e0731adc0a0f3056aa089c3329f05471705da3f&o=',
            'https://www.kayak.co.uk/rimg/himg/03/12/43/expedia_group-161426-91586791-464677.jpg?width=836&height=607&crop=true',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTiiCJzgV8oDzk0DiX8k_Y8Zb12JWdjJyA9ODz-j7f4IoRWtSeUc9UYGUsZ&s=10',
          ],
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

          galleryImages: [
            'https://cf.bstatic.com/xdata/images/hotel/max1024x768/122329342.jpg?k=a01127db6df26b57733f61e2f000bf4d2a43ccfe1153c7033b1d5a8122e7da1f&o=',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSd93y6JAMEwTZSTRDq4ljewKON3q5lXYroDN41GEHa2IgXdbIRxFoV2tgg&s=10',
            'https://images.trvl-media.com/lodging/16000000/15810000/15804900/15804813/e7a8c149.jpg?impolicy=resizecrop&rw=575&rh=575&ra=fill',
            'https://www.jetwinghotels.com/jetwinglake/wp-content/uploads/sites/8/2025/12/Jetwing-Lake-1920x900-1.jpg',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTXBYnDywbmvjPfPCZ8fMataUyAIvzW2XI4l_mg9oTV7JDeIPSNLp7S_YHO&s=10',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-YjncR1584zqT1Uvn8JAgg5YbOrE5abgit5Og4khevIMzx3NNZNUBDZwL&s=10',
          ],
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

          galleryImages: [
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYUy6YBADV8rDKl7RRRzWd5ctPhQWBkZOB0Uowx6sShT7Mk4DLszZ5OCKQ&s=10',
            'https://dz3vy4jhqsnnj.cloudfront.net/sites/11/2024/08/superior-duplex-hm-tab-feat.jpg',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSOWhpmzdymnBzbnsZGfI3m7ngGD28JMNFXIcvhDnShdFJCXCflWseoye4&s=10',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwC3ptBUwPQp2b7soI6J4HfUtLiw9NZOL4L7eBvUcaO8sMjJmytb956KE&s=10',
            'https://cf.bstatic.com/xdata/images/hotel/max1024x768/920673940.jpg?k=2500f1abe1b2f9638ac7120c82b820cf35a3ecbe034df777394b9892e34ed348&o=',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQThF-l1xizlqJeykI6bJ4pITI_kx57G07H3lj680VrSS4YPlUCgwIblrU&s=10',
          ],
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

          galleryImages: [
            'https://q-xx.bstatic.com/xdata/images/hotel/max500/187387540.jpg?k=f08feecf210269e298fdc28991bfe78043e86c94e54038dc28e3559fa10b8d3c&o=',
            'https://q-xx.bstatic.com/xdata/images/hotel/max500/187391954.jpg?k=694f7e47141699ee857ba078a81758980b802ec4fc7fd0f9f43d869a84394441&o=',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR8MwUz3BvelaRrTXI1iOcmKqvndGYJ67J2JIHDeVVD2s-4Lfpdb0_el54a&s=10',
            'https://cf.bstatic.com/xdata/images/hotel/max1024x768/189675849.jpg?k=46bb7d03d4b047d062a971bcaaaf88d4d96e8318bd9b3a97eb83e186ce9664e3&o=',
            'https://q-xx.bstatic.com/xdata/images/hotel/max500/187388359.jpg?k=6f799fb4f8dbfc7806792867986a85b44980178640cdd00f308770633979cf28&o=',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSZRZ3XA036i1Hgo6-REUN61zyFTbXn--AwAlJPdruDpH4BgLztZyIXZ_XT&s=10',
          ],
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

          galleryImages: [
            'https://cf.bstatic.com/xdata/images/hotel/max1024x768/165049126.jpg?k=70e5f420a0412c7002386067fb636152701ebafcbb0b78dc050f06d5a39848df&o=',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYz1rD2h1xaUX6SLtErGc1ADom6XxpyVBbJzSqUAVyNw&s=10',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhAObHVGbBYDhm2cqFWg5ODHGiyAuLZjOZag9D-_xH2tMI9UfN4GnV3wAU&s=10',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS2i_yY6dZJ5QYUR9usUiD3z_iWi__GgkuSkLELcxAZHoKtQqjx1KGpano&s=10',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTL1dfmoXBMzyGXl8zVD1XQ7Ctd3CNH9Hjo8lBa8qYLda-DC6f7U9fuX03K&s=10',
          ],
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

          galleryImages: [
            'https://pix10.agoda.net/hotelImages/290828/-1/edcf68526dee9c18e13dd8b13681271c.jpg?ca=10&ce=1&s=414x232',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRfomU_EEwoWl-1HEnN8ELO8OMcYuDBzTc4YylwRxI6owyEYD-TUKrAGltY&s=10',
            'https://cf.bstatic.com/xdata/images/hotel/max1024x768/862288183.jpg?k=7a79ade09001d3972df1643c129af18ad79f20f85e56aa13553df0d3939add49&o=',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvdA2bboOH1QHweTwYR-cxhMI6ju27JOhtCun5u3lCIjjjUvjU_NLyiZs&s=10',
          ],
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

          galleryImages: [
            'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/32/1e/da/f9/caption.jpg?w=1100&h=1100&s=1',
            'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/2e/79/98/22/at-rangiri-luuv-savor.jpg?w=1200&h=1200&s=1',
            'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRRZeXwiM3o4M87Ke7TtmFFtNyUIntzfnzwi-jcWEahZVm4XDyr4gR2NQ&s=10',
          ],
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

          galleryImages: [
            'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/33/d3/23/4b/caption.jpg?w=1100&h=1100&s=1',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSghNZtjosGY5_QnMEr8eOJeaomGeeyGVqu-arbLMLPh4eH0B412fepoTrf&s=10',
            'https://content.jdmagicbox.com/comp/varanasi/k7/0542px542.x542.231118095718.n1k7/catalogue/b36uogbv5un05e3-3qg87z3ez4.jpg',
          ],
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

          galleryImages: [
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQVppKQVmO74VeprpDevKR-wlFQLJegsekmdqPoRbywdiXefbARPsNN1kb0&s=10',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS3F0W7B1hqH-FFJEmYyaItOxkXWFj-bRumWgD4Xeeh0S0iKBOhfQnR-Nw_&s=10',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS9FXsF4jiFsZ1rks-rjYTHLSdUSM95ilvkUa5b5FWCCw&s',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQV85QbhJ8e9X6MMv8t7Iaj4LGlDy_Er3jydILGusXeSG-1NfcpR3yoMYY&s=10',
          ],
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

          galleryImages: [
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSe42UUawRaAX5CtoWxUkB2LS342_-ojgMV6Y_0Rr-itg&s',
            'https://d2kihw5e8drjh5.cloudfront.net/eyJidWNrZXQiOiJ1dGEtaW1hZ2VzIiwia2V5IjoicGxhY2VfaW1nL092UzdwaUpKVHUydVFMd0RXY2tvUVEiLCJlZGl0cyI6eyJyZXNpemUiOnsid2lkdGgiOjY0MCwiaGVpZ2h0Ijo2NDAsImZpdCI6Imluc2lkZSJ9LCJyb3RhdGUiOm51bGwsInRvRm9ybWF0IjogIndlYnAifX0=',
            'https://ceylonpages.lk/wp-content/uploads/2025/03/Ketha-Addara-Restaurant-2jpg_gallery_516829-1024x768.jpeg',
            'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/30/fd/db/37/caption.jpg?w=600&h=400&s=1',
          ],
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

          galleryImages: [
            'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/33/8f/ab/c2/i-m-lantheruma-owner.jpg?w=1200&h=1200&s=1',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQS3pc0Tq4qYjDt2HzZvaGxPwlMxesOXYrn-KFhwq9Ql3BIjS4OMnrgNQS6&s=10',
            'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/31/00/a0/8f/caption.jpg?w=200&h=200&s=1',
          ],
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

          galleryImages: [
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRfv4wyDOWlN23OMabb0h_joDqhrg6zxH5eiukJYQTd8msxegscHCp7A3s&s=10',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT77xvKM47QL5Y-LA_Pnc8qYkKKAR1NB5lf2E-XE_CKBw_FnlLC7WrCDcM&s=10',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTXgdcGAYP0Yq7MFGGAgw07P0VOjEZJZQueiSK1VokJzUTdh2I-INNNi0MU&s=10',
          ],
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
