/*
 * Project Name:  StoryLingoKids
 * File Name:     colors_test_view.dart
 * File Function: 颜色测试页面
 * Author:        林继申
 * Update Date:   2024-06-08
 * License:       MIT License
 */

import 'package:flutter/material.dart'
    show
        BouncingScrollPhysics,
        BuildContext,
        Color,
        Colors,
        CustomScrollView,
        EdgeInsets,
        Padding,
        Scaffold,
        ScrollController,
        SliverChildBuilderDelegate,
        SliverGrid,
        SliverGridDelegateWithFixedCrossAxisCount,
        SliverToBoxAdapter,
        State,
        StatefulWidget,
        Widget,
        debugPrint;
import 'package:just_audio/just_audio.dart' show AudioPlayer;
import 'package:storylingokids/app/lists/colors_list.dart' show colorsList;
import 'package:storylingokids/app/widgets/test_view_header.dart'
    show TestViewHeader;
import 'package:storylingokids/app/widgets/text_card.dart' show TextCard;

class ColorsTestView extends StatefulWidget {
  final String title;
  final Color primaryColor;
  final Color secondaryColor;

  const ColorsTestView({
    super.key,
    required this.title,
    required this.primaryColor,
    required this.secondaryColor,
  });

  @override
  State<ColorsTestView> createState() => _ColorsTestViewState();
}

class _ColorsTestViewState extends State<ColorsTestView> {
  final _scrollController = ScrollController();
  final _audioPlayer = AudioPlayer();
  double offset = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  void onScroll() {
    setState(() {
      offset = (_scrollController.hasClients) ? _scrollController.offset : 0;
    });
  }

  void _playAudio(String assetPath) async {
    try {
      await _audioPlayer.setAsset(assetPath);
      _audioPlayer.play();
    } catch (e) {
      debugPrint('Error loading audio source: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: TestViewHeader(
              title: widget.title,
              primaryColor: widget.primaryColor,
              secondaryColor: widget.secondaryColor,
              offset: offset,
            ),
          ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20.0,
            ),
            delegate: SliverChildBuilderDelegate(
              childCount: colorsList.length,
              (context, index) {
                return Padding(
                  padding: index % 2 == 0
                      ? const EdgeInsets.only(bottom: 20, left: 20)
                      : const EdgeInsets.only(bottom: 20, right: 20),
                  child: TextCard(
                    title: colorsList[index].name,
                    textColor: colorsList[index].name == 'White'
                        ? const Color(0xFF303030)
                        : Colors.white,
                    backgroundColor: Color(int.parse(colorsList[index].code)),
                    fontSizeBase: 35,
                    fontSizeActive: 40,
                    onTap: () => _playAudio(colorsList[index].audio),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}