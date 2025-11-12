import 'package:flutter/material.dart';
import '../../../screens/form_screen.dart';
import '../../themes/app_theme.dart';

class DocumentType {
  final String title;
  final String description;
  final String buttonText;
  final String imagePath;

  const DocumentType({
    required this.title,
    required this.description,
    required this.buttonText,
    required this.imagePath,
  });
}

class DocumentChoiceSlider extends StatefulWidget {
  const DocumentChoiceSlider({super.key});

  @override
  State<DocumentChoiceSlider> createState() => _DocumentChoiceSliderState();
}

class _DocumentChoiceSliderState extends State<DocumentChoiceSlider> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<DocumentType> documentTypes = [
    DocumentType(
      title: 'Legal Documents',
      description: 'Create professional legal documents with our easy-to-use templates. Perfect for contracts, agreements, and more.',
      buttonText: 'Create Legal Doc',
      imagePath: 'assets/images/illustrations/main_screen/img_ms_1.png',
    ),
    DocumentType(
      title: 'Business Forms',
      description: 'Streamline your business operations with customizable forms and templates for various business needs.',
      buttonText: 'Business Forms',
      imagePath: 'assets/images/illustrations/main_screen/img_ms_1.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      color: Colors.white,
      height: 600,
      child: Stack(
        children: [
          // 1. Grey rectangle with round corners (slightly off the right)
          Positioned(
            right: -screenWidth * 0.15,
            top: 140,
            child: Container(
              width: screenWidth * 1,
              height: 284,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
            ),
          ),
          // 2. Green rectangle (smaller, aligned with grey rectangle top)
          Positioned(
            right: screenWidth * 0.1,
            top: 90,
            child: Container(
              width: screenWidth * 0.65,
              height: 120,
              decoration: BoxDecoration(
                color: const Color(0xFF005451),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),

          // 3. PNG image starting from lower part of green rectangle - moved up
          Positioned(
            right: screenWidth * 0.25,
            top: 50, // Moved up to create overlap with green rectangle
            child: Image.asset(
              documentTypes[_currentPage].imagePath,
              width: screenWidth * 0.4,
              height: screenWidth * 0.4, // Slightly taller to accommodate the upward movement
            ),
          ),
          // 4. Content slider inside the grey rectangle
          Positioned(
            left: 100,
            top: 230, // Adjusted to stay inside grey rectangle
            bottom: 40, // Added bottom constraint to stay inside
            child: Container(
              width: screenWidth * 0.6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // PageView for horizontal sliding content
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: documentTypes.length,
                      onPageChanged: (int page) {
                        setState(() {
                          _currentPage = page;
                        });
                      },
                      itemBuilder: (context, index) {
                        final documentType = documentTypes[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Title
                              Text(
                                documentType.title,
                                style: AppTheme.lightTheme.textTheme.displayLarge?.copyWith(
                                  fontSize: 28,
                                ),
                              ),

                              const SizedBox(height: 16),

                              // Small horizontal division line
                              Container(
                                width: 50,
                                height: 2,
                                color: AppTheme.lightTheme.primaryColor,
                              ),

                              const SizedBox(height: 16),

                              // Small paragraph
                              Expanded(
                                child: Text(
                                  documentType.description,
                                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                                    fontSize: 14,
                                    height: 1.5,
                                  ),
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),

                              const SizedBox(height: 24),

                              // Button with text on left and icon on right
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation, secondaryAnimation) => const FormPage(),
                                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                        return SlideTransition(
                                          position: Tween<Offset>(
                                            begin: const Offset(1.0, 0.0),
                                            end: Offset.zero,
                                          ).animate(animation),
                                          child: child,
                                        );
                                      },
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.lightTheme.primaryColor,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      documentType.buttonText,
                                      style: AppTheme.lightTheme.textTheme.labelLarge,
                                    ),
                                    const SizedBox(width: 8),
                                    const Icon(
                                      Icons.arrow_forward,
                                      size: 18,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  // Page indicators
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: List.generate(
                      documentTypes.length,
                          (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentPage == index
                              ? AppTheme.lightTheme.primaryColor
                              : Colors.grey[400],
                        ),
                      ),
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

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}