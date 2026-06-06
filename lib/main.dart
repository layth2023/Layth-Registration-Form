import 'package:auth_project/OutputScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class AppColors {
  static const primary = Color(0xFF6C63FF);
  static const secondary = Color(0xFF8B85FF);
  static const background = Color(0xFFF5F3FF);
  static const card = Colors.white;
  static const textDark = Color(0xFF2D1B69);
  static const textLight = Color(0xFF7A73A8);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Layth Flutter Form',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          secondary: AppColors.secondary,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(
              color: Color(0xFFD6E4F0),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(
              color: AppColors.primary,
              width: 2,
            ),
          ),
        ),
      ),
      home: const MyFormScreen(),
    );
  }
}

class MyFormScreen extends StatefulWidget {
  const MyFormScreen({super.key});

  @override
  State<MyFormScreen> createState() => _MyFormScreenState();
}

class _MyFormScreenState extends State<MyFormScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _username;
  String? _password;
  String? _email;
  bool _rememberMe = false;
  String? _gender;
  String? _country;
  double _age = 18;
  DateTime? _selectedDate;

  final List<String> _countries = [
    'Palestine',
    'Jordan',
    'Egypt',
    'Syria',
    'Iraq',
  ];

  final List<String> _genders = ['Male', 'Female'];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_gender == null) {
        _showMessage('Please select your gender');
        return;
      }

      if (_selectedDate == null) {
        _showMessage('Please select a date');
        return;
      }

      _formKey.currentState!.save();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OutputScreen(
            username: _username,
            password: _password,
            email: _email,
            rememberMe: _rememberMe,
            gender: _gender,
            country: _country,
            age: _age,
            selectedDate: _selectedDate,
          ),
        ),
      );
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2050),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              onSurface: AppColors.textDark,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const _HeaderSection(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 24,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'User Registration',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Fill in your information below.',
                        style: TextStyle(
                          color: AppColors.textLight,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 22),

                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Username',
                          prefixIcon: Icon(Icons.person_outline),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your username';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _username = value;
                        },
                      ),

                      const SizedBox(height: 16),

                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock_outline),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _password = value;
                        },
                      ),

                      const SizedBox(height: 16),

                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!value.contains('@')) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _email = value;
                        },
                      ),

                      const SizedBox(height: 10),

                      CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Remember me'),
                        value: _rememberMe,
                        activeColor: AppColors.primary,
                        onChanged: (bool? value) {
                          setState(() {
                            _rememberMe = value ?? false;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),

                      const SizedBox(height: 10),

                      const Text(
                        'Gender',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppColors.textDark,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Row(
                        children: _genders.map((gender) {
                          final value = gender.toLowerCase();
                          final isSelected = _gender == value;

                          return Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _gender = value;
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 10),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                  horizontal: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColors.primary.withOpacity(0.10)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: isSelected
                                        ? AppColors.primary
                                        : const Color(0xFFD6E4F0),
                                    width: 1.5,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      isSelected
                                          ? Icons.radio_button_checked
                                          : Icons.radio_button_off,
                                      color: isSelected
                                          ? AppColors.primary
                                          : Colors.grey,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      gender,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: isSelected
                                            ? AppColors.primary
                                            : AppColors.textDark,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),

                      const SizedBox(height: 16),

                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Country',
                          prefixIcon: Icon(Icons.public),
                        ),
                        value: _country,
                        items: _countries.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _country = newValue;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a country';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _country = value;
                        },
                      ),

                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Age',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.10),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '${_age.round()} years',
                              style: const TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      Slider(
                        value: _age,
                        min: 18,
                        max: 99,
                        divisions: 81,
                        activeColor: AppColors.primary,
                        label: _age.round().toString(),
                        onChanged: (double value) {
                          setState(() {
                            _age = value;
                          });
                        },
                      ),

                      const SizedBox(height: 10),

                      InkWell(
                        borderRadius: BorderRadius.circular(18),
                        onTap: () => _selectDate(context),
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            labelText: 'Select Date',
                            prefixIcon: Icon(Icons.calendar_today_outlined),
                          ),
                          child: Text(
                            _selectedDate == null
                                ? 'No date selected'
                                : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),

                      const SizedBox(height: 26),

                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton.icon(
                          onPressed: _submitForm,
                          icon: const Icon(Icons.arrow_forward),
                          label: const Text(
                            'Submit Form',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            elevation: 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  const _HeaderSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 56, 24, 34),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary,
            AppColors.secondary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(34),
          bottomRight: Radius.circular(34),
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.person_add_alt_1_outlined,
            color: Colors.white,
            size: 42,
          ),
          SizedBox(height: 16),
          Text(
            'Layth Registration Form',
            style: TextStyle(
              color: Colors.white,
              fontSize: 29,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Created by: Layth',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}