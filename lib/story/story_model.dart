// ignore_for_file: constant_identifier_names

class CampaignModel {
  final String name;
  final String imagePath;

  CampaignModel(this.name, this.imagePath);
}

enum MediaType { IMAGE, VIDEO }

class StoryModel {
  final String url;
  final MediaType mediaType;
  final Duration duration;
  final CampaignModel campaignModel;

  StoryModel({
    required this.url,
    required this.mediaType,
    required this.duration,
    required this.campaignModel,
  });
}
