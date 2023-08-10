import 'package:clapp/components/imageFormField.component.dart';
import 'package:clapp/providers/profile.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileProvider profileProvider =
        Provider.of<ProfileProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar'),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 32.0),
              ImageFormFieldComponent(
                controller: profileProvider.imageController,
                onChanged: (s) => profileProvider.onChanged(),
              ),
              TextFormField(
                controller: profileProvider.firstNameController,
                decoration: const InputDecoration(
                  label: Text('Nombres'),
                ),
                onChanged: (s) => profileProvider.onChanged(),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: profileProvider.lastNameController,
                decoration: const InputDecoration(
                  label: Text('Apellidos'),
                ),
                onChanged: (s) => profileProvider.onChanged(),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: profileProvider.emailController,
                decoration: const InputDecoration(
                  label: Text('Email'),
                ),
                onChanged: (s) => profileProvider.onChanged(),
              ),
              const SizedBox(
                height: 16,
              ),
              TextButton(
                onPressed:
                    profileProvider.changed ? profileProvider.save : null,
                child: const Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
