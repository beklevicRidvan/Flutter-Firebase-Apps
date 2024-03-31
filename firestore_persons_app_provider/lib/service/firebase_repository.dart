
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/count_model.dart';
import '../model/person_model.dart';

class FireBaseRepository{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<List<PersonModel>> getPersonData()async{
    var personDocuments = await _firestore.collection('persons').get();
    var maps = personDocuments.docs;

    return List<PersonModel>.generate(maps.length, (index)
    {
      var row = maps[index];
      return PersonModel(personId: row["personId"], personName: row["personName"], personNumber: row["personNumber"]);
    }
    );
  }

  Future<List<PersonModel>> getSearchingData(String searchingValue)async{
    List<PersonModel> persons =[];
    var personDocuments = await _firestore.collection("persons").get();
    var maps = personDocuments.docs;

    for(var document in maps){
      var data = document.data();
      var id = document.id;
      var person = PersonModel.fromMap(data, id);

      if(      person.personName.toLowerCase().contains(searchingValue.toLowerCase())){
        persons.add(person);
      }
    }
    return persons;

  }


  Stream<List<CountModel>> getCountStream() {
    return FirebaseFirestore.instance
        .collection('count') // Count verilerini içeren Firestore koleksiyonu adı
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => CountModel.fromMap(doc.data()))
        .toList());
  }



  Future<String> addPerson(String personName,String personNumber)async{
    var newPersonId = await _firestore.collection("persons").doc().id;
    Map<String,dynamic> newData = {};
    newData["personId"] = newPersonId;
    newData["personName"] = personName;
    newData["personNumber"] = personNumber;

    await _firestore.doc("persons/$newPersonId").set(newData);
    await _firestore.doc("count/8AD70u84GbVGKnthUMTB").set({"myCount":FieldValue.increment(1)},SetOptions(merge: true));


    return newPersonId;

  }




  Future<void> deletePerson(String personId)async{
    await _firestore.doc("persons/$personId").delete();
    await _firestore.doc("count/8AD70u84GbVGKnthUMTB").set({"myCount":FieldValue.increment(-1)},SetOptions(merge: true));

  }


  Future<void> updatePerson(String personId,String personName,String personNumber)async{

    Map<String,dynamic> yeniMap = {};

    yeniMap["personName"] = personName;
    yeniMap["personNumber"] = personNumber;

    await _firestore.doc("persons/$personId").update(yeniMap);
  }





}