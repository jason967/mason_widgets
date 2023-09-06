import 'dart:io';
import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  await _removeFiles(context, '.gitkeep');
  // await _AddPackages(context, 'flutter_bloc');
}

Future<void> _removeFiles(HookContext context, String name) async {
  final msg = context.logger.progress('removing $name files ...');

  var dir = Directory('.');

  await dir
      .list(recursive: true)
      .where((element) => element.toString().contains(name))
      .listen(
    (element) {
      context.logger.info('${element.path}');
      element.delete();
    },
    onDone: () => msg('$name files removed'),
  );
  msg.complete();
}

Future<void> _AddPackages(HookContext context, String name) async {
  final progress = context.logger.progress('Installing packages');
  await Process.run('flutter', ['pub', 'add', name]);
  await Process.run('flutter', ['pub', 'get']);

  progress.complete();
}
