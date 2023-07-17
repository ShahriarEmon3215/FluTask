class ApiUrl {
  static const String baseUrl = 'http://10.0.3.2:2023/api/';
  static String loginUrl = '${baseUrl}user/login';
  static String registerUrl = '${baseUrl}user/register';
  static String getProjectsByUserId = '${baseUrl}project/getProjectsByUserId/';
  static String getContributions =
      '${baseUrl}collaboration/getCollaborationProjects';
  static String getContributors =
      '${baseUrl}collaboration/getCollaboratorsByProjectId';
  static String getTasksUrl = '${baseUrl}task/getTasks';
  static String getUserByEmail = '${baseUrl}user/getUserByEmail';
  static String createCollaborationUrl =
      '${baseUrl}collaboration/createCollaboration';
}
