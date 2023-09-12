import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mixmenu/app/views/feeds/bloc/a_bar_above_bloc/a_bar_above_bloc.dart';
import 'package:mixmenu/app/views/feeds/bloc/bevvy_bloc/bevvy_bloc.dart';
import 'package:mixmenu/app/views/feeds/widgets/mini_news_card.dart';
import 'package:mixmenu/services/service_locator.dart';

class BevvyTabView extends StatefulWidget {
  const BevvyTabView({super.key});

  @override
  State<BevvyTabView> createState() => _BevvyTabViewState();
}

class _BevvyTabViewState extends State<BevvyTabView>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    locator<BevvyBloc>()..add(BevvyGetFeedEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        locator<BevvyBloc>()..add(BevvyGetFeedEvent());
      },
      child: BlocBuilder<BevvyBloc, BevvyState>(builder: (ctx, state) {
        switch (state) {
          case BevvyInitial():
            return Center(
              child: ElevatedButton(
                child: Text('Get Data'),
                onPressed: () {
                  context.read<BevvyBloc>().add(BevvyGetFeedEvent());
                },
              ),
            );
          case BevvyLoading():
            return Center(
              child: CircularProgressIndicator(),
            );
          case BevvySuccess():
            return ListView.builder(
              key: PageStorageKey('bevvyFeedKey'),
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
