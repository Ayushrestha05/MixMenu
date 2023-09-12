part of 'bevvy_bloc.dart';

abstract class BevvyState extends Equatable {
  const BevvyState();
}

class BevvyInitial extends BevvyState {
  @override
  List<Object> get props => [];
}

class BevvyLoading extends BevvyState {
  @override
  List<Object?> get props => [];
}

class BevvySuccess extends BevvyState {
  final RssFeed? feed;

  BevvySuccess({this.feed});

  @override
  List<Object?> get props => [feed];

  BevvySuccess copyWith({
    RssFeed? feed,
  }) {
    return BevvySuccess(
      feed: feed ?? this.feed,
    );
  }
}

class BevvyError extends BevvyState {
  @override
  List<Object?> get props => [];
}
