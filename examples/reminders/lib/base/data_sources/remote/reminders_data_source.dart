import '../../models/reminder/reminder_list_response.dart';
import '../../models/reminder/reminder_model.dart';

abstract class RemindersDataSource {
  Future<int> getCompleteCount();

  Future<int> getIncompleteCount();

  Future<ReminderListResponse> getAll(ReminderModelRequest? request);

  Future<ReminderListResponse> getAllDashboard(ReminderModelRequest? request);

  Future<ReminderModel> create({
    required String title,
    required DateTime dueDate,
    required bool complete,
  });

  Future<void> delete(String id);

  Future<ReminderPair> update(ReminderModel updatedModel);
}
