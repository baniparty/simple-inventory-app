class ItemUiModel {
  String? companyName;
  String? productName;
  String? category;
  String? subCategory;
  String? barcode;
  List<String?> barcodes = [];

  ItemUiModel({
    this.companyName,
    this.productName,
    this.category,
    this.subCategory,
    this.barcode,
  });

  ItemUiModel.fromJson(Map<String, dynamic> json) {
    companyName = json['NAMA PERUSHAAAN'];
    productName = json['NAMA PRODUK'];
    category = json['KATEGORI'];
    subCategory = json['SUB KATEGORI'];
    barcode = json['BARCODE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['NAMA PERUSHAAAN'] = companyName;
    data['NAMA PRODUK'] = productName;
    data['KATEGORI'] = category;
    data['SUB KATEGORI'] = subCategory;
    data['BARCODE'] = barcode;
    return data;
  }
}
