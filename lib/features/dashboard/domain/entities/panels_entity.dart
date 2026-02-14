class PanelEntity {
  final int id;
  final String panelName;
  final int boardId;
  final int voltage;
  final String createAt;
  final String updateAt;
  final int project;

  PanelEntity({
    required this.id,
    required this.panelName,
    required this.boardId,
    required this.voltage,
    required this.createAt,
    required this.updateAt,
    required this.project,
  });
}


class PanelListEntity {
  final int count;
  final String? next;
  final String? previous;
  final List<PanelEntity> results;

  PanelListEntity({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });
}
