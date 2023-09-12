import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mixmenu/app/views/feeds/bloc/a_bar_above_bloc/a_bar_above_bloc.dart';
import 'package:mixmenu/app/views/feeds/widgets/mini_news_card.dart';
import 'package:mixmenu/services/service_locator.dart';

class ABarTabView extends StatefulWidget {
  const ABarTabView({super.key});

  @override
  State<ABarTabView> createState() => _ABarTabViewState();
}

class _ABarTabViewState extends State<ABarTabView>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    locator<ABarAboveBloc>()..add(ABarAboveGetFeedEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        locator<ABarAboveBloc>()..add(ABarAboveGetFeedEvent());
      },
      child: BlocBuilder<ABarAboveBloc, ABarAboveState>(builder: (ctx, state) {
        switch (state) {
          case ABarAboveInitial():
            return Center(
              child: ElevatedButton(
                child: Text('Get Data'),
                onPressed: () {
                  context.read<ABarAboveBloc>().add(ABarAboveGetFeedEvent());
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
              itemExtent: 150,
              itemBuilder: (ctx, val) =>
                  MiniNewsCard(news: state.feed!.items[val]),
              itemCount: state.feed!.items.length,
            );

          default:
            return Center(
              child: CircularProgressIndicator(),
            );
        }
      }),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
