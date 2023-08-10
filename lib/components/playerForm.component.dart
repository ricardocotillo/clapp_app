import 'package:clapp/components/user.component.dart';
import 'package:clapp/models/user.model.dart';
import 'package:clapp/providers/playerForm.provider.dart';
import 'package:clapp/theme.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';

class PlayerFormComponent extends StatelessWidget {
  const PlayerFormComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final PlayerFormProvider playerFormProvider =
        Provider.of<PlayerFormProvider>(context);
    final typing = playerFormProvider.typing;
    final textController = playerFormProvider.textController;
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Busca un usuario',
            style: AppTheme.headers.headerLg,
          ),
          TextFormField(
            controller: textController,
            decoration: const InputDecoration(
              prefixIcon: Icon(LineAwesomeIcons.search),
              hintText: 'ej: example@example.com',
              helperText: 'Busca por email o nombre',
            ),
            onChanged: playerFormProvider.onChanged,
          ),
          if (textController.text.isNotEmpty)
            PagedListView(
              shrinkWrap: true,
              pagingController: playerFormProvider.pagingController,
              builderDelegate: PagedChildBuilderDelegate<User>(
                itemBuilder: (context, user, i) => UserComponent(user: user),
              ),
            )
        ],
      ),
    );
  }
}
