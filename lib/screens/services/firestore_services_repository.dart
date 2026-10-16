import 'package:cloud_firestore/cloud_firestore.dart';

import 'service_data.dart';

class FirestoreServicesRepository {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  // New cities added by Admin Portal
  static Stream<List<Map<String, dynamic>>> watchCities() {
    return _db.collection('cities').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => {'id': doc.id, ...doc.data()})
          .where((city) => city['isActive'] != false)
          .toList();
    });
  }

  // New service categories
  static Stream<List<Map<String, dynamic>>> watchCategories() {
    return _db.collection('service_categories').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => {'id': doc.id, ...doc.data()})
          .where((category) => category['isActive'] != false)
          .toList();
    });
  }

  // New places for a selected city and category
  static Stream<List<ServicePlace>> watchPlaces(
    String cityName,
    String category,
  ) {
    return _db.collection('service_places').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => doc.data())
          .where(
            (data) =>
                data['isActive'] != false &&
                data['cityName']?.toString().toLowerCase() ==
                    cityName.toLowerCase() &&
                data['category']?.toString().toLowerCase() ==
                    category.toLowerCase(),
          )
          .map((data) => ServicePlace.fromMap(data))
          .toList();
    });
  }
}
