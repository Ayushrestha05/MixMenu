import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mixmenu/app/views/feeds/bloc/a_bar_above_bloc/a_bar_above_bloc.dart';
import 'package:mixmenu/app/views/feeds/bloc/chilled_bloc/chilled_bloc.dart';
import 'package:mixmenu/app/views/feeds/widgets/mini_news_card.dart';
import 'package:mixmenu/services/service_locator.dart';

class ChilledTabView extends StatefulWidget {
  const ChilledTabView({super.key});

  @override
  State<ChilledTabView> createState() => _ChilledTabViewState();
}

class _ChilledTabViewState extends State<ChilledTabView>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    locator<ChilledBloc>()..add(ChilledGetFeedEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChilledBloc, ChilledState>(builder: (ctx, state) {
      switch (state) {
        case ChilledInitial():
          return Center(
            child: ElevatedButton(
              child: Text('Get Data'),
              onPressed: () {
                context.read<ChilledBloc>().add(ChilledGetFeedEvent());
              },
            ),
          );
        case ChilledLoading():
          return Center(
            child: CircularProgressIndicator(),
          );
        case ChilledSuccess():
          return ListView.builder(
            key: PageStorageKey('chilledFeedKey'),
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
    });
  }

  @override
  bool get wantKeepAlive => true;
}
