class PanelUiModel {
  final int id;
  final String name;
  final int boardId;

  double voltage;
  double current;
  double radiance;
  bool isOn;

  PanelUiModel({
    required this.id,
    required this.name,
    required this.boardId,
    this.voltage = 0,
    this.current = 0,
    this.radiance = 0,
    this.isOn = false,
  });
}
