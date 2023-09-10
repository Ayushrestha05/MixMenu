import 'package:bloc/bloc.dart';
import 'package:dart_rss/dart_rss.dart';
import 'package:meta/meta.dart';
import 'package:mixmenu/app/views/feeds/repo/a_bar_repo.dart';

part 'a_bar_above_event.dart';

part 'a_bar_above_state.dart';

class ABarAboveBloc extends Bloc<ABarAboveEvent, ABarAboveState> {
  ABarAboveBloc() : super(ABarAboveInitial()) {
    on<ABarAboveEvent>((event, emit) {});

    on<ABarAboveGetFeedEvent>((event, emit) async {
      emit(ABarAboveLoading());
      await ABarRepo.getABarFeed().then((value) {
        value.fold((l) => emit(ABarAboveSuccess(feed: l as RssFeed)),
            (r) => emit(ABarAboveInitial()));
      });
    });
  }
}
