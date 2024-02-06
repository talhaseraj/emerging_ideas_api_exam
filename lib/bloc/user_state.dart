part of 'user_bloc.dart';

@immutable
abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class UsersInitial extends UserState {}

class UsersLoading extends UserState {}

class UsersLoaded extends UserState {
  final List<User> readResponseModel;
  const UsersLoaded(this.readResponseModel);
}

class UsersError extends UserState {
  final String? message;
  const UsersError(this.message);
}
