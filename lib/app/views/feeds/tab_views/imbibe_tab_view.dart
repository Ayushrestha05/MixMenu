import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mixmenu/app/views/feeds/bloc/a_bar_above_bloc/a_bar_above_bloc.dart';
import 'package:mixmenu/app/views/feeds/bloc/imbibe_bloc/imbibe_bloc.dart';
import 'package:mixmenu/app/views/feeds/widgets/mini_news_card.dart';
import 'package:mixmenu/services/service_locator.dart';

class ImbibeTabView extends StatefulWidget {
  const ImbibeTabView({super.key});

  @override
  State<ImbibeTabView> createState() => _ImbibeTabViewState();
}

class _ImbibeTabViewState extends State<ImbibeTabView>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    locator<ImbibeBloc>()..add(ImbibeGetFeedEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        locator<ImbibeBloc>()..add(ImbibeGetFeedEvent());
      },
      child: BlocBuilder<ImbibeBloc, ImbibeState>(builder: (ctx, state) {
        switch (state) {
          case ImbibeInitial():
            return Center(
              child: ElevatedButton(
                child: Text('Get Data'),
                onPressed: () {
                  context.read<ImbibeBloc>().add(ImbibeGetFeedEvent());
                },
              ),
            );
          case ImbibeLoading():
            return Center(
              child: CircularProgressIndicator(),
            );
          case ImbibeSuccess():
            return ListView.builder(
              key: PageStorageKey('imbibeFeedKey'),
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
