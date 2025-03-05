part of 'home_cubit.dart';

@freezed
class HomeState with _$HomeState {
  factory HomeState({
    required List<ItemUiModel> list,
    required List<ItemUiModel>? searchList,
    required List<int> selectedIndexes,
    required bool selectAllProduct,
  }) = _HomeState;

  factory HomeState.initial() => HomeState(
      list: [], searchList: null, selectedIndexes: [], selectAllProduct: false);
}
