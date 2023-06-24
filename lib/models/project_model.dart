class Project {
  int? id;
  String? projectName;
  String? startDate;
  String? endDate;
  int? userId;
  String? creationDate;

  Project(
      {this.id,
      this.projectName,
      this.startDate,
      this.endDate,
      this.userId,
      this.creationDate});

  Project.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectName = json['project_name'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    userId = json['user_id'];
    creationDate = json['creation_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['project_name'] = this.projectName;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['user_id'] = this.userId;
    data['creation_date'] = this.creationDate;
    return data;
  }
}
