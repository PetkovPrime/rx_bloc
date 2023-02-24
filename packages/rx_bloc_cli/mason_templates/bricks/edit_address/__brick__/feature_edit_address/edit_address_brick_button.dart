import 'package:flutter/material.dart';

import '../app_extensions.dart';

///TODO add license
class EditAddressBrickButton extends StatelessWidget {
  const EditAddressBrickButton({super.key});

  @override
  Widget build(BuildContext context) => IconButton(
      onPressed: () => context.router.push(const EditAddressBrickRoute()),
      icon: const Icon(Icons.house),
      color: context.designSystem.colors.activeButtonTextColor);
}
