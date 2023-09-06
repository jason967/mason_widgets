import 'dart:io';
import 'package:mason/mason.dart';

void run(HookContext context) async {
  _removeFiles(context, '.gitkeep');
  _AddPackages(context, 'flutter_bloc');
}

Future<void> _removeFiles(HookContext context, String name) async {
  final removingFilesDone = context.logger.progress('removing $name files ...');
  var dir = Directory('.');
  await dir.list().where((element) => element.toString().contains(name)).listen(
    (element) {
      element.delete();
    },
    onDone: () => removingFilesDone('$name files removed'),
  );
  removingFilesDone.complete();
}

Future<void> _AddPackages(HookContext context, String name) async {
  final progress = context.logger.progress('Installing packages');
  await Process.run('flutter', ['pub', 'add', name]);
  await Process.run('flutter', ['pub', 'get']);

  progress.complete();
}
