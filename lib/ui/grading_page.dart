import 'package:assignment_generator/controller/main_controller.dart';
import 'package:assignment_generator/ui/header.dart';
// ignore: depend_on_referenced_packages
//import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../controller/model/beans.dart';

class GradingPage extends StatefulWidget {
  const GradingPage({super.key});

  static MainController controller = MainController();

  @override
  @override
  _GradingPageState createState() => _GradingPageState();
}

class _GradingPageState extends State<GradingPage> {
  Course? _selectedCourse;
  String? _selectedExam;
  String? _selectedStudent;
  List<FileNameAndBytes> _studentFiles = [];
  FileNameAndBytes? _gradingFile;

  final List<String> _assignment = [
    'Assignment 1',
    'Assignment 2',
    'Assignment 3'
  ];

  final List<String> _students = [
    'Jon Doe1',
    'Jon Doe2',
    'Jon Doe3',
  ];

  List<Course> courses = [];

  bool readyForUpload() {
    return _gradingFile != null && _studentFiles.isNotEmpty;
  }

  Future<String> _compileAndGrade() async {
    if (kDebugMode) {
      print(_gradingFile);
      print(_studentFiles.join('\n'));
    }
    if (!readyForUpload()) return 'Invalid files';
    
    String output;
    try {
      output = await MainController().compileCodeAndGetOutput(
        List.from(_studentFiles)..add(_gradingFile!)
      );
      return output;
    } catch (e) {
      return e.toString();
    }
  }

  void _showGradeOutput(String output) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Compile and Run Results'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(output.isNotEmpty ? output : 'NO DATA'),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


 @override
  void initState() {
    super.initState();
    MainController().getCourses().then((result) {
      setState(() {
        courses = result;
      });
    });
  }

  Future<void> pickStudentFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      setState(() {
        _studentFiles = result.files.map((file) => FileNameAndBytes(file.name, file.bytes!)).toList();
      });
    }
  }

  Future<void> pickGradingFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result != null) {
      setState(() {
        _gradingFile = FileNameAndBytes(result.files.single.name, result.files.single.bytes!);
      });
    }
  }


@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(
        title: 'Compile and Grade Code',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<Course>(
              decoration: const InputDecoration(
                labelText: 'Select Course',
                border: OutlineInputBorder(),
              ),
              value: _selectedCourse,
              items: courses.map((course) {
                return DropdownMenuItem(
                  value: course,
                  child: Text(course.shortName),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCourse = value;
                });
              },
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Select Quiz',
                border: OutlineInputBorder(),
              ),
              value: _selectedExam,
              items: _assignment.map((exam) {  // Use the correct list here
                return DropdownMenuItem<String>(
                  value: exam,
                  child: Text(exam),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedExam = value;
                });
              },
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Select Student',
                border: OutlineInputBorder(),
              ),
              value: _selectedStudent,
              items: _students.map((student) {
                return DropdownMenuItem<String>(
                  value: student,
                  child: Text(student),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedStudent = value;
                });
              },
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(
                  onPressed: pickStudentFile,
                  child: const Text('Upload Student\'s File')
                ),
                const SizedBox(width: 8),
                Text(
                  _studentFiles.map((file) => file.filename).join(', '),
                  style: const TextStyle(color: Colors.green)
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(
                  onPressed: pickGradingFile,
                  child: const Text('Upload Grading File')
                ),
                const SizedBox(width: 8),
                Text(
                  _gradingFile?.filename ?? '',
                  style: const TextStyle(color: Colors.green)
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String output = await _compileAndGrade();
                _showGradeOutput(output);
              },
              child: const Text('Compile and Grade'),
            ),
          ],
        ),
      ),
    );
  }
}
