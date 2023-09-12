import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dart_rss/dart_rss.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:mixmenu/app/views/feeds/repo/feed_repo.dart';

part 'chilled_event.dart';

part 'chilled_state.dart';

class ChilledBloc extends Bloc<ChilledEvent, ChilledState> {
  ChilledBloc() : super(ChilledInitial()) {
    on<ChilledEvent>((event, emit) {});

    on<ChilledGetFeedEvent>((event, emit) async {
      if (state is ChilledSuccess) {
        await FeedRepo.getFeed(feedType: 'chilled').then((value) {
          value.fold((l) => emit(ChilledSuccess(feed: l as RssFeed)),
              (r) => emit(ChilledInitial()));
        });
      } else {
        emit(ChilledLoading());
        await FeedRepo.getFeed(feedType: 'chilled').then((value) {
          value.fold((l) => emit(ChilledSuccess(feed: l as RssFeed)),
              (r) => emit(ChilledInitial()));
        });
      }
    });
  }
}
