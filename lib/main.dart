import 'package:flutter/material.dart';

void main() {
  runApp(EmergencyApp());
}

class EmergencyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Швидка допомога',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EmergencyScreen(),
    );
  }
}

class EmergencyScreen extends StatefulWidget {
  @override
  _EmergencyScreenState createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {
  PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Employee> employees = [];
  List<Patient> patients = [];
  List<Medication> medications = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Швидка допомога'),
      ),
      body: Column(
        children: [
          // Кнопки для перемикання між списками
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  _pageController.animateToPage(0, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
                },
                child: Text('Співробітники'),
                style: ElevatedButton.styleFrom(
                  primary: _currentPage == 0 ? Colors.blue : null,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _pageController.animateToPage(1, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
                },
                child: Text('Пацієнти'),
                style: ElevatedButton.styleFrom(
                  primary: _currentPage == 1 ? Colors.blue : null,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _pageController.animateToPage(2, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
                },
                child: Text('Ліки'),
                style: ElevatedButton.styleFrom(
                  primary: _currentPage == 2 ? Colors.blue : null,
                ),
              ),
            ],
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: [
                // Список співробітників
                EmployeeList(employees: employees),
                // Список пацієнтів
                PatientList(patients: patients),
                // Список ліків
                MedicationList(medications: medications),
              ],
            ),
          ),
          // Додати кнопку для додавання нового об'єкта залежно від вибраної сторінки
          _currentPage == 0
              ? ElevatedButton(
            onPressed: () {
              _showAddEmployeeDialog(context);
            },
            child: Text('Додати співробітника'),
          )
              : _currentPage == 1
              ? ElevatedButton(
            onPressed: () {
              _showAddPatientDialog(context);
            },
            child: Text('Додати пацієнта'),
          )
              : ElevatedButton(
            onPressed: () {
              _showAddMedicationDialog(context);
            },
            child: Text('Додати лік'),
          ),
          // Кнопка "Назад"
          if (_currentPage != 0)
            ElevatedButton(
              onPressed: () {
                _pageController.animateToPage(0, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
              },
              child: Text('Назад'),
            ),
        ],
      ),
    );
  }

  // Функція для відображення діалогу додавання співробітника
  void _showAddEmployeeDialog(BuildContext context) {
    String name = '';
    String brigade = '';
    String shift = '';
    String vehicle = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Додати співробітника'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: 'Ім\'я'),
                  onChanged: (value) {
                    name = value;
                  },
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Бригада'),
                  onChanged: (value) {
                    brigade = value;
                  },
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Зміна'),
                  onChanged: (value) {
                    shift = value;
                  },
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Машина'),
                  onChanged: (value) {
                    vehicle = value;
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Employee employee = Employee(name, brigade, shift, vehicle);
                employees.add(employee);
                setState(() {});
                Navigator.of(context).pop();
              },
              child: Text('Додати'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Скасувати'),
            ),
          ],
        );
      },
    );
  }

  // Функція для відображення діалогу додавання пацієнта
  void _showAddPatientDialog(BuildContext context) {
    String name = '';
    String diagnosis = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Додати пацієнта'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: 'Ім\'я пацієнта'),
                  onChanged: (value) {
                    name = value;
                  },
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Діагноз'),
                  onChanged: (value) {
                    diagnosis = value;
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Patient patient = Patient(name, diagnosis);
                patients.add(patient);
                setState(() {});
                Navigator.of(context).pop();
              },
              child: Text('Додати'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Скасувати'),
            ),
          ],
        );
      },
    );
  }

  // Функція для відображення діалогу додавання ліку
  void _showAddMedicationDialog(BuildContext context) {
    String name = '';
    double dosage = 0;
    String patientName = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Додати лік'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: 'Назва ліку'),
                  onChanged: (value) {
                    name = value;
                  },
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Доза (шт.)'),
                  onChanged: (value) {
                    dosage = double.tryParse(value) ?? 0;
                  },
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Пацієнт'),
                  onChanged: (value) {
                    patientName = value;
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Medication medication = Medication(name, dosage, patientName);
                medications.add(medication);
                setState(() {});
                Navigator.of(context).pop();
              },
              child: Text('Додати'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Скасувати'),
            ),
          ],
        );
      },
    );
  }
}

class Employee {
  String name;
  String brigade;
  String shift;
  String vehicle;

  Employee(this.name, this.brigade, this.shift, this.vehicle);
}

class Patient {
  String name;
  String diagnosis;

  Patient(this.name, this.diagnosis);
}

class Medication {
  String name;
  double dosage;
  String patientName;

  Medication(this.name, this.dosage, this.patientName);
}

class EmployeeList extends StatelessWidget {
  final List<Employee> employees;

  EmployeeList({required this.employees});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: employees.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(employees[index].name),
          subtitle: Text('${employees[index].brigade}, ${employees[index].shift}, ${employees[index].vehicle}'),
        );
      },
    );
  }
}

class PatientList extends StatelessWidget {
  final List<Patient> patients;

  PatientList({required this.patients});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: patients.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(patients[index].name),
          subtitle: Text('Діагноз: ${patients[index].diagnosis}'),
        );
      },
    );
  }
}

class MedicationList extends StatelessWidget {
  final List<Medication> medications;

  MedicationList({required this.medications});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: medications.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(medications[index].name),
          subtitle: Text('Доза: ${medications[index].dosage}, Пацієнт: ${medications[index].patientName}'),
        );
      },
    );
  }
}
