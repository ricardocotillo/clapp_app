import 'package:clapp/providers/login.provider.dart';
import 'package:clapp/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: loginProvider.formKey,
            child: Column(
              children: [
                const FlutterLogo(
                  size: 100.0,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: loginProvider.emailController,
                  decoration: InputDecoration(
                    label: const Text('Email'),
                    errorText: loginProvider.errors.emailErrors,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: loginProvider.emailValidator,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: loginProvider.passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    label: const Text('Password'),
                    errorText: loginProvider.errors.passwordErrors,
                  ),
                  validator: loginProvider.passwordValidator,
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  onPressed: () => loginProvider.onSubmit(context),
                  child: const Text('Ingresar'),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextButton(
                  onPressed: () {},
                  style: const ButtonStyle(
                    visualDensity: VisualDensity.compact,
                  ),
                  child: Text(
                    'Recuperar Contraseña',
                    style: AppTheme.fontSizes.xsStyle,
                  ),
                ),
                TextButton(
                  onPressed: () => loginProvider.redirectToRegister(context),
                  style: const ButtonStyle(
                    visualDensity: VisualDensity.compact,
                  ),
                  child: Text(
                    'Registrarme',
                    style: AppTheme.fontSizes.xsStyle,
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
