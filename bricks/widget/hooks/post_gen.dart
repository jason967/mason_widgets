import 'dart:io';
import 'package:mason/mason.dart';

void run(HookContext context) async {
  final progress = context.logger.progress('Installing packages');
  await Process.run('flutter', ['pub', 'add', 'flutter_bloc']);
  await Process.run('flutter', ['pub', 'get']);

  final generator = await MasonGenerator.fromBrick(Brick.)
  progress.complete();
}
