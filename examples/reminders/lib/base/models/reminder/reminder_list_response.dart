import 'reminder_model.dart';

class ReminderListResponse {
  ReminderListResponse({
    required this.items,
    this.totalCount,
  });

  final List<ReminderModel> items;
  final int? totalCount;
}
