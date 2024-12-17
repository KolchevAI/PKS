import 'package:flutter/foundation.dart';
import '../models/chat_message.dart';
import '../services/chat_service.dart';

class ChatProvider extends ChangeNotifier {
  final ChatService _chatService = ChatService();

  Stream<List<ChatMessage>> getChatMessages(String userId, String sellerId) {
    return _chatService.getChatMessages(userId, sellerId);
  }

  Stream<List<ChatMessage>> getUserChats(String userId) {
    return _chatService.getUserChats(userId);
  }

  Future<void> sendMessage({
    required String senderId,
    required String receiverId,
    required String message,
  }) async {
    await _chatService.sendMessage(
      senderId: senderId,
      receiverId: receiverId,
      message: message,
    );
  }

  Stream<ChatMessage?> getLastMessage(String userId, String sellerId) {
    return _chatService.getLastMessage(userId, sellerId);
  }
}
