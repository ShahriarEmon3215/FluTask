class Task {
  int? id;
  String? taskName;
  int? projectId;
  int? userId;
  String? creationDate;
  String? username;
  String? status;
  String? collaborationDate;

  Task(
      {this.id,
      this.taskName,
      this.projectId,
      this.userId,
      this.creationDate,
      this.username,
      this.status,
      this.collaborationDate});

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    taskName = json['task_name'];
    projectId = json['project_id'];
    userId = json['user_id'];
    creationDate = json['creation_date'];
    username = json['username'];
    status = json['status'];
    collaborationDate = json['collaboration_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['task_name'] = this.taskName;
    data['project_id'] = this.projectId;
    data['user_id'] = this.userId;
    data['creation_date'] = this.creationDate;
    data['username'] = this.username;
    data['status'] = this.status;
    data['collaboration_date'] = this.collaborationDate;
    return data;
  }
}