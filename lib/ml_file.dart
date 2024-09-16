import 'package:flutter/material.dart';
import 'ml_service.dart';

class QuestionnairePage extends StatefulWidget {
  @override
  _QuestionnairePageState createState() => _QuestionnairePageState();
}

class _QuestionnairePageState extends State<QuestionnairePage> {
  final MLService _mlService = MLService();
  Map<String, dynamic> _userResponses = {}; // Store user responses

  void _submitQuestionnaire() async {
    _userResponses = {
      'response_numeric': 2, /
      'age': 25,
      'gender': 1,
    };

    String recommendation = await _mlService.getRecommendation(_userResponses);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Recommendation'),
        content: Text(recommendation),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Questionnaire')),
      body: Column(
        children: [
          // Your questionnaire UI here (questions and input fields)
          ElevatedButton(
            onPressed: _submitQuestionnaire,
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}
