import 'package:flutter/material.dart';
import 'package:justdigital_webapp/core/widgets/custom_appbar.dart';
import 'package:justdigital_webapp/core/widgets/main_screen/document_choice_slider.dart';

import '../core/themes/app_theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: CustomScrollView(
        slivers: <Widget>[
          // Section 1: Hero/Introduction
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              child: Column(
                children: [
                  Text(
                    'AGILICEMOS TUS PROCESOS LEGALES, JUNTOS',
                    style: AppTheme.lightTheme.textTheme.displayLarge,
                  ),
                 // SizedBox(height: 30),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: DocumentChoiceSlider(),
          ),

          // Section 5: Footer/Call to Action
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(32.0),
              color: AppTheme.lightTheme.primaryColor,
              child: Column(
                children: [
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}