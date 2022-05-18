class StadisticsModel {
  StadisticsModel({
    required this.prestado,
    required this.utilidad,
    required this.gastos,
    required this.faltante,
    required this.crecimiento,
  });

  double prestado;
  double utilidad;
  double gastos;
  double faltante;
  double crecimiento;

  factory StadisticsModel.fromJson(Map<String, dynamic> json) => StadisticsModel(
        prestado: json["prestado"].toDouble(),
        utilidad: json["utilidad"].toDouble(),
        gastos: json["gastos"].toDouble(),
        faltante: json["faltante"].toDouble(),
        crecimiento: json["crecimiento"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "prestado": prestado,
        "utilidad": utilidad,
        "gastos": gastos,
        "faltante": faltante,
        "crecimiento": crecimiento,
      };
}
