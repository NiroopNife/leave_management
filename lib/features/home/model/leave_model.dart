class LeaveModel {
  final String userName;
  final String replacementName;
  final DateTime appliedLeaveOn;
  final DateTime leaveDate;

  LeaveModel({
    required this.userName,
    required this.replacementName,
    required this.appliedLeaveOn,
    required this.leaveDate,
  });

  LeaveModel copyWith({
    String? userName,
    String? replacementName,
    DateTime? appliedLeaveOn,
    DateTime? leaveDate,
  }) {
    return LeaveModel(
      userName: userName ?? this.userName,
      replacementName: replacementName ?? this.replacementName,
      appliedLeaveOn: appliedLeaveOn ?? this.appliedLeaveOn,
      leaveDate: leaveDate ?? this.leaveDate,
    );
  }
}
