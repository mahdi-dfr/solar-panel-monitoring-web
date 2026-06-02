class ProjectListEntity {
  final int? count;
  final String? next;
  final String? previous;
  final List<ProjectEntity>? results;


  const ProjectListEntity({
    this.count,
    this.next,
    this.previous,
    this.results,
  });
}


class ProjectEntity {
  final int? id;
  final String? city;
  final String? projectName;
  final String? latitude;
  final String? longitude;
  final String? projectAddress;
  final String? createAt;
  final String? updateAt;
  final int? user;
  final int? province;


  const ProjectEntity({
    this.id,
    this.city,
    this.projectName,
    this.latitude,
    this.longitude,
    this.projectAddress,
    this.createAt,
    this.updateAt,
    this.user,
    this.province,
  });
}

