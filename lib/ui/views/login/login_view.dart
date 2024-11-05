import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login_viewmodel.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginViewModel = Provider.of<LoginViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email')),
            TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true),
            SizedBox(height: 20),
            if (loginViewModel.isLoading) CircularProgressIndicator(),
            if (loginViewModel.errorMessage != null)
              Text(loginViewModel.errorMessage!,
                  style: TextStyle(color: Colors.red)),
            ElevatedButton(
              onPressed: () async {
                _attemptLogin(
                    context, _emailController.text, _passwordController.text);
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }

  void _attemptLogin(
      BuildContext context, String email, String password) async {
    final loginViewModel = Provider.of<LoginViewModel>(context, listen: false);

    final success = await loginViewModel.login(email, password);
    if (success) {
      // Navigate to Home screen on success
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(loginViewModel.errorMessage ?? 'Login failed')),
      );
    }
  }
}
