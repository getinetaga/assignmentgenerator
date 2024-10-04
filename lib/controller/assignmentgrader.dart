import 'package:assignmentgenerator/controller/model/beans.dart';

/*

void main() {
  // Sample questions
  var questions = [
    Question("What is the capital of France?", "Paris", "Paris", questionText: '', name: '', type: ''),
    Question("What is 2 + 2?", "4", "5", questionText: '', name: '', type: ''),
    Question("What is the chemical symbol for water?", "H2O", "H2O", name: '', questionText: '', type: ''),
  ];

  // Create a quiz
  var quiz = Quiz(questions);

  // Create an instance of AssessmentGrader
  var grader = AssignmentGrader();
  
  // Grade the quiz
  grader.gradeAssessment(quiz);
}

*/

void main() {
  // Sample questions for a quiz
  var quizQuestions = [
    Question('What is the capital of France?', 'Paris', 'Paris'),
    Question('What is 2 + 2?', '4', '5'),
    Question('What is the chemical symbol for water?', 'H2O', 'H2O'),
  ];

  // Create a quiz
  var quiz = Quiz(quizQuestions);

  // Create an instance of AssignmentGrader
  var grader = AssignmentGrader();
  
  // Grade the quiz
  grader.gradeAssessment(quiz);

  // Generate an essay assignment
  var essay = EssayAssignment('Discuss the impact of climate change.', '1000 words');
  grader.gradeAssessment(essay);

  // Generate a code assignment
  var codeAssignment = CodeAssignment('Write a function to calculate the factorial of a number.', 'Python');
  grader.gradeAssessment(codeAssignment);
}

// Class definitions
class Question {
  String questionText;
  String correctAnswer;
  String studentAnswer;

  Question(this.questionText, this.correctAnswer, this.studentAnswer);
}

class Quiz {
  List<Question> questions;
  Quiz(this.questions);
}

class EssayAssignment {
  String prompt;
  String requirements;

  EssayAssignment(this.prompt, this.requirements);
}

class CodeAssignment {
  String prompt;
  String language;

  CodeAssignment(this.prompt, this.language);
}

class AssignmentGrader {
  void gradeAssessment(dynamic assignment) {
    if (assignment is Quiz) {
      _gradeQuiz(assignment);
    } else if (assignment is EssayAssignment) {
      _gradeEssay(assignment);
    } else if (assignment is CodeAssignment) {
      _gradeCode(assignment);
    } else {
      print('Unknown assignment type.');
    }
  }

  void _gradeQuiz(Quiz quiz) {
    int score = 0;
    for (var question in quiz.questions) {
      if (question.studentAnswer == question.correctAnswer) {
        score++;
      }
    }
    print('Quiz scored: $score/${quiz.questions.length}');
  }

  void _gradeEssay(EssayAssignment essay) {
    // Example grading logic
    print("Grading essay: '${essay.prompt}' with requirements: ${essay.requirements}");
    // Simple placeholder for scoring
    print('Essay graded: 85/100');
  }

  void _gradeCode(CodeAssignment code) {
    // Example grading logic
    print("Grading code assignment: '${code.prompt}' in ${code.language}");
    // Simple placeholder for scoring
    print('Code assignment graded: 90/100');
  }
}