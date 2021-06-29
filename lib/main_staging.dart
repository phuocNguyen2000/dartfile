import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wcloud/app/app.dart';
import 'package:wcloud/common/bloc/simple_bloc_delegate.dart';
import 'package:wcloud/common/constant/env.dart';

void main() {
  Bloc.observer = SimpleBlocDelegate();
  WidgetsFlutterBinding.ensureInitialized();

  runZonedGuarded(() {
    runApp(App(env: EnvValue.staging));
  }, (error, stackTrace) async {});
}
