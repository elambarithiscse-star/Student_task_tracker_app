import 'package:flutter/material.dart';
import '../models/task_model.dart';

class DashboardStats extends StatelessWidget {
  final List<Task> tasks;

  const DashboardStats({super.key, required this.tasks});

  int get totalTasks => tasks.length;
  int get completedTasks => tasks.where((t) => t.status == 'completed').length;
  int get pendingTasks => tasks.where((t) => t.status == 'pending').length;
  int get inProgressTasks => tasks.where((t) => t.status == 'in_progress').length;
  int get overdueTasks => tasks.where((t) => t.isOverdue).length;

  double get completionRate {
    if (totalTasks == 0) return 0;
    return (completedTasks / totalTasks) * 100;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        const Text(
          'Overview',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),

        // Progress Card
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Completion Rate',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${completionRate.toStringAsFixed(0)}%',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                LinearProgressIndicator(
                  value: completionRate / 100,
                  backgroundColor: Colors.grey[200],
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(4),
                ),
                const SizedBox(height: 8),
                Text(
                  '$completedTasks of $totalTasks tasks completed',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Stats Grid
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 1.5,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          children: [
            _buildStatCard(
              context,
              title: 'Total Tasks',
              value: totalTasks.toString(),
              icon: Icons.list_alt,
              color: Colors.blue,
            ),
            _buildStatCard(
              context,
              title: 'Completed',
              value: completedTasks.toString(),
              icon: Icons.check_circle,
              color: Colors.green,
            ),
            _buildStatCard(
              context,
              title: 'In Progress',
              value: inProgressTasks.toString(),
              icon: Icons.pending,
              color: Colors.orange,
            ),
            _buildStatCard(
              context,
              title: 'Overdue',
              value: overdueTasks.toString(),
              icon: Icons.warning,
              color: Colors.red,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, color: color, size: 28),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
