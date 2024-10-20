import 'package:flutter/material.dart';
import 'package:piotrek84nn_int_radio_player/presentation/constants/colors.dart';
import 'package:piotrek84nn_int_radio_player/presentation/constants/constant.dart';
import 'package:text_scroll/text_scroll.dart';

class StationItem extends StatelessWidget {
  const StationItem({
    required this.stationName,
    required this.isSelected,
    required this.callback,
    super.key,
    this.iconPath = defaultLogo,
    this.songTitle,
  });

  final String stationName;
  final String iconPath;
  final String? songTitle;
  final bool isSelected;
  final GestureTapCallback? callback;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: _StationItemWidget(
        isSelected: isSelected,
        iconPath: iconPath,
        stationName: stationName,
        songTitle: songTitle,
      ),
    );
  }
}

class _StationItemWidget extends StatelessWidget {
  const _StationItemWidget({
    required this.isSelected,
    required this.iconPath,
    required this.stationName,
    required this.songTitle,
  });

  final bool isSelected;
  final String iconPath;
  final String stationName;
  final String? songTitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        side: BorderSide(
          color: whiteColor,
          width: 4,
        ),
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              mainColor,
              if (isSelected == true) selectdBgColor else whiteColor,
            ],
          ),
        ),
        child: Row(
          children: [
            _LogoWidget(iconPath: iconPath),
            _TitleWidget(
              stationName: stationName,
              isSelected: isSelected,
              songTitle: songTitle,
            ),
          ],
        ),
      ),
    );
  }
}

class _LogoWidget extends StatelessWidget {
  const _LogoWidget({
    required this.iconPath,
  });

  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      child: Image.asset(
        iconPath,
        height: 100,
        width: 100,
      ),
    );
  }
}

class _TitleWidget extends StatelessWidget {
  const _TitleWidget({
    required this.stationName,
    required this.isSelected,
    required this.songTitle,
  });

  final String stationName;
  final bool isSelected;
  final String? songTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          stationName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: isSelected ? whiteColor : blackColor,
          ),
        ),
        if (isSelected)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 225),
              child: TextScroll(
                songTitle ?? '',
                fadedBorder: true,
                intervalSpaces: 5,
                velocity: const Velocity(pixelsPerSecond: Offset(40, 0)),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: isSelected ? whiteColor : blackColor,
                ),
              ),
            ),
          )
        else
          const SizedBox(),
      ],
    );
  }
}
