import 'package:cloud_firestore/cloud_firestore.dart';

class MatchModel {
  final String id;
  final String user1Id;
  final String user2Id;
  final DateTime matchedAt;
  final String? lastMessageId;
  final DateTime? lastMessageTime;
  final bool isActive;
  final bool user1HasUnmatched;
  final bool user2HasUnmatched;
  final String? lastMessage;
  final String? lastMessageSenderId;

  MatchModel({
    required this.id,
    required this.user1Id,
    required this.user2Id,
    required this.matchedAt,
    this.lastMessageId,
    this.lastMessageTime,
    this.isActive = true,
    this.user1HasUnmatched = false,
    this.user2HasUnmatched = false,
    this.lastMessage,
    this.lastMessageSenderId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user1Id': user1Id,
      'user2Id': user2Id,
      'matchedAt': matchedAt.millisecondsSinceEpoch,
      'lastMessageId': lastMessageId,
      'lastMessageTime': lastMessageTime?.millisecondsSinceEpoch,
      'isActive': isActive,
      'user1HasUnmatched': user1HasUnmatched,
      'user2HasUnmatched': user2HasUnmatched,
      'lastMessage': lastMessage,
      'lastMessageSenderId': lastMessageSenderId,
    };
  }

  factory MatchModel.fromMap(Map<String, dynamic> map) {
    return MatchModel(
      id: map['id'] ?? '',
      user1Id: map['user1Id'] ?? '',
      user2Id: map['user2Id'] ?? '',
      matchedAt: DateTime.fromMillisecondsSinceEpoch(map['matchedAt'] ?? 0),
      lastMessageId: map['lastMessageId'],
      lastMessageTime: map['lastMessageTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['lastMessageTime'])
          : null,
      isActive: map['isActive'] ?? true,
      user1HasUnmatched: map['user1HasUnmatched'] ?? false,
      user2HasUnmatched: map['user2HasUnmatched'] ?? false,
      lastMessage: map['lastMessage'],
      lastMessageSenderId: map['lastMessageSenderId'],
    );
  }

  factory MatchModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return MatchModel.fromMap(data);
  }

  // Helper method to check if a user is part of this match
  bool containsUser(String userId) {
    return user1Id == userId || user2Id == userId;
  }

  // Get the other user's ID given one user's ID
  String getOtherUserId(String userId) {
    if (user1Id == userId) return user2Id;
    if (user2Id == userId) return user1Id;
    throw ArgumentError('User $userId is not part of this match');
  }

  // Check if match is unmatched by any user
  bool get isUnmatched => user1HasUnmatched || user2HasUnmatched;

  MatchModel copyWith({
    String? id,
    String? user1Id,
    String? user2Id,
    DateTime? matchedAt,
    String? lastMessageId,
    DateTime? lastMessageTime,
    bool? isActive,
    bool? user1HasUnmatched,
    bool? user2HasUnmatched,
    String? lastMessage,
    String? lastMessageSenderId,
  }) {
    return MatchModel(
      id: id ?? this.id,
      user1Id: user1Id ?? this.user1Id,
      user2Id: user2Id ?? this.user2Id,
      matchedAt: matchedAt ?? this.matchedAt,
      lastMessageId: lastMessageId ?? this.lastMessageId,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      isActive: isActive ?? this.isActive,
      user1HasUnmatched: user1HasUnmatched ?? this.user1HasUnmatched,
      user2HasUnmatched: user2HasUnmatched ?? this.user2HasUnmatched,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageSenderId: lastMessageSenderId ?? this.lastMessageSenderId,
    );
  }
}
