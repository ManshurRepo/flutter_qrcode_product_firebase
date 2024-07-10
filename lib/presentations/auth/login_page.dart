import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_scanqr/data/models/request/login_request_model.dart';
import 'package:flutter_scanqr/presentations/auth/bloc/bloc/login_bloc.dart';

import '../../data/datasources/auth_local_datasource.dart';
import '../home/home_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Login Page",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextField(
              autocorrect: false,
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              autocorrect: false,
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                final loginRequest = LoginRequestModel(
                    email: emailController.text,
                    password: passwordController.text);
                context.read<LoginBloc>().add(LoginEvent.login(loginRequest));
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: BlocConsumer<LoginBloc, LoginState>(
                listener: (context, state) {
                  state.maybeWhen(
                    loaded: (state) {
                      AuthLocalDatasource().saveAuthData(state);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                         const SnackBar(
                          content: Text('Login Success!', style: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.bold), ),
                          backgroundColor: Color.fromARGB(255, 19, 255, 27),
                        ),
                      );
                    },
                    error: (message) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Login Error: $message', style: const TextStyle(fontSize: 17,  fontWeight: FontWeight.bold),),
                          backgroundColor: const Color.fromARGB(255, 255, 72, 59),
                        ),
                      );
                    },
                    orElse: () {},
                  );
                },
                builder: (context, state) {
                  if (state == const LoginState.loading()) {
                    return const Center(
                      child: SizedBox(
                        width: 22, // Atur lebar sesuai dengan keinginan Anda
                        height: 22, // Atur tinggi sesuai dengan keinginan Anda
                        child: CircularProgressIndicator(
                          strokeWidth:
                              3, // Atur lebar garis progress sesuai keinginan Anda
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                    );
                  } else {
                    return const Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
