import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker/talker.dart';

class AppObserver extends BlocObserver {
  final talker = GetIt.I<Talker>();

  @override
  void onCreate(BlocBase bloc) {
    talker.info('Bloc $bloc created!');
    super.onCreate(bloc);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    talker.info('BLoc $bloc, event: $event');
    super.onEvent(bloc, event);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    talker.info(
      '${bloc.runtimeType}: Current state is ${change.currentState}, next is ${change.nextState}}',
    );
    super.onChange(bloc, change);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    talker.error(
      'BLoc error in state: ${bloc.state.toString()}',
      error,
      stackTrace,
    );
    super.onError(bloc, error, stackTrace);
  }
}
