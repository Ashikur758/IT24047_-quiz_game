# How to Run This Project on Windows

This guide is for running **Sirajganj District Quiz** on a Windows PC.

The project uses:

1. Java JDK 17 or 21
2. Apache Maven
3. MySQL 8+
4. Apache Tomcat 10.1+
5. IntelliJ IDEA (optional)

> **Important:** This project uses `jakarta.servlet`, so use **Tomcat 10.1+**. Do not use Tomcat 9.

---

## Project Information

Project name:

```text
Sirajganj District Quiz
```

Database:

```text
sirajganj_quiz_db
```

WAR file:

```text
sirajganj-quiz.war
```

Default application URL:

```text
http://localhost:8080/sirajganj-quiz/
```

Default admin URL:

```text
http://localhost:8080/sirajganj-quiz/admin/login
```

Default admin login:

```text
Username: admin
Password: admin123
```

---

# Step 1 — Install Java JDK

You need JDK 17 or JDK 21.

You can download Eclipse Temurin from:

https://adoptium.net/

Install the JDK normally.

If the installer provides an option to set `JAVA_HOME`, enable it.

After installation, open a **new Command Prompt** and run:

```bat
java -version
```

You should see Java 17 or Java 21.

Example:

```text
java version "17.x.x"
```

or:

```text
java version "21.x.x"
```

### If Java is not recognized

Open:

```text
Start → Search → Environment Variables
```

Then select:

```text
Edit the system environment variables
```

Click:

```text
Environment Variables
```

Under **System variables**, create or edit:

```text
JAVA_HOME
```

Example:

```text
C:\Program Files\Eclipse Adoptium\jdk-17.0.x-hotspot
```

Then edit `Path` and add:

```text
%JAVA_HOME%\bin
```

Close Command Prompt and open a new one.

Test again:

```bat
java -version
```

---

# Step 2 — Install Apache Maven

Apache Maven is used to build this project.

Official Maven installation information:

https://maven.apache.org/install

Maven on Windows requires a JDK and its `bin` directory must be available through `PATH`.

Download the Maven binary ZIP archive.

For example:

```text
apache-maven-3.9.x-bin.zip
```

Extract it to:

```text
C:\apache-maven-3.9.x
```

You may use another folder if you prefer.

## Configure Maven

Open:

```text
Environment Variables
```

Create:

```text
MAVEN_HOME
```

Example:

```text
C:\apache-maven-3.9.x
```

Edit `Path` and add:

```text
%MAVEN_HOME%\bin
```

Open a new Command Prompt.

Check Maven:

```bat
mvn -v
```

You should see both Maven and Java information.

Example:

```text
Apache Maven 3.9.x
Java version: 17.x.x
```

---

# Step 3 — Install MySQL

You need MySQL 8+.

For Windows, MySQL provides installation packages and configuration tools.

Official MySQL documentation:

https://dev.mysql.com/doc/mysql-installer/en/

For MySQL 8.0, the MySQL Installer provides a wizard-based installation process.

## Recommended option

Install:

```text
MySQL Server
MySQL Workbench
```

During installation, remember the password you create for:

```text
root
```

Example:

```text
Username: root
Password: YourPassword123
```

Make sure MySQL Server is running.

You can check Windows Services:

```text
Start
↓
Services
↓
MySQL80
```

The status should be:

```text
Running
```

---

# Step 4 — Check MySQL

Open Command Prompt.

Try:

```bat
mysql -u root -p
```

Enter your MySQL password.

If MySQL opens successfully, you should see:

```text
mysql>
```

Then test:

```sql
SELECT VERSION();
```

You can exit MySQL using:

```sql
exit;
```

---

# Step 5 — Create the Sirajganj Database

The project contains:

```text
database\sirajganj_quiz_db.sql
```

This SQL file creates:

```text
sirajganj_quiz_db
```

and the required tables:

```text
players
questions
quiz_attempts
quiz_answers
```

It also inserts the 20 starter quiz questions.

---

## Option A — MySQL Command Prompt

First go to your project folder.

Example:

```bat
cd C:\Users\YOUR_NAME\Desktop\projects\sirajganj-quiz
```

Then import the SQL file:

```bat
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" -u root -p < database\sirajganj_quiz_db.sql
```

Enter your MySQL root password.

> If your MySQL installation is in another folder, change the path to `mysql.exe`.

