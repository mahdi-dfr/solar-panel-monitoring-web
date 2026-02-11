import '../../domain/entities/project_entity.dart';

class ProjectListModel extends ProjectListEntity {
  ProjectListModel({
    required super.count,
    required super.next,
    required super.previous,
    required super.results,
  });

  factory ProjectListModel.fromJson(Map<String, dynamic> json) => ProjectListModel(
    count: json['count'],
    next: json['next'],
    previous: json['previous'],
    results: json['results'] != null
        ? List<ProjectModel>.from(json['results'].map((v) => ProjectModel.fromJson(v)))
        : null,
  );
}

class ProjectModel extends ProjectEntity {
  const ProjectModel({
    super.id,
    CityModel? city,
    super.projectName,
    super.projectAddress,
    super.createAt,
    super.updateAt,
    super.user,
    super.province,
  }) : super(city: city);


  factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
    id: json['id'],
    city: json['city'] != null ? CityModel.fromJson(json['city']) : null,
    projectName: json['project_name'],
    projectAddress: json['project_address'],
    createAt: json['create_at'],
    updateAt: json['update_at'],
    user: json['user'],
    province: json['province'],
  );
}

class CityModel extends CityEntity {
  const CityModel({
    super.id,
    super.title,
    super.code,
    super.province,
  });


  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
    id: json['id'],
    title: json['title'],
    code: json['code'],
    province: json['province'],
  );
}
