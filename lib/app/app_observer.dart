import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker/talker.dart';

class MyBLoCObserver extends BlocObserver {
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    GetIt.instance<Talker>().error(
      'BLoc error: ${bloc.runtimeType}',
      error,
      stackTrace,
    );
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    GetIt.instance<Talker>().info(
      '${bloc.runtimeType}: Current state is ${change.currentState.runtimeType}, Next is ${change.nextState.runtimeType}',
    );
    super.onChange(bloc, change);
  }
}