---

## Option B — Using MySQL Shell / mysql Command

If `mysql` is already in your PATH:

```bat
mysql -u root -p < database\sirajganj_quiz_db.sql
```

---

## Option C — MySQL Workbench

You can also import the SQL file through MySQL Workbench.

1. Open MySQL Workbench.
2. Connect to your local MySQL server.
3. Select:

```text
File → Open SQL Script
```

4. Choose:

```text
database\sirajganj_quiz_db.sql
```

5. Run the script using the lightning/run button.

---

# Step 6 — Check the Database

Open MySQL:

```bat
mysql -u root -p
```

Then run:

```sql
SHOW DATABASES;
```

You should see:

```text
sirajganj_quiz_db
```

Select the database:

```sql
USE sirajganj_quiz_db;
```

Check the tables:

```sql
SHOW TABLES;
```

You should see:

```text
players
questions
quiz_attempts
quiz_answers
```

Check the questions:

```sql
SELECT COUNT(*) FROM questions;
```

The expected result is:

```text
20
```

You can also check:

```sql
SELECT * FROM questions;
```

---

# Step 7 — Configure Database Connection

Open:

```text
src\main\resources\db.properties
```

Set the database configuration:

```properties
db.url=jdbc:mysql://localhost:3306/sirajganj_quiz_db?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=Asia/Dhaka
db.user=root
db.password=YOUR_MYSQL_PASSWORD

admin.username=admin
admin.password=admin123
```

Replace:

```text
YOUR_MYSQL_PASSWORD
```

with your actual MySQL root password.

For example:

```properties
db.password=123456
```

If your MySQL root password is empty:

```properties
db.password=
```

Save the file.

---

# Step 8 — Check the Project Structure

Your project should look approximately like this:

```text
sirajganj-quiz/
│
├── pom.xml
├── README.md
├── HOW_TO_RUN_WINDOWS.md
│
├── database/
│   └── sirajganj_quiz_db.sql
│
└── src/
    └── main/
        ├── java/
        │   └── com/
        │       └── sirajganjquiz/
        │
        ├── resources/
        │   └── db.properties
        │
        └── webapp/
            ├── index.jsp
            ├── css/
            ├── js/
            └── WEB-INF/
                ├── web.xml
                ├── jsp/
                └── jspf/
```

---

# Step 9 — Build the Project with Maven

Open Command Prompt.

Go to the project folder.

Example:

```bat
cd C:\Users\YOUR_NAME\Desktop\projects\sirajganj-quiz
```

Run:

```bat
mvn clean package
```

Maven will:

1. Download required dependencies.
2. Compile the Java source code.
3. Process JSP/Jakarta dependencies.
4. Build the WAR file.

Wait until you see:

```text
BUILD SUCCESS
```

---

# Step 10 — Find the WAR File

After successful build, open:

```text
target
```

You should find:

```text
sirajganj-quiz.war
```

Full path example:

```text
C:\Users\YOUR_NAME\Desktop\projects\sirajganj-quiz\target\sirajganj-quiz.war
```

---

# Step 11 — Install Apache Tomcat 10.1

This project uses Jakarta Servlet APIs.

Tomcat 10.1 is therefore appropriate.

Official Tomcat 10.1 download page:

https://tomcat.apache.org/download-10.1.cgi

Download the Windows ZIP distribution.

Extract it somewhere such as:

```text
C:\apache-tomcat-10.1.xx
```

The exact version number may be different.

Tomcat 10+ uses the `jakarta.*` namespace, unlike older Tomcat versions that use `javax.*`.

---

# Step 12 — Optional: Configure CATALINA_HOME

You can create:

```text
CATALINA_HOME
```

Example:

```text
C:\apache-tomcat-10.1.xx
```

You may also add:

```text
%CATALINA_HOME%\bin
```

to the Windows `Path`.

This is optional.

You can always run Tomcat using its full path.

---

# Step 13 — Deploy the WAR File

Copy:

```text
target\sirajganj-quiz.war
```

to:

```text
C:\apache-tomcat-10.1.xx\webapps\
```

For example:

```bat
copy target\sirajganj-quiz.war C:\apache-tomcat-10.1.xx\webapps\
```

After copying, the structure should contain:

```text
webapps\
    sirajganj-quiz.war
```

