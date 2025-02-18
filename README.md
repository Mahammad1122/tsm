# Task Management System

## Overview
The **Task Management System** is a web-based application built on **ASP.NET Framework 4.0** with **MS SQL Server** as the database. It is designed to facilitate efficient project and task management within an organization. The system supports two types of users:

- **Project Manager**
- **Employee**

## Features

### Project Manager
- Create and manage projects.
- Assign tasks to employees.
- View task progress and status.

### Employee
- Create their own tasks.
- View assigned tasks.
- Update task status upon completion.

## System Requirements
- **Framework:** ASP.NET Framework 4.0
- **Database:** Microsoft SQL Server
- **IDE:** Visual Studio (Recommended)
- **Web Server:** IIS (Internet Information Services)

## Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/Mahammad1122/tsm.git
   ```
2. Open the project in Visual Studio.
3. Configure the **Web.config** file with your MS SQL Server connection string.
4. Restore NuGet packages (if applicable).
5. Build the project.
6. Run the project using IIS Express or deploy it to IIS.

## Database Setup
1. Create a database in MS SQL Server.
2. Execute the provided SQL script (if available) to create tables and seed initial data.
3. Update the connection string in the **Web.config** file.

## Usage
- **Login:** Project Manager and Employee login credentials will be provided by the admin or seeded during database setup.
- **Dashboard:**
  - Project Manager can create projects and assign tasks.
  - Employees can view assigned tasks, create personal tasks, and mark tasks as complete.

## Technologies Used
- **Backend:** ASP.NET Framework 4.0
- **Frontend:** HTML, CSS, JavaScript,JQuery
- **Database:** MS SQL Server

## Contributing
Contributions are welcome. Please fork the repository and submit a pull request.

## Contact
For any inquiries, please contact [mahammadali2307@gmail.com].

