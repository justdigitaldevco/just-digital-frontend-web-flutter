import 'package:flutter/material.dart';

class ContentSection extends StatelessWidget {
  final String title;
  final String paragraphText;
  final String imagePath;

  const ContentSection({
    super.key,
    required this.title,
    required this.paragraphText,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // First part: Grey section with margins
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 40.0),
          color: Colors.grey[300],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title text
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Woman writing PNG image
              Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ],
          ),
        ),

        // Second part: Darker grey section without lateral margins
        Container(
          color: Colors.grey[700], // Darker grey
          child: Center(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 16.0),
              width: double.infinity,
              // This container will have lateral margins inside the dark grey
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                padding: const EdgeInsets.all(16.0),
                color: Colors.grey[400], // Lighter grey
                child: Text(
                  paragraphText,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}