When Tomcat starts, it will normally unpack the WAR into:

```text
webapps\sirajganj-quiz\
```

---

# Step 14 — Start Tomcat

Open Command Prompt.

Run:

```bat
C:\apache-tomcat-10.1.xx\bin\startup.bat
```

A Tomcat window should open.

Wait several seconds for Tomcat to start.

You can also check the Tomcat logs inside:

```text
C:\apache-tomcat-10.1.xx\logs\
```

---

# Step 15 — Open the Website

Open your browser.

Go to:

```text
http://localhost:8080/sirajganj-quiz/
```

The Sirajganj District Quiz homepage should appear.

---

# Step 16 — Open the Admin Login

Admin login:

```text
http://localhost:8080/sirajganj-quiz/admin/login
```

Default credentials:

```text
Username: admin
Password: admin123
```

These values come from:

```text
src\main\resources\db.properties
```

---

# Step 17 — Test the Quiz

After opening the homepage:

1. Enter your name.
2. Start the quiz.
3. The server selects 10 random active questions.
4. Answer the questions.
5. Submit the quiz.
6. The server calculates the score.
7. The result page displays the score.
8. The attempt and answers are stored in MySQL.

You can verify the saved attempt using the Admin panel.

---

# Step 18 — Test Admin CRUD

Open:

```text
http://localhost:8080/sirajganj-quiz/admin/login
```

Login:

```text
admin
admin123
```

Then test:

### Add question

Create a new question.

### View questions

Open the question list.

### Edit question

Change the question or answer.

### Deactivate question

Set the question to inactive.

### Start quiz

Verify that the inactive question is not selected.

### Delete question

Delete the question if required.

---

# Step 19 — Verify Data in MySQL

Open MySQL:

```bat
mysql -u root -p
```

Select the database:

```sql
USE sirajganj_quiz_db;
```

Check players:

```sql
SELECT * FROM players;
```

Check questions:

```sql
SELECT * FROM questions;
```

Check attempts:

```sql
SELECT * FROM quiz_attempts;
```

Check answers:

```sql
SELECT * FROM quiz_answers;
```

---

# Step 20 — Stop Tomcat

To stop Tomcat:

```bat
C:\apache-tomcat-10.1.xx\bin\shutdown.bat
```

---

# Run Again After Changing Java Code

Whenever you change Java source code, build the project again:

```bat
cd C:\Users\YOUR_NAME\Desktop\projects\sirajganj-quiz
mvn clean package
```

Then replace the old WAR:

```text
C:\apache-tomcat-10.1.xx\webapps\sirajganj-quiz.war
```

with the newly generated:

```text
target\sirajganj-quiz.war
```

If Tomcat has already unpacked the application, stop Tomcat first and remove the old exploded application folder:

```text
webapps\sirajganj-quiz\
```

Then copy the new WAR and start Tomcat again.

---

# Run from IntelliJ IDEA

You can also run the project directly from IntelliJ IDEA.

## 1. Open the Project

Open:

```text
sirajganj-quiz
```

in IntelliJ IDEA.

Wait for Maven to finish importing the project.

---

## 2. Check the JDK

Go to:

```text
File
→ Project Structure
→ Project
```

Set the Project SDK to:

```text
JDK 17
```

or:

```text
JDK 21
```

The `pom.xml` currently uses:

```xml
<maven.compiler.release>17</maven.compiler.release>
```

---

## 3. Add Tomcat

Go to:

```text
File
→ Settings
→ Build, Execution, Deployment
→ Application Servers
```

Add:

```text
Tomcat Server
```

Select your Tomcat folder:

```text
C:\apache-tomcat-10.1.xx
```

---

## 4. Create Tomcat Run Configuration

Go to:

```text
Run
→ Edit Configurations
```

Click:

```text
+
```

Select:

```text
Tomcat Server → Local
```

---

## 5. Deployment

Open the:

```text
Deployment
```

tab.

Add:

```text
sirajganj-quiz:war exploded
```

Set:

```text
Application context: /sirajganj-quiz
```

Apply the configuration.

---

## 6. Run

Click:

```text
Run
```

Then open:

```text
http://localhost:8080/sirajganj-quiz/
```

---

# Common Windows Problems

## Problem 1 — `java` is not recognized

Error:

```text
'java' is not recognized as an internal or external command
```

### Solution

Check:

