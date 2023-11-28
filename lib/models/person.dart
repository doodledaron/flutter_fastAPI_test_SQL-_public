import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Person {
  final int id;
  final String name;
  final int age;
  final String sex;
  Person({
    required this.id,
    required this.name,
    required this.age,
    required this.sex,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'age': age,
      'sex': sex,
    };
  }

  factory Person.fromMap(Map<String, dynamic> map) {
    return Person(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      age: map['age'] ?? '',
      sex: map['sex'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Person.fromJson(String source) => Person.fromMap(json.decode(source));
}
