import 'package:flutter/material.dart';

class CustomLoginField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isPassword;
  final String? Function(String?)? validator;
  final bool
      showError; // Tambahkan parameter untuk menentukan apakah kesalahan harus ditampilkan

  const CustomLoginField({
    super.key,
    required this.controller,
    required this.labelText,
    this.isPassword = false,
    this.validator,
    this.showError = false, // Default tidak menampilkan error
  });

  @override
  State<CustomLoginField> createState() => _CustomLoginFieldState();
}

class _CustomLoginFieldState extends State<CustomLoginField> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    String? errorText;
    if (widget.showError) {
      errorText = widget.validator?.call(widget.controller.text);
    }

    return TextField(
      controller: widget.controller,
      obscureText: widget.isPassword ? _isObscured : false,
      decoration: InputDecoration(
        labelText: widget.labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: errorText != null ? Colors.red : Colors.grey,
          ),
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
        errorText: errorText, // Menampilkan pesan kesalahan
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _isObscured ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _isObscured = !_isObscured;
                  });
                },
              )
            : null,
      ),
    );
  }
}

class CustomFormField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isPassword;
  final String? Function(String?)? validator;

  const CustomFormField({
    super.key,
    required this.controller,
    required this.labelText,
    this.isPassword = false,
    this.validator,
  });

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  bool _isObscured = true;
  String? _errorText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.isPassword ? _isObscured : false,
      decoration: InputDecoration(
        labelText: widget.labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
        errorText: _errorText,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _isObscured ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _isObscured = !_isObscured;
                  });
                },
              )
            : null,
      ),
      onChanged: (value) {
        setState(() {
          _errorText = widget.validator?.call(value);
        });
      },
    );
  }
}

String? emailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email cannot be empty';
  }
  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
  if (!emailRegex.hasMatch(value)) {
    return 'Enter a valid email';
  }
  return null;
}

String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password cannot be empty';
  }
  if (value.length < 8) {
    return 'Password must be at least 8 characters';
  }
  return null;
}

String? confirmPasswordValidator(String? value, String password) {
  if (value == null || value.isEmpty) {
    return 'Confirm Password cannot be empty';
  }
  if (value != password) {
    return 'Passwords do not match';
  }
  return null;
}
