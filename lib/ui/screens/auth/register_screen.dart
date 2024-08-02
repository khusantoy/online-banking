import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_banking/logic/blocs/auth/auth_bloc.dart';
import 'package:online_banking/ui/widgets/textformfield_item.dart';
import 'package:online_banking/utils/loading_dialog.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _validateAndSubmit() async {
    if (_formKey.currentState!.validate()) {
      LoadingDialog.showLoadingDialog(context);
      context.read<AuthBloc>().add(RegisterAuthEvent(usernameController.text,
          emailController.text, passwordController.text));

      Navigator.pop(context);
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextformfieldItem(
                  labelText: "Ismingiz",
                  textEditingController: usernameController,
                  textInputType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Ismingizni kiriting";
                    }

                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextformfieldItem(
                  labelText: "Email",
                  textEditingController: emailController,
                  textInputType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Email manzilingizni kiriting";
                    } else {
                      final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                      if (!emailRegex.hasMatch(value)) {
                        return "Email xato";
                      }
                    }

                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextformfieldItem(
                  labelText: "Parol",
                  textEditingController: passwordController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Parol kiriting";
                    }
                    return null;
                  },
                  textInputType: TextInputType.name,
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextformfieldItem(
                  labelText: "Parolni tasdiqlang",
                  textEditingController: confirmPasswordController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Parolni kiriting";
                    } else if (passwordController.text !=
                        confirmPasswordController.text) {
                      return "Parol mos emas";
                    }
                    return null;
                  },
                  textInputType: TextInputType.name,
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: _validateAndSubmit,
                    child: const Text("Register"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
