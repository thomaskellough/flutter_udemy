import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/models/task_data.dart';
import 'package:todoey_flutter/widgets/tasks_tile.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final task = taskData.tasks[index];
            return TaskTile(
              isChecked: task.isDone,
              taskTitle: task.name,
              checkboxCallback: (bool checkboxState) {
                taskData.updateTask(task: task);
              },
              longPressCallback: () {
                print(task.name);
                print('Tapped long press');
                taskData.deleteTask(task: task);
              },
            );
          },
          itemCount: taskData.taskCount,
        );
      },
    );
  }
}