```bat
java -version
```

If it fails, configure:

```text
JAVA_HOME
```

and:

```text
%JAVA_HOME%\bin
```

in `Path`.

Then open a new Command Prompt.

---

# Problem 2 — `mvn` is not recognized

Error:

```text
'mvn' is not recognized as an internal or external command
```

### Solution

Make sure Maven's `bin` folder is in `Path`.

Example:

```text
C:\apache-maven-3.9.x\bin
```

Then open a new Command Prompt.

Test:

```bat
mvn -v
```

---

# Problem 3 — `mysql` is not recognized

Error:

```text
'mysql' is not recognized as an internal or external command
```

### Solution

Use the full path.

Example:

```bat
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" -u root -p
```

Or add the MySQL `bin` folder to Windows `Path`.

---

# Problem 4 — Database Does Not Exist

Error may look like:

```text
Unknown database 'sirajganj_quiz_db'
```

### Solution

Import:

```text
database\sirajganj_quiz_db.sql
```

Then check:

```sql
SHOW DATABASES;
```

You should see:

```text
sirajganj_quiz_db
```

---

# Problem 5 — Database Connection Error

Check these items:

### MySQL is running

Check:

```text
Services → MySQL80
```

### Database name

Your `db.properties` must contain:

```properties
db.url=jdbc:mysql://localhost:3306/sirajganj_quiz_db?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=Asia/Dhaka
```

### Username

```properties
db.user=root
```

### Password

```properties
db.password=YOUR_MYSQL_PASSWORD
```

After changing the configuration, rebuild:

```bat
mvn clean package
```

Then deploy the new WAR again.

---

# Problem 6 — Tomcat 404 Error

If you see:

```text
HTTP Status 404
```

check:

1. Tomcat is running.
2. `sirajganj-quiz.war` exists inside `webapps`.
3. Tomcat has unpacked the WAR.
4. The URL is correct.

Correct URL:

```text
http://localhost:8080/sirajganj-quiz/
```

Check:

```text
webapps\
```

You should have:

```text
sirajganj-quiz.war
```

and usually:

```text
sirajganj-quiz\
```

---

# Problem 7 — `jakarta.servlet` Error

If you see errors involving:

```text
jakarta.servlet
```

make sure you are using:

```text
Apache Tomcat 10.1+
```

Do not use:

```text
Tomcat 9
```

Tomcat 10 moved from the older Java EE `javax.*` namespace to the Jakarta EE `jakarta.*` namespace.

---

# Problem 8 — Port 8080 Already in Use

If Tomcat cannot start because port 8080 is already being used, you may see an error similar to:

```text
Address already in use
```

Find the process using port 8080:

```bat
netstat -ano | findstr :8080
```

You can then identify the process:

```bat
tasklist | findstr PID_NUMBER
```

Alternatively, change Tomcat's port.

Open:

```text
C:\apache-tomcat-10.1.xx\conf\server.xml
```

Find:

```xml
<Connector port="8080"
```

Change it to:

```xml
<Connector port="8081"
```

Restart Tomcat.

Then open:

```text
http://localhost:8081/sirajganj-quiz/
```

---

# Problem 9 — WAR Builds but Application Does Not Start

First stop Tomcat.

Then remove the previously unpacked application:

```text
C:\apache-tomcat-10.1.xx\webapps\sirajganj-quiz\
```

Also remove the old:

```text
sirajganj-quiz.war
```

Build again:

```bat
mvn clean package
```

Copy the new WAR:

```bat
copy target\sirajganj-quiz.war C:\apache-tomcat-10.1.xx\webapps\
```

Start Tomcat again:

```bat
C:\apache-tomcat-10.1.xx\bin\startup.bat
```

---

# Problem 10 — JSP/JSTL Error

If JSP pages fail because of JSTL, check that the `pom.xml` contains both:

```xml
<dependency>
    <groupId>jakarta.servlet.jsp.jstl</groupId>
    <artifactId>jakarta.servlet.jsp.jstl-api</artifactId>
    <version>3.0.0</version>
</dependency>
```

and:

```xml
<dependency>
    <groupId>org.glassfish.web</groupId>
    <artifactId>jakarta.servlet.jsp.jstl</artifactId>
    <version>3.0.1</version>
</dependency>
```

Then run:

```bat
mvn clean package
```

---

