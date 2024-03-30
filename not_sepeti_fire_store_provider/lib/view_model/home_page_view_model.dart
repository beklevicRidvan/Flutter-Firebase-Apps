import 'package:flutter/material.dart';
import 'package:not_sepeti_fire_store_provider/view/addnote_page_view.dart';
import 'package:provider/provider.dart';

import '../model/not_model.dart';
import '../service/firebase_service.dart';

class HomePageViewModel with ChangeNotifier {
  List<NotModel> _notes = [];

  Stream<List<NotModel>>? _notStream;

  late TextEditingController _titleController;
  late TextEditingController _contentController;

  late TextEditingController _updatedTitleController;
  late TextEditingController _updatedContentController;

  final _service = FirebaseService();

  HomePageViewModel() {
    _titleController = TextEditingController();
    _contentController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeNotesStream();
    });
  }

  void _initializeNotesStream() async {
    _notStream = _service.getNotesStream();
    _notStream!.listen((notesData) {
      _notes = notesData;
      _notes.sort((a, b) => a.notTitle.compareTo(b.notTitle));
      notifyListeners();
    });
  }

  void addNote(BuildContext context,HomePageViewModel viewModel) async {
    List<dynamic>? values = await goAddNotePage(context,viewModel);
    if (values != null) {
      String notTitle = values[0];
      String notContent = values[1];

      NotModel notModel = NotModel(notTitle: notTitle, notContent: notContent);
      String noteId = await _service.addNote(notModel);
      print(noteId);
      notModel.notId = noteId;

      _notes.add(notModel);
    }
  }

  void updateNote(int index, BuildContext context) async {
    NotModel notModel = _notes[index];
    List<dynamic>? values = await showUpdateDialog(context,
        currentContent: notModel.notContent, currentTitle: notModel.notTitle);

    if (values != null) {
      String newTitle = values[0];
      String newContent = values[1];
      notModel.guncelle(newTitle, newContent);
      await _service.updateNote(notModel);
    }
  }

  void deleteNote(int index) async {
    NotModel notModel = _notes[index];
    _notes.removeAt(index);
    await _service.deleteNote(notModel);
  }

  Future<List<dynamic>?> goAddNotePage(BuildContext context,HomePageViewModel viewModel) async {
    var list = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return  AddNotePageView(viewModel:viewModel);
        },
      ),
    );
    return list;
  }

  Future<List<dynamic>?> showUpdateDialog(BuildContext context,
      {String currentContent = "", String currentTitle = ""}) {
    _updatedContentController = TextEditingController(text: currentContent);
    _updatedTitleController = TextEditingController(text: currentTitle);
    return showDialog<List<dynamic>>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("UPDATE NOTE"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("TİTLE"),
                TextField(
                  controller: _updatedTitleController,
                  decoration:
                      const InputDecoration(border: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text("CONTENT"),
                TextField(
                  controller: _updatedContentController,
                  decoration:
                      const InputDecoration(border: OutlineInputBorder()),
                  textInputAction: TextInputAction.done,
                  maxLines: 4,
                ),
              ],
            ),
          ),
          actions: [
            ButtonBar(
              alignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    child: const Text(
                      "CANCEL",
                      style: TextStyle(color: Colors.white),
                    )),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, [
                        _updatedTitleController.text,
                        _updatedContentController.text
                      ]);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    child: const Text(
                      "SAVE",
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
          ],
        );
      },
    );
  }

  List<NotModel> get notes => _notes;

  TextEditingController get contentController => _contentController;

  TextEditingController get titleController => _titleController;
}
