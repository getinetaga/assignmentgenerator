// ignore_for_file: unused_import, non_constant_identifier_names

/*import 'dart:convert';

import 'package:assignment_generator/controller/model/beans.dart';
import 'package:assignmentgrader/controller/model/beans.dart';
import 'package:http/http.dart' as http;

class AssignmentGenerator {
  final serverUrl;

  AssignmentGenerator({required this.serverUrl});

  Future<Quiz> generateAssessment(String queryPrompt) async {
    final response = await http.post(
      Uri.parse('$serverUrl/generateAssignment'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {'QueryPrompt': queryPrompt},
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      final aiResponse = responseBody['assignment'];
      return Quiz.fromXmlString(aiResponse);
    } else {
      throw Exception('Failed to generate assignment');
    }
  }
}
Future<Essay> generateAssessment(String queryPrompt) async {
    final response = await http.post(
      Uri.parse('$serverUrl/generateAssignment'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {'QueryPrompt': queryPrompt},
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      final aiResponse = responseBody['assignment'];
      return Essay.fromXmlString(aiResponse);
    } else {
      throw Exception('Failed to generate assignment');
    }
  }
    }
    Future<Code> generateAssignment(String queryPrompt) async {
    final response = await http.post(
      Uri.parse('$serverUrl/generateAssignment'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {'QueryPrompt': queryPrompt},
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      final aiResponse = responseBody['assignment'];
      return Quiz.fromXmlString(aiResponse);
    } else {
      throw Exception('Failed to generate assignment');
    }
  }
  }

*/

/*                                               OPTION 2
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
//import 'package:path_provider/path_provider.dart';
//import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class AssignmentGenerator {
  final String serverUrl;

  AssignmentGenerator({required this.serverUrl});
  
  get subject_assignment => null;

  Future<String> generateAssignment(String subject) async {
    // Replace with your actual API calls to Perplexity and ChatGPT
    String assignmentFromChatGPT = await fetchFromChatGPT(subject);
    String assignmentFromPerplexity = await fetchFromPerplexity(subject);
    
    return '$assignmentFromChatGPT\n\n$assignmentFromPerplexity';
  }

  Future<String> fetchFromChatGPT(String subject) async {
    // Example API call to ChatGPT (replace with actual logic)
    // Placeholder response
    return 'ChatGPT assignment for $subject';
  }

  Future<String> fetchFromPerplexity(String subject) async {
    // Example API call to Perplexity (replace with actual logic)
    // Placeholder response
    return 'Perplexity assignment for $subject';
  }

  Future<void> saveToPDF(String content, String subject) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Text(content),
        ),
      ),
    );

    final output = await getApplicationDocumentsDirectory();
    final file = File('${output.path}/$subject_assignment.pdf');
    await file.writeAsBytes(await pdf.save());
  }
  
  getApplicationDocumentsDirectory() {}
}

// Example usage:
void main() async {
  final generator = AssignmentGenerator(serverUrl: 'your_server_url');

  List<String> subjects = [
    'Math',
    'Chemistry',
    'Biology',
    'Computer Science',
    'Literature',
    'History',
    'Language Arts',
  ];

  for (var subject in subjects) {
    String assignment = await generator.generateAssignment(subject);
    await generator.saveToPDF(assignment, subject);
    print('Saved assignment for $subject');
  }
}

*/
import 'dart:convert';

import 'package:http/http.dart' as http;
//import 'package:stopwatch/stopwatch.dart';

class AssignmentGenerator {
  final String chatGptUrl; // Your ChatGPT endpoint
  final String perplexityUrl; // Your Perplexity endpoint
  final String claudeaiUrl; //https://claude.ai/

  AssignmentGenerator({required this.chatGptUrl, required this.perplexityUrl, this.claudeaiUrl});

  Future<Map<String, dynamic>> generateAssignment(String subject) async {
    final stopwatch = Stopwatch()..start();

    String chatGptResponse = await fetchFromChatGPT(subject);
    stopwatch.stop();
    final chatGptTime = stopwatch.elapsedMilliseconds;

    stopwatch.reset();
    stopwatch.start();

    String perplexityResponse = await fetchFromPerplexity(subject);
    stopwatch.stop();
    final perplexityTime = stopwatch.elapsedMilliseconds;

    String claudeAIResponse = await fetchFromClaudeAI(subject);
    stopwatch.stop();
    final claudeAiTime = stopwatch.elapsedMilliseconds;

    return {
      'chatGptResponse': chatGptResponse,
      'perplexityResponse': perplexityResponse,
      'chatGptTime': chatGptTime,
      'perplexityTime': perplexityTime,
    };
  }

  Future<String> fetchFromChatGPT(String subject) async {
    // Replace with actual API call
    await Future.delayed(Duration(seconds: 1)); // Simulate response time
    return 'ChatGPT assignment for $subject';
  }

  Future<String> fetchFromPerplexity(String subject) async {
    // Replace with actual API call
    await Future.delayed(Duration(seconds: 2)); // Simulate response time
    return 'Perplexity assignment for $subject';
  }
  Future<String> fetchFromChatbot(String subject) async {
    // Replace with actual API call
    await Future.delayed(Duration(seconds: 2)); // Simulate response time
    return 'Chatbot assignment helper for $subject';
  }
}

fetchFromClaudeAI(String subject) {
}

// Example usage:
void main() async {
  final generator = AssignmentGenerator(
    chatGptUrl: 'your_chatgpt_url',
    perplexityUrl: 'your_perplexity_url',
  );

  final result = await generator.generateAssignment('Math');
  
  print('ChatGPT Response Time: ${result['chatGptTime']} ms');
  print('Perplexity Response Time: ${result['perplexityTime']} ms');
  print('ChatGPT Response: ${result['chatGptResponse']}');
  print('Perplexity Response: ${result['perplexityResponse']}');
}
