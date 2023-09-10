import 'package:dio/dio.dart';
import 'package:mixmenu/services/network/api_manager.dart';
import 'package:mixmenu/services/service_locator.dart';
import 'package:fpdart/fpdart.dart';
import 'package:dart_rss/dart_rss.dart';

class ABarRepo {
  static ApiManager _apiManager = locator<ApiManager>();

  static const String _feedURL = 'https://abarabove.com/feed/';

  static Future<Either> getABarFeed() async {
    Response response = await ApiManager().dio!.get(_feedURL);
    if (response.statusCode == 200) {
      var rssFeed = new RssFeed.parse(response.data.toString());
      print(rssFeed.runtimeType);
      return Left(rssFeed);
    } else {
      return Right('a');
    }
  }
}
