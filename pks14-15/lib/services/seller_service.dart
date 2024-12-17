import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SellerService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Получить ID продавца из Firestore
  Future<String?> getSellerId() async {
    try {
      final sellerDoc = await _firestore.collection('sellers').doc('main_seller').get();
      if (sellerDoc.exists) {
        return sellerDoc.id;
      } else {
        // Если продавца нет, создаем его
        await _firestore.collection('sellers').doc('main_seller').set({
          'email': 'seller@example.com',
          'role': 'seller',
          'createdAt': FieldValue.serverTimestamp(),
        });
        return 'main_seller';
      }
    } catch (e) {
      print('Ошибка при получении ID продавца: $e');
      return null;
    }
  }
}
