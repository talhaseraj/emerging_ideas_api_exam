part of 'user_bloc.dart';

@immutable
abstract class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object> get props => [];
}

class GetUsersList extends UsersEvent {}

class DeleteUser extends UsersEvent {
  final email, id;
  const DeleteUser(this.email, this.id);
}

class CreateUser extends UsersEvent {
  final Map<String, String> params;
  const CreateUser(this.params);
}

class EditUser extends UsersEvent {
  final Map<String, String> params;
  final id;
  const EditUser(this.params, this.id);
}
