

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
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'AGILICEMOS TUS PROCESOS LEGALES, JUNTOS',
                    style: AppTheme.lightTheme.textTheme.displayLarge,
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: DocumentChoiceSlider(), // Your custom widget here
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'AGILICEMOS TUS PROCESOS LEGALES, JUNTOS',
                    style: AppTheme.lightTheme.textTheme.displayLarge,
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),

          // Section 2: Features with horizontal scrolling
          SliverToBoxAdapter(
            child: SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Container(
                    width: 150,
                    margin: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.star, size: 40),
                        Text('Feature ${index + 1}'),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),

          // Section 3: Content with grid
          SliverPadding(
            padding: EdgeInsets.all(16.0),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 columns on mobile
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.0,
              ),
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text('Item $index'),
                    ),
                  );
                },
                childCount: 6,
              ),
            ),
          ),

          // Section 4: Long content
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppTheme.lightTheme.primaryColor,
                    child: Text('${index + 1}'),
                  ),
                  title: Text(
                    'List Item ${index + 1}',
                    style: AppTheme.lightTheme.textTheme.titleMedium,
                  ),
                  subtitle: Text(
                    'Description for item ${index + 1}',
                    style: AppTheme.lightTheme.textTheme.bodyMedium,
                  ),
                );
              },
              childCount: 10,
            ),
          ),

          // Section 5: Footer/Call to Action
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(32.0),
              color: AppTheme.lightTheme.primaryColor,
              child: Column(
                children: [
                  Text(
                    'Ready to get started?',
                    style: AppTheme.lightTheme.textTheme.displayMedium?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Get Started'),
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