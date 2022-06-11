import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../detail_page.dart';
import 'story_model.dart';
import 'story_widget.dart';

class StoryPage extends StatefulWidget {
  const StoryPage({Key? key, required this.stories, this.selectedIndex})
      : super(key: key);

  final List<StoryModel> stories;
  final int? selectedIndex;
  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animController;
  late VideoPlayerController _videoController;

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _animController = AnimationController(vsync: this);
    _videoController = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
    controlSelectedIndex();
    final StoryModel firstStory = widget.stories[_currentIndex];
    _loadStory(story: firstStory, animateToPage: false);

    _animController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animController.stop();
        _animController.reset();
        setState(() {
          if (_currentIndex + 1 < widget.stories.length) {
            _currentIndex += 1;
            _loadStory(story: widget.stories[_currentIndex]);
          } else {
            Navigator.of(context).pop();
            /*  _currentIndex = 0;
            _loadStory(story: widget.stories[_currentIndex]); */
          }
        });
      }
    });
  }

  // Selected story index check
  void controlSelectedIndex() {
    if (widget.selectedIndex != null) {
      _currentIndex = widget.selectedIndex!;
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animController.dispose();
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final StoryModel story = widget.stories[_currentIndex];
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: GestureDetector(
          onTapUp: (details) => _onTapUp(details, story),
          onLongPressUp: () => _onLongPressUp(story),
          onLongPress: () => _onLongPress(story),
          onVerticalDragStart: (details) => _onVerticalDragStart(details),
          child: PageView.builder(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.stories.length,
            itemBuilder: (context, i) {
              final StoryModel story = widget.stories[_currentIndex];
              return StroyWidget(
                imageUrl: story.url,
                videoController: _videoController,
                animController: _animController,
                activeBarIndex: _currentIndex,
                model: story,
                stories: widget.stories,
              );
            },
          ),
        ),
      ),
    );
  }

  // For next or previous story pass,
  void _onTapUp(TapUpDetails details, StoryModel story) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;
    if (dx < screenWidth / 3) {
      setState(() {
        if (_currentIndex - 1 >= 0) {
          _currentIndex -= 1;
          _loadStory(story: widget.stories[_currentIndex]);
        }
      });
    } else if (dx > 2 * screenWidth / 3) {
      setState(() {
        if (_currentIndex + 1 < widget.stories.length) {
          _currentIndex += 1;
          _loadStory(story: widget.stories[_currentIndex]);
        } else {
          Navigator.of(context).pop();
          /* _currentIndex = 0;
          _loadStory(story: widget.stories[_currentIndex]); */
        }
      });
    }
  }

  // Continuation of the animation.
  void _onLongPressUp(StoryModel story) {
    if (story.mediaType == MediaType.VIDEO) {
      if (_videoController.value.isPlaying) {
        _videoController.pause();
        _animController.stop();
      } else {
        _videoController.play();
        _animController.forward();
      }
    } else {
      _animController.forward();
    }
  }

  /// we ensure that our story is loaded.
  void _loadStory({required StoryModel story, bool animateToPage = true}) {
    _animController.stop();
    _animController.reset();
    switch (story.mediaType) {
      case MediaType.IMAGE:
        _animController.duration = story.duration;
        _animController.forward();
        break;
      case MediaType.VIDEO:
        _videoController.dispose();
        _videoController = VideoPlayerController.network(story.url)
          ..initialize().then((_) {
            setState(() {});
            if (_videoController.value.isInitialized) {
              _animController.duration = _videoController.value.duration;
              _videoController.play();
              _animController.forward();
            }
          });
        break;
    }
    if (animateToPage) {
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  // We can stop our story transition by pressing and holding the screen.
  _onLongPress(StoryModel story) {
    if (story.mediaType == MediaType.VIDEO) {
      if (_videoController.value.isPlaying) {
        _videoController.pause();
        _animController.stop();
      } else {
        _videoController.play();
        _animController.forward();
      }
    } else {
      _animController.stop();
    }
  }

  // We can move to another page by swiping up from the bottom.
  _onVerticalDragStart(DragStartDetails details) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double dy = details.globalPosition.dy;
    if (dy > screenHeight / 1.6) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const DetailPageScreen(),
        ),
      );
    }
  }
}
