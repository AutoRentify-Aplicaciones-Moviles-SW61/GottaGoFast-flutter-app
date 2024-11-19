import 'package:flutter/material.dart';
import 'package:app_tentify_frfr/auth/screens/login.dart';
import 'package:app_tentify_frfr/shared/services/authService.dart';
import 'package:app_tentify_frfr/shared/services/Smooth_Navigation.dart';
import 'package:app_tentify_frfr/shared/services/notifier.dart';
import 'package:app_tentify_frfr/shared/widgets/gottagofast.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController cellphoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController = TextEditingController();
  final AuthService _authService = AuthService();
  bool isLandlord = false;

  @override
  void dispose() {
    nameController.dispose();
    lastNameController.dispose();
    cellphoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmationController.dispose();
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
            const Text(
              "Create Account",
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 32),
            // Campo para el nombre
            RoundedInputField(
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              hintText: "Your Name",
              icon: const Icon(Icons.person),
              controller: nameController,
            ),
            // Campo para el apellido
            RoundedInputField(
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              hintText: "Your Last Name",
              icon: const Icon(Icons.person),
              controller: lastNameController,
            ),
            // Campo para el número de teléfono
            RoundedInputField(
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              hintText: "Your Cellphone",
              icon: const Icon(Icons.phone),
              controller: cellphoneController,
            ),
            // Campo para el correo electrónico
            RoundedInputField(
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              hintText: "Your Email",
              icon: const Icon(Icons.email),
              controller: emailController,
            ),
            // Campo para la contraseña
            RoundedInputFieldObscure(
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.next,
              hintText: "Your Password",
              icon: const Icon(Icons.lock),
              controller: passwordController,
            ),
            // Campo para confirmar la contraseña
            RoundedInputFieldObscure(
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              hintText: "Confirm Password",
              icon: const Icon(Icons.lock),
              controller: passwordConfirmationController,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  value: isLandlord,
                  onChanged: (bool? value) {
                    setState(() {
                      isLandlord = value ?? false;
                    });
                  },
                ),
                const Text("I want to be a landlord"),
              ],
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () async {
                final name = nameController.text;
                final lastName = lastNameController.text;
                final cellphone = cellphoneController.text;
                final email = emailController.text;
                final password = passwordController.text;
                final passwordConfirmation = passwordConfirmationController.text;

                final bool emailValid = RegExp(
                    r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                    .hasMatch(email);

                // Validación de campos
                if (name.isEmpty || lastName.isEmpty || cellphone.isEmpty ||
                    email.isEmpty || password.isEmpty || passwordConfirmation.isEmpty) {
                  sendAlertMessage("Please fill all fields");
                  return;
                }

                if (!emailValid) {
                  sendAlertMessage("Please enter a valid email address");
                  return;
                }

                if (password != passwordConfirmation) {
                  sendAlertMessage("Your password does not match");
                  return;
                }

                // Llamada al servicio de registro
                final String result = await _authService.signup(
                  name,
                  lastName,
                  cellphone,
                  email,
                  password,
                  isLandlord,
                );

                if (result == 'User registered successfully') {
                  smoothNavigation(
                    context,
                    const SignUp(),
                    const Login(),
                    1.0,
                    0.0,
                    -1.0,
                    0.0,
                  );
                } else {
                  sendAlertMessage(result);
                }
              },
              style: FilledButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 82, 141, 252),
                foregroundColor: Colors.white70,
                fixedSize: const Size(200, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
              child: const Text("Sign Up"),
            ),
            const SizedBox(height: 32),
            loginLink(),
          ],
        ),
      ),
    );
  }

  Row loginLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already have an account?"),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () {
            smoothNavigation(
              context,
              const SignUp(),
              const Login(),
              1.0,
              0.0,
              -1.0,
              0.0,
            );
          },
          child: const Text(
            "Login",
            style: TextStyle(
              color: Colors.blueAccent,
            ),
          ),
        ),
      ],
    );
  }
}