# Problem 11 — Changes Are Not Showing

If you changed Java/JSP/CSS code but the browser still shows the old version:

1. Stop Tomcat.
2. Run:

```bat
mvn clean package
```

3. Remove the old application:

```text
webapps\sirajganj-quiz\
```

4. Replace the old WAR.
5. Start Tomcat.
6. Refresh the browser.

You can also use:

```text
Ctrl + F5
```

for a hard browser refresh.

---

# Problem 12 — MySQL Password Is Wrong

Test your password directly:

```bat
mysql -u root -p
```

If you cannot log in, the problem is with the MySQL credentials rather than the Java application.

After confirming the password, update:

```text
src\main\resources\db.properties
```

Then rebuild:

```bat
mvn clean package
```

---

# Problem 13 — Maven Dependency Download Error

If Maven cannot download dependencies, check:

```bat
mvn -v
```

Then make sure:

1. Internet connection is working.
2. Maven is configured correctly.
3. Java is working.
4. Windows Firewall/antivirus is not blocking Java/Maven.

Try:

```bat
mvn clean package
```

again.

---

# Project URLs

After successful deployment:

| Page | URL |
|---|---|
| Home | `http://localhost:8080/sirajganj-quiz/` |
| About Sirajganj | `http://localhost:8080/sirajganj-quiz/about` |
| Start Quiz | `http://localhost:8080/sirajganj-quiz/quiz/start` |
| Quiz | `http://localhost:8080/sirajganj-quiz/quiz` |
| Result | `http://localhost:8080/sirajganj-quiz/quiz/result` |
| Admin Login | `http://localhost:8080/sirajganj-quiz/admin/login` |
| Dashboard | `http://localhost:8080/sirajganj-quiz/admin/dashboard` |
| Questions | `http://localhost:8080/sirajganj-quiz/admin/questions` |
| Players | `http://localhost:8080/sirajganj-quiz/admin/players` |
| Attempts | `http://localhost:8080/sirajganj-quiz/admin/attempts` |

---

# Quick Start

If Java, Maven, MySQL, and Tomcat are already installed:

### 1. Open the project

```bat
cd C:\Users\YOUR_NAME\Desktop\projects\sirajganj-quiz
```

### 2. Import the database

```bat
mysql -u root -p < database\sirajganj_quiz_db.sql
```

### 3. Configure password

Edit:

```text
src\main\resources\db.properties
```

Set:

```properties
db.url=jdbc:mysql://localhost:3306/sirajganj_quiz_db?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=Asia/Dhaka
db.user=root
db.password=YOUR_MYSQL_PASSWORD
admin.username=admin
admin.password=admin123
```

### 4. Build

```bat
mvn clean package
```

### 5. Copy WAR

```bat
copy target\sirajganj-quiz.war C:\apache-tomcat-10.1.xx\webapps\
```

### 6. Start Tomcat

```bat
C:\apache-tomcat-10.1.xx\bin\startup.bat
```

### 7. Open browser

```text
http://localhost:8080/sirajganj-quiz/
```

---

# Final Checklist

Before running the project, verify:

- [ ] JDK 17 or 21 installed
- [ ] `java -version` works
- [ ] Maven installed
- [ ] `mvn -v` works
- [ ] MySQL 8+ installed
- [ ] MySQL service is running
- [ ] `sirajganj_quiz_db` database exists
- [ ] `players` table exists
- [ ] `questions` table exists
- [ ] `quiz_attempts` table exists
- [ ] `quiz_answers` table exists
- [ ] 20 questions are inserted
- [ ] `db.properties` contains the correct MySQL password
- [ ] Tomcat 10.1+ installed
- [ ] `mvn clean package` shows `BUILD SUCCESS`
- [ ] `target\sirajganj-quiz.war` exists
- [ ] WAR is copied to Tomcat `webapps`
- [ ] Tomcat is running
- [ ] `http://localhost:8080/sirajganj-quiz/` opens successfully
- [ ] Admin login works

---

# Official Installation Resources

- Java / Eclipse Temurin: https://adoptium.net/
- Apache Maven: https://maven.apache.org/install
- MySQL: https://dev.mysql.com/downloads/
- MySQL Windows documentation: https://dev.mysql.com/doc/mysql-installer/en/
- Apache Tomcat 10: https://tomcat.apache.org/download-10.cgi

