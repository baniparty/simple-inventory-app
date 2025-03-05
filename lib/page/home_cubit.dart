import 'package:csv2json/csv2json.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:inventory_app/item_ui_model.dart';

part 'home_state.dart';
part 'home_cubit.freezed.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState.initial());

  void openFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.any);
    final path = result?.files.single.path;
    if (path != null) {
      final jsonData = await csvFileToJson(path);
      final itemList = jsonData.map((e) => ItemUiModel.fromJson(e)).toList();

      final scrapingList = <ItemUiModel>[];

      var existIndex = -1;
      for (var item in itemList) {
        if (item.productName?.isNotEmpty == true) {
          if (item.barcode != null) {
            item.barcodes.add(item.barcode!);
          }
          scrapingList.add(item);
          existIndex += 1;
        } else {
          if (item.barcode != null && existIndex > -1) {
            scrapingList[existIndex].barcodes.add(item.barcode!);
          }
        }
      }

      final result = scrapingList.distinctBy((e) => e.productName!).toList();

      emit(state.copyWith(list: result));
    }
  }

  void search(String query) {
    if (query.isEmpty) {
      emit(state.copyWith(searchList: null));
    } else {
      var result = <ItemUiModel>[];

      final isNumeric = double.tryParse(query) != null;

      if (isNumeric) {
        result = state.list
            .where((a) => a.barcodes
                .where((code) => code?.startsWith(query) == true)
                .isNotEmpty)
            .toList();
      } else {
        result = state.list
            .where((a) =>
                a.productName?.toLowerCase().contains(query.toLowerCase()) ==
                true)
            .toList();
      }

      debugPrint("Manstap ${result[0].barcodes}");

      emit(state.copyWith(searchList: result.toList()));
    }
  }

  bool checkList(ItemUiModel cat, String q) {
    for (int i = 0; i < state.list.length; i++) {
      if (state.list[i].productName?.toLowerCase().contains(q) == true) {
        return true;
      }
    }
    return false;
  }

  void setSelectedIndex(int index) {
    final currSelectedIndexes = List<int>.from(state.selectedIndexes);

    debugPrint("Checked Index => $index");
    final exist = currSelectedIndexes.contains(index);

    if (exist) {
      currSelectedIndexes.remove(index);
    } else {
      currSelectedIndexes.add(index);
    }

    emit(state.copyWith(selectedIndexes: currSelectedIndexes));
  }

  void removeItem(int index) {
    final list = List<ItemUiModel>.from(state.list);
    final currSelectedIndexes = List<int>.from(state.selectedIndexes);

    list.removeAt(index);
    currSelectedIndexes.remove(index);

    emit(
      state.copyWith(
        selectedIndexes: currSelectedIndexes,
        list: list,
      ),
    );
  }

  void setSelectAllProduct(bool value) {
    final selectedIndexes = <int>[];
    if (value) {
      for (var index = 0; index < state.list.length; index++) {
        selectedIndexes.add(index);
      }
    }

    emit(
      state.copyWith(
        selectAllProduct: value,
        selectedIndexes: selectedIndexes,
      ),
    );
  }
}

extension IterableExtension<T> on List<T> {
  Iterable<T> distinctBy(Object Function(T e) getCompareValue) {
    var idSet = <Object>{};
    var distinct = <T>[];
    for (var d in this) {
      if (idSet.add(getCompareValue(d))) {
        distinct.add(d);
      }
    }

    return distinct;
  }
}
