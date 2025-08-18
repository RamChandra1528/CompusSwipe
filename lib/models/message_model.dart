import 'package:cloud_firestore/cloud_firestore.dart';

enum MessageType { text, image, gif }
enum MessageStatus { sent, delivered, read }

class MessageModel {
  final String id;
  final String matchId;
  final String senderId;
  final String receiverId;
  final String content;
  final MessageType type;
  final MessageStatus status;
  final DateTime timestamp;
  final bool isDeleted;
  final String? imageUrl;
  final String? gifUrl;
  final List<String> reactions;
  final DateTime? editedAt;

  MessageModel({
    required this.id,
    required this.matchId,
    required this.senderId,
    required this.receiverId,
    required this.content,
    this.type = MessageType.text,
    this.status = MessageStatus.sent,
    required this.timestamp,
    this.isDeleted = false,
    this.imageUrl,
    this.gifUrl,
    this.reactions = const [],
    this.editedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'matchId': matchId,
      'senderId': senderId,
      'receiverId': receiverId,
      'content': content,
      'type': type.name,
      'status': status.name,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'isDeleted': isDeleted,
      'imageUrl': imageUrl,
      'gifUrl': gifUrl,
      'reactions': reactions,
      'editedAt': editedAt?.millisecondsSinceEpoch,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id'] ?? '',
      matchId: map['matchId'] ?? '',
      senderId: map['senderId'] ?? '',
      receiverId: map['receiverId'] ?? '',
      content: map['content'] ?? '',
      type: MessageType.values.firstWhere(
        (e) => e.name == map['type'],
        orElse: () => MessageType.text,
      ),
      status: MessageStatus.values.firstWhere(
        (e) => e.name == map['status'],
        orElse: () => MessageStatus.sent,
      ),
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp'] ?? 0),
      isDeleted: map['isDeleted'] ?? false,
      imageUrl: map['imageUrl'],
      gifUrl: map['gifUrl'],
      reactions: List<String>.from(map['reactions'] ?? []),
      editedAt: map['editedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['editedAt'])
          : null,
    );
  }

  factory MessageModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return MessageModel.fromMap(data);
  }

  bool get isImage => type == MessageType.image && imageUrl != null;
  bool get isGif => type == MessageType.gif && gifUrl != null;
  bool get isText => type == MessageType.text;
  bool get isEdited => editedAt != null;
  bool get hasReactions => reactions.isNotEmpty;

  MessageModel copyWith({
    String? id,
    String? matchId,
    String? senderId,
    String? receiverId,
    String? content,
    MessageType? type,
    MessageStatus? status,
    DateTime? timestamp,
    bool? isDeleted,
    String? imageUrl,
    String? gifUrl,
    List<String>? reactions,
    DateTime? editedAt,
  }) {
    return MessageModel(
      id: id ?? this.id,
      matchId: matchId ?? this.matchId,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      content: content ?? this.content,
      type: type ?? this.type,
      status: status ?? this.status,
      timestamp: timestamp ?? this.timestamp,
      isDeleted: isDeleted ?? this.isDeleted,
      imageUrl: imageUrl ?? this.imageUrl,
      gifUrl: gifUrl ?? this.gifUrl,
      reactions: reactions ?? this.reactions,
      editedAt: editedAt ?? this.editedAt,
    );
  }
}
