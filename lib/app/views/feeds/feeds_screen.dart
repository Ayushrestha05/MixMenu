// import 'package:any_link_preview/any_link_preview.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dart_rss/dart_rss.dart';
import 'package:flutter/material.dart';
import 'package:mixmenu/app/views/feeds/model/feed_model.dart';
import 'package:mixmenu/app/views/feeds/tab_views/a_bar_tab_view.dart';
import 'package:mixmenu/app/views/feeds/tab_views/bevvy_tab_view.dart';
import 'tab_views/chilled_tab_view.dart';
import 'tab_views/imbibe_tab_view.dart';

class FeedScreen extends StatefulWidget {
  FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: feeds.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: Text(
                  'Feeds',
                  style: Theme.of(context).textTheme.headlineMedium,
                )),
            TabBar(
                controller: _tabController,
                dividerColor: Color(0x00000000),
                splashFactory: NoSplash.splashFactory,
                // isScrollable: true,
                // tabAlignment: TabAlignment.start,
                tabs: feeds
                    .map((e) =>
                        buildFeedSelectionContainer(feedIMGURL: e.imageURL))
                    .toList()),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: TabBarView(controller: _tabController, children: [
                ABarTabView(),
                ImbibeTabView(),
                ChilledTabView(),
                BevvyTabView(),
              ]),
            )
          ],
        ),
      ),
    );
  }

  /// Builds a Tab for Feed Image
  Widget buildFeedSelectionContainer({required String feedIMGURL}) {
    return CachedNetworkImage(
      imageUrl: feedIMGURL,
      imageBuilder: (ctx, img_provider) => Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(image: img_provider)),
        margin: EdgeInsets.only(bottom: 5),
        clipBehavior: Clip.antiAlias,
        // child: Image(image: img_provider),
      ),
      placeholder: (ctx, url) => Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
                image: AssetImage('assets/placeholder/img-placeholder.jpg'))),
        margin: EdgeInsets.only(bottom: 5),
        clipBehavior: Clip.antiAlias,
      ),
      errorWidget: (ctx, url, err) => Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
                image: AssetImage('assets/placeholder/img-placeholder.jpg'))),
        margin: EdgeInsets.only(bottom: 5),
        clipBehavior: Clip.antiAlias,
      ),
    );
  }

  /// Builds a Card for Feeds
  Widget buildFeedCard(RssItem data) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: Center(
              child: Icon(Icons.image),
            ),
          ),
          Expanded(
              child: Column(
            children: [
              Text('${data.title ?? ''}'),
              // buildFeedCategoryChips(data)
            ],
          ))
        ],
      ),
    );
  }

  Widget buildFeedCategoryChips(RssItem data) {
    if (data.categories.length != 0) {
      return Wrap(
        spacing: 8,
        children: data.categories
            .take(2)
            .toList()
            .map((e) => ChoiceChip(
                  selected: true,
                  label: Text(capitalizeFirstLetterOfEveryWord(e.value ?? '')),
                  backgroundColor:
                      MaterialStateColor.resolveWith((states) => Colors.grey),
                  labelStyle: TextStyle(color: Colors.black),
                  elevation: 1,
                  shadowColor: Colors.grey.shade300,
                ))
            .toList(),
      );
    } else {
      return Container();
    }
  }

  String capitalizeFirstLetterOfEveryWord(String text) {
    List<String> words = text.split(" ");
    List<String> capitalizedWords = [];

    for (String word in words) {
      capitalizedWords.add(word[0].toUpperCase() + word.substring(1));
    }

    return capitalizedWords.join(" ");
  }

  @override
  bool get wantKeepAlive => true;
}
