part of 'trendings_cubit.dart';

sealed class TrendingsState extends Equatable {
  const TrendingsState();

  @override
  List<Object> get props => [];
}

final class TrendingsInitial extends TrendingsState {}

final class TrendingsSuccess extends TrendingsState {
  final List<Video> video;

  const TrendingsSuccess({required this.video});

  @override
  List<Object> get props => [video];
}

final class TrendingsFailure extends TrendingsState {
  final String message;

  const TrendingsFailure({required this.message});

  @override
  List<Object> get props => [message];
}
