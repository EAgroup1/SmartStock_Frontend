import 'package:rlbasic/models/lot.dart';
import 'package:rlbasic/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'delivery.g.dart';

/// Una anotación para el auto-generador de código para que sepa que en esta clase
/// necesita generarse lógica de serialización JSON.
@JsonSerializable()
class Delivery {
  @JsonKey(name: 'lotItem')
  Lot lot;
  @JsonKey(name: '_id')
  String id;
  String originLocation;
  String destinationLocation;
  User destinationItem;
  String? deliveryDate;
  bool? isPicked;
  bool? isDelivered;
  bool? isReady;
  User businessItem;
  bool? isAssigned;
  User userItem;
  String? description;
  String? time;
  bool? casa;

  Delivery(
      this.destinationLocation,
      this.destinationItem,
      this.isReady,
      this.isAssigned,
      this.userItem,
      this.lot,
      this.id,
      this.deliveryDate,
      this.businessItem,
      this.description,
      this.originLocation,
      this.isDelivered,
      this.isPicked,
      this.time,
      this.casa);

  /// Un método constructor de tipo factory es necesario para crear una nueva instancia User
  /// desde un mapa. Pasa el mapa al constructor auto-generado `_$UserFromJson()`.
  /// El constructor es nombrado después de la clase fuente, en este caso User.

  ///factory Delivery.fromJson(Map<String, dynamic> json) => _$DeliveryFromJson(json);

  factory Delivery.fromJson(Map<String, dynamic> json) =>
      _$DeliveryFromJson(json);

  /// `toJson` es la convención para una clase declarar que soporta serialización
  /// a JSON. La implementación simplemente llama al método de ayuda privado
  /// `_$UserToJson`.

  Map<String, dynamic> toJson() => _$DeliveryToJson(this);

  /* static Delivery fromJson(Map json) {
    print('dentro');
    print(json['lot']);
    return Delivery(
        lot: Lot.fromJson(json['lot']),
        id: json['id'],
        deliveryDate: json['price'],
        businnessItem: User.fromJson(json['businnessItem']),
        description: json['description']);
  } */
}
