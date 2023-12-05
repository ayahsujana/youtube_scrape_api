part of 'channels_cubit.dart';

sealed class ChannelsState extends Equatable {
  const ChannelsState();

  @override
  List<Object> get props => [];
}

final class ChannelsInitial extends ChannelsState {}
final class ChannelsLoading extends ChannelsState {}

final class ChannelsSuccess extends ChannelsState {
  final ChannelData? channel;

  const ChannelsSuccess({required this.channel});

  @override
  List<Object> get props => [channel!];
}

final class ChannelsFailure extends ChannelsState {
  final String message;

  const ChannelsFailure({required this.message});

  @override
  List<Object> get props => [message];
}
