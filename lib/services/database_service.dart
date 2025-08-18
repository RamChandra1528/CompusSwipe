import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:campus_swipe/models/user_model.dart';
import 'package:campus_swipe/models/swipe_model.dart';
import 'package:campus_swipe/models/match_model.dart';
import 'package:campus_swipe/models/message_model.dart';
import 'package:campus_swipe/models/report_model.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Collections
  static const String usersCollection = 'users';
  static const String swipesCollection = 'swipes';
  static const String matchesCollection = 'matches';
  static const String messagesCollection = 'messages';
  static const String reportsCollection = 'reports';

  // User operations
  Future<List<UserModel>> getSwipeableUsers({
    required String currentUserId,
    int? ageMin,
    int? ageMax,
    Department? department,
    String? batch,
    int limit = 10,
  }) async {
    try {
      Query query = _firestore
          .collection(usersCollection)
          .where('uid', isNotEqualTo: currentUserId)
          .where('status', isEqualTo: UserStatus.verified.name)
          .where('isVerified', isEqualTo: true);

      // Apply filters
      if (ageMin != null) {
        query = query.where('age', isGreaterThanOrEqualTo: ageMin);
      }
      if (ageMax != null) {
        query = query.where('age', isLessThanOrEqualTo: ageMax);
      }
      if (department != null) {
        query = query.where('department', isEqualTo: department.name);
      }
      if (batch != null) {
        query = query.where('batch', isEqualTo: batch);
      }

      query = query.limit(limit);

      QuerySnapshot snapshot = await query.get();
      
      List<UserModel> users = snapshot.docs
          .map((doc) => UserModel.fromFirestore(doc))
          .toList();

      // Filter out users already swiped by current user
      List<String> swipedUserIds = await getSwipedUserIds(currentUserId);
      users = users.where((user) => !swipedUserIds.contains(user.uid)).toList();

      return users;
    } catch (e) {
      throw Exception('Failed to get swipeable users: $e');
    }
  }

  Future<List<String>> getSwipedUserIds(String userId) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection(swipesCollection)
          .where('swiperId', isEqualTo: userId)
          .where('isUndo', isEqualTo: false)
          .get();

      return snapshot.docs
          .map((doc) => SwipeModel.fromFirestore(doc).swipedUserId)
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<UserModel?> getUser(String uid) async {
    try {
      DocumentSnapshot doc = await _firestore
          .collection(usersCollection)
          .doc(uid)
          .get();

      if (doc.exists) {
        return UserModel.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get user: $e');
    }
  }

  Future<void> updateUser(UserModel user) async {
    try {
      await _firestore
          .collection(usersCollection)
          .doc(user.uid)
          .update(user.toMap());
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }

  // Swipe operations
  Future<void> addSwipe(SwipeModel swipe) async {
    try {
      await _firestore
          .collection(swipesCollection)
          .doc(swipe.id)
          .set(swipe.toMap());

      // Update user's swipe count
      await _firestore
          .collection(usersCollection)
          .doc(swipe.swiperId)
          .update({
        'swipeCount': FieldValue.increment(1),
      });
    } catch (e) {
      throw Exception('Failed to add swipe: $e');
    }
  }

  Future<bool> checkMutualLike(String userId1, String userId2) async {
    try {
      // Check if user2 has liked user1
      QuerySnapshot snapshot = await _firestore
          .collection(swipesCollection)
          .where('swiperId', isEqualTo: userId2)
          .where('swipedUserId', isEqualTo: userId1)
          .where('swipeType', whereIn: [SwipeType.like.name, SwipeType.superLike.name])
          .where('isUndo', isEqualTo: false)
          .get();

      return snapshot.docs.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  // Match operations
  Future<MatchModel> createMatch(String userId1, String userId2) async {
    try {
      String matchId = '${userId1}_$userId2';
      
      MatchModel match = MatchModel(
        id: matchId,
        user1Id: userId1,
        user2Id: userId2,
        matchedAt: DateTime.now(),
      );

      await _firestore
          .collection(matchesCollection)
          .doc(matchId)
          .set(match.toMap());

      // Update match count for both users
      await Future.wait([
        _firestore
            .collection(usersCollection)
            .doc(userId1)
            .update({'matchCount': FieldValue.increment(1)}),
        _firestore
            .collection(usersCollection)
            .doc(userId2)
            .update({'matchCount': FieldValue.increment(1)}),
      ]);

      return match;
    } catch (e) {
      throw Exception('Failed to create match: $e');
    }
  }

  Future<List<MatchModel>> getUserMatches(String userId) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection(matchesCollection)
          .where('user1Id', isEqualTo: userId)
          .where('isActive', isEqualTo: true)
          .get();

      QuerySnapshot snapshot2 = await _firestore
          .collection(matchesCollection)
          .where('user2Id', isEqualTo: userId)
          .where('isActive', isEqualTo: true)
          .get();

      List<MatchModel> matches = [
        ...snapshot.docs.map((doc) => MatchModel.fromFirestore(doc)),
        ...snapshot2.docs.map((doc) => MatchModel.fromFirestore(doc)),
      ];

      // Sort by last message time or match time
      matches.sort((a, b) {
        DateTime timeA = a.lastMessageTime ?? a.matchedAt;
        DateTime timeB = b.lastMessageTime ?? b.matchedAt;
        return timeB.compareTo(timeA);
      });

      return matches;
    } catch (e) {
      throw Exception('Failed to get user matches: $e');
    }
  }

  Future<MatchModel?> getMatch(String userId1, String userId2) async {
    try {
      String matchId1 = '${userId1}_$userId2';
      String matchId2 = '${userId2}_$userId1';

      DocumentSnapshot doc1 = await _firestore
          .collection(matchesCollection)
          .doc(matchId1)
          .get();

      if (doc1.exists) {
        return MatchModel.fromFirestore(doc1);
      }

      DocumentSnapshot doc2 = await _firestore
          .collection(matchesCollection)
          .doc(matchId2)
          .get();

      if (doc2.exists) {
        return MatchModel.fromFirestore(doc2);
      }

      return null;
    } catch (e) {
      throw Exception('Failed to get match: $e');
    }
  }

  // Message operations
  Future<void> sendMessage(MessageModel message) async {
    try {
      await _firestore
          .collection(messagesCollection)
          .doc(message.id)
          .set(message.toMap());

      // Update match with last message info
      await _firestore
          .collection(matchesCollection)
          .doc(message.matchId)
          .update({
        'lastMessageId': message.id,
        'lastMessageTime': message.timestamp.millisecondsSinceEpoch,
        'lastMessage': message.content,
        'lastMessageSenderId': message.senderId,
      });
    } catch (e) {
      throw Exception('Failed to send message: $e');
    }
  }

  Stream<List<MessageModel>> getMessages(String matchId) {
    return _firestore
        .collection(messagesCollection)
        .where('matchId', isEqualTo: matchId)
        .where('isDeleted', isEqualTo: false)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => MessageModel.fromFirestore(doc))
            .toList());
  }

  Future<void> markMessageAsRead(String messageId) async {
    try {
      await _firestore
          .collection(messagesCollection)
          .doc(messageId)
          .update({'status': MessageStatus.read.name});
    } catch (e) {
      throw Exception('Failed to mark message as read: $e');
    }
  }

  // Report operations
  Future<void> createReport(ReportModel report) async {
    try {
      await _firestore
          .collection(reportsCollection)
          .doc(report.id)
          .set(report.toMap());
    } catch (e) {
      throw Exception('Failed to create report: $e');
    }
  }

  Future<List<ReportModel>> getPendingReports() async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection(reportsCollection)
          .where('status', isEqualTo: ReportStatus.pending.name)
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => ReportModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to get pending reports: $e');
    }
  }

  Future<void> updateReportStatus(String reportId, ReportStatus status,
      String reviewedBy, String? adminNotes, String? actionTaken) async {
    try {
      await _firestore
          .collection(reportsCollection)
          .doc(reportId)
          .update({
        'status': status.name,
        'reviewedBy': reviewedBy,
        'reviewedAt': DateTime.now().millisecondsSinceEpoch,
        'adminNotes': adminNotes,
        'actionTaken': actionTaken,
      });
    } catch (e) {
      throw Exception('Failed to update report status: $e');
    }
  }

  // Admin operations
  Future<List<UserModel>> getPendingUsers() async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection(usersCollection)
          .where('status', isEqualTo: UserStatus.pending.name)
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => UserModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to get pending users: $e');
    }
  }

  Future<void> updateUserStatus(String userId, UserStatus status) async {
    try {
      bool isVerified = status == UserStatus.verified;
      await _firestore
          .collection(usersCollection)
          .doc(userId)
          .update({
        'status': status.name,
        'isVerified': isVerified,
        'updatedAt': DateTime.now().millisecondsSinceEpoch,
      });
    } catch (e) {
      throw Exception('Failed to update user status: $e');
    }
  }

  Future<Map<String, int>> getAppStatistics() async {
    try {
      // Get total users
      QuerySnapshot usersSnapshot = await _firestore
          .collection(usersCollection)
          .get();

      // Get verified users
      QuerySnapshot verifiedUsersSnapshot = await _firestore
          .collection(usersCollection)
          .where('isVerified', isEqualTo: true)
          .get();

      // Get pending users
      QuerySnapshot pendingUsersSnapshot = await _firestore
          .collection(usersCollection)
          .where('status', isEqualTo: UserStatus.pending.name)
          .get();

      // Get total matches
      QuerySnapshot matchesSnapshot = await _firestore
          .collection(matchesCollection)
          .get();

      // Get pending reports
      QuerySnapshot reportsSnapshot = await _firestore
          .collection(reportsCollection)
          .where('status', isEqualTo: ReportStatus.pending.name)
          .get();

      return {
        'totalUsers': usersSnapshot.docs.length,
        'verifiedUsers': verifiedUsersSnapshot.docs.length,
        'pendingUsers': pendingUsersSnapshot.docs.length,
        'totalMatches': matchesSnapshot.docs.length,
        'pendingReports': reportsSnapshot.docs.length,
      };
    } catch (e) {
      throw Exception('Failed to get app statistics: $e');
    }
  }
}
