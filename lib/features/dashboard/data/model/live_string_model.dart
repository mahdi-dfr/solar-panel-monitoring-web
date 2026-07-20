import '../../domain/entities/live_string_entity.dart';

class LiveProjectModel extends LiveProjectEntity {
  const LiveProjectModel({
    required super.projectId,
    required super.boards,
  });

  factory LiveProjectModel.fromJson(Map<String, dynamic> json) {
    return LiveProjectModel(
      projectId: json['project_id'],
      boards: (json['boards'] as List)
          .map((e) => LiveBoardModel.fromJson(e))
          .toList(),
    );
  }
}


class LiveBoardModel extends LiveBoardEntity {
  const LiveBoardModel({
    required super.boardId,
    required super.boardName,
    required super.strings,
  });

  factory LiveBoardModel.fromJson(Map<String, dynamic> json) {
    return LiveBoardModel(
      boardId: json['board_id'],
      boardName: json['board_name'],
      strings: (json['strings'] as List)
          .map((e) => LiveStringModel.fromJson(e))
          .toList(),
    );
  }
}

class LiveStringModel extends LiveStringEntity {
  const LiveStringModel({
    required super.stringId,
    required super.name,
    required super.voltage,
    required super.current,
    required super.power,
    required super.energy,
  });

  factory LiveStringModel.fromJson(Map<String, dynamic> json) {
    return LiveStringModel(
      stringId: json['string_id'],
      name: json['name'],
      voltage: json['voltage'],
      current: json['current'],
      power: (json['power'] as num).toDouble(),
      energy: (json['energy'] as num).toDouble(),
    );
  }
}