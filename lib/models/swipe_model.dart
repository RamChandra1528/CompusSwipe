import 'package:cloud_firestore/cloud_firestore.dart';

enum SwipeType { like, dislike, superLike }

class SwipeModel {
  final String id;
  final String swiperId; // User who swiped
  final String swipedUserId; // User who was swiped
  final SwipeType swipeType;
  final DateTime timestamp;
  final bool isUndo; // True if this swipe was undone

  SwipeModel({
    required this.id,
    required this.swiperId,
    required this.swipedUserId,
    required this.swipeType,
    required this.timestamp,
    this.isUndo = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'swiperId': swiperId,
      'swipedUserId': swipedUserId,
      'swipeType': swipeType.name,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'isUndo': isUndo,
    };
  }

  factory SwipeModel.fromMap(Map<String, dynamic> map) {
    return SwipeModel(
      id: map['id'] ?? '',
      swiperId: map['swiperId'] ?? '',
      swipedUserId: map['swipedUserId'] ?? '',
      swipeType: SwipeType.values.firstWhere(
        (e) => e.name == map['swipeType'],
        orElse: () => SwipeType.dislike,
      ),
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp'] ?? 0),
      isUndo: map['isUndo'] ?? false,
    );
  }

  factory SwipeModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return SwipeModel.fromMap(data);
  }

  SwipeModel copyWith({
    String? id,
    String? swiperId,
    String? swipedUserId,
    SwipeType? swipeType,
    DateTime? timestamp,
    bool? isUndo,
  }) {
    return SwipeModel(
      id: id ?? this.id,
      swiperId: swiperId ?? this.swiperId,
      swipedUserId: swipedUserId ?? this.swipedUserId,
      swipeType: swipeType ?? this.swipeType,
      timestamp: timestamp ?? this.timestamp,
      isUndo: isUndo ?? this.isUndo,
    );
  }
}
