import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  bool isSelectAll = false;
  List<bool> selectedProducts =
      List.generate(products.length, (index) => false);

  void toggleSelectAll(bool? value) {
    setState(() {
      isSelectAll = value ?? false;
      selectedProducts = List.generate(products.length, (index) => isSelectAll);
    });
  }

  void toggleProduct(int index) {
    setState(() {
      selectedProducts[index] = !selectedProducts[index];
      isSelectAll = selectedProducts.every((selected) => selected);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 16),

              //Button upload file
              SizedBox(
                height: 44,
                child: TextButton.icon(
                  onPressed: () {},
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
                    value: isSelectAll,
                    activeColor: const Color(0xFF0B8F47),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                    onChanged: toggleSelectAll,
                  ),
                  const Text('Pilih Semua', style: TextStyle(fontSize: 14)),
                  const Spacer(),
                  Text('${products.length} produk terdeteksi',
                      style: const TextStyle(fontSize: 14, color: Colors.grey)),
                  const SizedBox(width: 20),
                ],
              ),

              const SizedBox(height: 8),

              //Product list
              Column(
                children: List.generate(products.length, (index) {
                  return ProductItem(
                    company: products[index]["company"],
                    name: products[index]["name"],
                    categories:
                        List<String>.from(products[index]["categories"]),
                    codes: List<String>.from(products[index]["codes"]),
                    isSelected: selectedProducts[index],
                    onToggle: () => toggleProduct(index),
                  );
                }),
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
        ),
      )),
    );
  }
}
