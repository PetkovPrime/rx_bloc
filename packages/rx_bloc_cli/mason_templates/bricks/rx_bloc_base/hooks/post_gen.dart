import 'dart:io';

import 'package:mason/mason.dart';
import 'package:path/path.dart' as path;

void run(HookContext context) async {
  // Add your post-generation code here
  // (Code executed immediately after the generation step)
  final _editAddress = 'edit_address';
  // if (context.vars['ui_toolkit'] as bool) {
  //   final process = context.logger.progress('Generating ui_toolkit...');
  //   context.logger.info(Directory.current.path);
  //   final generator = await MasonGenerator.fromBrick(
  //       //TODO clean the path strategy
  //       Brick.path('../../mason_templates/bricks/ui_toolkit'));
  //
  //   final files = await generator.generate(DirectoryGeneratorTarget(
  //           //TODO update path to pass the code from the root and update the structure in the brick
  //           // Directory(path.join(Directory.current.path, 'lub', ))
  //           // destination),
  //           Directory.current),
  //       vars: <String, dynamic>{'ui_toolkit': true},
  //       fileConflictResolution: FileConflictResolution.overwrite);
  //
  //   await generator.hooks.postGen(
  //       workingDirectory: Directory.current.path,
  //       vars: <String, dynamic>{'ui_toolkit': context.vars['ui_toolkit']});
  //
  //   for (final file in files) {
  //     context.logger.info('Generated ${file.path} :: ${file.status}');
  //   }
  //   process.complete();
  // }


    if (context.vars['edit_address'] as bool) {
      final process = context.logger.progress('Generating edit_address...');
      context.logger.info(Directory.current.path);
      final generator = await MasonGenerator.fromBrick(
        //TODO clean the path strategy
          Brick.path('../../mason_templates/bricks/edit_address'));

      /// Generates the brick content inside the lib folder of the test_app
        final destination = Directory(
          path.join(
            Directory.current.path,
            'lib',
            // (context.vars[_editAddress] as String).snakeCase,
            /// todo check if any subdirectory should be added here
          ),
        );

      final files = await generator.generate(DirectoryGeneratorTarget(
        //TODO update path to pass the code from the root and update the structure in the brick
        // Directory(path.join(Directory.current.path, 'lub', ))
        //   Directory.current
      destination,
      ),
          vars: <String, dynamic>{'edit_address': true},
          fileConflictResolution: FileConflictResolution.overwrite);

      await generator.hooks.postGen(
          workingDirectory: Directory.current.path,
          vars: <String, dynamic>{'edit_address': context.vars['edit_address']});

      for (final file in files) {
        context.logger.info('Generated ${file.path} :: ${file.status}');
      }
      process.complete();
    }



  // if (context.vars[_editAddress] as bool) {
  //   final process = context.logger.progress('Generating $_editAddress...');
  //   context.logger.info(Directory.current.path);
  //
  //   final generator = await MasonGenerator.fromBrick(
  //       //TODO clean the path strategy
  //       Brick.path('../../mason_templates/bricks/$_editAddress'));
  //
  //   final destination = Directory(
  //     path.join(
  //       Directory.current.path,
  //       'lib',
  //       'feature_edit_address',
  //       // (context.vars[_editAddress] as String).snakeCase,
  //       /// todo check if any subdirectory should be added here
  //     ),
  //   );
  //
  //   final files = await generator.generate(
  //       DirectoryGeneratorTarget(destination),
  //       //TODO update path to pass the code from the root and update the structure in the brick
  //       // Directory(path.join(Directory.current.path, 'lub', ))
  //       // Directory.current),
  //       vars: <String, dynamic>{_editAddress: true},
  //       fileConflictResolution: FileConflictResolution.overwrite);
  //
  //   await generator.hooks.postGen(
  //       workingDirectory: Directory.current.path,
  //       vars: <String, dynamic>{_editAddress: context.vars[_editAddress]});
  //
  //   for (final file in files) {
  //     context.logger.info('Generated ${file.path} :: ${file.status}');
  //   }
  //   process.complete();
  // }
}
