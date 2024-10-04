import 'package:assignment_generator/controller/model/beans.dart';

class PromptEngine {
  static const prompt_quizgen_choice =
      'Generate a multiple choice quiz in XML format '
      'that is compatible with Moodle XML import. The quiz is to be on the subject of '
      '[subject] and should be related to [topic]. '
      'The quiz should be the same level of difficulty for college [gradelevel] students of the '
      'English-speaking language. The quiz should have [numquestions] questions. ';

  static const prompt_quizgen_truefalse =
      'Generate a true/false quiz in XML format '
      'that is compatible with Moodle XML import. The quiz is to be on the subject of '
      '[subject] and should be related to [topic]. '
      'The quiz should be the same level of difficulty for college [gradelevel] students of the '
      'English-speaking language. The quiz should have [numquestions] questions. ';

  static const prompt_quizgen_shortanswer =
      'Generate a short answer assignment in XML '
      'format that is compatible with Moodle XML import. The assignment is to be on the '
      'subject of [subject] and should be related to [topic]. '
      'The assignment should be the same level of difficulty for college [gradelevel] students of the '
      'English-speaking language. The assignment should have [numquestions] questions. ';

  static const prompt_quizgen_essay =
      'Generate an essay assignment in XML format that '
      'is compatible with Moodle XML import. The assignment is to be on the subject of [subject] '
      'and should be related to [topic]. '
      'The assignment should be the same level of difficulty for college [gradelevel] students of the '
      'English-speaking language. ';

  static const prompt_quizgen_code =
      'Generate [numquestions] coding assignments in XML format '
      'that is compatible with Moodle XML import. The assignments are to be on the subject of '
      '[subject], should be related to [topic], and the programming language should be [codinglanguage]. '
      'The assignments should be the same level of difficulty for college [gradelevel] '
      'students of the English-speaking language. '
      'Make a rubric in the <generalfeedback> tag. '
      'Create a code template in the <responsetemplate> tag. '
      'Create a unit test to run the code template in the <graderinfo> tag. ';

  static const prompt_quizgen_xmlonly =
      'Provide only the XML in your response. ';

  static const prompt_quizgen_choice_example =
      'Please use this XML sample as a template for your response: <?xml version="1.0" encoding="UTF-8"?> <quiz> ... </quiz>'; // truncated for brevity

  static const prompt_quizgen_truefalse_example =
      'Please use this XML sample as a template for your response: <?xml version="1.0" encoding="UTF-8"?> <quiz> ... </quiz>'; // truncated for brevity

  static const prompt_quizgen_shortanswer_example =
      'Please use this XML sample as a template for your response: <?xml version="1.0" encoding="UTF-8"?> <quiz> ... </quiz>'; // truncated for brevity

  static const prompt_quizgen_essay_example =
      'Please use this XML sample as a template for your response: <?xml version="1.0" encoding="UTF-8"?> <quiz> ... </quiz>'; // truncated for brevity

  static const prompt_quizgen_coding_example =
      'Please use this XML sample as a template for your response: <?xml version="1.0" encoding="UTF-8"?> <quiz> ... </quiz>'; // truncated for brevity

  static String generatePrompt(AssignmentForm form) {
    String prompt;
    switch (form.questionType) {
      case QuestionType.multichoice:
        prompt = prompt_quizgen_choice + prompt_quizgen_choice_example;
        break;
      case QuestionType.truefalse:
        prompt = prompt_quizgen_truefalse + prompt_quizgen_truefalse_example;
        break;
      case QuestionType.shortanswer:
        prompt = prompt_quizgen_shortanswer + prompt_quizgen_shortanswer_example;
        break;
      case QuestionType.essay:
        prompt = prompt_quizgen_essay + prompt_quizgen_essay_example;
        break;
      case QuestionType.coding:
        prompt = prompt_quizgen_code + prompt_quizgen_coding_example;
        break;
    }
    prompt = prompt
        .replaceAll('[subject]', form.subject)
        .replaceAll('[topic]', form.topic)
        .replaceAll('[gradelevel]', form.gradeLevel)
        .replaceAll('[maxgrade]', form.maximumGrade.toString())
        .replaceAll('[numquestions]', form.questionCount.toString());

    if (form.assignmentCount != null) {
      prompt = prompt.replaceAll(
          '[numassignments]', form.assignmentCount.toString());
    }
    if (form.gradingCriteria != null) {
      prompt = prompt.replaceAll('[rubriccriteria]', form.gradingCriteria!);
    }
    if (form.codingLanguage != null) {
      prompt = prompt.replaceAll('[codinglanguage]', form.codingLanguage!);
    }
    prompt += prompt_quizgen_xmlonly;
    return prompt;
  }
}
