part of 'chilled_bloc.dart';

@immutable
abstract class ChilledState extends Equatable {}

class ChilledInitial extends ChilledState {
  @override
  List<Object?> get props => [];
}

class ChilledLoading extends ChilledState {
  @override
  List<Object?> get props => [];
}

class ChilledSuccess extends ChilledState {
  final RssFeed? feed;

  ChilledSuccess({this.feed});

  @override
  List<Object?> get props => [feed];

  ChilledSuccess copyWith({
    RssFeed? feed,
  }) {
    return ChilledSuccess(
      feed: feed ?? this.feed,
    );
  }
}

class ChilledError extends ChilledState {
  @override
  List<Object?> get props => [];
}
