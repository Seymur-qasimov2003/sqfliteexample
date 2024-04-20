import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttersqlite/views/utils/dbhelper.dart';

import '../model/personmodel.dart';
import '../services/personservice.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PersonService personService = PersonService();
  List<PersonModel> persons = [];

  @override
  void initState() {
    //DbHelper.initDb();

    personService.getPersons().then((value) {
      setState(() {
        persons = value;
      });
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          ///add new person
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              adddDialogComponent();
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: persons.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(persons[index].name),
            // subtitle: Text(persons[index].id.toString()),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    personService.deletePerson(persons[index].id!).then((value) {
                      if (value) {
                        personService.getPersons().then((value) {
                          setState(() {
                            persons = value;
                          });
                        });
                      }
                    });
                  },
                ),
                ///edit
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    showDialogComponent(index: index, context: context);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
  Future showDialogComponent({required int index, required BuildContext context} ){
    return showDialog(
      context: context,
      builder: (context) {
        TextEditingController controller = TextEditingController();
        controller.text = persons[index].name;
        return AlertDialog(
          title: const Text('Edit Person'),
          content: TextField(
            controller: controller,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                PersonModel model = PersonModel(
                  id: persons[index].id,
                  name: controller.text,
                );
                personService.updatePerson(model).then((value) {
                  if (value) {
                    personService.getPersons().then((value) {
                      setState(() {
                        persons = value;
                      });
                    });
                  }
                });
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
  ///
Future adddDialogComponent(){
    return  showDialog(
      context: context,
      builder: (context) {
        TextEditingController controller = TextEditingController();
        return AlertDialog(
          title: const Text('Add Person'),
          content: TextField(
            controller: controller,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                PersonModel model = PersonModel(name: controller.text);
                personService.createPerson(model).then((value) {
                  if (value) {
                    personService.getPersons().then((value) {
                      setState(() {
                        persons = value;
                      });
                    });
                  }
                });
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
}
}
