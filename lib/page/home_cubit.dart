import 'dart:convert';
import 'dart:io';

import 'package:csv2json/csv2json.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
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

      final seen = <ItemUiModel>{};
      final uniqueList =
          scrapingList.where((entity) => seen.add(entity)).toList();
      emit(state.copyWith(list: uniqueList));
    } else {
      // User canceled the picker
    }
  }
}
