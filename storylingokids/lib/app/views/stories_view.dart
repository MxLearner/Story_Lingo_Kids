/*
 * Project Name:  StoryLingoKids
 * File Name:     stories_view.dart
 * File Function: 故事页面
 * Author:        林继申、王麒懿
 * Update Date:   2024-06-15
 * License:       MIT License
 */

import 'package:flutter/material.dart'
    show
        Alignment,
        AssetImage,
        BorderRadius,
        BouncingScrollPhysics,
        BoxDecoration,
        BoxFit,
        BuildContext,
        Color,
        Container,
        CustomScrollView,
        DecorationImage,
        EdgeInsets,
        GestureDetector,
        MaterialPageRoute,
        Navigator,
        Padding,
        Scaffold,
        ScrollController,
        SliverChildBuilderDelegate,
        SliverGrid,
        SliverGridDelegateWithFixedCrossAxisCount,
        SliverToBoxAdapter,
        State,
        StatefulWidget,
        Widget;
import 'package:storylingokids/app/views/abc_view.dart' show PageABC;
import 'package:storylingokids/app/views/count_view.dart' show PageCount;
import 'package:storylingokids/app/widgets/view_header.dart' show ViewHeader;

class StoriesView extends StatefulWidget {
  final String title;
  final Color primaryColor;
  final Color secondaryColor;

  const StoriesView({
    super.key,
    required this.title,
    required this.primaryColor,
    required this.secondaryColor,
  });

  @override
  State<StoriesView> createState() => _StoriesViewState();
}

class _StoriesViewState extends State<StoriesView> {
  final _scrollController = ScrollController();
  double offset = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void onScroll() {
    setState(() {
      offset = (_scrollController.hasClients) ? _scrollController.offset : 0;
    });
  }

  void _navigateToPageOne() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PageABC(title: 'ABC'),
      ),
    );
  }

  void _navigateToPageTwo() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PageCount(title: 'Let\'s count!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: ViewHeader(
              title: widget.title,
              primaryColor: widget.primaryColor,
              secondaryColor: widget.secondaryColor,
              offset: offset,
              showMicrophoneIcon: false,
            ),
          ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20.0,
              mainAxisSpacing: 20.0,
            ),
            delegate: SliverChildBuilderDelegate(
              childCount: 2,
              (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GestureDetector(
                    onTap: () {
                      if (index == 0) {
                        _navigateToPageOne();
                      } else {
                        _navigateToPageTwo();
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/images/stories/cover_$index.png'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
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
