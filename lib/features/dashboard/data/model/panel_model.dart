import '../../domain/entities/panels_entity.dart';

class PanelModel extends PanelEntity {
  PanelModel({
    required super.id,
    required super.panelName,
    required super.boardId,
    required super.voltage,
    required super.createAt,
    required super.updateAt,
    required super.project,
  });

  factory PanelModel.fromJson(Map<String, dynamic> json) {
    return PanelModel(
      id: json['id'],
      panelName: json['panel_name'],
      boardId: json['board_id'],
      voltage: json['volatge'],
      createAt: json['create_at'],
      updateAt: json['update_at'],
      project: json['project'],
    );
  }
}


class PanelListModel extends PanelListEntity {
  PanelListModel({
    required super.count,
    required super.next,
    required super.previous,
    required super.results,
  });

  factory PanelListModel.fromJson(Map<String, dynamic> json) {
    return PanelListModel(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: List<PanelModel>.from(
        json['results'].map((e) => PanelModel.fromJson(e)),
      ),
    );
  }
}
