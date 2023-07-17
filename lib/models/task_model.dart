class Task {
  int? id;
  String? taskName;
  int? projectId;
  String? startDate;
  String? endDate;
  String? creationDate;

  Task(
      {this.id,
      this.taskName,
      this.projectId,
      this.startDate,
      this.endDate,
      this.creationDate});

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    taskName = json['task_name'];
    projectId = json['project_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    creationDate = json['creation_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['task_name'] = this.taskName;
    data['project_id'] = this.projectId;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['creation_date'] = this.creationDate;
    return data;
  }
}