import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dart_rss/dart_rss.dart';
import 'package:equatable/equatable.dart';
import 'package:mixmenu/app/views/feeds/repo/feed_repo.dart';

part 'imbibe_event.dart';
part 'imbibe_state.dart';

class ImbibeBloc extends Bloc<ImbibeEvent, ImbibeState> {
  ImbibeBloc() : super(ImbibeInitial()) {
    on<ImbibeEvent>((event, emit) {});

    on<ImbibeGetFeedEvent>((event, emit) async {
      emit(ImbibeLoading());
      await FeedRepo.getFeed(feedType: 'imbibe').then((value) {
        value.fold((l) => emit(ImbibeSuccess(feed: l as RssFeed)),
            (r) => emit(ImbibeInitial()));
      });
    });
  }
}
