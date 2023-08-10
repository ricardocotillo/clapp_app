import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:go_router/go_router.dart';

class CommentFormComponent extends StatelessWidget {
  CommentFormComponent({
    super.key,
    this.title,
    this.onSubmit,
  });

  final Widget? title;
  final void Function(String)? onSubmit;
  final TextEditingController commentController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (title != null) title!,
              TextFormField(
                controller: commentController,
                validator: ValidationBuilder(localeName: 'es')
                    .required()
                    .maxLength(300)
                    .build(),
                maxLength: 300,
                textInputAction: TextInputAction.newline,
                maxLines: null,
              ),
              TextButton(
                onPressed: () {
                  final state = formKey.currentState;
                  if (state != null && state.validate()) {
                    context.pop(commentController.text);
                  }
                },
                child: const Text('Publicar'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
