import 'package:justdigital_webapp/core/constants/app_constants.dart';

class Question {
  final String id;
  final String question;
  final String inputType;
  final String associatedFields;
  final String condition;
  final String helpText;
  final List<String> options;
  final List<String> validators;
  final String dependsOn;
  final String dependencyValue;
  String? answer;

  Question({
    required this.id,
    required this.question,
    required this.inputType,
    required this.associatedFields,
    required this.condition,
    required this.helpText,
    this.options = const [],
    this.validators = const [],
    this.dependsOn = "",
    this.dependencyValue = "",
    this.answer,
  });


  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'inputType': inputType,
      'associatedFields': associatedFields,
      'condition': condition,
      'helpText': helpText,
      'answer': answer,
    };
  }
}


  List<Question> questionsFreeTutela = [
    Question(
      id: 'q0',
      question: 'Selecciona el departamento y ciudad donde se va a presentar la tutela',
      inputType: 'cityDept',
      associatedFields: 'depto_tutela, ciudad_tutela',
      condition: '',
      helpText: 'En qué juzgado se va a presentar la tutela',
    ),
    Question(
      id: 'q1',
      question: '¿Para quién es la tutela?',
      inputType: 'dropdown',
      associatedFields: 'tutela_para_quien',
      condition: '',
      helpText: 'Quién es el afectado?',
      options: [AppConstants.paraMi, AppConstants.paraOtraPersona]
    ),
    Question(
      id: 'q2',
      question: 'Escribe tu nombre completo, no el del afectado',
      inputType: 'text',
      associatedFields: 'nombre_autor',
      condition: 'tutela_para_quien = "Para un familiar que no puede hacerla por sí mismo"',
      helpText: '¿Cuál es tu nombre?',
      dependsOn: 'q1',
      dependencyValue: AppConstants.paraMi
    ),
    Question(
      id: 'q3',
      question: 'Escribe tu nombre completo',
      inputType: 'text',
      associatedFields: 'nombre_autor',
      condition: 'tutela_para_quien = "Para mí"',
      helpText: '¿Cuál es tu nombre?',
    ),
    Question(
      id: 'q4',
      question: 'Escribe tu número de identificación',
      inputType: 'text',
      associatedFields: 'id_autor',
      condition: '',
      helpText: '',
    ),
    Question(
      id: 'q5',
      question: 'Selecciona el departamento y ciudad de expedición de tu documento de identificación',
      inputType: 'cityDept',
      associatedFields: 'id_autor_depto, id_autor_ciudad',
      condition: '',
      helpText: '',
    ),
    Question(
      id: 'q6',
      question: 'Selecciona el departamento y ciudad donde resides actualmente',
      inputType: 'cityDept',
      associatedFields: 'id_autor_depto_res, id_autor_ciudad_res',
      condition: '',
      helpText: '',
    ),
    Question(
      id: 'q7',
      question: 'Escribe tu edad',
      inputType: 'text',
      associatedFields: 'edad_afectado',
      condition: 'tutela_para_quien = "Para mí"',
      helpText: '',
      dependsOn: 'q1',
        dependencyValue: AppConstants.paraMi
    ),
    Question(
      id: 'q8',
      question: 'Escribe tu teléfono de contacto',
      inputType: 'text',
      associatedFields: 'telefono_autor',
      condition: 'tutela_para_quien = "Para mí"',
      helpText: '',
        dependsOn: 'q1',
        dependencyValue: AppConstants.paraMi
    ),
    Question(
      id: 'q9',
      question: 'Escribe tu correo electrónico',
      inputType: 'text',
      associatedFields: 'correo_autor',
      condition: 'tutela_para_quien = "Para mí"',
      helpText: '',
        dependsOn: 'q1',
        dependencyValue: AppConstants.paraMi
    ),
    Question(
      id: 'q10',
      question: '¿Cuál es el nombre del afectado?',
      inputType: 'text',
      associatedFields: 'nombre_afectado',
      condition: '',
      helpText: '',
        dependsOn: 'q1',
        dependencyValue: AppConstants.paraOtraPersona
    ),
    Question(
      id: 'q11',
      question: '¿Número de identificación del afectado?',
      inputType: 'text',
      associatedFields: 'id_afectado',
      condition: 'tutela_para_quien = "Para un familiar que no puede hacerla por sí mismo"',
      helpText: '',
        dependsOn: 'q1',
        dependencyValue: AppConstants.paraOtraPersona
    ),
    Question(
      id: 'q12',
      question: '¿Cuál es la edad del afectado?',
      inputType: 'text',
      associatedFields: 'edad_afectado',
      condition: 'tutela_para_quien = "Para un familiar que no puede hacerla por sí mismo"',
      helpText: '',
        dependsOn: 'q1',
        dependencyValue: AppConstants.paraOtraPersona
    ),
    Question(
      id: 'q13',
      question: 'EPS',
      inputType: 'dropdown',
      associatedFields: 'eps',
      condition: '',
      helpText: '',
      options :  [
        'Sura', 'Nueva EPS', 'EPS Sanitas', 'Salud Total', 'Coosalud',
        'Savia Salud', 'Emssanar', 'Asmet Salud', 'Famisanar', 'Otro'
      ]
    ),
    Question(
      id: 'q14',
      question: '¿Cuál es el régimen de afiliación de la EPS?',
      inputType: 'dropdown',
      associatedFields: 'regimen',
      condition: '',
      helpText: 'El régimen de la EPS',
      options: ['Régimen contributivo', 'Régimen subsidiado']
    ),
    Question(
      id: 'q15',
      question: '¿Tienes un diagnóstico?',
      inputType: 'yesOrNo',
      associatedFields: 'diagnostico',
      condition: '',
      helpText: '',
    ),
    Question(
      id: 'q16',
      question: '¿Qué tratamiento, procedimiento o suministro de medicamento necesita actualmente y que fue ordenado por su médico tratante?',
      inputType: 'text',
      associatedFields: 'servicios_medicos_exigidos',
      condition: '',
      helpText: '',
    ),
    Question(
      id: 'q17',
      question: '¿Pertenece usted a un grupo de especial protección Constitucional?',
      inputType: 'yesOrNo',
      associatedFields: 'grupo_especial_si_no',
      condition: '',
      helpText: '',
    ),
    Question(
      id: 'q18',
      question: '¿Cuál?',
      inputType: 'dropdown',
      associatedFields: 'grupo_especial',
      condition: 'grupo_especial_si_no="Yes"',
      options: ['Adulto mayor', 'Menor de edad', "Persona con discapacidad", "Victima del conflicto",
        "Mujeres embarazadas", "Comunidades étnicas",
        "Personas en situación de desplazamiento forzado o víctimas del conflicto armado"
        , "Cáncer", "VIH", "Enfermedades Huérfanas"],
      helpText: '',
        dependsOn: 'q17',
        dependencyValue: "true"
    ),
    Question(
      id: 'q18', // Note: This ID is duplicated, you might want to change it
      question: '¿Tienes historia clínica?',
      inputType: 'boolean',
      associatedFields: 'tiene_historia_clinica',
      condition: '',
      helpText: '',
    ),
    Question(
      id: 'q19',
      question: '¿Tienes orden médica física o virtual?',
      inputType: 'boolean',
      associatedFields: 'tienes_orden_medica',
      condition: '',
      helpText: '',
    ),
  ];

