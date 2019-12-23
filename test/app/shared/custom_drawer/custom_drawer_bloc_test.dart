import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:squadrum/app/shared/custom_drawer/custom_drawer_bloc.dart';
import 'package:squadrum/app/app_module.dart';

void main() {

  initModule(AppModule());
  CustomDrawerBloc bloc;
  
  setUp(() {
      bloc = AppModule.to.bloc<CustomDrawerBloc>();
  });

  group('CustomDrawerBloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<CustomDrawerBloc>());
    });
  });

}
  