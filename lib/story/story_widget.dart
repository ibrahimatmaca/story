import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:story_application/story/user_info.dart';
import 'package:video_player/video_player.dart';

import 'animated_bar.dart';
import 'story_model.dart';

class StroyWidget extends StatelessWidget {
  const StroyWidget(
      {Key? key,
      required this.imageUrl,
      required this.stories,
      required this.animController,
      this.activeBarIndex = 0,
      required this.model,
      this.detailShortText = 'Detay Hakkında bazı\nşeyler yazacak',
      this.videoController})
      : super(key: key);

  final String imageUrl;
  final VideoPlayerController? videoController;
  final String detailShortText;
  final List<StoryModel> stories;
  final AnimationController animController;
  final int activeBarIndex;
  final StoryModel model;

  @override
  Widget build(BuildContext context) {
    final double widthM = MediaQuery.of(context).size.width;
    final double heightM = MediaQuery.of(context).size.height;
    return Stack(
      children: <Widget>[
        model.mediaType == MediaType.IMAGE
            ? SizedBox(
                width: widthM,
                height: heightM,
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.fill,
                  ),
                ),
              )
            : videoController!.value.isInitialized
                ? Align(
                    alignment: Alignment.center,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: SizedBox(
                        width: widthM,
                        height: heightM * .8,
                        child: VideoPlayer(videoController!),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
        Positioned(
          top: 10.0,
          left: 10.0,
          right: 10.0,
          child: Column(
            children: <Widget>[
              Row(
                children: stories
                    .asMap()
                    .map((i, e) {
                      return MapEntry(
                        i,
                        AnimatedBar(
                          animController: animController,
                          position: i,
                          currentIndex: activeBarIndex,
                        ),
                      );
                    })
                    .values
                    .toList(),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 1.5, vertical: 10.0),
                child: UserInfo(user: model.campaignModel),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
