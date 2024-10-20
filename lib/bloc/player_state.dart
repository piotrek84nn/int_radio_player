import 'package:equatable/equatable.dart';

abstract class PlayerStates extends Equatable {
  const PlayerStates(this.selectedIndex);
  final int selectedIndex;

  @override
  List<Object?> get props => [
        selectedIndex,
      ];
}

class InitialState extends PlayerStates {
  const InitialState(super.selectedIndex) : super();
}

class PlayState extends PlayerStates {
  const PlayState(
    super.selectedIndex, {
    this.songTitle,
  }) : super();

  final String? songTitle;

  @override
  List<Object?> get props => [
        selectedIndex,
        songTitle,
      ];
}

class ReconnectingState extends PlayerStates {
  const ReconnectingState(super.selectedIndex) : super();

  ReconnectingState copyWith({int? selectedIndex}) {
    return ReconnectingState(
      selectedIndex ?? this.selectedIndex,
    );
  }

  @override
  List<Object> get props => [
        selectedIndex,
      ];
}
