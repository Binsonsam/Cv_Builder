class ResumeModel {
  String fullName;
  String title;
  String email;
  String phone;
  String location;
  String summary;

  List<String> skills;
  List<EducationModel> education;
  List<String> experience;
  List<String> languages;

  List<ProjectModel> projects;

  ResumeModel({
    required this.fullName,
    required this.title,
    required this.email,
    required this.phone,
    required this.location,
    required this.summary,
    required this.skills,
    required this.education,
    required this.experience,
    required this.languages,
    required this.projects,
  });
}

class EducationModel {
  final String title;
  final String year;

  EducationModel({
    required this.title,
    required this.year,
  });
  Map<String, dynamic> toJson() => {
    'title': title,
    'year': year,
  };

  factory EducationModel.fromJson(Map<String, dynamic> json) {
    return EducationModel(
      title: json['title'] ?? '',
      year: json['year'] ?? '',
    );
  }
}

class ProjectModel {
  String title;
  String tech;
  String githubLink;
  String liveLink;
  List<String> points;

  ProjectModel({
    required this.title,
    required this.tech,
    this.githubLink = "",
    this.liveLink = "",
    required this.points,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'tech': tech,
      'githubLink': githubLink,
      'liveLink': liveLink,
      'points': points,
    };
  }

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      title: json['title'] ?? '',
      tech: json['tech'] ?? '',
      githubLink: json['githubLink'] ?? '',
      liveLink: json['liveLink'] ?? '',
      points: List<String>.from(json['points'] ?? []),
    );
  }
}
