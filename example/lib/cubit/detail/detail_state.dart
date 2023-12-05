part of 'detail_cubit.dart';

sealed class DetailState extends Equatable {
  const DetailState();

  @override
  List<Object> get props => [];
}

final class DetailInitial extends DetailState {}

final class DetailLoading extends DetailState {}

final class DetailSuccess extends DetailState {
  final VideoData? video;

  const DetailSuccess({required this.video});

  @override
  List<Object> get props => [video!];
}

final class DetailFailure extends DetailState {
  final String message;

  const DetailFailure({required this.message});

  @override
  List<Object> get props => [message];
}
