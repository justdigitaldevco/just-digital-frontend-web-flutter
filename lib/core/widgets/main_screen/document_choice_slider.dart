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
      title: 'TUTELA DE SALUD',
      description: 'Obten la tutela de salud. Protege y garantiza tus derechos cuando el sistema no responde',
      buttonText: 'Generar mi tutela',
      imagePath: 'assets/images/illustrations/main_screen/img_ms_1.png',
    ),
    DocumentType(
      title: 'SOLICITUD DE BANCARROTA',
      description: 'Obten tu documento de solicitud de bancarrota. Protege y garantiza tus derechos cuando el sistema no responde',
      buttonText: 'Próximamente',
      imagePath: 'assets/images/illustrations/main_screen/img_ms_1.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          // Stack containing all the visual elements
          Stack(
            children: [
              // Main content area with grey background - now adapts to content
              Container(
                margin: EdgeInsets.only(
                  left: screenWidth * 0.15,
                  top: 140,
                  bottom: 60, // Added bottom margin to separate from indicators
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 40.0,
                    right: 40.0,
                    top: 90,
                    bottom: 40, // Reduced bottom padding since container adapts
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // Allows container to adapt to content height
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // PageView for horizontal sliding content
                      SizedBox(
                        height: 280, // Fixed height for the PageView
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
                              padding: const EdgeInsets.only(right: 14.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Title
                                  Text(
                                      documentType.title,
                                      style: AppTheme.lightTheme.textTheme.displayLarge
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    width: screenWidth * 0.33,
                                    height: 2,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(height: 8),
                                  // Description and button
                                  Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            documentType.description,
                                            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                                                fontSize: 18,
                                                height: 1.4,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "Roboto"
                                            ),
                                            maxLines: 4,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 20),
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
                                              backgroundColor: const Color(0xFFDD6129),
                                              foregroundColor: Colors.white,
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 20,
                                                vertical: 12,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(25), // Very round corners
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
                                                  Icons.edit_note,
                                                  size: 20,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Green rectangle positioned over the grey background
              Positioned(
                right: screenWidth * 0.1,
                top: 90, // Positioned above the grey rectangle
                child: Container(
                  width: screenWidth * 0.65,
                  height: 120,
                  decoration: BoxDecoration(
                    color: const Color(0xFF005451),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              // PNG image positioned over both rectangles
              Positioned(
                right: screenWidth * 0.25,
                top: 10, // Positioned to overlap with green rectangle
                child: Image.asset(
                  documentTypes[_currentPage].imagePath,
                  width: screenWidth * 0.4,
                  height: screenWidth * 0.4,
                ),
              ),
            ],
          ),

          // Page indicators with more separation
          Container(
            padding: const EdgeInsets.only(bottom: 40, top: 20), // Increased top padding for more separation
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                documentTypes.length,
                    (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 6), // Slightly increased horizontal margin
                  width: 12, // Slightly larger indicators
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index
                        ? AppTheme.lightTheme.primaryColor
                        : Colors.grey[400],
                  ),
                ),
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