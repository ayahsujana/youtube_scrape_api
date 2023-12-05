import 'package:skibidiwartube/data/enum/box_types.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  await _setupHive();
}

Future<void> _setupHive() async {
  await Hive.initFlutter();
  final boxDynamic = await Hive.openBox(BoxType.settings.name);
  locator.registerLazySingleton<Box<dynamic>>(() => boxDynamic,
      instanceName: BoxType.settings.name);
}
