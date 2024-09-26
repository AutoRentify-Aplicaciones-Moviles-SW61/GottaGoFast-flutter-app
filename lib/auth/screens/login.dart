import 'package:flutter/material.dart';
import 'package:lead_your_way/auth/screens/signup.dart';
import 'package:lead_your_way/renting/screens/home_page.dart';
import 'package:lead_your_way/shared/services/Smooth_Navigation.dart';
import 'package:lead_your_way/shared/services/notifier.dart';
import 'package:lead_your_way/shared/widgets/gottagofast_navigator.dart';
import 'package:lead_your_way/shared/widgets/gottagofast.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logoCar.png',
              width: 125,
              height: 125,
            ),
            const SizedBox(height: 32),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                );
              },
              child: const Text(
                "Welcome Back!",
                style: TextStyle(fontSize: 30, color: Color(0xff000000)),
              ),
            ),
            const SizedBox(height: 32),
            RoundedInputField(
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              hintText: "Your email",
              icon: const Icon(Icons.person),
              controller: emailController,
            ),
            RoundedInputFieldObscure(
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              hintText: "Your password",
              icon: const Icon(Icons.lock),
              controller: passwordController,
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () {
                final email = emailController.text;
                final password = passwordController.text;
                final bool emailValid = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(email);

                if (email.isEmpty || password.isEmpty) {
                  sendAlertMessage("Please fill all the fields");
                  return;
                }

                if (!emailValid) {
                  sendAlertMessage("Please enter a valid email address");
                  return;
                }

                smoothNavigation(
                  context,
                  const Login(),
                  const LywNavigator(),
                  0.0,
                  -1.0,
                  0.0,
                  1.0,
                );
              },
              style: FilledButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 74, 135, 250),
                foregroundColor: Colors.white,
                fixedSize: const Size(200, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
              child: const Text("Login"),
            ),
            const SizedBox(height: 96),
            SignUpLink(),
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Row SignUpLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account?"),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () {
            smoothNavigation(
              context,
              const Login(),
              const SignUp(),
              -1.0,
              0.0,
              1.0,
              0.0,
            );
          },
          child: const Text(
            "Sign up",
            style: TextStyle(
              color: Color.fromARGB(255, 113, 167, 238),
              backgroundColor: Color.fromARGB(0, 138, 132, 132),
            ),
          ),
        ),
      ],
    );
  }
}
