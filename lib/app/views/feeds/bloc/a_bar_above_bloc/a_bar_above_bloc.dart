import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dart_rss/dart_rss.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:mixmenu/app/views/feeds/repo/feed_repo.dart';

part 'a_bar_above_event.dart';

part 'a_bar_above_state.dart';

class ABarAboveBloc extends Bloc<ABarAboveEvent, ABarAboveState> {
  ABarAboveBloc() : super(ABarAboveInitial()) {
    on<ABarAboveEvent>((event, emit) {});

    on<ABarAboveGetFeedEvent>((event, emit) async {
      if (state is ABarAboveSuccess) {
        await FeedRepo.getFeed(feedType: 'aBar').then((value) {
          value.fold((l) => emit(ABarAboveSuccess(feed: l as RssFeed)),
              (r) => emit(ABarAboveInitial()));
        });
      } else {
        emit(ABarAboveLoading());
        await FeedRepo.getFeed(feedType: 'aBar').then((value) {
          value.fold((l) => emit(ABarAboveSuccess(feed: l as RssFeed)),
              (r) => emit(ABarAboveInitial()));
        });
      }
    });
  }
}
