import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:story_application/story/story_model.dart';
import 'package:story_application/story/story_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<StoryModel> stories = [
    StoryModel(
      url:
          'https://images.unsplash.com/photo-1534103362078-d07e750bd0c4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
      mediaType: MediaType.IMAGE,
      duration: const Duration(seconds: 10),
      campaignModel: CampaignModel(
        'MANZARA 1',
        'https://images.unsplash.com/photo-1534103362078-d07e750bd0c4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
      ),
    ),
    StoryModel(
      url:
          'https://images.unsplash.com/photo-1531694611353-d4758f86fa6d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=564&q=80',
      mediaType: MediaType.IMAGE,
      duration: const Duration(seconds: 5),
      campaignModel: CampaignModel(
        'MANZARA 2',
        'https://images.unsplash.com/photo-1531694611353-d4758f86fa6d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=564&q=80',
      ),
    ),
    StoryModel(
      url:
          'https://images.unsplash.com/photo-1534103362078-d07e750bd0c4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
      mediaType: MediaType.IMAGE,
      duration: const Duration(seconds: 3),
      campaignModel: CampaignModel(
        'İbrahim Atmaca',
        'https://wallpapercave.com/wp/AYWg3iu.jpg',
      ),
    ),
    StoryModel(
      url:
          'https://static.videezy.com/system/resources/previews/000/005/529/original/Reaviling_Sjusj%C3%B8en_Ski_Senter.mp4',
      mediaType: MediaType.VIDEO,
      duration: const Duration(seconds: 0),
      campaignModel: CampaignModel(
        'İbrahim Atmaca',
        'https://wallpapercave.com/wp/AYWg3iu.jpg',
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final double mediaQuery = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 200,
            child: ListView.builder(
              itemCount: stories.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: ((context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              StoryPage(stories: stories, selectedIndex: index),
                        ),
                      );
                    },
                    child: CircleAvatar(
                      radius: mediaQuery > 650 ? 60.0 : 40.0,
                      backgroundColor: const Color(0xff0057CB),
                      child: ClipOval(
                        child: Image(
                          image: CachedNetworkImageProvider(
                            stories[index].campaignModel.imagePath,
                          ),
                          fit: BoxFit.cover,
                          height: mediaQuery > 650 ? 100 : 70,
                          width: mediaQuery > 650 ? 100 : 70,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
