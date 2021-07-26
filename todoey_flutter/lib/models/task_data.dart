import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todoey_flutter/models/task.dart';

class TaskData extends ChangeNotifier {
  List<Task> _tasks = [
    Task(name: "Buy milk"),
    Task(name: "Buy eggs"),
    Task(name: "Buy bread"),
  ];

  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  int get taskCount {
    return _tasks.length;
  }

  void addTask({required String taskName}) {
    _tasks.add(Task(name: taskName));
    notifyListeners();
  }

  void deleteTask({required Task task}) {
    _tasks.remove(task);
    notifyListeners();
  }

  void updateTask({required Task task}) {
    task.toggleDone();
    notifyListeners();
  }
}