import 'dart:io';
import 'package:mason/mason.dart';

void run(HookContext context) async {
 _removeFiles(context, '.gitkeep');
 _AddPackages(context, 'flutter_bloc');
}

Future<void> _removeFiles(HookContext context, String name) async {
  final message = context.logger.progress('removing $name files');
  final dir = Directory('.');
  await dir.list(recursive: true).where((element) =>
      element.toString().contains(name)).listen((element) {
    element.delete()
  }, onDone: () => removingFilesDone('$name files removed'));
  progress.complete();
}

Future<void> _AddPackages(HookContext context, String name) async {
  final progress = context.logger.progress('Installing packages');
  await Process.run('flutter', ['pub', 'add', name]);
  await Process.run('flutter', ['pub', 'get']);

  progress.complete();
}