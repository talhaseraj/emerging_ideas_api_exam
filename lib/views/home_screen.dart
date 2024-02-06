import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'dart:convert' show utf8;

import '../bloc/user_bloc.dart';
import 'create_edit_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UsersBloc usersBloc = UsersBloc();

  bool connected = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    usersBloc.add(GetUsersList());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocBuilder<UsersBloc, UserState>(
        bloc: UsersBloc(), // provide the local bloc instance

        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Users"),
            ),
            body: SafeArea(
              child: Container(
                color: Colors.white,
                width: size.width,
                height: size.height,
                child: buildUsersList(size),
              ),
            ),
            floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CreateEditScreen(title: "Create User")),
                  ).then((params) {
                    if (params == null) {
                      return;
                    }
                    usersBloc.add(CreateUser(params));
                  });
                }),
          );
          // return widget here based on BlocA's state
        });
  }

  Widget buildUsersList(Size size) {
    return BlocProvider(
      create: (_) => usersBloc,
      child: BlocListener<UsersBloc, UserState>(
        listener: (context, state) {
          if (state is UsersError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message!),
              ),
            );
          }
        },
        child: BlocBuilder<UsersBloc, UserState>(
          builder: (context, state) {
            if (state is UsersInitial) {
              return _buildLoading();
            } else if (state is UsersLoading) {
              return _buildLoading();
            } else if (state is UsersLoaded) {
              final users = state.readResponseModel;

              return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          12,
                        ),
                        side: const BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CachedNetworkImage(
                          imageUrl: user.imgLink,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      title: Text(user.title),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(user.email),
                          Text(
                            user.description,
                          )
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () async {
                                usersBloc.add(DeleteUser(user.email, user.id));
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              )),
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CreateEditScreen(
                                            title: "Edit User",
                                            user: user,
                                          )),
                                ).then((params) {
                                  if (params == null) {
                                    return;
                                  }
                                  usersBloc.add(EditUser(params, user.id));
                                });
                              },
                              icon: const Icon(
                                Icons.edit,
                              )),
                        ],
                      ),
                    );
                  });
            } else if (state is UsersError) {
              return const Center(child: Text("No Users"));
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
