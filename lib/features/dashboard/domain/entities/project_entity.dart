// ---------------- PROJECT LIST ENTITY (Pagination) ----------------
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
  final CityEntity? city;
  final String? projectName;
  final String? projectAddress;
  final String? createAt;
  final String? updateAt;
  final int? user;
  final int? province;


  const ProjectEntity({
    this.id,
    this.city,
    this.projectName,
    this.projectAddress,
    this.createAt,
    this.updateAt,
    this.user,
    this.province,
  });
}

class CityEntity {
  final int? id;
  final String? title;
  final String? code;
  final int? province;


  const CityEntity({
    this.id,
    this.title,
    this.code,
    this.province,
  });
}