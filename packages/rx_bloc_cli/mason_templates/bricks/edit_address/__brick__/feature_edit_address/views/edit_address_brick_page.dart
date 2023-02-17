import 'package:flutter/material.dart';

import '../../app_extensions.dart';

///TODO add license
class EditAddressBrickPage extends StatelessWidget implements AutoRouteWrapper {
  const EditAddressBrickPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) => this;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: _buildAppBar(context),
        body: const Center(
          child: Text('Edit Address Page'),
        ),
      );

  AppBar _buildAppBar(BuildContext context) => AppBar(
        leading: IconButton(
          onPressed: () => context.router.pop(),
          icon: const Icon(Icons.arrow_back),
        ),
      );
}
