import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/validation.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_event.dart';
import '../blocs/auth/auth_state.dart';

class CreateUserScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is UserCreated) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('User created successfully!')),
            );
            Navigator.pop(context);
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
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      child: TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          errorMaxLines: 3,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0.dp),
                            borderSide: BorderSide(
                              color: const Color(0xFF303133).withOpacity(0.13),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0.dp),
                            borderSide: BorderSide(
                              color: const Color(0xFF303133).withOpacity(0.13),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0.dp),
                            borderSide: BorderSide(
                              color: const Color(0xFF303133).withOpacity(0.13),
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
                         validator: (value) =>
                            Validation.validateEmail(value ?? ''), // Validad
                      ),
                    ),
                    SizedBox(height: 26.dp),
                    Container(
                      child: TextFormField(
                        obscureText: true,
                        controller: _passwordController,
                        decoration: InputDecoration(
                          errorMaxLines: 3,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0.dp),
                            borderSide: BorderSide(
                              color: const Color(0xFF303133).withOpacity(0.13),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0.dp),
                            borderSide: BorderSide(
                              color: const Color(0xFF303133).withOpacity(0.13),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0.dp),
                            borderSide: BorderSide(
                              color: const Color(0xFF303133).withOpacity(0.13),
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
                          validator: (value) =>
                            Validation.validatePassword(value ?? ''),
                      ),
                    ),
                    SizedBox(height: 50.dp),
                    SizedBox(
                      width: double.infinity,
                      height: 51.dp,
                      child: ElevatedButton(
                        onPressed: () {
                            if (_formKey.currentState!.validate()) {
                            // Si el formulario es válido, crea el usuario
                            BlocProvider.of<AuthBloc>(context).add(
                              CreateUser(
                                email: _emailController.text,
                                password: _passwordController.text,
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.dp),
                            ),
                            backgroundColor: const Color(0xFF00A786)),
                        child: Text(
                          "Registrarte",
                          style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 16.dp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize; // default is 56.0

  CustomAppBar({
    Key? key,
  })  : preferredSize = Size.fromHeight(
            109.dp), // Set here your preferred height for AppBar
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: 700.dp,
        ),
        padding: EdgeInsets.only(top: 48.dp),
        height: 109.dp,
        color: Colors.white,
        child: Container(
          color: Colors.white,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 25.dp),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: SvgPicture.asset(
                  'lib/assets/svg/arrow_back.svg',
                  width: 43.dp,
                  height: 43.dp,
                ),
              ),
              SizedBox(width: 15.dp),
              Image.asset(
                'lib/assets/png/LOGO-01.png',
                width: 200.16.dp,
                height: 60.dp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
