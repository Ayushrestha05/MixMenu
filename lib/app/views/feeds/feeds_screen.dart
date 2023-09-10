import 'package:any_link_preview/any_link_preview.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dart_rss/dart_rss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mixmenu/app/views/feeds/bloc/a_bar_above_bloc/a_bar_above_bloc.dart';
import 'package:mixmenu/app/views/feeds/model/feed_model.dart';

class FeedScreen extends StatefulWidget {
  FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);

  @override
  void initState() {
    _tabController = TabController(length: feeds.length, vsync: this);
    _tabController.addListener(() {
      _currentIndex.value = _tabController.index;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ValueListenableBuilder(
                valueListenable: _currentIndex,
                builder: (context, v, _) {
                  return Text('${feeds[v].name}');
                }),
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
            Expanded(
              child: TabBarView(controller: _tabController, children: [
                BlocBuilder<ABarAboveBloc, ABarAboveState>(
                    builder: (ctx, state) {
                  switch (state) {
                    case ABarAboveInitial():
                      return Center(
                        child: ElevatedButton(
                          child: Text('Get Data'),
                          onPressed: () {
                            context
                                .read<ABarAboveBloc>()
                                .add(ABarAboveGetFeedEvent());
                          },
                        ),
                      );
                    case ABarAboveLoading():
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    case ABarAboveSuccess():
                      return ListView.builder(
                        key: PageStorageKey('aBarFeedKey'),
                        itemExtent: 70,
                        itemBuilder: (ctx, val) =>
                            buildFeedCard(state.feed!.items[val]),
                        itemCount: state.feed!.items.length,
                      );

                    default:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                  }
                }),
                Text('Page 2'),
                Text('Page 3'),
                Text('Page 4'),
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
    return AnyLinkPreview(
      link: data.link ?? '',
      displayDirection: UIDirection.uiDirectionHorizontal,
    );
    // return Card(
    //   clipBehavior: Clip.antiAlias,
    //   child: Row(
    //     children: [
    //       Image.asset(
    //         'assets/placeholder/img-placeholder.jpg',
    //         height: 70,
    //         width: 70,
    //       ),
    //       Text('${data.title ?? ''}')
    //     ],
    //   ),
    // );
  }
}
