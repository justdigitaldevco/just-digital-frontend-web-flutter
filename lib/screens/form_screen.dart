import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:justdigital_webapp/core/constants/questions.dart';
import 'package:justdigital_webapp/core/widgets/questions_slider.dart';
import '../core/widgets/custom_appbar.dart';
import '../core/themes/app_theme.dart';

class FormPage extends StatelessWidget {
  const FormPage({super.key});

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
              child: QuestionSlider(questions: questionsFreeTutela),
            ),
          ),

          // Orange info box
          SliverToBoxAdapter(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color.fromARGB(200,255, 211, 193), // Orange background
                borderRadius: BorderRadius.circular(8), // Optional: rounded corners
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
                      // Replace with your actual PNG icon
                      // For now using an Icon, replace with Image.asset() for your PNG
                      Icon(
                        Icons.medical_services, // Replace with your actual icon
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

                  SizedBox(height: 16), // Spacing between icon and text

                  // Paragraph text
                  const Text(
                    'La tutela es útil cuando: te exigen requisitos innecesarios que retrasan tu atención.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
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