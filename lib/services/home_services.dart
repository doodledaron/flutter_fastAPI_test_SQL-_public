// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/models/person.dart';

const String ipAddress = 'http://192.168.100.3:8000';

class HomeService {
  Future<List<Person>> getPeople(BuildContext context) async {
    List<Person> personList = [];
    try {
      http.Response res = await http.get(Uri.parse('$ipAddress/api/people'));

      // Decode the JSON response
      Map<String, dynamic> responseMap = jsonDecode(res.body);
      // print(responseMap);

      // Check if the response has the 'people' key and if it's a list
      if (responseMap.containsKey('people') && responseMap['people'] is List) {
        List<dynamic> peopleData = responseMap['people'];
        print("$peopleData");
        for (int i = 0; i < peopleData.length; i++) {
          // Create a Person instance for each map in the array
          //from map to Person object
          Person person = Person.fromMap(peopleData[i]);

          // Add the Person instance to the list
          personList.add(person);
        }
      }
    } catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (builder) => AlertDialog(
                title: Text(
                  e.toString(),
                ),
              ));
    }

    return personList;
  }

  Future<Person?> getPerson(BuildContext context, int id) async {
    Person person;
    try {
      http.Response res = await http.get(
        Uri.parse('$ipAddress/api/people/$id'),
      );
      if (res.statusCode >= 400) throw Exception('User not found');
      // print(res.body);
      // Decode the JSON string
      Map<String, dynamic> data = jsonDecode(res.body)["person"];

      person = Person.fromMap(data);
    } catch (e) {
      showDialog(
        context: context,
        builder: (builder) => AlertDialog(
          title: Text(
            e.toString(),
          ),
        ),
      );
      return null;
    }
    return person;
  }

  Future<Person> deletePerson(BuildContext context, int id) async {
    Person person = Person(id: 0, name: '', age: 0, sex: '');
    try {
      http.Response res = await http.delete(
        Uri.parse('$ipAddress/api/people/$id'),
      );
      Map<String, dynamic> data = jsonDecode(res.body)["person_deleted"];

      person = Person.fromMap(data);
    } catch (e) {
      print(e);
      showDialog(
        context: context,
        builder: (builder) => AlertDialog(
          title: Text(
            e.toString(),
          ),
        ),
      );
    }
    return person;
  }

  Future<void> createPerson(
      BuildContext context, int id, String name, int age, String sex) async {
    Map<String, dynamic> data = {
      'id': id,
      'name': name,
      'age': age,
      'sex': sex,
    };
    try {
      http.Response res = await http.post(
        Uri.parse('$ipAddress/api/create_person'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );
      // Show a success Snackbar
      if (res.statusCode == 200)
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Person created successfully'),
            duration: Duration(seconds: 2), // You can adjust the duration
          ),
        );

      //if user create an user with same id, throw exception
      if (res.statusCode >= 400)
        throw Exception('Failed to create user: ${res.statusCode}');
    } catch (e) {
      showDialog(
        context: context,
        builder: (builder) => AlertDialog(
          title: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  Future<void> putPerson(
      BuildContext context, int id, String name, int age, String sex) async {
    //put the data into map
    Map<String, dynamic> data = {
      'id': id,
      'name': name,
      'age': age,
      'sex': sex,
    };
    try {
      http.Response res = await http.put(
        Uri.parse('$ipAddress/api/update_or_create_person/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );
      if (res.statusCode == 200)
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Person created/updated successfully'),
            duration: Duration(seconds: 2), // You can adjust the duration
          ),
        );

      //if user create an user with same id, throw exception
      if (res.statusCode >= 400)
        throw Exception('Failed to create user: ${res.statusCode}');
    } catch (e) {
      showDialog(
        context: context,
        builder: (builder) => AlertDialog(
          title: Text(
            e.toString(),
          ),
        ),
      );
    }
  }
}
