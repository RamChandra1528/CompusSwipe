import 'package:cloud_firestore/cloud_firestore.dart';

enum UserStatus { pending, verified, rejected, suspended }
enum Department { computerScience, engineering, medical, business, arts, science, other }

class UserModel {
  final String uid;
  final String email;
  final String? phone;
  final String name;
  final int age;
  final String bio;
  final String college;
  final Department department;
  final String batch;
  final String city;
  final List<String> photoUrls;
  final List<String> interests;
  final UserStatus status;
  final bool isVerified;
  final bool isAdmin;
  final String? idProofUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isOnline;
  final DateTime? lastSeen;
  final int swipeCount;
  final int matchCount;
  final int points;

  UserModel({
    required this.uid,
    required this.email,
    this.phone,
    required this.name,
    required this.age,
    required this.bio,
    required this.college,
    required this.department,
    required this.batch,
    required this.city,
    required this.photoUrls,
    required this.interests,
    this.status = UserStatus.pending,
    this.isVerified = false,
    this.isAdmin = false,
    this.idProofUrl,
    required this.createdAt,
    required this.updatedAt,
    this.isOnline = false,
    this.lastSeen,
    this.swipeCount = 0,
    this.matchCount = 0,
    this.points = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'phone': phone,
      'name': name,
      'age': age,
      'bio': bio,
      'college': college,
      'department': department.name,
      'batch': batch,
      'city': city,
      'photoUrls': photoUrls,
      'interests': interests,
      'status': status.name,
      'isVerified': isVerified,
      'isAdmin': isAdmin,
      'idProofUrl': idProofUrl,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'isOnline': isOnline,
      'lastSeen': lastSeen?.millisecondsSinceEpoch,
      'swipeCount': swipeCount,
      'matchCount': matchCount,
      'points': points,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'],
      name: map['name'] ?? '',
      age: map['age'] ?? 0,
      bio: map['bio'] ?? '',
      college: map['college'] ?? '',
      department: Department.values.firstWhere(
        (e) => e.name == map['department'],
        orElse: () => Department.other,
      ),
      batch: map['batch'] ?? '',
      city: map['city'] ?? '',
      photoUrls: List<String>.from(map['photoUrls'] ?? []),
      interests: List<String>.from(map['interests'] ?? []),
      status: UserStatus.values.firstWhere(
        (e) => e.name == map['status'],
        orElse: () => UserStatus.pending,
      ),
      isVerified: map['isVerified'] ?? false,
      isAdmin: map['isAdmin'] ?? false,
      idProofUrl: map['idProofUrl'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] ?? 0),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] ?? 0),
      isOnline: map['isOnline'] ?? false,
      lastSeen: map['lastSeen'] != null 
          ? DateTime.fromMillisecondsSinceEpoch(map['lastSeen'])
          : null,
      swipeCount: map['swipeCount'] ?? 0,
      matchCount: map['matchCount'] ?? 0,
      points: map['points'] ?? 0,
    );
  }

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserModel.fromMap(data);
  }

  UserModel copyWith({
    String? uid,
    String? email,
    String? phone,
    String? name,
    int? age,
    String? bio,
    String? college,
    Department? department,
    String? batch,
    String? city,
    List<String>? photoUrls,
    List<String>? interests,
    UserStatus? status,
    bool? isVerified,
    bool? isAdmin,
    String? idProofUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isOnline,
    DateTime? lastSeen,
    int? swipeCount,
    int? matchCount,
    int? points,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      name: name ?? this.name,
      age: age ?? this.age,
      bio: bio ?? this.bio,
      college: college ?? this.college,
      department: department ?? this.department,
      batch: batch ?? this.batch,
      city: city ?? this.city,
      photoUrls: photoUrls ?? this.photoUrls,
      interests: interests ?? this.interests,
      status: status ?? this.status,
      isVerified: isVerified ?? this.isVerified,
      isAdmin: isAdmin ?? this.isAdmin,
      idProofUrl: idProofUrl ?? this.idProofUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isOnline: isOnline ?? this.isOnline,
      lastSeen: lastSeen ?? this.lastSeen,
      swipeCount: swipeCount ?? this.swipeCount,
      matchCount: matchCount ?? this.matchCount,
      points: points ?? this.points,
    );
  }
}
