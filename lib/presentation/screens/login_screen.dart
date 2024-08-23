import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import '../../utils/validation.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_event.dart';
import '../blocs/auth/auth_state.dart';
import 'create_user_screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => HomeScreen(token: state.token)),
            );
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0.dp),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Image.asset(
                        "lib/assets/png/LOGO-01.png",
                        width: 300.dp,
                        height: 100.9.dp,
                      ),
                      SizedBox(height: 50.dp),
                      Container(
                        constraints: BoxConstraints(maxWidth: 700.dp),
                        child: TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0.dp),
                              borderSide: BorderSide(
                                color:
                                    const Color(0xFF303133).withOpacity(0.13),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0.dp),
                              borderSide: BorderSide(
                                color:
                                    const Color(0xFF303133).withOpacity(0.13),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0.dp),
                              borderSide: BorderSide(
                                color:
                                    const Color(0xFF303133).withOpacity(0.13),
                              ),
                            ),
                            filled: true,
                            fillColor: const Color(0xFFF8F8F8),
                            labelText: "Email",
                            hintStyle: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 18.dp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF303133).withOpacity(0.6),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 19.dp, vertical: 15.dp),
                          ),
                          validator: (value) => Validation.validateEmail(
                              value ?? ''), // Validador de email
                        ),
                      ),
                      SizedBox(height: 20.dp),
                      Container(
                        constraints: BoxConstraints(maxWidth: 700.dp),
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0.dp),
                              borderSide: BorderSide(
                                color:
                                    const Color(0xFF303133).withOpacity(0.13),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0.dp),
                              borderSide: BorderSide(
                                color:
                                    const Color(0xFF303133).withOpacity(0.13),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0.dp),
                              borderSide: BorderSide(
                                color:
                                    const Color(0xFF303133).withOpacity(0.13),
                              ),
                            ),
                            filled: true,
                            fillColor: const Color(0xFFF8F8F8),
                            labelText: "Contraseña",
                            hintStyle: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 18.dp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF303133).withOpacity(0.6),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 19.dp, vertical: 15.dp),
                          ),
                          validator: (value) => Validation.validatePassword(
                              value ?? ''), // Validador de contraseña
                        ),
                      ),
                      SizedBox(height: 60.dp),
                      SizedBox(
                        width: double.infinity,
                        height: 51.dp,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // Verifica si el formulario es válido
                              BlocProvider.of<AuthBloc>(context).add(SignIn(
                                email: _emailController.text,
                                password: _passwordController.text,
                              ));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.dp),
                              ),
                              backgroundColor: const Color(0xFF00A786)),
                          child: Text(
                            "Entrar",
                            style: TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 16.dp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 30.dp),
                      Column(
                        children: [
                          Text(
                            "Aun no tienes Cuenta",
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 13.dp,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).colorScheme.onBackground,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          SizedBox(height: 50.dp),
                          Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .shadow
                                      .withOpacity(0.15),
                                  offset: Offset(0.dp, 3.dp),
                                  blurRadius: 6.dp,
                                  spreadRadius: 0.dp,
                                ),
                              ],
                            ),
                            width: MediaQuery.of(context).size.width - 60.0.dp,
                            height: 51.dp,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => CreateUserScreen()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.dp),
                                ),
                                surfaceTintColor: Colors.white,
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.white,
                                elevation: 0,
                              ),
                              child: Text(
                                "Registrarte",
                                style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontSize: 16.dp,
                                    color: Color(0xFF00A786),
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
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
