import 'package:bloc_pattern/bloc_pattern.dart';

class HomeBloc extends BlocBase {
  HomeBloc() {
    print("Tentando carregar usuário");
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    super.dispose();
  }
}
