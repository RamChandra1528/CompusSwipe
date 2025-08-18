import 'package:cloud_firestore/cloud_firestore.dart';

enum ReportType { 
  inappropriateContent, 
  fakeProfile, 
  harassment, 
  spam, 
  underage, 
  violence,
  other 
}

enum ReportStatus { pending, reviewed, resolved, dismissed }

class ReportModel {
  final String id;
  final String reporterId; // User who reported
  final String reportedUserId; // User who was reported
  final String? reportedMessageId; // Optional: specific message reported
  final ReportType type;
  final String description;
  final ReportStatus status;
  final DateTime createdAt;
  final String? reviewedBy; // Admin who reviewed
  final DateTime? reviewedAt;
  final String? adminNotes;
  final String? actionTaken; // What action was taken

  ReportModel({
    required this.id,
    required this.reporterId,
    required this.reportedUserId,
    this.reportedMessageId,
    required this.type,
    required this.description,
    this.status = ReportStatus.pending,
    required this.createdAt,
    this.reviewedBy,
    this.reviewedAt,
    this.adminNotes,
    this.actionTaken,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'reporterId': reporterId,
      'reportedUserId': reportedUserId,
      'reportedMessageId': reportedMessageId,
      'type': type.name,
      'description': description,
      'status': status.name,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'reviewedBy': reviewedBy,
      'reviewedAt': reviewedAt?.millisecondsSinceEpoch,
      'adminNotes': adminNotes,
      'actionTaken': actionTaken,
    };
  }

  factory ReportModel.fromMap(Map<String, dynamic> map) {
    return ReportModel(
      id: map['id'] ?? '',
      reporterId: map['reporterId'] ?? '',
      reportedUserId: map['reportedUserId'] ?? '',
      reportedMessageId: map['reportedMessageId'],
      type: ReportType.values.firstWhere(
        (e) => e.name == map['type'],
        orElse: () => ReportType.other,
      ),
      description: map['description'] ?? '',
      status: ReportStatus.values.firstWhere(
        (e) => e.name == map['status'],
        orElse: () => ReportStatus.pending,
      ),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] ?? 0),
      reviewedBy: map['reviewedBy'],
      reviewedAt: map['reviewedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['reviewedAt'])
          : null,
      adminNotes: map['adminNotes'],
      actionTaken: map['actionTaken'],
    );
  }

  factory ReportModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return ReportModel.fromMap(data);
  }

  bool get isPending => status == ReportStatus.pending;
  bool get isResolved => status == ReportStatus.resolved;
  bool get isDismissed => status == ReportStatus.dismissed;
  bool get isMessageReport => reportedMessageId != null;

  ReportModel copyWith({
    String? id,
    String? reporterId,
    String? reportedUserId,
    String? reportedMessageId,
    ReportType? type,
    String? description,
    ReportStatus? status,
    DateTime? createdAt,
    String? reviewedBy,
    DateTime? reviewedAt,
    String? adminNotes,
    String? actionTaken,
  }) {
    return ReportModel(
      id: id ?? this.id,
      reporterId: reporterId ?? this.reporterId,
      reportedUserId: reportedUserId ?? this.reportedUserId,
      reportedMessageId: reportedMessageId ?? this.reportedMessageId,
      type: type ?? this.type,
      description: description ?? this.description,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      reviewedBy: reviewedBy ?? this.reviewedBy,
      reviewedAt: reviewedAt ?? this.reviewedAt,
      adminNotes: adminNotes ?? this.adminNotes,
      actionTaken: actionTaken ?? this.actionTaken,
    );
  }
}
