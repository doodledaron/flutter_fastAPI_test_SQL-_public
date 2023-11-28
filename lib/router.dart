import 'package:flutter/material.dart';
import 'package:project/screens/post_person_form.dart';
import 'package:project/screens/put_person_form.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case PostPersonForm.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const PostPersonForm(),
      );

    case PutPersonForm.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const PutPersonForm(),
      );

    default:
      return MaterialPageRoute(
          builder: (_) => const Scaffold(
                body: Scaffold(
                  body: Center(
                    child: Text('Page Not Found'),
                  ),
                ),
              ));
  }
}
