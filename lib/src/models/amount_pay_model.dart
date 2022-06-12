class AmountToPayModel {
  AmountToPayModel({
    required this.mora,
    required this.moraAplicada,
    required this.delay,
    required this.organico,
    required this.total,
  });

  double mora;
  double moraAplicada;
  int delay;
  double organico;
  double total;

  factory AmountToPayModel.fromJson(Map<String, dynamic> json) => AmountToPayModel(
        mora: json["mora"].toDouble(),
        moraAplicada: json["mora_aplicada"].toDouble(),
        delay: json["delay"],
        organico: json["organico"].toDouble(),
        total: json["total"].toDouble(),
      );
}
