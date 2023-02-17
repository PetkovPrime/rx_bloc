{{> licence.dart }}

import 'package:flutter/material.dart';

class UiToolkitPage extends StatelessWidget {
  const UiToolkitPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: const Center(
          child: Text('UI TOOLKIT PAGE'),
        ),
        appBar: AppBar(automaticallyImplyLeading: true),
      );
}
