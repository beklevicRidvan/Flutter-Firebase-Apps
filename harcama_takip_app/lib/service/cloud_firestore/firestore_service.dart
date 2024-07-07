import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:harcama_takip_app/model/card_model.dart';
import 'package:harcama_takip_app/model/user_model.dart';
import 'package:harcama_takip_app/service/database_base_service.dart';

class FirestoreService extends DatabaseBaseService {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final _exceptionMessage = 'KULLANICI GİRİŞ YAPMALI';
  @override
  Future addCard(CardModel cardModel) async {
    User? currentUser = _auth.currentUser;

    try {
      if (currentUser != null) {
        var docId = _firestore
            .collection("humans")
            .doc(currentUser.uid)
            .collection("cards")
            .doc()
            .id;
        return await _firestore
            .collection("humans")
            .doc(currentUser.uid)
            .collection("cards")
            .doc(docId)
            .set(cardModel.toMap(key: docId));
      } else {
        throw Exception(_exceptionMessage);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> deleteCard(CardModel cardModel) async {
    User? currentUser = _auth.currentUser;

    try {
      if (currentUser != null) {
        await _firestore
            .doc("humans/${currentUser.uid}")
            .collection("cards")
            .doc(cardModel.cardId)
            .delete();
      } else {
        throw Exception(_exceptionMessage);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Stream<List<CardModel>> getCardData() {
    try {
      User? currentUser = _auth.currentUser;

      if (currentUser != null) {
        return _firestore
            .doc("humans/${currentUser.uid}")
            .collection("cards").orderBy('price',descending: true)
            .snapshots()
            .map((event) => event.docs
                .map(
                  (e) => CardModel.fromMap(e.data(), key: e.id),
                )
                .toList());
      } else {
        return const Stream.empty();
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> updateCard(
      dynamic newPrice, String newPaymentName, CardModel cardModel) async {
    User? currentUser = _auth.currentUser;

    try {
      if (currentUser != null) {
        await _firestore
            .collection("humans")
            .doc(currentUser.uid)
            .collection("cards")
            .doc(cardModel.cardId)
            .update(cardModel.toUpdatedMap(newPaymentName, newPrice));
      } else {
        throw Exception('KULLANICI GİRİŞ YAPMALI');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<UserModel> getCurrentUserModel() async {
    User? currentUser = _auth.currentUser;
    try {
      if (currentUser != null) {
        var docRef = await _firestore
            .collection('humans')
            .where('userId', isEqualTo: currentUser.uid)
            .get();
        if (docRef.docs.isEmpty) {
          throw Exception(_exceptionMessage);
        } else {
          var docs = docRef.docs.first;
          return UserModel.fromMap(docs.data(), key: docs.id);
        }
      } else {
        throw Exception(_exceptionMessage);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
