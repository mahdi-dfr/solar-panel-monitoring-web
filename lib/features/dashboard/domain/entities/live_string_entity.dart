class LiveProjectEntity {
  final int projectId;
  final List<LiveBoardEntity> boards;

  const LiveProjectEntity({
    required this.projectId,
    required this.boards,
  });
}


class LiveBoardEntity {
  final int boardId;
  final String boardName;
  final List<LiveStringEntity> strings;

  const LiveBoardEntity({
    required this.boardId,
    required this.boardName,
    required this.strings,
  });
}


class LiveStringEntity {
  final int stringId;
  final String name;
  final int voltage;
  final int current;
  final double power;
  final double energy;

  const LiveStringEntity({
    required this.stringId,
    required this.name,
    required this.voltage,
    required this.current,
    required this.power,
    required this.energy,
  });
}