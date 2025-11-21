import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ub_t/core/common/constants/app_constants.dart';
import 'package:ub_t/core/common/validators/input_validators.dart';
import 'package:ub_t/core/common/widgets/loader.dart';
import 'package:ub_t/core/theme/app_pallete.dart';
import 'package:ub_t/core/utils/responsive.dart';
import 'package:ub_t/core/utils/show_snackbar.dart';
import 'package:ub_t/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ub_t/features/auth/presentation/bloc/auth_event.dart';
import 'package:ub_t/features/auth/presentation/bloc/auth_state.dart';
import 'package:ub_t/features/auth/presentation/widgets/auth_field.dart';
import 'package:ub_t/features/auth/presentation/widgets/auth_gradient_button.dart';

import 'package:ub_t/features/courses/presentation/pages/course_selection_page.dart';

class SignUpPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const SignUpPage());

  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _matriculeController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String? _selectedDepartment;
  int? _selectedLevel;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _matriculeController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onSignUp() {
    if (_formKey.currentState!.validate()) {
      if (_selectedDepartment == null) {
        showErrorSnackBar(context, 'Please select a department');
        return;
      }
      if (_selectedLevel == null) {
        showErrorSnackBar(context, 'Please select a level');
        return;
      }
      if (_passwordController.text != _confirmPasswordController.text) {
        showErrorSnackBar(context, 'Passwords do not match');
        return;
      }

      context.read<AuthBloc>().add(
        AuthSignUp(
          matriculeNumber: _matriculeController.text.trim(),
          password: _passwordController.text,
          department: _selectedDepartment!,
          level: _selectedLevel!,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            showErrorSnackBar(context, state.message);
          } else if (state is AuthSuccess) {
            Navigator.of(context).pushReplacement(CourseSelectionPage.route());
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Loader();
          }

          return SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: Responsive.padding(context),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: Responsive.isDesktop(context)
                        ? 500
                        : double.infinity,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Icon(
                          Icons.school,
                          size: Responsive.fontSize(context, 80),
                          color: AppPallete.primarySkyBlue,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Create Account',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Sign up to get started',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 32),
                        AuthField(
                          hintText: 'Matricule Number (e.g., CT23A254)',
                          controller: _matriculeController,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.characters,
                          validator: InputValidators.validateMatriculeNumber,
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          value: _selectedDepartment,
                          decoration: const InputDecoration(
                            hintText: 'Select Department',
                          ),
                          items: AppConstants.departments
                              .map(
                                (dept) => DropdownMenuItem(
                                  value: dept,
                                  child: Text(
                                    dept,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedDepartment = value;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Please select a department';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<int>(
                          value: _selectedLevel,
                          decoration: const InputDecoration(
                            hintText: 'Select Level',
                          ),
                          items: AppConstants.availableLevels
                              .map(
                                (level) => DropdownMenuItem(
                                  value: level,
                                  child: Text('Level $level'),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedLevel = value;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Please select a level';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        AuthField(
                          hintText: 'Password',
                          controller: _passwordController,
                          isObscureText: _obscurePassword,
                          validator: InputValidators.validatePassword,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        AuthField(
                          hintText: 'Confirm Password',
                          controller: _confirmPasswordController,
                          isObscureText: _obscureConfirmPassword,
                          validator: InputValidators.validatePassword,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureConfirmPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureConfirmPassword =
                                    !_obscureConfirmPassword;
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 24),
                        AuthGradientButton(
                          buttonText: 'Sign Up',
                          onPressed: _onSignUp,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account? ',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                'Sign In',
                                style: TextStyle(
                                  color: AppPallete.primarySkyBlue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
