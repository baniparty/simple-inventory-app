import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inventory_app/page/home_cubit.dart';
import 'package:inventory_app/widget/product_item.dart';

List<Map<String, dynamic>> products = [
  {
    "company": "PT ABC President Indonesia",
    "name": "Mie Abc",
    "categories": ["Bumbu Dapur", "Mie Instant"],
    "codes": [
      "123456789012",
      "987654321098",
      "456789123456",
      "321654987012",
      "654321789654"
    ]
  },
  {
    "company": "PT XYZ Makanan Sehat",
    "name": "Mie Kelapa",
    "categories": ["Bumbu Dapur", "Mie Pedas"],
    "codes": ["987654321012", "123456789098"]
  },
  {
    "company": "CV Makanan Sehat Alami",
    "name": "Soto Kelapa",
    "categories": ["Bumbu Masak", "Mie Pedas Manis"],
    "codes": ["123456789012", "987654321098", "456789012345"]
  },
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final cubit = HomeCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
        return Scaffold(
          body: SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 16),

                //Button upload file
                SizedBox(
                  height: 44,
                  child: TextButton.icon(
                    onPressed: () {
                      cubit.openFile();
                    },
                    label: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/icons/ic_upload.svg'),
                        const Text('Upload File',
                            style: TextStyle(color: Colors.white, fontSize: 16))
                      ],
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          const WidgetStatePropertyAll(Color(0xFF0B8F47)),
                      shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                //Field search data
                SizedBox(
                  height: 44,
                  child: TextField(
                    onChanged: (text) {
                      cubit.search(text);
                    },
                    decoration: InputDecoration(
                      hintText: 'Cari Data',
                      hintStyle:
                          const TextStyle(color: Colors.grey, fontSize: 14),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(12),
                        child: SvgPicture.asset('assets/icons/ic_search.svg'),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                            color: (Color(0xFF0B8F47)), width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                            color: (Color(0xFF0B8F47)), width: 1),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                //Select all and product count detected
                Row(
                  children: [
                    Checkbox(
                      value: state.selectAllProduct,
                      activeColor: const Color(0xFF0B8F47),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      onChanged: (value) {
                        cubit.setSelectAllProduct(value == true);
                      },
                    ),
                    const Text('Pilih Semua', style: TextStyle(fontSize: 14)),
                    const Spacer(),
                    Text('${state.list.length} produk terdeteksi',
                        style:
                            const TextStyle(fontSize: 14, color: Colors.grey)),
                    const SizedBox(width: 20),
                  ],
                ),

                const SizedBox(height: 8),

                //Product list
                Expanded(
                  child: ListView.builder(
                    itemCount: state.searchList == null
                        ? state.list.length
                        : state.searchList?.length,
                    itemBuilder: (_, index) {
                      final list = state.searchList ?? state.list;
                      return ProductItem(
                        company: list[index].companyName ?? '',
                        name: list[index].productName ?? '',
                        categories: List<String>.from(
                            [list[index].category, list[index].subCategory]),
                        codes: list[index].barcodes.map((e) => e ?? '').toList(),
                        isSelected: state.selectedIndexes.contains(index),
                        onToggle: () {
                          cubit.setSelectedIndex(index);
                        },
                        onRemovedTap: () {
                          cubit.removeItem(index);
                        },
                      );
                    },
                  ),
                ),

                const SizedBox(height: 24),

                //Submit button
                SizedBox(
                  height: 44,
                  width: 144,
                  child: TextButton.icon(
                    onPressed: () {},
                    label: const Text('SUBMIT',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                    style: ButtonStyle(
                      backgroundColor:
                          const WidgetStatePropertyAll(Color(0xFF0B8F47)),
                      shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),
              ],
            ),
          )),
        );
      }),
    );
  }
}
