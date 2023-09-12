import 'package:dio/dio.dart';
import 'package:mixmenu/services/network/api_manager.dart';
import 'package:mixmenu/services/service_locator.dart';
import 'package:fpdart/fpdart.dart';
import 'package:dart_rss/dart_rss.dart';

class FeedRepo {
  static ApiManager _apiManager = locator<ApiManager>();

  static const String _aBarAboveFeedURL = 'https://abarabove.com/feed/';
  static const String _imbibeFeedURL = 'https://imbibemagazine.com/feed/';
  static const String _chilledFeedURL = 'https://chilledmagazine.com/feed/';
  static const String _bevvyFeedURL = 'https://bevvy.co/articles/feed';

  static const Map<String, String> feedURL = {
    'aBar': _aBarAboveFeedURL,
    'imbibe': _imbibeFeedURL,
    'chilled': _chilledFeedURL,
    'bevvy': _bevvyFeedURL
  };

  static Future<Either> getFeed({required String feedType}) async {
    Response response = await ApiManager().dio!.get(feedURL[feedType]!);
    if (response.statusCode == 200) {
      var rssFeed = new RssFeed.parse(response.data.toString());
      print(rssFeed.runtimeType);
      return Left(rssFeed);
    } else {
      return Right('a');
    }
  }
}
