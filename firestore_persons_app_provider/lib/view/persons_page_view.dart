import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/person_model.dart';
import '../../view_model/persons_page_view_model.dart';

class PersonsPageView extends StatelessWidget {
  const PersonsPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
      floatingActionButton: _buildFloattingActionButton(context),
    );
  }

  _buildAppBar(BuildContext context) {
    return PreferredSize(
        preferredSize: const Size(double.infinity, 60),
        child: Consumer<PersonsPageViewModel>(
          builder: (context, value, child) {
            return AppBar(
              title: value.appbarValue ? CupertinoSearchTextField(
                controller: value.searchingNameController,
                onChanged: (girilenDeger) {
                  value.getSearchingData(girilenDeger);
                },

                backgroundColor: Colors.white,
              ) : const Text("Persons App"),
              centerTitle: true,
              backgroundColor: Colors.greenAccent.shade200,
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: IconButton(
                      onPressed: () {
                        value.changeAppBarState(value.appbarValue);
                        if(!value.appbarValue){
                          value.getPersonData();
                        }
                      },
                      icon: value.appbarValue ? const Icon(Icons.clear):const Icon(
                        Icons.search,
                        size: 35,
                      )),
                )
              ],
            );
          },
        ));
  }

  _buildBody(BuildContext context) {
    return Consumer<PersonsPageViewModel>(
      builder: (context, value, child) {
        if (value.persons.isNotEmpty) {
          String countText =
              'Person Count: ${value.personCount.isNotEmpty ? value.personCount[0].toString() : 'N/A'}';
          debugPrint("Body  consumer çalıştı");

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(
                    Icons.supervisor_account,
                    size: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      countText,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: value.persons.length,
                  itemBuilder: (context, index) {
                    debugPrint("Listview builder çalıştı");

                    return ChangeNotifierProvider.value(
                        value: value.persons[index],
                        child: _buildListItem(context, index));
                  },
                ),
              )
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.redAccent,
            ),
          );
        }
      },
    );
  }

  _buildListItem(BuildContext context, int index) {
    PersonsPageViewModel viewModel =
        Provider.of<PersonsPageViewModel>(context, listen: false);
    return SizedBox(
      child: Consumer<PersonModel>(
        builder: (context, person, child) {
          debugPrint("List Item consumer çalıştı");
          return GestureDetector(
            onTap: () {
              viewModel.goDetailPage(context, person);
            },
            child: ListTile(
                key: Key(person.personId),
                leading: const Icon(Icons.person),
                title: Text(person.personName),
                subtitle: Text(person.personNumber),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () {
                          viewModel.showUpdatePerson(context, index,
                              name: person.personName,
                              number: person.personNumber);
                        },
                        icon: const Icon(Icons.border_color)),
                    IconButton(
                        onPressed: () {
                          viewModel.deletePerson(person.personId);
                        },
                        icon: const Icon(
                          Icons.clear,
                          color: Colors.red,
                        )),
                  ],
                )),
          );
        },
      ),
    );
  }

  _buildFloattingActionButton(BuildContext context) {
    PersonsPageViewModel viewModel =
        Provider.of<PersonsPageViewModel>(context, listen: false);

    return FloatingActionButton(
      backgroundColor: Colors.greenAccent,
      onPressed: () {
        viewModel.nameController.text = "";
        viewModel.numberController.text = "";
        viewModel.showAddPerson(context);
      },
      child: const Icon(
        Icons.add,
        color: Colors.black,
        size: 35,
      ),
    );
  }
}
