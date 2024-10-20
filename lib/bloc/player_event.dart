import 'package:equatable/equatable.dart';

abstract class PlayerEvents extends Equatable {
  const PlayerEvents();

  @override
  List<Object?> get props => [];
}

class PlayEvent extends PlayerEvents {
  const PlayEvent({required this.selectedIndex});
  final int selectedIndex;

  int get getSelectedIndex => selectedIndex;

  @override
  List<Object> get props => [
        selectedIndex,
      ];
}

class IcyDataReceivedEvent extends PlayerEvents {
  const IcyDataReceivedEvent({this.icyData});

  final String? icyData;

  @override
  List<Object?> get props => [icyData];
}

class LostConnectionEvent extends PlayerEvents {
  const LostConnectionEvent();

  @override
  List<Object> get props => [];
}
