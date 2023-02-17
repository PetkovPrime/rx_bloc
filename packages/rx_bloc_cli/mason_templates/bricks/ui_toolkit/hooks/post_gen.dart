import 'dart:io';

import 'package:mason/mason.dart';

void run(HookContext context) async {
  final progress = context.logger.progress('Installing packages...');

  await Process.run('flutter', ['pub', 'add', 'shimmer']);
  await Process.run('flutter', ['pub', 'add', 'theme_tailor_annotation']);
  await Process.run('flutter', ['pub', 'add', 'theme_tailor']);
  await Process.run('flutter', ['pub', 'get']);

  progress.complete();
}
