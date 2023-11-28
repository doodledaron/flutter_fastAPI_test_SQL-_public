// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import 'package:project/models/person.dart';
import 'package:project/screens/post_person_form.dart';
import 'package:project/screens/put_person_form.dart';
import 'package:project/services/home_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> listWordings = [
    'Create a new person (POST)',
    'Get a person(GET)',
    'Get people(GET)',
    'Edit a existing person or create a new one if there is no existing one((PUT )',
    'Delete a person(DELETE)'
  ];

  List<Person>? people;

  HomeService homeService = HomeService();
  void doOperations(int index) {
    String textField = '';
    final TextEditingController idController = TextEditingController();
    switch (index) {
      //create new person
      case 0:
        Navigator.pushNamed(context, PostPersonForm.routeName);
        break;
      //get a person
      case 1:
        showDialog(
          context: context,
          builder: (builder) => AlertDialog(
            content: Container(
              height: 300,
              child: Column(
                children: [
                  Text('Enter Id to get'),
                  TextField(
                    controller: idController,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  textField = idController.text;
                  getPerson(int.parse(textField));
                },
                child: Text('Go!'),
              )
            ],
          ),
        );
        break;
      case 2:
        getPeople();
        break;
      //edit an existing person or create a new one
      case 3:
        Navigator.pushNamed(context, PutPersonForm.routeName);
        break;
      case 4:
        showDialog(
          context: context,
          builder: (builder) => AlertDialog(
            content: Container(
              height: 300,
              child: Column(
                children: [
                  Text('Enter Id to delete'),
                  TextField(
                    controller: idController,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  textField = idController.text;
                  deletePerson(
                    int.parse(textField),
                  );
                },
                child: Text('Go!'),
              )
            ],
          ),
        );
        break;
      default:
    }
  }

  void getPeople() async {
    people = await homeService.getPeople(context);

    showDialog(
      context: context,
      builder: (builder) => AlertDialog(
        content: SizedBox(
          height: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'People list:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 10),
              if (people != null)
                for (Person person in people!)
                  Text(
                    'ID: ${person.id} | Name: ${person.name} | Age: ${person.age} | Sex: ${person.sex}',
                  ),
            ],
          ),
        ),
      ),
    );
  }

  void getPerson(int id) async {
    Person? person = await homeService.getPerson(context, id);
    if (person != null) {
      showDialog(
        context: context,
        builder: (builder) => AlertDialog(
          content: SizedBox(
            height: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Person:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'ID: ${person.id} | Name: ${person.name} | Age: ${person.age} | Sex: ${person.sex}',
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  void deletePerson(int id) async {
    Person person = await homeService.deletePerson(context, id);
    showDialog(
      context: context,
      builder: (builder) => AlertDialog(
        content: SizedBox(
          height: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Person:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'DELETED PERSON :ID: ${person.id} | Name: ${person.name} | Age: ${person.age} | Sex: ${person.sex}',
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: listWordings.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => doOperations(index),
          child: ListTile(
            title: Text(listWordings[index]),
          ),
        ),
      ),
    );
  }
}
