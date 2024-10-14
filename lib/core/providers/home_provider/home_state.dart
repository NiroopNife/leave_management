import 'package:leave_management/features/home/model/leave_model.dart';

class HomeState {
  final DateTime focusedDay;
  final DateTime? selectedDay;
  final Map<DateTime, List<LeaveModel>> leaves;
  final String selectedUser;
  final List<LeaveModel> selectedLeaves;

  HomeState({
    required this.focusedDay,
    this.selectedDay,
    required this.leaves,
    required this.selectedUser,
    required this.selectedLeaves,
  });

  HomeState copyWith({
    DateTime? focusedDay,
    DateTime? selectedDay,
    Map<DateTime, List<LeaveModel>>? leaves,
    String? selectedUser,
    List<LeaveModel>? selectedLeaves,
  }) {
    return HomeState(
      focusedDay: focusedDay ?? this.focusedDay,
      selectedDay: selectedDay ?? this.selectedDay,
      leaves: leaves ?? this.leaves,
      selectedUser: selectedUser ?? this.selectedUser,
      selectedLeaves: selectedLeaves ?? this.selectedLeaves,
    );
  }
}
