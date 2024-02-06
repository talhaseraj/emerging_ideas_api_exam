import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:emerging_ideas/models/general_response_model.dart';
import 'package:emerging_ideas/models/read_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';

import '../repository/api_repository.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';

part 'user_state.dart';

class UsersBloc extends Bloc<UsersEvent, UserState> {
  UsersBloc() : super(UsersInitial()) {
    final ApiRepository _apiRepository = ApiRepository();

    on<GetUsersList>((event, emit) async {
      try {
        emit(UsersLoading());
        final uList = await _apiRepository.fetchUsersList();
        emit(UsersLoaded(uList));
        if (uList == null) {
          emit(const UsersError("Error"));
        }
      } on NetworkError {
        emit(const UsersError("Failed to fetch data. is your device online?"));
      } catch (e) {
        emit(const UsersError("No Users Availalbe"));
      }
    });
    on<DeleteUser>((event, emit) async {
      try {
        emit(UsersLoading());
        final List<GeneralResponseModel> res =
            await _apiRepository.deleteUser(event.email, event.id);
        if (res.first.message == "successful") {
          Fluttertoast.showToast(
              msg: "User Deleted",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          Fluttertoast.showToast(
              msg: "User Not Deleted",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
        final uList = await _apiRepository.fetchUsersList();

        emit(UsersLoaded(uList));
        if (uList == null) {
          emit(const UsersError("Error"));
        }
      } on NetworkError {
        emit(const UsersError("Failed to fetch data. is your device online?"));
      }
    });

    on<CreateUser>((event, emit) async {
      try {
        emit(UsersLoading());
        final List<GeneralResponseModel> res = await _apiRepository.createUser(
          event.params,
        );
        if (res.first.message == "successful") {
          Fluttertoast.showToast(
              msg: "User Added",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          Fluttertoast.showToast(
              msg: "User Not Added",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }

        final uList = await _apiRepository.fetchUsersList();

        emit(UsersLoaded(uList));
        if (uList == null) {
          emit(const UsersError("Error"));
        }
      } on NetworkError {
        emit(const UsersError("Failed to fetch data. is your device online?"));
      }
    });

    on<EditUser>((event, emit) async {
      try {
        emit(UsersLoading());
        final List<GeneralResponseModel> res =
            await _apiRepository.editUser(event.params, event.id);
        if (res.first.message == "successful") {
          Fluttertoast.showToast(
              msg: "User Updated",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          Fluttertoast.showToast(
              msg: "User Not Updated",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
        final uList = await _apiRepository.fetchUsersList();

        emit(UsersLoaded(uList));
        if (uList == null) {
          emit(const UsersError("Error"));
        }
      } on NetworkError {
        emit(const UsersError("Failed to fetch data. is your device online?"));
      }
    });
  }
}
