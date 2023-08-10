import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ImageFormFieldComponent extends StatefulWidget {
  const ImageFormFieldComponent({
    super.key,
    this.validator,
    this.controller,
    this.width,
    this.height,
    this.onChanged,
  });

  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  final ImageEditingController? controller;
  final double? width;
  final double? height;

  @override
  State<ImageFormFieldComponent> createState() =>
      _ImageFormFieldComponentState();
}

class _ImageFormFieldComponentState extends State<ImageFormFieldComponent> {
  @override
  Widget build(BuildContext context) {
    final String? url = widget.controller?.path ?? widget.controller?.url;
    return GestureDetector(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          if (url != null)
            CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 50,
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: url,
                  fit: BoxFit.cover,
                  width: 96.0,
                  height: 96.0,
                ),
              ),
            ),
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: const BorderRadius.all(Radius.circular(100))),
            child: const Icon(
              LineAwesomeIcons.edit,
              size: 20.0,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class ImageEditingController {
  String? path;
  String? url;

  String get image => url ?? '';

  ImageEditingController({
    this.path,
    this.url,
  });
}
