/*
 * Project Name:  StoryLingoKids
 * File Name:     menu_card.dart
 * File Function: 菜单卡片
 * Author:        林继申
 * Update Date:   2024-06-08
 * License:       MIT License
 */

import 'package:flutter/cupertino.dart'
    show
        Alignment,
        BorderRadius,
        BoxDecoration,
        BoxShadow,
        BuildContext,
        Clip,
        Color,
        Container,
        CupertinoPageRoute,
        EdgeInsets,
        LinearGradient,
        Navigator,
        Offset,
        State,
        StatefulWidget,
        Text,
        Widget,
        debugPrint;
import 'package:flutter/material.dart'
    show
        Alignment,
        BorderRadius,
        BoxDecoration,
        BoxShadow,
        BuildContext,
        Clip,
        Color,
        Colors,
        Container,
        EdgeInsets,
        InkWell,
        LinearGradient,
        Material,
        MaterialType,
        Navigator,
        Offset,
        State,
        StatefulWidget,
        Text,
        Widget,
        debugPrint;
import 'package:flutter/painting.dart'
    show
        Alignment,
        BorderRadius,
        BoxDecoration,
        BoxShadow,
        Clip,
        Color,
        EdgeInsets,
        FontWeight,
        LinearGradient,
        Offset,
        TextStyle;
import 'package:flutter/services.dart' show Color, HapticFeedback, Offset;
import 'package:just_audio/just_audio.dart' show AudioPlayer;

class MenuCard extends StatefulWidget {
  final String title;
  final Color primaryColor;
  final Color secondaryColor;
  final Widget screen;

  const MenuCard({
    super.key,
    required this.title,
    required this.primaryColor,
    required this.secondaryColor,
    required this.screen,
  });

  @override
  State<MenuCard> createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {
  final _audioPlayer = AudioPlayer();

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _pushAudio() async {
    try {
      await _audioPlayer.setAsset(
        'assets/audios/effects/Forward.wav',
      );
      _audioPlayer.play();
    } catch (e) {
      debugPrint('Error loading audio source: $e');
    }
  }

  void _navigate(BuildContext context, Widget screen) {
    _pushAudio();
    HapticFeedback.lightImpact();
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (_) {
          return screen;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 10,
            color: Colors.grey[900]!.withOpacity(0.2),
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [widget.primaryColor, widget.secondaryColor],
        ),
      ),
      height: 180.0,
      child: Material(
        type: MaterialType.transparency,
        borderRadius: BorderRadius.circular(20),
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: () => _navigate(context, widget.screen),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text(
              widget.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 72,
                fontWeight: FontWeight.w700,
                letterSpacing: 4.0,
              ),
              softWrap: false,
            ),
          ),
        ),
      ),
    );
  }
}