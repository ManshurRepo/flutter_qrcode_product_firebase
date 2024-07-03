import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_scanqr/bloc_firebase/auth/auth_bloc.dart';
import 'package:flutter_scanqr/presentations/home/home_page.dart';


class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController emailController =
      TextEditingController(text: "admin@gmail.com");
  final TextEditingController passwordController =
      TextEditingController(text: "tesadmin_123");

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
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                // Dispatch AuthEventLogin with actual text values from controllers
                context.read<AuthBloc>().add(AuthEventLogin(
                      emailController.text,
                      passwordController.text,
                    ));
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
                  if (state is AuthStateError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          state.message,
                          style: const TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.red,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is AuthStateLoading) {
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
                      style: TextStyle(color: Colors.white),
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
