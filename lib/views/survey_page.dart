import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:care_assist/view_models/survey_page_vm.dart';
import 'package:care_assist/views/survey_tile.dart';
import 'package:care_assist/models/survey_info.dart';

class SurveyPage extends StatefulWidget {
  const SurveyPage({super.key});

  @override
  State<SurveyPage> createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final surveyViewModel = context.watch<SurveyInfoViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Survey'),
      ),
      body: FutureBuilder(
        future: _fetchSurveyInfo(surveyViewModel, currentIndex),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Waiting'),
            );
          } else if (!snapshot.hasData) {
            return const Center(
              child: Text('No survey data available'),
            );
          } else {
            return SurveyTile(
              surveyInfo: snapshot.data!,
              nextQuestion: () {
                setState(() {
                  int questionLenght = surveyViewModel.surveyInfos.length;
                  if (currentIndex < questionLenght - 1) {
                    currentIndex++;
                  } else if (currentIndex == questionLenght - 1) {
                    context.pop();
                  }
                });
              },
            );
          }
        },
      ),
    );
  }

  Future<SurveyInfo> _fetchSurveyInfo(
      SurveyInfoViewModel viewModel, int index) async {
    // Assuming the `surveyInfos` list contains Future<SurveyInfo> objects
    return await viewModel.surveyInfos[index];
  }
}
