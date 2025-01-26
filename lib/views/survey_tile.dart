import 'package:flutter/material.dart';

import 'package:care_assist/models/survey_info.dart';

class SurveyTile extends StatelessWidget {
  const SurveyTile(
      {super.key, required this.surveyInfo, required this.nextQuestion});
  final SurveyInfo surveyInfo;
  final Function() nextQuestion;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.only(
        top: 100,
        left: MediaQuery.of(context).size.width / 4,
      ),
      width: MediaQuery.of(context).size.width / 2,
      height: 100,
      decoration: const BoxDecoration(
        color: Colors.lime,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Question'),
            Text(surveyInfo.question),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: nextQuestion,
                  child: const Text('Yes'),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('No'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
