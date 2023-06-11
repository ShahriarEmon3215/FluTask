class ApiUrl {
  static const String baseUrl = 'http://10.0.2.2:2023/api/';
  static String loginUrl = '${baseUrl}user/login';
  static String registerUrl = '${baseUrl}user/register';
  static String getProjectsByUserId = '${baseUrl}project/getProjectsByUserId/';
}
