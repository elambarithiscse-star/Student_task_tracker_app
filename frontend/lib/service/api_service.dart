import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/task_model.dart';

class ApiService {
  // Use 10.0.2.2 for Android Emulator, localhost for others
  static String get baseUrl {
    if (!kIsWeb && Platform.isAndroid) {
      return 'http://10.0.2.2/student_task_tracker_backend/api';
    }
    return 'http://localhost/student_task_tracker_backend/api';
  }
  
  // Store token after login
  static String? authToken;
  static String? userId;

  // Helper method to get headers with token
  static Map<String, String> _getHeaders() {
    return {
      'Content-Type': 'application/json',
      if (authToken != null) 'Authorization': 'Bearer $authToken',
      if (userId != null) 'User-Id': userId!,
    };
  }

  // ============ AUTHENTICATION APIs ============

  // Register new user
  static Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register.php'),
        headers: _getHeaders(),
        body: json.encode({
          'name': name,
          'email': email,
          'password': password,
        }),
      );
      
      final data = json.decode(response.body);
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        return {'success': true, 'data': data};
      } else {
        return {'success': false, 'message': data['message'] ?? 'Registration failed'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
    }
  }

  // Login user
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login.php'),
        headers: _getHeaders(),
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );
      
      final data = json.decode(response.body);
      
      if (response.statusCode == 200) {
        authToken = data['token']; // Store the token
        if (data['user'] != null && data['user']['id'] != null) {
            userId = data['user']['id'].toString();
        }
        return {'success': true, 'data': data};
      } else {
        return {'success': false, 'message': data['message'] ?? 'Login failed'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
    }
  }

  // Logout user
  static Future<void> logout() async {
    authToken = null;
    userId = null;
    // Clear any stored user data
  }

  // ============ TASK APIs ============

  // Get all tasks for current user
  static Future<Map<String, dynamic>> getTasks() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/tasks/list.php'),
        headers: _getHeaders(),
      );
      
      final data = json.decode(response.body);
      
      if (response.statusCode == 200) {
        List<Task> tasks = [];
        if (data['tasks'] != null) {
            tasks = (data['tasks'] as List)
                .map((task) => Task.fromJson(task))
                .toList();
        }
        return {'success': true, 'tasks': tasks};
      } else {
        return {'success': false, 'message': data['message'] ?? 'Failed to fetch tasks'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
    }
  }

  // Create new task
  static Future<Map<String, dynamic>> createTask({
    required String title,
    required String description,
    required DateTime dueDate,
    required String status,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/tasks/create.php'),
        headers: _getHeaders(),
        body: json.encode({
          'title': title,
          'description': description,
          'due_date': dueDate.toIso8601String(),
          'status': status,
        }),
      );
      
      final data = json.decode(response.body);
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        return {'success': true, 'data': data};
      } else {
        return {'success': false, 'message': data['message'] ?? 'Failed to create task'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
    }
  }

  // Update existing task
  static Future<Map<String, dynamic>> updateTask({
    required String taskId,
    required String title,
    required String description,
    required DateTime dueDate,
    required String status,
  }) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/tasks/update.php'),
        headers: _getHeaders(),
        body: json.encode({
          'id': taskId,
          'title': title,
          'description': description,
          'due_date': dueDate.toIso8601String(),
          'status': status,
        }),
      );
      
      final data = json.decode(response.body);
      
      if (response.statusCode == 200) {
        return {'success': true, 'data': data};
      } else {
        return {'success': false, 'message': data['message'] ?? 'Failed to update task'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
    }
  }

  // Delete task
  static Future<Map<String, dynamic>> deleteTask(String taskId) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/tasks/delete.php'),
        headers: _getHeaders(),
        body: json.encode({'id': taskId}),
      );
      
      final data = json.decode(response.body);
      
      if (response.statusCode == 200) {
        return {'success': true, 'data': data};
      } else {
        return {'success': false, 'message': data['message'] ?? 'Failed to delete task'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
    }
  }

  // Get dashboard statistics
  static Future<Map<String, dynamic>> getDashboardStats() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/tasks/dashboard.php'),
        headers: _getHeaders(),
      );
      
      final data = json.decode(response.body);
      
      if (response.statusCode == 200) {
        return {'success': true, 'stats': data};
      } else {
        return {'success': false, 'message': data['message'] ?? 'Failed to fetch stats'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
    }
  }
}