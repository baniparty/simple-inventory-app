List<Map<String, dynamic>> convertCsvToJson(String csvData) {
  final lines = csvData.split('\n');
  final result = <Map<String, dynamic>>[];
  String? currentCompany;

  for (int i = 1; i < lines.length; i++) { // Skip header
    final line = lines[i].trim();
    if (line.isEmpty) continue;

    final parts = line.split(',').map((e) => e.trim()).toList();
    
    // Handle perusahaan
    if (parts[0].isNotEmpty) {
      currentCompany = parts[0];
      result.add({
        'NAMA PERUSAHAAN': currentCompany,
        'BARCODE': [parts[4]]
      });
    } 
    // Handle barcode untuk perusahaan yang sama
    else if (currentCompany != null && parts[4].isNotEmpty) {
      final lastCompany = result.lastWhere(
        (e) => e['NAMA PERUSAHAAN'] == currentCompany,
      );
      lastCompany['BARCODE'].add(parts[4]);
    }
  }

  return result;
}