import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ub_t/core/common/validators/input_validators.dart';
import 'package:ub_t/core/common/widgets/loader.dart';
import 'package:ub_t/core/theme/app_pallete.dart';
import 'package:ub_t/core/utils/responsive.dart';
import 'package:ub_t/core/utils/show_snackbar.dart';
import 'package:ub_t/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ub_t/features/auth/presentation/bloc/auth_event.dart';
import 'package:ub_t/features/auth/presentation/bloc/auth_state.dart';
import 'package:ub_t/features/auth/presentation/pages/signup_page.dart';
import 'package:ub_t/features/auth/presentation/widgets/auth_field.dart';
import 'package:ub_t/features/auth/presentation/widgets/auth_gradient_button.dart';

class LoginPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const LoginPage());
  
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _matriculeController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _matriculeController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLogin() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
            AuthLogin(
              matriculeNumber: _matriculeController.text.trim(),
              password: _passwordController.text,
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
            Navigator.of(context).pushReplacementNamed('/home');
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
                    maxWidth: Responsive.isDesktop(context) ? 500 : double.infinity,
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
                          'Welcome Back',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Sign in to continue',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 48),
                        AuthField(
                          hintText: 'Matricule Number',
                          controller: _matriculeController,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.characters,
                          validator: InputValidators.validateMatriculeNumber,
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
                        const SizedBox(height: 24),
                        AuthGradientButton(
                          buttonText: 'Sign In',
                          onPressed: _onLogin,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account? ",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(SignUpPage.route());
                              },
                              child: const Text(
                                'Sign Up',
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
