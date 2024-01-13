import 'dart:html';

import 'package:flutter/material.dart';
import '../widgets/course.dart';

const slots = {
  "Monday": {
    "M1": "08:00 - 08:50",
    "A": "09:00 - 09:50",
    "B": "10:00 - 10:50",
    "C": "11:00 - 11:50",
    "H": "12:05 - 12:55",
    "I": "14:00 - 15:15",
    "J": "15:30 - 16:45",
    "E1": "17:10 -  18:00",
    "PM1": "10:00 - 12:55",
    "PA1": "14:00 - 16:45",
  },
  "Tuesday": {
    "M2": "08:00 - 08:50",
    "F": "09:00 - 10:15",
    "G": "10:30 - 11:45",
    "D": "12:00 - 12:50",
    "K": "14:00 - 15:15",
    "L": "15:30 - 16:45",
    "E2": "17:10 - 18:00",
    "PM2": "09:00 - 11:45",
    "PA2": "14:00 - 16:45",
  },
  "Wednesday": {
    "M3": "08:00 - 08:50",
    "A": "09:00 - 09:50",
    "B": "10:00 - 10:50",
    "C": "11:00 - 11:50",
    "H": "12:05 - 12:55",
    "Q": "14:00 - 14:50",
    "R": "15:00 - 15:50",
    "EML": "16:00 -  18:00",
    "PM3": "10:00 - 12:55",
    "PA3": "14:00 - 16:45",
  },
  "Thursday": {
    "M4": "08:00 - 08:50",
    "F": "09:00 - 10:15",
    "G": "10:30 - 11:45",
    "D": "12:00 - 12:50",
    "K": "14:00 - 15:15",
    "L": "15:30 - 16:45",
    "E4": "17:10 - 18:00",
    "PM4": "09:00 - 11:45",
    "PA4": "14:00 - 16:45",
  },
  "Friday": {
    "M5": "08:00 - 08:50",
    "A": "09:00 - 09:50",
    "B": "10:00 - 10:50",
    "C": "11:00 - 11:50",
    "H": "12:05 - 12:55",
    "I": "14:00 - 15:15",
    "J": "15:30 - 16:45",
    "E5": "17:10 -  18:00",
    "PM5": "10:00 - 12:55",
    "PA5": "14:00 - 16:45",
  },
};

const classSlots = {
  "DBMS": ["A"],
  "DBMS Lab": ["PA1"],
  "Compiler Design": ["D", "E5"],
  "Compiler Design Lab": ["PA5"],
  "CMA": ["PA4", "E4"],
  "Foundations of DS & ML": ["F"],
  "Computational Complexity": ["B"],
  "Parameterized Algorithms": ["H"],
  "Model Checking": ["C", "E2"],
  "Quantum Computing": ["E"],
  "Functional Programming": ["B"],
  "Big Data Lab": ["PM3"],
  "Deep Learning": ["G", "PM5"],
  "Responsible AI": ["L"],
  "Error-Correcting Codes": ["F"],
  "Quantum Mechanics": ["G"],
  "Relativity": ["G"],
  "Linguistics": ["G"],
  "Mental Health": ["G"],
  "Economic Development": ["G"],
  "Finite Methods": ["G"],
  "Electrochemistry": ["G"],
  "Sustainability": ["G"],
  "Nanobiotech": ["G"],
  "Photosynthesis": ["G"],
  "Computer Graphics": ["G"],
  "Computational Methods for inv": ["G"],
  "How to prepare for internship": ["E4"],
  "Industrial chemistry": ["F"],
  "Engineering economics": ["F"],
};

class TimeTableGenerator extends StatefulWidget {
  const TimeTableGenerator({super.key, required this.selectedCourses});

  final List<Course> selectedCourses;
  @override
  State<TimeTableGenerator> createState() => _TimeTableGeneratorState();
}

class _TimeTableGeneratorState extends State<TimeTableGenerator> {
  List<Widget> schedule = [];

  @override
  void initState() {
    super.initState();
    var classes = _getClasses(widget.selectedCourses);
    var schedule_ = _generateClassSchedule(slots, classes);
    for (var day in schedule_.keys) {
      schedule.add(Text(
        day,
        style: const TextStyle(
          color: Colors.lightBlueAccent,
          fontSize: 25,
          fontWeight: FontWeight.w700,
        ),
      ));
      for (var classes_ in schedule_[day]!) {
        var courseName = classes_["course"];
        var courseTime = classes_["time"];
        schedule.add(Text(
          "$courseTime : $courseName",
          style: const TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(1, 0),
              end: Alignment(0, 1),
              colors: [
                Color(0XFF47BFDF),
                Color(0XFF4A91FF),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Scrollbar(
                    thickness: 10,
                    thumbVisibility: true,
                    trackVisibility: true,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: schedule.length,
                      itemBuilder: (context, index) => schedule[index],
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Go back"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Map<String, List<Map<String, String>>> _generateClassSchedule(
      Map<String, Map<String, String>>? slots,
      Map<String, List<String>>? classes) {
    if (slots == null || classes == null) {
      // Handle null input gracefully, e.g., return an empty schedule or throw an exception
      return {}; // Returning an empty schedule here as an example
    }

    Map<String, List<Map<String, String>>> classSchedule = {};

    for (var day in slots.keys) {
      classSchedule[day] = [];

      // Sort slots within the day, ensuring `slots[day]` is not null before accessing `entries`
      if (slots[day] != null) {
        var sortedSlotEntries = slots[day]!.entries.toList()
          ..sort((a, b) => a.value.compareTo(b.value));

        for (var slotEntry in sortedSlotEntries) {
          var slot = slotEntry.key;
          var time = slotEntry.value.trim();

          for (var course in classes.keys) {
            if (classes[course]!.contains(slot)) {
              classSchedule[day]!.add({"course": course, "time": time});
            }
          }
        }
      }
    }
    return classSchedule;
  }

  Map<String, List<String>> _getClasses(List<Course> selectedCourses) {
    Map<String, List<String>> classes = {};
    for (var course in selectedCourses) {
      classes[course.course] = classSlots[course.course]!;
    }
    return classes;
  }
}
