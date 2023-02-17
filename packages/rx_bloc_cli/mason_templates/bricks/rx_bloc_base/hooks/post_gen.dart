import 'dart:io';

import 'package:mason/mason.dart';

void run(HookContext context) async {
  if (context.vars['ui_toolkit'] as bool) {
    final process = context.logger.progress('Generating ui_toolkit...');
    context.logger.info(Directory.current.path);
    final generator = await MasonGenerator.fromBrick(
        //TODO clean the path strategy
        Brick.path('../../mason_templates/bricks/ui_toolkit'));

    final files = await generator.generate(DirectoryGeneratorTarget(
            //TODO update path to pass the code from the root and update the structure in the brick
            // Directory(path.join(Directory.current.path, 'lub', ))
            Directory.current),
        vars: <String, dynamic>{'ui_toolkit': true},
        fileConflictResolution: FileConflictResolution.overwrite);

    await generator.hooks.postGen(
        workingDirectory: Directory.current.path,
        vars: <String, dynamic>{'ui_toolkit': context.vars['ui_toolkit']});

    for (final file in files) {
      context.logger.info('Generated ${file.path} :: ${file.status}');
    }
    process.complete();
  }
}
