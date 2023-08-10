import 'package:clapp/providers/register.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final RegisterProvider registerProvider =
        Provider.of<RegisterProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: registerProvider.formKey,
            child: Column(
              children: [
                const FlutterLogo(
                  size: 100.0,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: registerProvider.emailController,
                  decoration: InputDecoration(
                    label: const Text('Email'),
                    errorText: registerProvider.errors.emailErrors,
                  ),
                  validator: registerProvider.emailValidator,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: registerProvider.firstNameController,
                  decoration: const InputDecoration(
                    label: Text('Nombres'),
                  ),
                  validator: registerProvider.firstNameValidator,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: registerProvider.lastNameController,
                  decoration: const InputDecoration(
                    label: Text('Apellidos'),
                  ),
                  validator: registerProvider.lastNameValidator,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: registerProvider.passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    label: const Text('Contraseña'),
                    errorText: registerProvider.errors.passwordErrors,
                  ),
                  validator: registerProvider.password1Validator,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: registerProvider.password2Controller,
                  obscureText: true,
                  decoration: const InputDecoration(
                    label: Text('Repetir Contraseña'),
                  ),
                  validator: registerProvider.password2Validator,
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  onPressed: () => registerProvider.onSubmit(context),
                  child: const Text('Registrarme'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