// Helper function to print all questions
void printQuestions(List<Question> questions) {
  for (var question in questions) {
    print('ID: ${question.id}');
    print('Pregunta: ${question.question}');
    print('Tipo: ${question.inputType}');
    print('Campos: ${question.associatedFields}');
    print('Condición: ${question.condition}');
    print('Ayuda: ${question.helpText}');
    print('---');
  }
}

// Find question by ID
Question? findQuestionById(List<Question> questions, String id) {
  return questions.firstWhere((q) => q.id == id);
}

// Get questions by input type
List<Question> getQuestionsByType(List<Question> questions, String inputType) {
  return questions.where((q) => q.inputType == inputType).toList();
}

// Get questions that depend on a specific condition
List<Question> getQuestionsByCondition(List<Question> questions, String conditionField) {
  return questions.where((q) => q.condition.contains(conditionField)).toList();
}

// Convert entire list to JSON
List<Map<String, dynamic>> convertToJson(List<Question> questions) {
  return questions.map((q) => q.toJson()).toList();
}

List<Question> questionsTutela = [
  Question(
    id: 'q0',
    question: 'Selecciona el departamento y ciudad donde se va a presentar la tutela',
    inputType: 'cityDept',
    associatedFields: 'depto_tutela, ciudad_tutela',
    condition: '',
    helpText: 'En qué juzgado se va a presentar la tutela',
  ),
  Question(
      id: 'q1',
      question: '¿Para quién es la tutela?',
      inputType: 'dropdown',
      associatedFields: 'tutela_para_quien',
      condition: '',
      helpText: 'Quién es el afectado?',
      options: [AppConstants.paraMi, AppConstants.paraOtraPersona]
  ),
  Question(
      id: 'q2',
      question: 'Escribe tu nombre completo, no el del afectado',
      inputType: 'text',
      associatedFields: 'nombre_autor',
      condition: 'tutela_para_quien = "Para un familiar que no puede hacerla por sí mismo"',
      helpText: '¿Cuál es tu nombre?',
      dependsOn: 'q1',
      dependencyValue: AppConstants.paraMi
  ),
  Question(
    id: 'q3',
    question: 'Escribe tu nombre completo',
    inputType: 'text',
    associatedFields: 'nombre_autor',
    condition: 'tutela_para_quien = "Para mí"',
    helpText: '¿Cuál es tu nombre?',
  ),
  Question(
    id: 'q4',
    question: 'Escribe tu número de identificación',
    inputType: 'text',
    associatedFields: 'id_autor',
    condition: '',
    helpText: '',
  ),
  Question(
    id: 'q5',
    question: 'Selecciona el departamento y ciudad de expedición de tu documento de identificación',
    inputType: 'cityDept',
    associatedFields: 'id_autor_depto, id_autor_ciudad',
    condition: '',
    helpText: '',
  ),
  Question(
    id: 'q6',
    question: 'Selecciona el departamento y ciudad donde resides actualmente',
    inputType: 'cityDept',
    associatedFields: 'id_autor_depto_res, id_autor_ciudad_res',
    condition: '',
    helpText: '',
  ),
  Question(
      id: 'q7',
      question: 'Escribe tu edad',
      inputType: 'text',
      associatedFields: 'edad_afectado',
      condition: 'tutela_para_quien = "Para mí"',
      helpText: '',
      dependsOn: 'q1',
      dependencyValue: AppConstants.paraMi
  ),
  Question(
      id: 'q8',
      question: 'Escribe tu teléfono de contacto',
      inputType: 'text',
      associatedFields: 'telefono_autor',
      condition: 'tutela_para_quien = "Para mí"',
      helpText: '',
      dependsOn: 'q1',
      dependencyValue: AppConstants.paraMi
  ),
  Question(
      id: 'q9',
      question: 'Escribe tu correo electrónico',
      inputType: 'text',
      associatedFields: 'correo_autor',
      condition: 'tutela_para_quien = "Para mí"',
      helpText: '',
      dependsOn: 'q1',
      dependencyValue: AppConstants.paraMi
  ),
  Question(
      id: 'q10',
      question: '¿Cuál es el nombre del afectado?',
      inputType: 'text',
      associatedFields: 'nombre_afectado',
      condition: '',
      helpText: '',
      dependsOn: 'q1',
      dependencyValue: AppConstants.paraOtraPersona
  ),
  Question(
      id: 'q11',
      question: '¿Número de identificación del afectado?',
      inputType: 'text',
      associatedFields: 'id_afectado',
      condition: 'tutela_para_quien = "Para un familiar que no puede hacerla por sí mismo"',
      helpText: '',
      dependsOn: 'q1',
      dependencyValue: AppConstants.paraOtraPersona
  ),
  Question(
      id: 'q12',
      question: '¿Cuál es la edad del afectado?',
      inputType: 'text',
      associatedFields: 'edad_afectado',
      condition: 'tutela_para_quien = "Para un familiar que no puede hacerla por sí mismo"',
      helpText: '',
      dependsOn: 'q1',
      dependencyValue: AppConstants.paraOtraPersona
  ),
  Question(
      id: 'q13',
      question: 'EPS',
      inputType: 'dropdown',
      associatedFields: 'eps',
      condition: '',
      helpText: '',
      options :  [
        'Sura', 'Nueva EPS', 'EPS Sanitas', 'Salud Total', 'Coosalud',
        'Savia Salud', 'Emssanar', 'Asmet Salud', 'Famisanar', 'Otro'
      ]
  ),
  Question(
      id: 'q14',
      question: '¿Cuál es el régimen de afiliación de la EPS?',
      inputType: 'dropdown',
      associatedFields: 'regimen',
      condition: '',
      helpText: 'El régimen de la EPS',
      options: ['Régimen contributivo', 'Régimen subsidiado']
  ),
  Question(
    id: 'q15',
    question: '¿Tienes un diagnóstico?',
    inputType: 'yesOrNo',
    associatedFields: 'diagnostico',
    condition: '',
    helpText: '',
  ),
  Question(
    id: 'q16',
    question: '¿Qué tratamiento, procedimiento o suministro de medicamento necesita actualmente y que fue ordenado por su médico tratante?',
    inputType: 'text',
    associatedFields: 'servicios_medicos_exigidos',
    condition: '',
    helpText: '',
  ),
  Question(
    id: 'q17',
    question: '¿Pertenece usted a un grupo de especial protección Constitucional?',
    inputType: 'yesOrNo',
    associatedFields: 'grupo_especial_si_no',
    condition: '',
    helpText: '',
  ),
  Question(
      id: 'q18',
      question: '¿Cuál?',
      inputType: 'dropdown',
      associatedFields: 'grupo_especial',
      condition: 'grupo_especial_si_no="Yes"',
      options: ['Adulto mayor', 'Menor de edad', "Persona con discapacidad", "Victima del conflicto",
        "Mujeres embarazadas", "Comunidades étnicas",
        "Personas en situación de desplazamiento forzado o víctimas del conflicto armado"
        , "Cáncer", "VIH", "Enfermedades Huérfanas"],
      helpText: '',
      dependsOn: 'q17',
      dependencyValue: "true"
  ),
  Question(
    id: 'q18', // Note: This ID is duplicated, you might want to change it
    question: '¿Tienes historia clínica?',
    inputType: 'boolean',
    associatedFields: 'tiene_historia_clinica',
    condition: '',
    helpText: '',
  ),
  Question(
    id: 'q19',
    question: '¿Tienes orden médica física o virtual?',
    inputType: 'boolean',
    associatedFields: 'tienes_orden_medica',
    condition: '',
    helpText: '',
  ),
];