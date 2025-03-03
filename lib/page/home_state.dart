part of 'home_cubit.dart';

@freezed
class HomeState with _$HomeState {
  factory HomeState({
    required List<ItemUiModel> list,
  }) = _HomeState;

  factory HomeState.initial() => HomeState(list: []);
}
