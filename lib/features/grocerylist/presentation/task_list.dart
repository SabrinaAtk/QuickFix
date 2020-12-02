import 'package:flutter/material.dart';

import 'package:quickfix/features/grocerylist/domain/task.dart';
import 'package:quickfix/features/grocerylist/presentation/list_item.dart';

class TaskList extends StatelessWidget {
  final List<Task> tasks;

  TaskList({@required this.tasks});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: getChildrenTasks(),
    );
  }

  List<Widget> getChildrenTasks() {
    return tasks.map((todo) => TaskListItem(task: todo)).toList();
  }
}