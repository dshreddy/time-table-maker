import 'package:flutter/material.dart';

class Course extends StatelessWidget {
  const Course({super.key, required this.course, required this.remove});
  final String course;
  final void Function(String) remove;

  @override
  Widget build(BuildContext context) {
    if (course == "DBMS" ||
        course == "DBMS Lab" ||
        course == "Compiler Design" ||
        course == "Compiler Design Lab") {
      return ListTile(
        title: Text(
          course,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    } else {
      return ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              course,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            IconButton(
              onPressed: () {
                remove(course);
              },
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
      );
    }
  }
}
