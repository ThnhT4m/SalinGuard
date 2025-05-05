import 'package:sagu/models/index_model.dart';

class IndexDetails {
  final List<IndexModel> indexData;

  IndexDetails({required this.indexData});

  factory IndexDetails.fromSensorData(Map<String, dynamic> data) {
    return IndexDetails(
      indexData: [
        IndexModel(icon: '', value: data['pH'].toString(), title: "pH Level"),
        IndexModel(icon: '', value: data['EC'].toString(), title: "Salinity"),
        IndexModel(
          icon: '',
          value: data['Temp'].toString(),
          title: "Temperature",
        ),
        IndexModel(
          icon: '',
          value: data['Turbidity']?.toString() ?? '-',
          title: "Turbidity",
        ),
      ],
    );
  }
}
