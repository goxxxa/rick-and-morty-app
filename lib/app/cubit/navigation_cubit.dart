import 'package:flutter_bloc/flutter_bloc.dart';

enum AppTab { characters, favorites }

class NavigationCubit extends Cubit<AppTab> {
  NavigationCubit() : super(AppTab.characters);

  void updateTab(AppTab tab) => emit(tab);
}
