import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/not_model.dart';

class FirebaseService {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Stream<List<NotModel>> getNotesStream() {
    return _firestore
        .collection('notes') // Firestore koleksiyon adı
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => NotModel.fromMap(doc.data(),doc.id))
            .toList());
  }


  Future<String> addNote(NotModel notModel)async{
      var noteId =  _firestore.collection("notes").doc().id;

      await _firestore.doc("notes/$noteId").set(notModel.toMap());
      return noteId;
  }
  Future<void> deleteNote(NotModel notModel)async{
    await _firestore.doc("notes/${notModel.notId}").delete();
  }
  Future<void> updateNote(NotModel notModel)async{
    await _firestore.doc("notes/${notModel.notId}").update(notModel.toMap());
  }



}
