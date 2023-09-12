part of 'imbibe_bloc.dart';

abstract class ImbibeState extends Equatable {
  const ImbibeState();
}

class ImbibeInitial extends ImbibeState {
  @override
  List<Object> get props => [];
}

class ImbibeLoading extends ImbibeState {
  @override
  List<Object?> get props => [];
}

class ImbibeSuccess extends ImbibeState {
  final RssFeed? feed;

  ImbibeSuccess({this.feed});

  @override
  List<Object?> get props => [feed];

  ImbibeSuccess copyWith({
    RssFeed? feed,
  }) {
    return ImbibeSuccess(
      feed: feed ?? this.feed,
    );
  }
}

class ImbibeError extends ImbibeState {
  @override
  List<Object?> get props => [];
}
