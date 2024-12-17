import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/chat_message.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Получить сообщения чата между двумя пользователями
  Stream<List<ChatMessage>> getChatMessages(String userId, String sellerId) {
    return _firestore
        .collection('messages')
        .where('participants', arrayContains: userId)
        .where('participants', arrayContains: sellerId)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => ChatMessage.fromFirestore(doc))
              .toList();
        });
  }

  // Получить все чаты пользователя
  Stream<List<ChatMessage>> getUserChats(String userId) {
    return _firestore
        .collection('messages')
        .where('participants', arrayContains: userId)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => ChatMessage.fromFirestore(doc))
              .toList();
        });
  }

  // Отправить сообщение
  Future<void> sendMessage({
    required String senderId,
    required String receiverId,
    required String message,
  }) async {
    final newMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      senderId: senderId,
      receiverId: receiverId,
      message: message,
      timestamp: DateTime.now(),
    );

    await _firestore.collection('messages').add(newMessage.toJson());
  }

  // Получить последнее сообщение чата
  Stream<ChatMessage?> getLastMessage(String userId, String sellerId) {
    return _firestore
        .collection('messages')
        .where('participants', arrayContains: userId)
        .where('participants', arrayContains: sellerId)
        .orderBy('timestamp', descending: true)
        .limit(1)
        .snapshots()
        .map((snapshot) {
          if (snapshot.docs.isEmpty) return null;
          return ChatMessage.fromFirestore(snapshot.docs.first);
        });
  }
}
