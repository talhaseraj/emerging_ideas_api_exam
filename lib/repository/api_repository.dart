import '../services/api_service.dart';

class ApiRepository {
  final _provider = ApiService();
  Future createUser(Map<String, String> params) {
    return _provider.createUser(params);
  }

  Future editUser(Map<String, String> params, id) {
    return _provider.editUser(params, id);
  }

  Future fetchUsersList() {
    return _provider.readUsers();
  }

  Future deleteUser(email, id) {
    return _provider.deleteUser(email, id);
  }
}

class NetworkError extends Error {}
