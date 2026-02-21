class Task {
  final String id;
  final String title;
  final String description;
  final DateTime dueDate;
  final String status; // 'pending', 'in_progress', 'completed'

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.status,
  });

  // Convert JSON to Task object (for API responses)
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'].toString(),
      title: json['title'],
      description: json['description'] ?? '',
      dueDate: DateTime.parse(json['due_date']),
      status: json['status'],
    );
  }

  // Convert Task object to JSON (for API requests)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'due_date': dueDate.toIso8601String(),
      'status': status,
    };
  }

  // Check if task is overdue
  bool get isOverdue {
    return status != 'completed' && dueDate.isBefore(DateTime.now());
  }

  // Get status color
  String get statusColor {
    switch (status) {
      case 'completed':
        return '#4CAF50'; // Green
      case 'in_progress':
        return '#FF9800'; // Orange
      case 'pending':
        return '#2196F3'; // Blue
      default:
        return '#757575'; // Grey
    }
  }

  // Get status display text
  String get statusText {
    switch (status) {
      case 'in_progress':
        return 'In Progress';
      case 'pending':
        return 'Pending';
      case 'completed':
        return 'Completed';
      default:
        return status;
    }
  }

  // Create a copy of task with updated fields
  Task copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? dueDate,
    String? status,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      status: status ?? this.status,
    );
  }
}