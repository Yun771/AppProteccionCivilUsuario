import 'dart:convert';

CardModel cardModelFromJson(String str) => CardModel.fromJson(json.decode(str));

String cardModelToJson(CardModel data) => json.encode(data.toJson());

class CardModel {
  CardModel({
    this.id,
    this.titulo,
    this.fecha,
    this.descripcion,
  });

  String id;
  String titulo;
  String fecha;
  String descripcion;

  factory CardModel.fromJson(Map<String, dynamic> json) => CardModel(
        id: json["id"],
        titulo: json["titulo"],
        fecha: json["fecha"],
        descripcion: json["descripcion"],
      );

  Map<String, dynamic> toJson() => {
        // "id": id,
        "titulo": titulo,
        "fecha": fecha,
        "descripcion": descripcion,
      };
}
