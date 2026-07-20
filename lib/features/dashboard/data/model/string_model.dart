//
//
// import '../../domain/entities/string_entity.dart';
//
// class StringLiveModel extends StringLiveEntity {
//
//   const StringLiveModel({
//     required super.stringId,
//     required super.name,
//     required super.voltage,
//     required super.current,
//     required super.power,
//     required super.energy,
//   });
//
//   factory StringLiveModel.fromJson(
//       Map<String,dynamic> json,
//       ) {
//     return StringLiveModel(
//       stringId: json['string_id'],
//       name: json['name'],
//       voltage: json['voltage'],
//       current: json['current'],
//       power: (json['power'] ?? 0).toDouble(),
//       energy: (json['energy'] ?? 0).toDouble(),
//     );
//   }
// }