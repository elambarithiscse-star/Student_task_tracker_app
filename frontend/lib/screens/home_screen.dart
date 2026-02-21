import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../widgets/task_card.dart';
import '../widgets/dashboard_stats.dart';
import '../service/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  bool _isLoading = false;
  String _selectedFilter = 'All';

  // TODO: This will be replaced with actual data from API
  List<Task> _tasks = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final navigator = Navigator.of(context);
              await ApiService.logout();
              if (!mounted) return;
              navigator.pop();
              navigator.pushReplacementNamed('/login');
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  void _refreshTasks() async {
    setState(() {
      _isLoading = true;
    });

    final result = await ApiService.getTasks();

    if (mounted) {
      setState(() {
        _isLoading = false;
        if (result['success']) {
          _tasks = result['tasks'];
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(result['message'] ?? 'Failed to load tasks')),
          );
        }
      });
    }
  }

  List<Task> _getFilteredTasks() {
    if (_selectedFilter == 'All') {
      return _tasks;
    }
    return _tasks.where((task) => task.status == _selectedFilter.toLowerCase()).toList();
  }

  void _deleteTask(String taskId) async {
    final result = await ApiService.deleteTask(taskId);
    
    if (result['success']) {
      setState(() {
        _tasks.removeWhere((task) => task.id == taskId);
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Task deleted successfully')),
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result['message'] ?? 'Failed to delete task')),
        );
      }
    }
  }

  void _editTask(Task task) {
    Navigator.pushNamed(context, '/edit-task', arguments: task).then((_) {
      _refreshTasks();
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Tracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
            tooltip: 'Logout',
          ),
        ],
      ),
      body: _selectedIndex == 0 ? _buildTasksList() : _buildDashboard(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
        ],
      ),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/create-task').then((_) {
                  _refreshTasks();
                });
              },
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  Widget _buildTasksList() {
    return Column(
      children: [
        // Filter Chips
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip('All'),
                const SizedBox(width: 8),
                _buildFilterChip('Pending'),
                const SizedBox(width: 8),
                _buildFilterChip('In_progress'),
                const SizedBox(width: 8),
                _buildFilterChip('Completed'),
              ],
            ),
          ),
        ),

        // Tasks List
        Expanded(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _getFilteredTasks().isEmpty
                  ? _buildEmptyState()
                  : RefreshIndicator(
                      onRefresh: () async {
                        _refreshTasks();
                      },
                      child: ListView.builder(
                        padding: const EdgeInsets.only(bottom: 80),
                        itemCount: _getFilteredTasks().length,
                        itemBuilder: (context, index) {
                          final task = _getFilteredTasks()[index];
                          return TaskCard(
                            task: task,
                            onEdit: () => _editTask(task),
                            onDelete: () => _deleteTask(task.id),
                          );
                        },
                      ),
                    ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = _selectedFilter == label;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedFilter = label;
        });
      },
      selectedColor: Theme.of(context).primaryColor.withValues(alpha: 0.2),
      checkmarkColor: Theme.of(context).primaryColor,
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.task_alt,
            size: 80,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 16),
          Text(
            'No tasks found',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap + to create a new task',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboard() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DashboardStats(tasks: _tasks),
          const SizedBox(height: 24),
          
          // Upcoming Tasks Section
          const Text(
            'Upcoming Deadlines',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          
          ..._tasks
              .where((task) => task.status != 'completed' && 
                             task.dueDate.isAfter(DateTime.now()))
              .take(5)
              .map((task) => TaskCard(
                    task: task,
                    onEdit: () => _editTask(task),
                    onDelete: () => _deleteTask(task.id),
                  ))
              .toList(),
          
          if (_tasks.where((task) => task.status != 'completed').isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Text(
                  'All caught up! ',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
