import 'package:animated_music_indicator/animated_music_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:piotrek84nn_int_radio_player/bloc/player_bloc.dart';
import 'package:piotrek84nn_int_radio_player/bloc/player_event.dart';
import 'package:piotrek84nn_int_radio_player/bloc/player_state.dart';
import 'package:piotrek84nn_int_radio_player/presentation/constants/colors.dart';
import 'package:piotrek84nn_int_radio_player/presentation/constants/constant.dart';
import 'package:piotrek84nn_int_radio_player/presentation/widgets/station_item.dart';

class PlayerPage extends StatefulWidget {
  const PlayerPage({super.key});

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  @override
  void initState() {
    super.initState();
    context.read<PlayerBloc>().onInitState();
  }

  @override
  void dispose() {
    super.dispose();
    context.read<PlayerBloc>().onDispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<PlayerBloc>().state;
    return Scaffold(
      appBar: const _AppBar(),
      body: Builder(
        builder: (context) {
          switch (state) {
            case InitialState _:
            case ReconnectingState _:
              return const _LoadingWidget(
                isLoading: true,
              );
            case PlayState _:
              return _PlayWidget(
                state: state,
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar();

  @override
  Size get preferredSize => const Size.fromHeight(28);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: mainColor,
      shape: const RoundedRectangleBorder(
        side: BorderSide(color: whiteColor),
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      centerTitle: false,
      title: const Text(
        mainWidgetName,
        style: appBarTitleStyle,
      ),
      elevation: 55,
      shadowColor: mainColor,
      toolbarHeight: 28,
    );
  }
}

class _PlayWidget extends StatelessWidget {
  const _PlayWidget({
    required this.state,
  });

  final PlayState state;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            whiteColor,
            mainColor,
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (state.songTitle == null)
            const _LoadingWidget(
              isLoading: true,
            )
          else
            const SizedBox(
              height: 120,
              child: AnimatedMusicIndicator(
                numberOfBars: 10,
                size: 0.95,
                barStyle: BarStyle.dash,
                color: mainColor,
              ),
            ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount:
                  context.read<PlayerBloc>().stationRepository.media.length,
              itemBuilder: (context, index) {
                final mediaItem =
                    context.read<PlayerBloc>().stationRepository.media[index];
                return StationItem(
                  stationName: mediaItem.title!,
                  songTitle: state.songTitle,
                  iconPath: mediaItem.logo ?? defaultLogo,
                  isSelected: state.selectedIndex == index,
                  callback: () => {
                    context
                        .read<PlayerBloc>()
                        .add(PlayEvent(selectedIndex: index)),
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget({
    required this.isLoading,
  });

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isLoading == true)
            const SizedBox(
              width: 220,
              height: 120,
              child: LoadingIndicator(
                indicatorType: Indicator.lineScalePulseOutRapid,
                colors: kDefaultRainbowColors,
              ),
            )
          else
            const SizedBox(
              width: 220,
              height: 120,
              child: LoadingIndicator(
                indicatorType: Indicator.audioEqualizer,
                colors: kDefaultRainbowColors,
              ),
            ),
        ],
      ),
    );
  }
}
