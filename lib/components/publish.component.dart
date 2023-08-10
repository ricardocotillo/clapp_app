import 'package:clapp/providers/publish.provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';

class PublishComponent extends StatelessWidget {
  const PublishComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final PublishProvider publishProvider =
        Provider.of<PublishProvider>(context);
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: publishProvider.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: publishProvider.bodyController,
                  validator: publishProvider.bodyValidator,
                  onFieldSubmitted: (_) =>
                      FocusManager.instance.primaryFocus?.unfocus(),
                  decoration: const InputDecoration(
                    label: Text('Qué estás pensando?'),
                  ),
                  maxLength: 300,
                ),
                if (publishProvider.file != null) const SizedBox(height: 5.0),
                if (publishProvider.file != null)
                  AspectRatio(
                    aspectRatio: 1 / 1,
                    child: Image.file(
                      publishProvider.file!,
                      fit: BoxFit.cover,
                    ),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: publishProvider.addImage,
                          icon: const Icon(LineAwesomeIcons.image),
                        ),
                        const SizedBox(width: 4.0),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(LineAwesomeIcons.map_marker),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () async {
                        FocusManager.instance.primaryFocus?.unfocus();
                        final p = await publishProvider.publish();
                        if (context.mounted) {
                          context.pop(p);
                        }
                      },
                      child: const Text('Publicar'),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
