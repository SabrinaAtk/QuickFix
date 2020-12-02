import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:quickfix/features/grocerylist/domain/list_model.dart';
import 'package:quickfix/features/grocerylist/presentation/task_list.dart';

class AllTasksTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<TodosModel>(
        builder: (context, todos, child) => TaskList(
              tasks: todos.allTasks,
            ),
      ),
    );
  }
}