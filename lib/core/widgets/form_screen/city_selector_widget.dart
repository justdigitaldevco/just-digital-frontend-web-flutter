
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/colombia_geo.dart';

class CityDeptWidget extends StatefulWidget {
  final Map<String, String?> value;
  final ValueChanged<Map<String, String?>> onChanged;
  final InputDecoration? departmentDecoration;
  final InputDecoration? cityDecoration;
  final String? departmentLabel;
  final String? cityLabel;
  final bool sortDepartmentsAlphabetically;

  const CityDeptWidget({
    Key? key,
    required this.value,
    required this.onChanged,
    this.departmentDecoration,
    this.cityDecoration,
    this.departmentLabel = 'Departamento',
    this.cityLabel = 'Ciudad',
    this.sortDepartmentsAlphabetically = true,
  }) : super(key: key);

  @override
  State<CityDeptWidget> createState() => _CityDeptWidgetState();
}

class _CityDeptWidgetState extends State<CityDeptWidget> {
  late Map<String, String?> _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = Map.from(widget.value);
  }

  @override
  void didUpdateWidget(covariant CityDeptWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _currentValue = Map.from(widget.value);
    }
  }

  void _updateDepartment(String? department) {
    final newValue = {
      'department': department,
      'city': null, // Reset city when department changes
    };
    setState(() {
      _currentValue = newValue;
    });
    widget.onChanged(newValue);
  }

  void _updateCity(String? city) {
    final newValue = {
      'department': _currentValue['department'],
      'city': city,
    };
    setState(() {
      _currentValue = newValue;
    });
    widget.onChanged(newValue);
  }

  List<String> _getDepartmentOptions() {
    final departments = deptCiudadesColombia.keys.toList();
    if (widget.sortDepartmentsAlphabetically) {
      departments.sort();
    }
    return departments;
  }

  List<String> _getCityOptions(String? department) {
    if (department == null || !deptCiudadesColombia.containsKey(department)) {
      return [];
    }

    final cities = deptCiudadesColombia[department]!;
    return List.from(cities)..sort();
  }

  @override
  Widget build(BuildContext context) {
    final defaultInputDecoration = InputDecoration(
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

    return Column(
      children: [
        DropdownButtonFormField<String>(
          value: _currentValue['department'],
          decoration: (widget.departmentDecoration ?? defaultInputDecoration).copyWith(
            labelText: widget.departmentLabel,
          ),
          items: _getDepartmentOptions()
              .map((dept) => DropdownMenuItem(
            value: dept,
            child: Text(dept),
          ))
              .toList(),
          onChanged: _updateDepartment,
          isExpanded: true,
          borderRadius: BorderRadius.circular(12),
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          value: _currentValue['city'],
          decoration: (widget.cityDecoration ?? defaultInputDecoration).copyWith(
            labelText: widget.cityLabel,
          ),
          items: _getCityOptions(_currentValue['department'])
              .map((city) => DropdownMenuItem(
            value: city,
            child: Text(city),
          ))
              .toList(),
          onChanged: _currentValue['department'] != null ? _updateCity : null,
          isExpanded: true,
          borderRadius: BorderRadius.circular(12),
          disabledHint: const Text('Selecciona un departamento primero'),
        ),
      ],
    );
  }
}