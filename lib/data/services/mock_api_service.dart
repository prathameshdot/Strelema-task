import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/que_model.dart';

class MockApiService {
  static const String _url = 'https://6a3cc27fd8e212699e22b7db.mockapi.io/api/v1/questionnaires';

  Future<List<QueModel>> fetchQues() async {
    try {
      final res = await http.get(Uri.parse(_url));
      if (res.statusCode == 200) {
        List<dynamic> data = json.decode(res.body);
        return data.map((j) => QueModel.fromJson(j['id'] ?? '', j)).toList();
      }
    } catch (e) {
      print(e);
    }
    return _getStaticQues();
  }
  List<QueModel> _getStaticQues() {
    return [
      QueModel(
        id: '1',
        title: 'Master Flutter & Dart',
        desc: 'A comprehensive 10-question quiz to test your absolute knowledge.',
        ques: [
          Que(id: 'q1', text: 'What is Flutter?', opts: ['A game engine', 'A UI toolkit', 'An OS', 'A database']),
          Que(id: 'q2', text: 'Which programming language is used in Flutter?', opts: ['Java', 'Kotlin', 'Dart', 'Swift']),
          Que(id: 'q3', text: 'What is a StatefulWidget?', opts: ['Immutable widget', 'Mutable widget', 'A function', 'A package']),
          Que(id: 'q4', text: 'Who developed Flutter?', opts: ['Apple', 'Microsoft', 'Google', 'Facebook']),
          Que(id: 'q5', text: 'What command starts a new Flutter project?', opts: ['flutter run', 'flutter start', 'flutter create', 'flutter init']),
          Que(id: 'q6', text: 'What widget is used for scrolling lists?', opts: ['Column', 'Row', 'ListView', 'Stack']),
          Que(id: 'q7', text: 'How do you define a constant variable in Dart?', opts: ['let', 'var', 'final', 'const']),
          Que(id: 'q8', text: 'What does the pubspec.yaml file do?', opts: ['Manages assets and dependencies', 'Compiles code', 'Runs tests', 'Stores user data']),
          Que(id: 'q9', text: 'Which widget allows overlapping its children?', opts: ['Container', 'Row', 'Stack', 'Column']),
          Que(id: 'q10', text: 'What is the root widget of a material app usually called?', opts: ['GetMaterialApp / MaterialApp', 'Scaffold', 'Center', 'AppBar']),
        ],
      ),
      QueModel(
        id: '2',
        title: 'Mobile App Design Basics',
        desc: 'A quick 5-question test on standard mobile design principles.',
        ques: [
          Que(id: 'd1', text: 'What does UI stand for?', opts: ['User Integration', 'User Interface', 'Unified Integration', 'Unique Interface']),
          Que(id: 'd2', text: 'What does UX stand for?', opts: ['User Experience', 'User Execution', 'User Extraction', 'Universal Experience']),
          Que(id: 'd3', text: 'Which color model is primarily used for digital screens?', opts: ['CMYK', 'RGB', 'Pantone', 'Grayscale']),
          Que(id: 'd4', text: 'What is a wireframe?', opts: ['A high-fidelity mockup', 'A coded prototype', 'A basic visual guide of a layout', 'A 3D model']),
          Que(id: 'd5', text: 'What does CTA stand for?', opts: ['Call to Action', 'Click to Animate', 'Center Text Alignment', 'Color Theme Application']),
        ],
      ),
    ];
  }
}
