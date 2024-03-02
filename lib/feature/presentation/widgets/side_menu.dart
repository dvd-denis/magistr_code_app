import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magistr_code/feature/domain/entities/teacher_groups_entity.dart';
import 'package:magistr_code/feature/domain/entities/user_entity.dart';
import 'package:magistr_code/feature/domain/usecases/user.dart';
import 'package:magistr_code/feature/presentation/bloc/teacher_groups_cubut/teacher_groups_cubit.dart';
import 'package:magistr_code/feature/presentation/bloc/teacher_groups_cubut/teacher_groups_state.dart';
import 'package:magistr_code/feature/presentation/pages/group_screen.dart';
import 'package:magistr_code/feature/presentation/pages/profile_screen.dart';
import 'package:magistr_code/locator_service.dart' as di;

class SideMenu extends StatelessWidget {
  final UserEntity user;

  SideMenu({super.key, required this.user});

  final Exit exit = di.sl<Exit>();

  Future<void> _exit() async {
    await exit(());
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TeacherGroupsCubit>(context).load(user.token);

    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _header(context),
            _items(context),
          ],
        ),
      ),
    );
  }

  _header(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Column(
        children: [
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(0),
              child: CircleAvatar(
                backgroundColor: const Color.fromRGBO(144, 64, 245, 1.0),
                radius: 25,
                backgroundImage: Image.asset('assets/icons/profile.png').image,
              ),
            ),
            subtitle: Text(
              "${user.name} ${user.middleName}",
              style: const TextStyle(fontSize: 16),
            ),
            title: const Text(
              "Учитель",
              style: TextStyle(fontSize: 12),
            ),
            onTap: () {
              Navigator.of(context).popAndPushNamed("/profile",
                  arguments: ProfileArguments(user: user));
            },
          ),
          const Divider(
            height: 20,
            indent: 20,
            endIndent: 20,
            thickness: 2,
          ),
        ],
      ),
    );
  }

  _items(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Wrap(
        runSpacing: 2,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              "Главная".toUpperCase(),
              style: const TextStyle(color: Color.fromRGBO(144, 64, 245, 1.0)),
            ),
          ),
          ListTile(
            title: const Text("Все группы"),
            leading: Image.asset(
              "assets/icons/profile_sidebar.png",
              color: const Color.fromRGBO(144, 64, 245, 1.0),
            ),
            onTap: () {
              Navigator.of(context).popAndPushNamed("/main", arguments: user);
            },
          ),
          BlocBuilder<TeacherGroupsCubit, TeacherGroupsState>(
            builder: (context, state) {
              List<TeacherGroupsEntity> teacherGroups = [];

              if (state is TeacherGroupsLoading && state.isFisrtFetch) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                );
              } else if (state is TeacherGroupsLoading) {
                teacherGroups = state.oldTeacherGroups;
              } else if (state is TeacherGroupsLoaded) {
                teacherGroups = state.teacherGroups;
              }

              return Column(
                children: List.generate(
                  teacherGroups.length,
                  (index) {
                    final branch = teacherGroups[index];

                    return Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        title: Text(branch.name),
                        leading: Image.asset(
                          "assets/icons/branch_sidebar.png",
                          color: const Color.fromRGBO(144, 64, 245, 1.0),
                        ),
                        children: List.generate(branch.groups.length, (index) {
                          final group = branch.groups[index];
                          return Container(
                            padding: const EdgeInsets.all(5),
                            child: ListTile(
                              title: Text(group.name),
                              leading: const Icon(
                                Icons.adjust,
                                color: Color.fromRGBO(144, 64, 245, 1.0),
                              ),
                              onTap: () {
                                Navigator.of(context).pop();

                                Navigator.of(context).pushNamed("/group",
                                    arguments: GroupArguments(
                                        user: user, groupId: group.id));
                              },
                            ),
                          );
                        }),
                      ),
                    );
                  },
                ),
              );
            },
          ),
          const Divider(
            height: 20,
            indent: 20,
            endIndent: 20,
            thickness: 2,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              "Task Manager".toUpperCase(),
              style: const TextStyle(color: Color.fromRGBO(144, 64, 245, 1.0)),
            ),
          ),
          Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              title: const Text("Проекты"),
              leading: Image.asset(
                "assets/icons/task_sidebar.png",
                color: const Color.fromRGBO(144, 64, 245, 1.0),
              ),
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  child: ListTile(
                    title: const Text("В разработке"),
                    leading: const Icon(
                      Icons.adjust,
                      color: Color.fromRGBO(144, 64, 245, 1.0),
                    ),
                    onTap: () {},
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 40),
            child: ListTile(
              title: const Text(
                "Выйти",
                style: TextStyle(
                  color: Color.fromRGBO(144, 64, 245, 1.0),
                ),
              ),
              leading: Image.asset(
                "assets/icons/exit_sidebar.png",
                color: const Color.fromRGBO(144, 64, 245, 1.0),
              ),
              onTap: () {
                _exit();
                Navigator.of(context).pop();

                Navigator.of(context).pushNamed("/login");
              },
            ),
          ),
        ],
      ),
    );
  }
}
