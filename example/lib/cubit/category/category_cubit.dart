import 'package:bloc/bloc.dart';

class CategoryCubit extends Cubit<int> {
  CategoryCubit() : super(0);

  void categorySelected(int channelId) {
    emit(channelId);
  }
}