part of 'a_bar_above_bloc.dart';

@immutable
abstract class ABarAboveState extends Equatable {}

class ABarAboveInitial extends ABarAboveState {
  @override
  List<Object> get props => [];
}

class ABarAboveLoading extends ABarAboveState {
  @override
  List<Object?> get props => [];
}

class ABarAboveSuccess extends ABarAboveState {
  final RssFeed? feed;

  ABarAboveSuccess({this.feed});

  @override
  List<Object?> get props => [feed];

  ABarAboveSuccess copyWith({
    RssFeed? feed,
  }) {
    return ABarAboveSuccess(
      feed: feed ?? this.feed,
    );
  }
}

class ABarAboveError extends ABarAboveState {
  @override
  List<Object?> get props => [];
}
