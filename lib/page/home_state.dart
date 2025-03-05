part of 'home_cubit.dart';

@freezed
class HomeState with _$HomeState {
  factory HomeState({
    required List<ItemUiModel> list,
    required List<ItemUiModel> searchList,
  }) = _HomeState;

  factory HomeState.initial() => HomeState(list: [], searchList: []);
}
