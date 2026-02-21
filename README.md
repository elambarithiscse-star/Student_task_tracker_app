# 📱 Student Task Tracker App

A full-stack mobile application built with **Flutter** and **PHP** to help students manage their academic tasks, assignments, and deadlines efficiently.

![Flutter](https://img.shields.io/badge/Flutter-3.0+-02569B?style=flat&logo=flutter)
![PHP](https://img.shields.io/badge/PHP-8.0+-777BB4?style=flat&logo=php)
![MySQL](https://img.shields.io/badge/MySQL-8.0+-4479A1?style=flat&logo=mysql&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green.svg)

## 📋 Table of Contents

- [Features](#features)
- [Screenshots](#screenshots)
- [Tech Stack](#tech-stack)
- [Architecture](#architecture)
- [Installation](#installation)
- [API Documentation](#api-documentation)
- [Database Schema](#database-schema)
- [Team Members](#team-members)
- [Project Structure](#project-structure)
- [Future Enhancements](#future-enhancements)
- [License](#license)

## ✨ Features

### User Authentication
- ✅ Secure user registration with email validation
- ✅ Login with bcrypt password hashing
- ✅ Token-based session management

### Task Management
- ✅ Create tasks with title, description, and due date
- ✅ Update task status (Pending, In Progress, Completed)
- ✅ Edit existing tasks
- ✅ Delete tasks with confirmation
- ✅ Filter tasks by status
- ✅ Overdue task highlighting

### Dashboard & Analytics
- ✅ Task completion statistics
- ✅ Completion rate percentage
- ✅ Task distribution by status
- ✅ Total, completed, pending, and overdue counts

### User Experience
- ✅ Material Design UI
- ✅ Pull-to-refresh functionality
- ✅ Loading and error states
- ✅ Empty state messages
- ✅ Responsive design
- ✅ Cross-platform (Android & iOS)

## 📸 Screenshots

```
|!
 Login Scr![WhatsApp Image 2026-02-21 at 13 41 01 (1)](https://github.com/user-attachments/assets/c4ad8624-edad-4938-9d13-8ce92e7b5015)
![WhatsApp Image 2026-02-21 at 13 41 01 (2)](https://github.com/user-attachments/assets/376662c6-c994-42f5-8531-cf7fa628c5ec)
![WhatsApp Image 2026-02-21 at 13 41 01 (3)](https://github.com/user-attachments/assets/8af2b3c3-a522-49f7-825f-382bda81c2ac)
![WhatsApp Image 2026-02-21 at 13 41 01 (4)](https://github.com/user-attachments/assets/45cfad7b-0178-459e-ae11-1e0812335e95)
![WhatsApp Image 2026-02-21 at 13 41 01 (5)](https://github.com/user-attachments/assets/5058dd97-b3d0-401e-a9a8-c30c2cc7110c)
![WhatsApp Image 2026-02-21 at 13 41 02](https://github.com/user-attachments/assets/76c7571b-53dc-4a12-8302-31d43b90544e)
![WhatsApp Image 2026-02-21 at 13 41 01](https://github.com/user-attachments/assets/397c3c67-0f61-41a1-aaf9-4cfda99f69d1)
een | Home Screen | Create Task | Dashboard |
|--------------|-------------|-------------|-----------|
| ![Login](screenshots/login.png) | ![Home](screenshots/home.png) | ![Create](screenshots/create.png) | ![Dashboard](screenshots/dashboard.png) |
```

## 🛠️ Tech Stack

### Frontend
- **Framework:** Flutter 3.0+
- **Language:** Dart
- **State Management:** setState (StatefulWidget)
- **HTTP Client:** http package
- **UI Components:** Material Design widgets

### Backend
- **Language:** PHP 8.0+
- **Database:** MySQL 8.0+
- **Architecture:** RESTful API
- **Security:** 
  - PDO Prepared Statements (SQL Injection Prevention)
  - Bcrypt Password Hashing
  - Input Sanitization (XSS Prevention)
  - CORS Configuration

### Development Tools
- **API Testing:** Postman
- **Database Management:** phpMyAdmin
- **Version Control:** Git & GitHub
- **Local Server:** XAMPP
- **IDE:** Android Studio / VS Code

## 🏗️ Architecture

```
┌─────────────────────────────────────┐
│      Flutter Mobile App             │
│   (Cross-platform Frontend)         │
└──────────────┬──────────────────────┘
               │
               │ HTTP/JSON
               │
┌──────────────▼──────────────────────┐
│         REST API Layer              │
│      (PHP Backend - No Framework)   │
└──────────────┬──────────────────────┘
               │
               │ PDO
               │
┌──────────────▼──────────────────────┐
│        MySQL Database               │
│    (Relational Data Storage)        │
└─────────────────────────────────────┘
```

### Project Architecture Pattern
- **Frontend:** Layered Architecture (Models, Services, Widgets, Screens)
- **Backend:** Procedural PHP with organized folder structure
- **Database:** Relational schema with foreign key constraints

## 🚀 Installation

### Prerequisites

- **Flutter SDK** (3.0 or higher) - [Install Flutter](https://flutter.dev/docs/get-started/install)
- **XAMPP** (PHP 8.0+ & MySQL 8.0+) - [Download XAMPP](https://www.apachefriends.org/)
- **Android Studio** / **VS Code** with Flutter plugin
- **Git** - [Install Git](https://git-scm.com/)

### Backend Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/YOUR_USERNAME/student-task-tracker.git
   cd student-task-tracker
   ```

2. **Setup Backend**
   ```bash
   # Copy backend folder to XAMPP
   # Windows: C:\xampp\htdocs\student_task_tracker_backend\
   # Mac/Linux: /Applications/XAMPP/htdocs/student_task_tracker_backend/
   
   cp -r backend/ /path/to/xampp/htdocs/student_task_tracker_backend/
   ```

3. **Start XAMPP**
   - Open XAMPP Control Panel
   - Start **Apache** server
   - Start **MySQL** database

4. **Create Database**
   - Open browser: `http://localhost/phpmyadmin`
   - Create database: `student_task_tracker`
   - Import SQL file: `backend/database/schema.sql`

5. **Configure Database** (if needed)
   
   Edit `backend/config/database.php`:
   ```php
   private $host = "localhost";
   private $db_name = "student_task_tracker";
   private $username = "root";
   private $password = ""; // Your MySQL password
   ```

6. **Test Backend**
   ```bash
   # Open browser
   http://localhost/student_task_tracker_backend/api/login.php
   
   # Should see: {"success":false,"message":"Please provide email and password."}
   ```

### Flutter Setup

1. **Install Dependencies**
   ```bash
   cd flutter_app
   flutter pub get
   ```

2. **Configure API URL**
   
   Edit `lib/services/api_service.dart`:
   ```dart
   // For Android Emulator
   static const String baseUrl = 'http://10.0.2.2/student_task_tracker_backend/api';
   
   // For Physical Phone (use your computer's IP)
   // static const String baseUrl = 'http://192.168.1.XXX/student_task_tracker_backend/api';
   
   // For iOS Simulator
   // static const String baseUrl = 'http://localhost/student_task_tracker_backend/api';
   ```

3. **Run the App**
   ```bash
   # List available devices
   flutter devices
   
   # Run on connected device
   flutter run
   
   # Or run on specific device
   flutter run -d chrome          # For web browser
   flutter run -d emulator-5554   # For Android emulator
   ```

## 📡 API Documentation

### Base URL
```
http://localhost/student_task_tracker_backend/api
```

### Endpoints

#### 1. User Registration
```http
POST /register.php

Request Body:
{
  "name": "John Doe",
  "email": "john@example.com",
  "password": "password123"
}

Response (201):
{
  "success": true,
  "message": "User registered successfully."
}
```

#### 2. User Login
```http
POST /login.php

Request Body:
{
  "email": "john@example.com",
  "password": "password123"
}

Response (200):
{
  "success": true,
  "message": "Login successful.",
  "token": "abc123...",
  "user": {
    "id": "1",
    "name": "John Doe",
    "email": "john@example.com"
  }
}
```

#### 3. Get All Tasks
```http
GET /tasks/list.php?user_id=1

Response (200):
{
  "success": true,
  "tasks": [
    {
      "id": "1",
      "title": "Complete Assignment",
      "description": "Finish mobile app project",
      "due_date": "2026-02-25 10:00:00",
      "status": "pending"
    }
  ],
  "count": 1
}
```

#### 4. Create Task
```http
POST /tasks/create.php

Request Body:
{
  "user_id": "1",
  "title": "New Task",
  "description": "Task details",
  "due_date": "2026-02-25 10:00:00",
  "status": "pending"
}

Response (201):
{
  "success": true,
  "message": "Task created successfully.",
  "task_id": "5"
}
```

#### 5. Update Task
```http
PUT /tasks/update.php

Request Body:
{
  "id": "5",
  "user_id": "1",
  "title": "Updated Task",
  "description": "Updated details",
  "due_date": "2026-02-26 10:00:00",
  "status": "in_progress"
}

Response (200):
{
  "success": true,
  "message": "Task updated successfully."
}
```

#### 6. Delete Task
```http
DELETE /tasks/delete.php

Request Body:
{
  "id": "5",
  "user_id": "1"
}

Response (200):
{
  "success": true,
  "message": "Task deleted successfully."
}
```

#### 7. Get Dashboard Statistics
```http
GET /tasks/dashboard.php?user_id=1

Response (200):
{
  "success": true,
  "stats": {
    "total": 10,
    "completed": 4,
    "pending": 3,
    "in_progress": 2,
    "overdue": 1,
    "completion_rate": 40.00
  }
}
```

### Error Responses

All endpoints return consistent error format:

```json
{
  "success": false,
  "message": "Error description here"
}
```

**Common HTTP Status Codes:**
- `200` - Success
- `201` - Created
- `400` - Bad Request (validation error)
- `401` - Unauthorized (authentication failed)
- `404` - Not Found
- `409` - Conflict (duplicate entry)
- `500` - Internal Server Error

## 🗄️ Database Schema

### Users Table
```sql
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

### Tasks Table
```sql
CREATE TABLE tasks (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    due_date DATETIME NOT NULL,
    status ENUM('pending', 'in_progress', 'completed') DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_status (status),
    INDEX idx_due_date (due_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

### Entity Relationship
```
users (1) ──────< (M) tasks
  │                     │
  └─── CASCADE DELETE ──┘
```



## 📂 Project Structure

```
student-task-tracker/
│
├── backend/                          # PHP Backend
│   ├── api/                          # API Endpoints
│   │   ├── register.php              # User registration
│   │   ├── login.php                 # User login
│   │   └── tasks/
│   │       ├── list.php              # Get all tasks
│   │       ├── create.php            # Create task
│   │       ├── update.php            # Update task
│   │       ├── delete.php            # Delete task
│   │       └── dashboard.php         # Get statistics
│   ├── config/
│   │   ├── database.php              # Database connection
│   │   └── cors.php                  # CORS headers
│   ├── helpers/
│   │   └── functions.php             # Utility functions
│   ├── database/
│   │   └── schema.sql                # Database schema
│   └── README.md                     # Backend documentation
│
├── flutter_app/                      # Flutter Frontend
│   ├── lib/
│   │   ├── main.dart                 # App entry point
│   │   ├── models/
│   │   │   └── task_model.dart       # Task data model
│   │   ├── screens/
│   │   │   ├── login_screen.dart     # Login UI
│   │   │   ├── register_screen.dart  # Registration UI
│   │   │   ├── home_screen.dart      # Main dashboard
│   │   │   ├── create_task_screen.dart
│   │   │   └── edit_task_screen.dart
│   │   ├── widgets/
│   │   │   ├── task_card.dart        # Task display widget
│   │   │   └── dashboard_stats.dart  # Statistics widget
│   │   └── services/
│   │       └── api_service.dart      # API integration
│   ├── pubspec.yaml                  # Dependencies
│   └── README.md                     # Frontend documentation
│
├── docs/                             # Documentation
│   ├── API_DOCUMENTATION.md
│   ├── SETUP_GUIDE.md
│   └── Technical_Report.pdf
│
├── screenshots/                      # App screenshots
│   ├── login.png
│   ├── home.png
│   ├── create_task.png
│   └── dashboard.png
│
├── .gitignore                        # Git ignore file
├── LICENSE                           # MIT License
└── README.md                         # This file
```

## 🧪 Testing

### Backend Testing

Test APIs using Postman or cURL:

```bash
# Test registration
curl -X POST http://localhost/student_task_tracker_backend/api/register.php \
  -H "Content-Type: application/json" \
  -d '{"name":"Test User","email":"test@test.com","password":"123456"}'

# Test login
curl -X POST http://localhost/student_task_tracker_backend/api/login.php \
  -H "Content-Type: application/json" \
  -d '{"email":"test@test.com","password":"123456"}'
```

### Flutter Testing

```bash
# Run tests
flutter test

# Run app in debug mode
flutter run --debug

# Build APK
flutter build apk --release
```

## 🔐 Security Features

- ✅ **Password Hashing:** Bcrypt algorithm with cost factor 10
- ✅ **SQL Injection Prevention:** PDO prepared statements
- ✅ **XSS Prevention:** Input sanitization with htmlspecialchars
- ✅ **CORS Configuration:** Controlled cross-origin access
- ✅ **Input Validation:** Server-side validation for all inputs
- ✅ **Error Handling:** Secure error messages without sensitive data
- ✅ **Database Security:** Foreign key constraints, indexed columns

## 🚀 Future Enhancements

### Planned Features
- [ ] Push notifications for upcoming deadlines
- [ ] Dark mode support
- [ ] Task categories/tags
- [ ] Search functionality
- [ ] Recurring tasks
- [ ] Task priority levels
- [ ] Attachment support (files, images)
- [ ] Collaborative tasks (share with classmates)
- [ ] Calendar view
- [ ] Export tasks to PDF

### Technical Improvements
- [ ] Implement JWT for authentication
- [ ] Add caching layer (Redis)
- [ ] Implement MVVM architecture with Provider
- [ ] Add unit and integration tests
- [ ] Migrate to cloud hosting (AWS/Firebase)
- [ ] Add offline mode with local storage
- [ ] Implement CI/CD pipeline
- [ ] Add API rate limiting
- [ ] Biometric authentication

## 📝 Development Timeline

| Phase | Duration | Activities |
|-------|----------|------------|
| Planning & Design | Day 1 | Requirements, architecture, database design |
| Backend Development | Day 2-4 | API creation, database setup, security |
| Frontend Development | Day 5-7 | UI screens, widgets, navigation |
| Integration | Day 8-9 | API integration, testing, bug fixes |
| Deployment & Docs | Day 10 | Documentation, Git setup, final testing |

**Total Development Time:** 10 days (4 team members)

## 🐛 Known Issues

- None currently. Please report issues on GitHub Issues page.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📞 Contact

For any queries or suggestions:

- ** [Elambarithi S] - CSE Department
- **Project Link:** [https://github.com/elambarithiscse-star/student_task_tracker_app](https://github.com/elambarithiscse-star/Student_task_tracker_app)

## 🙏 Acknowledgments

- Faculty advisor for guidance
- Department for resources
- Open-source community for Flutter and PHP documentation
- Fellow students for testing and feedback

---

**⭐ If you find this project useful, please consider giving it a star!**

****
