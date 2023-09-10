class FeedModel {
  String name;
  String imageURL;

  FeedModel({required this.name, required this.imageURL});
}

List<FeedModel> feeds = [
  FeedModel(
      name: 'A Bar Above',
      imageURL: 'https://i1.feedspot.com/4541978.jpg?t=1639825088'),
  FeedModel(
      name: 'Imbibe',
      imageURL: 'https://i1.feedspot.com/1144172.jpg?t=1649241266'),
  FeedModel(
      name: 'Chilled',
      imageURL: 'https://i1.feedspot.com/4946272.jpg?t=1639829409'),
  FeedModel(
      name: 'Art of Drinks',
      imageURL: 'https://i1.feedspot.com/5569787.jpg?t=1684326422'),
];
