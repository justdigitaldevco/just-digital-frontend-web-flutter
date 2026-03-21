import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:justdigital_webapp/core/constants/questions.dart';
import 'package:justdigital_webapp/core/widgets/questions_slider.dart';
import '../core/widgets/custom_appbar.dart';
import '../core/themes/app_theme.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  String _currentHelpTextLong =
      'La tutela es útil cuando: te exigen requisitos innecesarios que retrasan tu atención.';

  void _onQuestionChanged(Question question) {
    setState(() {
      _currentHelpTextLong = question.helpTextLong.isNotEmpty
          ? question.helpTextLong
          : 'La tutela es útil cuando: te exigen requisitos innecesarios que retrasan tu atención.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: CustomScrollView(
        slivers: <Widget>[
          // Header container
          SliverToBoxAdapter(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              margin: EdgeInsets.all(16),
              color: AppTheme.lightTheme.primaryColor,
              child: const Center(
                child: Text(
                  'TUTELA DE SALUD',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          // Question slider
          SliverToBoxAdapter(
            child: SizedBox(
              height: 500,
              child: QuestionSlider(
                questions: questionsFreeTutela,
                onQuestionChanged: _onQuestionChanged,
              ),
            ),
          ),

          // Orange info box
          SliverToBoxAdapter(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color.fromARGB(200, 255, 211, 193),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon with decorative lines
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          color: Colors.white,
                          margin: EdgeInsets.only(right: 8),
                        ),
                      ),
                      Icon(
                        Icons.medical_services,
                        color: Colors.white,
                        size: 24,
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: Colors.white,
                          margin: EdgeInsets.only(left: 8),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16),

                  // Paragraph text — driven by current question's helpTextLong
                  Text(
                    _currentHelpTextLong,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}