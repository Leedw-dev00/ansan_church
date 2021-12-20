class ProgressChart {
  String id;
  String date; // 날짜
  String content2; // 신약
  String footnote;
  String lifeStudy = "";
  String lifeStudyAll = "";
  String lifeStudyAll2 = "";
  String pDate = "0";
  String progressChartCol = "0";

  ProgressChart({
    required this.id,
    required this.date,
    required this.content2,
    required this.footnote,
    this.lifeStudy = "",
    this.lifeStudyAll = "",
    this.lifeStudyAll2 = "",
    this.pDate = "0",
    this.progressChartCol = "0",
  });

  factory ProgressChart.fromJson(Map<String, dynamic> json) {
    return ProgressChart(
      id: json['id'] as String,
      date: json['date'] as String,
      content2: json['content2'] as String,
      footnote: json['footnote'] as String,
      lifeStudy: json['lifestudy'] == null ? "" : json['lifestudy'] as String,
      lifeStudyAll:
          json['lifestudy_all'] == null ? "" : json['lifestudy_all'] as String,
      lifeStudyAll2:
      json['lifestudy_all2'] == null ? "" : json['lifestudy_all2'] as String,
      pDate: json['pdate'] == null ? "" : json['pdate'] as String,
      progressChartCol: json['progress_chartcol'] == null
          ? ""
          : json['progress_chartcol'] as String,
    );
  }
}
