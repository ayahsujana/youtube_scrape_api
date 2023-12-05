part of 'search_cubit.dart';

sealed class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchSuccess extends SearchState {
  final List<Video> video;

  const SearchSuccess({required this.video});
}

final class SearchFailure extends SearchState {
  final String message;

  const SearchFailure({required this.message});
}
