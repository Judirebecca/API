import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'App.dart';
import 'BO/BO.mapper.g.dart';
import 'Services/IAvengerService/AvengerService.dart';
import 'Services/IAvengerService/IAvengerService.dart';
import 'main.reflectable.dart';

void main() {
  // Trigger the method initializeRefleactable
  initializeReflectable();

  // Trigger the method initializeJsonMapper
  initializeJsonMapper();

  // Registering the IAvengerServices using the getit instance to access the objects
  GetIt.instance.registerSingleton<IAvengerService>(AvengerService());

  // Initialize and run the application
  runApp(const App());
}