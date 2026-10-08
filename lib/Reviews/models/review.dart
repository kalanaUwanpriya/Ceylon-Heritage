import 'package:cloud_firestore/cloud_firestore.dart';

class Review {
  final String id;
  final String userId;
  final String placeId;
  final String placeName;
  final String placeImage;
  final String location;
  final int rating;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Review({
    required this.id,
    required this.userId,
    required this.placeId,
    required this.placeName,
    required this.placeImage,
    required this.location,
    required this.rating,
    this.createdAt,
    this.updatedAt,
  });

  factory Review.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};
    return Review.fromMap(data, id: doc.id);
  }

  factory Review.fromMap(Map<String, dynamic> data, {String? id}) {
    DateTime? parseDate(dynamic value) {
      if (value is Timestamp) {
        return value.toDate();
      }
      if (value is DateTime) {
        return value;
      }
      if (value is int) {
        return DateTime.fromMillisecondsSinceEpoch(value);
      }
      return null;
    }

    int rawRating = 1;
    if (data['rating'] is num) {
      rawRating = (data['rating'] as num).toInt();
    }
    // Strictly clamp rating to 1, 2, or 3
    final safeRating = rawRating.clamp(1, 3);

    return Review(
      id: id ?? (data['id'] as String? ?? ''),
      userId: data['userId'] as String? ?? '',
      placeId: data['placeId'] as String? ?? '',
      placeName: data['placeName'] as String? ?? '',
      placeImage: data['placeImage'] as String? ?? '',
      location: data['location'] as String? ?? '',
      rating: safeRating,
      createdAt: parseDate(data['createdAt']),
      updatedAt: parseDate(data['updatedAt']),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'placeId': placeId,
      'placeName': placeName,
      'placeImage': placeImage,
      'location': location,
      'rating': rating.clamp(1, 3),
      if (createdAt != null)
        'createdAt': Timestamp.fromDate(createdAt!)
      else
        'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'placeId': placeId,
      'placeName': placeName,
      'placeImage': placeImage,
      'location': location,
      'rating': rating.clamp(1, 3),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  Review copyWith({
    String? id,
    String? userId,
    String? placeId,
    String? placeName,
    String? placeImage,
    String? location,
    int? rating,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Review(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      placeId: placeId ?? this.placeId,
      placeName: placeName ?? this.placeName,
      placeImage: placeImage ?? this.placeImage,
      location: location ?? this.location,
      rating: rating != null ? rating.clamp(1, 3) : this.rating,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
