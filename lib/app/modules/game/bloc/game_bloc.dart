import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'game_events.dart';
part 'game_states.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  // Usecase Here!

  GameBloc() : super(GameInitial());

  Stream<GameState> mapEventToState(GameEvent event) async* {
    switch (event.runtimeType) {
      case TestEvent:
        yield GameLoaded();
        break;
      default:
        yield GameInitial();
        break;
    }
  }
}
