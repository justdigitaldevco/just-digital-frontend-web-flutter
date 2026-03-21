import 'package:flutter/material.dart';
import 'package:justdigital_webapp/core/widgets/custom_appbar.dart';
import 'package:justdigital_webapp/core/widgets/main_screen/document_choice_slider.dart';
import 'package:justdigital_webapp/core/widgets/main_screen/quienes_somos.dart';

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
          SliverToBoxAdapter(
            child: ContentSection(
                title: "¿QUIENES SOMOS?",
                paragraphText: "Just Digital es una plataforma legal digital Colombiana diseñada para acercar el derecho a las personas, empoderándolas a través de herramientas claras, prácticas y accesibles.",
                imagePath: "assets/images/illustrations/main_screen/img_ms_2.png"),
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