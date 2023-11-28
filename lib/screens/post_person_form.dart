// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:project/services/home_services.dart';
import 'package:project/widgets/custom_text_field.dart';

class PostPersonForm extends StatelessWidget {
  static const routeName = '/post-person-form';
  const PostPersonForm({super.key});

  @override
  Widget build(BuildContext context) {
    final _personFormKey = GlobalKey<FormState>();
    final TextEditingController idController = TextEditingController();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController ageController = TextEditingController();
    final TextEditingController sexController = TextEditingController();
    final HomeService homeService = HomeService();

    void createPerson() async {
      try {
        await homeService.createPerson(
          context,
          int.parse(idController.text),
          nameController.text,
          int.parse(ageController.text),
          sexController.text,
        );


      } catch (e) {
        // Show an error Snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to create person: $e'),
            duration: Duration(seconds: 2), // You can adjust the duration
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Create a new person'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _personFormKey,
                child: Column(
                  children: [
                    CustomTextField(
                      hintText: 'id',
                      controller: idController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                        hintText: 'name', controller: nameController),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(hintText: 'age', controller: ageController),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(hintText: 'sex', controller: sexController),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //this may not visible, as andriod doesn't support apple pay, and vice versa
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                      onPressed: createPerson,
                      child: Text('Create!'),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
