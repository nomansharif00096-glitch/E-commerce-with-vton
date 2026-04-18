import 'package:flutter/material.dart';
import 'package:frontend_side/core/app/app_view.dart';
import 'package:frontend_side/core/bloc/bloc_observer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_side/core/di/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppView();
  }
}
