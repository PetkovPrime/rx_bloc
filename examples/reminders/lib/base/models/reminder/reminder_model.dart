import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rx_bloc_list/models.dart';

enum ReminderModelRequestSort {
  dueDateDesc,
  dueDateAsc,
}

class DueDateRange {
  DueDateRange({
    required this.from,
    required this.to,
  });

  final DateTime from;
  final DateTime to;
}

class ReminderModelRequest {
  ReminderModelRequest({
    this.filterByDueDateRange,
    this.sort,
    this.page = 0,
    this.pageSize = 50,
  });

  final DueDateRange? filterByDueDateRange;
  final ReminderModelRequestSort? sort;
  final int page;
  final int pageSize;
}

class ReminderModel implements Identifiable {
  ReminderModel({
    required this.id,
    required this.title,
    required this.dueDate,
    required this.complete,
  });

  @override
  final String id;
  final String title;
  final DateTime dueDate;
  final bool complete;

  factory ReminderModel.fromIndex(int index) => ReminderModel(
        id: index.toString(),
        title: 'Reminder $index',
        complete: false,
        dueDate: DateTime.now()
            .subtract(
              const Duration(days: 100),
            )
            .add(
              Duration(days: index),
            ),
      );

  ReminderModel copyWith({
    String? title,
    DateTime? dueDate,
    bool? complete,
  }) =>
      ReminderModel(
        id: id,
        title: title ?? this.title,
        dueDate: dueDate ?? this.dueDate,
        complete: complete ?? this.complete,
      );

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'title': title,
      'dueDate': dueDate,
      'complete': complete,
    };
  }

  ReminderModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'] as String,
          title: json['title'] as String,
          dueDate: (json['dueDate'] as Timestamp).toDate(),
          complete: json['complete'] as bool,
        );
}
