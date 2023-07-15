class CollaborationRequestModel {
  int? projectId;
  int? userId;
  String? addedDate;

  CollaborationRequestModel({this.projectId, this.userId, this.addedDate});

  CollaborationRequestModel.fromJson(Map<String, dynamic> json) {
    projectId = json['project_id'];
    userId = json['user_id'];
    addedDate = json['added_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['project_id'] = this.projectId;
    data['user_id'] = this.userId;
    data['added_date'] = this.addedDate;
    return data;
  }
}