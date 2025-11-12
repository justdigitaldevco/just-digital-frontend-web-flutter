import 'package:flutter/material.dart';
import '../constants/questions.dart';
import 'form_screen/city_selector_widget.dart';

class QuestionSlider extends StatefulWidget {
  final List<Question> questions;

  const QuestionSlider({Key? key, required this.questions}) : super(key: key);

  @override
  State<QuestionSlider> createState() => _QuestionSliderState();
}

class _QuestionSliderState extends State<QuestionSlider> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Only need controllers for text inputs now
  final Map<int, TextEditingController> _textControllers = {};
  final Map<int, Map<String, String?>> _cityDeptValues = {};

  // Get filtered questions based on dependencies
  List<Question> get _filteredQuestions {
    return widget.questions.where((question) {
      // If no dependency, always show the question
      if (question.dependsOn.isEmpty) return true;

      // Find the dependency question
      final dependencyQuestion = widget.questions.firstWhere(
            (q) => q.id == question.dependsOn,
        orElse: () => Question(
            id: '',
            question: '',
            inputType: '',
            associatedFields: '',
            condition: '',
            helpText: ''
        ),
      );

      // Check if the dependency value matches
      return dependencyQuestion.answer == question.dependencyValue;
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    // Initialize controllers only for text questions
    for (int i = 0; i < widget.questions.length; i++) {
      final question = widget.questions[i];
      if (question.inputType == 'text') {
        _textControllers[i] = TextEditingController();
        // Add listener to trigger rebuild when text changes
        _textControllers[i]!.addListener(() {
          setState(() {});
          // Update the answer directly on the question
          widget.questions[i].answer = _textControllers[i]?.text;
        });
      } else if (question.inputType == 'cityDept') {
        _cityDeptValues[i] = {'department': null, 'city': null};
      }
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    // Dispose all text controllers
    for (final controller in _textControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _nextQuestion() {
    if (_currentPage < _filteredQuestions.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _showResultsScreen();
    }
  }

  void _previousQuestion() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  // Helper method to get original index from filtered index
  int _getOriginalIndex(int filteredIndex) {
    final filteredQuestion = _filteredQuestions[filteredIndex];
    return widget.questions.indexWhere((q) => q.id == filteredQuestion.id);
  }

  void _showResultsScreen() {
    // Now we can directly pass the questions with their answers!
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ResultsScreen(
          questions: widget.questions,
        ),
      ),
    );
  }

  bool _isCurrentQuestionValid() {
    final question = _filteredQuestions[_currentPage];

    switch (question.inputType) {
      case 'text':
        return (question.answer ?? '').trim().isNotEmpty;
      case 'dropdown':
      case 'yesOrNo':
        return question.answer != null && question.answer!.isNotEmpty;
      case 'boolean':
        return true; // Boolean always has a value
      case 'cityDept':
        final originalIndex = _getOriginalIndex(_currentPage);
        final cityDept = _cityDeptValues[originalIndex];
        return cityDept?['department'] != null && cityDept?['city'] != null;
      default:
        return true;
    }
  }

  Widget _buildQuestionContent(Question question) {
    return Container(
      margin: EdgeInsets.all(16),
      color: Colors.grey[50],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildQuestionHeader(question),
            const SizedBox(height: 24),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      question.question,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 12),
                    if (question.helpText.isNotEmpty && question.helpText != '—')
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.blue[100]!),
                        ),
                        child: Text(
                          question.helpText,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.blue[800],
                            height: 1.4,
                          ),
                        ),
                      ),
                    const SizedBox(height: 32),
                    _buildInputField(question),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionHeader(Question question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: (_currentPage + 1) / _filteredQuestions.length,
          backgroundColor: Colors.grey[200],
          valueColor: AlwaysStoppedAnimation<Color>(
            Theme.of(context).primaryColor,
          ),
          minHeight: 6,
          borderRadius: BorderRadius.circular(3),
        ),
      ],
    );
  }

  Widget _buildInputField(Question question) {
    final inputDecoration = InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[400]!),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[400]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2),
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    );

    final originalIndex = _getOriginalIndex(_currentPage);

    switch (question.inputType) {
      case 'text':
        return TextField(
          controller: _textControllers[originalIndex],
          decoration: inputDecoration.copyWith(
            hintText: 'Escribe tu respuesta aquí...',
            labelText: 'Respuesta',
          ),
          maxLines: 3,
          minLines: 1,
          // The listener in initState handles updating the answer
        );

      case 'dropdown':
        return DropdownButtonFormField<String>(
          value: question.answer, // Direct from question!
          decoration: inputDecoration.copyWith(
            labelText: 'Selecciona una opción',
          ),
          items: question.options
              .map((option) => DropdownMenuItem(
            value: option,
            child: Text(option),
          ))
              .toList(),
          onChanged: (value) {
            setState(() {
              question.answer = value; // Direct assignment!
            });
          },
          isExpanded: true,
          borderRadius: BorderRadius.circular(12),
        );

      case 'yesOrNo':
        return Container(
          height: 60,
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      question.answer = 'Sí'; // Direct assignment!
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: question.answer == 'Sí'
                        ? Colors.green
                        : Colors.green[50],
                    foregroundColor: question.answer == 'Sí'
                        ? Colors.white
                        : Colors.green[800],
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: Colors.green[300]!),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Sí'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      question.answer = 'No'; // Direct assignment!
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: question.answer == 'No'
                        ? Colors.red
                        : Colors.red[50],
                    foregroundColor: question.answer == 'No'
                        ? Colors.white
                        : Colors.red[800],
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: Colors.red[300]!),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('No'),
                ),
              ),
            ],
          ),
        );

      case 'boolean':
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Activar/Desactivar',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Switch(
                value: question.answer == 'true', // Convert from string
                onChanged: (value) {
                  setState(() {
                    question.answer = value.toString(); // Direct assignment!
                  });
                },
                activeColor: Theme.of(context).primaryColor,
              ),
            ],
          ),
        );

      case 'cityDept':
        return CityDeptWidget(
          value: _cityDeptValues[originalIndex] ?? {'department': null, 'city': null},
          onChanged: (newValue) {
            setState(() {
              _cityDeptValues[originalIndex] = newValue;
              // Format and store the answer
              question.answer = 'Departamento: ${newValue['department'] ?? 'No seleccionado'}, '
                  'Ciudad: ${newValue['city'] ?? 'No seleccionada'}';
            });
          },
          departmentDecoration: inputDecoration,
          cityDecoration: inputDecoration,
        );

      default:
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.orange[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.orange[300]!),
          ),
          child: const Text('Tipo de entrada no soportado'),
        );
    }
  }

  Widget _buildNavigationButtons() {
    final bool isCurrentQuestionValid = _isCurrentQuestionValid();
    final bool isLastQuestion = _currentPage == _filteredQuestions.length - 1;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey[300]!),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            if (_currentPage > 0)
              Expanded(
                child: OutlinedButton(
                  onPressed: _previousQuestion,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Atrás'),
                ),
              ),
            if (_currentPage > 0) const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: isCurrentQuestionValid ? _nextQuestion : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isCurrentQuestionValid
                      ? Theme.of(context).primaryColor
                      : Colors.grey[400],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  isLastQuestion ? 'Finalizar' : 'Continuar',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: _filteredQuestions.length,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemBuilder: (context, index) {
              return _buildQuestionContent(_filteredQuestions[index]);
            },
          ),
        ),
        _buildNavigationButtons(),
      ],
    );
  }
}

class ResultsScreen extends StatelessWidget {
  final List<Question> questions;

  const ResultsScreen({
    Key? key,
    required this.questions,
  }) : super(key: key);

  void _printAllQuestionsAndAnswers() {
    print('=== RESUMEN DE RESPUESTAS DEL FORMULARIO ===');
    for (int i = 0; i < questions.length; i++) {
      final question = questions[i];
      print('Pregunta ${i + 1} (ID: ${question.id}):');
      print('  Pregunta: ${question.question}');
      print('  Respuesta: ${question.answer ?? 'No respondida'}');
      print('  Tipo: ${question.inputType}');
      print('  ---');
    }
    print('=== FIN DEL RESUMEN ===');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultados del Formulario'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Resumen de Respuestas',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  final question = questions[index];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pregunta ${index + 1}:',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            question.question,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.green[50],
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.green[100]!),
                            ),
                            child: Text(
                              'Respuesta: ${question.answer ?? 'No respondida'}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),

            // New Continue Button
            ElevatedButton(
              onPressed: _printAllQuestionsAndAnswers,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                'Continuar',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Back Button
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Volver al Inicio'),
            ),
          ],
        ),
      ),
    );
  }
}