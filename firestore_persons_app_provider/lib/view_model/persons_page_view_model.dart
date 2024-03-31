import 'package:flutter/material.dart';

import '../model/count_model.dart';
import '../model/person_model.dart';
import '../service/firebase_repository.dart';
import '../view/persons_detail_page_view.dart';


class PersonsPageViewModel with ChangeNotifier{

  List<PersonModel> _persons=[];
  List<CountModel> _personCount = [];
  Stream<List<CountModel>>? _countStream;
  bool _appbarValue = false;

  late TextEditingController _nameController;
  late TextEditingController _numberController;
  late TextEditingController _updateNameController;
  late TextEditingController _updateNumberController;
  late TextEditingController _searchingNameController;

  final _service = FireBaseRepository();

  PersonsPageViewModel(){
    _nameController = TextEditingController();
    _numberController = TextEditingController();
    _searchingNameController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getPersonData();
      _initializeCountStream();
      //_initializePersonStream();
    });
  }


  void _initializeCountStream() {
    _countStream = _service.getCountStream(); // Firestore'dan count verilerini içeren bir Stream döndüren bir metod
    _countStream!.listen((countData) {
      _personCount = countData;
      notifyListeners();
    });
  }


  void getSearchingData(String searchingValue)async{
    _persons = await _service.getSearchingData(searchingValue);
    notifyListeners();
  }

  void getPersonData()async{
    _persons =  await _service.getPersonData();
    notifyListeners();
  }

  void addPerson(String personName,String personNumber)async{
    String personId =await _service.addPerson(personName, personNumber);
    _persons.add(PersonModel(personId: personId, personName: personName, personNumber: personNumber));
    notifyListeners();

  }
  void deletePerson(String personId)async{
    await _service.deletePerson(personId);
    _persons.removeWhere((element) => element.personId == personId);
    notifyListeners();

  }

  void updatePerson(String personName,String personNumber,int index)async{
    PersonModel person = _persons[index];
    await _service.updatePerson(person.personId, personName, personNumber);
    person.update(personName, personNumber);
  }

  void goDetailPage(BuildContext context,PersonModel personModel){
    MaterialPageRoute pageRoute = MaterialPageRoute(builder:  (context) =>  PersonsDetailPageView(person: personModel,),);
    Navigator.push(context, pageRoute);
  }


  void showAddPerson(BuildContext context)async{
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: const Text("ADD PERSON"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
            ),
            TextField(
              controller: _numberController,
            ),

          ],
        ),
        actions: [
          ButtonBar(

            children: [
              ElevatedButton(onPressed: (){
                Navigator.pop(context);
              }, child: const Text("Cancel")),

              ElevatedButton(onPressed: (){
                if(_nameController.text.isNotEmpty && _numberController.text.isNotEmpty){
                  addPerson(_nameController.text, _numberController.text);
                  Navigator.pop(context);
                }
              }, child: const Text("Add"))
            ],
          ),
        ],
      );
    },);
  }



  void showUpdatePerson(BuildContext context,int index,{String? name,String? number})async{
    _updateNameController = TextEditingController(text: name);
    _updateNumberController = TextEditingController(text: number);

    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: const Text("UPDATE PERSON"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _updateNameController,
            ),
            TextField(
              controller: _updateNumberController,

            ),

          ],
        ),
        actions: [
          ButtonBar(

            children: [
              ElevatedButton(onPressed: (){
                Navigator.pop(context);
              }, child: const Text("Cancel")),

              ElevatedButton(onPressed: (){
                if(_updateNameController.text.isNotEmpty && _updateNumberController.text.isNotEmpty){
                  updatePerson(_updateNameController.text, _updateNumberController.text, index);
                  Navigator.pop(context);
                }
              }, child: const Text("Update"))
            ],
          ),
        ],
      );
    },);
  }


  void changeAppBarState(bool value){
    _appbarValue = !value;
    notifyListeners();
  }



  List<PersonModel> get persons => _persons;
  List<CountModel> get personCount => _personCount;

  TextEditingController get numberController => _numberController;

  TextEditingController get nameController => _nameController;


  TextEditingController get searchingNameController => _searchingNameController;

  bool get appbarValue => _appbarValue;
}