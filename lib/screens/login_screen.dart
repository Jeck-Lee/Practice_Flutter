import 'package:flutter/material.dart';
import 'package:practice_flutter/router_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginView();
  }
}

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final router = context.read<RouterProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: () {
                  router.login(token: "abcd");
                },
                child: const Text("Login"),
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: () {
                  router.login(token: "1234");
                },
                child: const Text("Login by Expired token"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
