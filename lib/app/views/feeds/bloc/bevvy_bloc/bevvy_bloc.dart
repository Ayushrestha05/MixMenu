import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dart_rss/dart_rss.dart';
import 'package:equatable/equatable.dart';
import 'package:mixmenu/app/views/feeds/repo/feed_repo.dart';

part 'bevvy_event.dart';
part 'bevvy_state.dart';

class BevvyBloc extends Bloc<BevvyEvent, BevvyState> {
  BevvyBloc() : super(BevvyInitial()) {
    on<BevvyEvent>((event, emit) {});

    on<BevvyGetFeedEvent>((event, emit) async {
      emit(BevvyLoading());
      await FeedRepo.getFeed(feedType: 'bevvy').then((value) {
        value.fold((l) => emit(BevvySuccess(feed: l as RssFeed)),
            (r) => emit(BevvyInitial()));
      });
    });
  }
}
