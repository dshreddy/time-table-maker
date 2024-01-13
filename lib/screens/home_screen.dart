import 'package:flutter/material.dart';
import 'package:time_table_maker/screens/time_table_screen.dart';
import 'package:time_table_maker/widgets/course.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> pmeList = [
    "Select PME",
    "CMA",
    "Foundations of DS & ML",
    "Computational Complexity",
    "Parameterized Algorithms",
    "Model Checking",
    "Quantum Computing",
    "Functional Programming",
    "Big Data Lab",
    "Deep Learning",
    "Responsible AI",
    "Error-Correcting Codes",
  ];
  List<DropdownMenuItem<String>> pmeDropdownItems = [];
  String selectedPME = "Select PME";

  List<String> gceList = [
    "Select GCE",
    "Quantum Mechanics",
    "Relativity",
    "Linguistics",
    "Mental Health",
    "Economic Development",
    "Finite Methods",
    "Electrochemistry",
    "Sustainability",
    "Nanobiotech",
    "Photosynthesis",
    "Computer Graphics",
    "Computational Methods for inv",
    "How to prepare for internship",
    "Industrial chemistry",
    "Engineering economics",
  ];
  List<DropdownMenuItem<String>> gceDropdownItems = [];
  String selectedGCE = "Select GCE";

  List<Course> selectedCourses = [];

  void removeSelectedCourse(String course) {
    setState(() {
      selectedCourses
          .removeWhere((selectedCourse) => selectedCourse.course == course);
    });
  }

  @override
  void initState() {
    super.initState();
    selectedCourses = [
      Course(
        course: "DBMS",
        remove: removeSelectedCourse,
      ),
      Course(
        course: "DBMS Lab",
        remove: removeSelectedCourse,
      ),
      Course(
        course: "Compiler Design",
        remove: removeSelectedCourse,
      ),
      Course(
        course: "Compiler Design Lab",
        remove: removeSelectedCourse,
      ),
    ];

    for (int i = 0; i < pmeList.length; i++) {
      pmeDropdownItems.add(DropdownMenuItem(
        value: pmeList[i],
        child: Text(pmeList[i]),
      ));
    }
    for (int i = 0; i < gceList.length; i++) {
      gceDropdownItems.add(DropdownMenuItem(
        value: gceList[i],
        child: Text(gceList[i]),
      ));
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
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(10),
                child: const Text(
                  "My courses",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    decoration: null,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                width: 400,
                color: Colors.white,
                child: DropdownButton<String>(
                  isExpanded: true,
                  dropdownColor: Colors.white,
                  value: selectedPME,
                  items: pmeDropdownItems,
                  onChanged: (value) {
                    setState(() {
                      if (value != null && value != "Select PME") {
                        if (!selectedCourses
                            .any((course) => course.course == value)) {
                          selectedCourses.add(Course(
                            course: value,
                            remove: removeSelectedCourse,
                          ));
                        }
                      }
                    });
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                width: 400,
                color: Colors.white,
                child: DropdownButton<String>(
                  isExpanded: true,
                  dropdownColor: Colors.white,
                  value: selectedGCE,
                  items: gceDropdownItems,
                  onChanged: (value) {
                    setState(() {
                      if (value != null && value != "Select GCE") {
                        if (!selectedCourses
                            .any((course) => course.course == value)) {
                          selectedCourses.add(Course(
                            course: value,
                            remove: removeSelectedCourse,
                          ));
                        }
                      }
                    });
                  },
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(10),
                  color: Colors.white,
                  child: Scrollbar(
                    thickness: 10,
                    thumbVisibility: true,
                    trackVisibility: true,
                    child: ListView.builder(
                      itemCount: selectedCourses.length,
                      itemBuilder: (context, index) => selectedCourses[index],
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: const EdgeInsets.all(10),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return TimeTableGenerator(
                              selectedCourses: selectedCourses);
                        },
                      ),
                    );
                  },
                  child: const Text("Get Time Table"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
