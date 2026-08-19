# Sirajganj District Knowledge Quiz

A Servlet, JSP, and JDBC CRUD application.

Players answer **10 random unique questions** from a bank of 20 questions about Sirajganj District, Bangladesh.

The homepage title is:

**Test Your Knowledge About Sirajganj**

Topics:

* Crops & Agriculture
* Academic Institutions
* Geography

---

## What this project does

1. Player enters a name and starts a quiz.
2. The server picks 10 different active questions from MySQL (`ORDER BY RAND() LIMIT 10`).
3. Those 10 questions are stored in the HTTP session, so a page refresh does not pick a new set.
4. The player submits answers.
5. The **server** marks the quiz (10 points per correct answer).
6. The attempt and each answer are saved in MySQL inside one transaction.
7. The result page shows the score and a question-by-question review.
8. An admin area can create, read, update, delete, and activate/deactivate questions.

---

## How to read this code (start here)

This project uses a simple MVC split. If you are new to Java web apps, read the files in this order:

1. `database/sirajganj_quiz_db.sql` — tables and the 20 questions
2. `src/main/java/com/sirajganjquiz/model/` — plain Java objects (one object = one table row)
3. `src/main/java/com/sirajganjquiz/dao/DBConnection.java` — opens a MySQL connection
4. `src/main/java/com/sirajganjquiz/dao/QuestionDAO.java` — SQL for questions
5. `src/main/java/com/sirajganjquiz/controller/QuizStartServlet.java` — starts a quiz
6. `src/main/java/com/sirajganjquiz/controller/QuizSubmitServlet.java` — marks and saves
7. `src/main/webapp/WEB-INF/jsp/quiz.jsp` — the quiz page

Rule of thumb:

* **Servlet** = traffic cop (reads the request, calls a DAO, sends the user to a JSP)
* **DAO** = talks to MySQL
* **Model** = holds data
* **JSP** = HTML page

There is no Spring, no Hibernate, and no React.

---

## Features

* Random 10-question quiz from 20 seeded questions
* Player, attempt, and answer history in MySQL
* Question CRUD with search and category/difficulty filters
* Activate/deactivate questions (inactive questions are skipped)
* Player list, edit, delete (delete also removes that player's attempts)
* Admin dashboard with counts, recent attempts, and highest scores
* About Sirajganj page with official source links

---

## Technologies

* Java 17+
* Maven
* Jakarta Servlet + JSP + JSTL
* JDBC
* MySQL 8+
* Apache Tomcat 10+
* HTML5 / CSS3 / a little JavaScript

---

## Requirements

* JDK 17 or 21
* Maven 3.8+
* MySQL 8+
* Apache Tomcat 10.1+ (Jakarta, not Tomcat 9)

---

## Database setup

1. Open MySQL.
2. Import the SQL file:

```bash
mysql -u root -p < database/sirajganj_quiz_db.sql
```

Or in MySQL Workbench:

**File → Run SQL Script → choose `database/sirajganj_quiz_db.sql`**

That creates:

* database `sirajganj_quiz_db`
* tables `players`
* `questions`
* `quiz_attempts`
* `quiz_answers`
* 20 starter questions

### Schema

```text
players 1 ---- N quiz_attempts 1 ---- N quiz_answers
questions 1 ---------------------- N quiz_answers
```

Deleting a player also deletes that player's attempts and answers (`ON DELETE CASCADE`).

---

## MySQL configuration

Edit:

`src/main/resources/db.properties`

```properties
db.url=jdbc:mysql://localhost:3306/sirajganj_quiz_db?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=Asia/Dhaka
db.user=root
db.password=CHANGE_ME
admin.username=admin
admin.password=admin123
```

Put your real MySQL password in place of `CHANGE_ME`.

---

## How to run on Windows

Make sure the following are installed:

* JDK 17 or 21
* Maven 3.8+
* MySQL 8+
* Apache Tomcat 10.1+

Start MySQL and make sure the database has been imported successfully.

Then build the project:

```bash
mvn clean package
```

---

## How to run

### 1. Build the WAR

```bash
mvn clean package
```

This creates:

```text
target/sirajganj-quiz.war
```

### 2. Deploy on Tomcat

1. Copy `target/sirajganj-quiz.war` into Tomcat's `webapps` folder.
2. Start Tomcat.
3. Open:

```text
http://localhost:8080/sirajganj-quiz/
```

If you rename the WAR to `ROOT.war`, the app will be available at:

```text
http://localhost:8080/
```

---

## Default URLs

| Page            | URL                                          |
| --------------- | -------------------------------------------- |
| Home            | `/sirajganj-quiz/` or `/sirajganj-quiz/home` |
| About Sirajganj | `/sirajganj-quiz/about`                      |
| Start quiz      | `/sirajganj-quiz/quiz/start`                 |
| Quiz            | `/sirajganj-quiz/quiz`                       |
| Result          | `/sirajganj-quiz/quiz/result`                |
| Admin login     | `/sirajganj-quiz/admin/login`                |
| Dashboard       | `/sirajganj-quiz/admin/dashboard`            |
| Questions       | `/sirajganj-quiz/admin/questions`            |
| Players         | `/sirajganj-quiz/admin/players`              |
| Attempts        | `/sirajganj-quiz/admin/attempts`             |

### Default admin login

From `db.properties`:

```text
Username: admin
Password: admin123
```

---

## Project structure

```text
sirajganj-quiz/
├── pom.xml
├── README.md
├── database/
│   └── sirajganj_quiz_db.sql
└── src/main/
    ├── java/com/sirajganjquiz/
    │   ├── model/
    │   │   ├── Player.java
    │   │   ├── Question.java
    │   │   ├── QuizAttempt.java
    │   │   └── QuizAnswer.java
    │   │
    │   ├── dao/
    │   │   ├── DBConnection.java
    │   │   ├── PlayerDAO.java
    │   │   ├── QuestionDAO.java
    │   │   ├── QuizAttemptDAO.java
    │   │   └── QuizAnswerDAO.java
    │   │
    │   ├── controller/
    │   │   ├── HomeServlet.java
    │   │   ├── QuizStartServlet.java
    │   │   ├── QuizServlet.java
    │   │   ├── QuizSubmitServlet.java
    │   │   ├── ResultServlet.java
    │   │   ├── AdminLoginServlet.java
    │   │   ├── AdminDashboardServlet.java
    │   │   ├── QuestionServlet.java
    │   │   ├── PlayerServlet.java
    │   │   └── AttemptServlet.java
    │   │
    │   └── util/
    │       └── Small helper classes
    │
    ├── resources/
    │   └── db.properties
    │
    └── webapp/
        ├── index.jsp
        ├── css/
        │   └── style.css
        ├── js/
        │   └── app.js
        └── WEB-INF/
            ├── web.xml
            ├── jsp/
            │   ├── home.jsp
            │   ├── about.jsp
            │   ├── quiz.jsp
            │   ├── result.jsp
            │   ├── admin-login.jsp
            │   ├── admin-dashboard.jsp
            │   ├── questions.jsp
            │   ├── players.jsp
            │   └── attempts.jsp
            └── jspf/
                ├── header.jspf
                └── footer.jspf
```

---

## Quiz scoring

The quiz contains:

* **10 questions**
* **10 points** for each correct answer
* Maximum score = **100**

Examples:

```text
10 correct = 100
9 correct  = 90
7 correct  = 70
5 correct  = 50
0 correct  = 0
```

### Result messages

* **90–100:** Excellent! You know Sirajganj very well!
* **70–89:** Very Good!
* **50–69:** Good effort!
* **Below 50:** Keep learning about Sirajganj!

---

## Quiz categories

The initial 20 questions can be divided into:

### 1. Crops & Agriculture

Questions about:

* Major crops
* Agriculture
* Rice production
* Jute
* Agricultural activities
* Important agricultural areas

### 2. Academic Institutions

Questions about:

* Shahjadpur University College
* Government educational institutions
* Schools and colleges
* Sirajganj-related educational institutions
* Important academic establishments

### 3. Geography

Questions about:

* Sirajganj District
* Jamuna River
* Upazilas
* Rivers and geographical features
* District boundaries
* Important locations

---

## Admin CRUD

The admin can manage quiz questions.

### Create

Admin can add a new question with:

```text
Question
Option A
Option B
Option C
Option D
Correct Answer
Category
Difficulty
Active/Inactive
```

### Read

Admin can view all questions and use:

* Search
* Category filter
* Difficulty filter
* Active/inactive filter

### Update

Admin can edit existing questions.

### Delete

Admin can permanently delete questions.

### Activate / Deactivate

Inactive questions are not selected when a player starts a quiz.

---

## Player management

The admin can:

* View all players
* Search players
* Edit player information
* Delete players
* View player attempts

When a player is deleted, the player's quiz attempts and answers are also deleted because of:

```sql
ON DELETE CASCADE
```

---

## Quiz workflow

```text
Player
   ↓
Enter Name
   ↓
Start Quiz
   ↓
QuizStartServlet
   ↓
QuestionDAO
   ↓
MySQL
   ↓
Select 10 Random Active Questions
   ↓
HTTP Session
   ↓
quiz.jsp
   ↓
Player Answers
   ↓
QuizSubmitServlet
   ↓
Server Checks Answers
   ↓
Calculate Score
   ↓
Save Attempt + Answers
   ↓
MySQL Transaction
   ↓
Result Page
```

---

## Transaction handling

When the player submits the quiz, the application saves:

1. Quiz attempt
2. Score
3. Individual answers

inside **one database transaction**.

Conceptually:

```text
BEGIN TRANSACTION

Save quiz attempt

Save answer 1
Save answer 2
Save answer 3
...
Save answer 10

COMMIT
```

If something fails:

```text
ROLLBACK
```

This prevents incomplete quiz records from being saved.

---

## Important security rule

The correct answers must **not** be trusted from the browser.

The browser only sends the player's selected answers.

The server loads the correct answers from the database/session and calculates the score.

```text
Browser
   ↓
Player's answers
   ↓
Server
   ↓
Correct answers
   ↓
Compare
   ↓
Score
```

This prevents a player from simply changing the score using browser JavaScript.

---

## Demo checklist for viva

* [ ] Add a question.
* [ ] See it in the question list.
* [ ] Edit the question.
* [ ] Deactivate the question.
* [ ] Start a quiz.
* [ ] Verify the inactive question does not appear.
* [ ] Answer the 10 questions.
* [ ] Submit the quiz.
* [ ] Check the score.
* [ ] Open Admin → Attempts.
* [ ] View saved answers.
* [ ] Edit a player.
* [ ] Delete a player.
* [ ] Verify the player's attempts are also deleted.
* [ ] Activate the question again.
* [ ] Start another quiz.

---

## Screenshots

Add screenshots here after running the application:

### Home

```text
![Home Page](screenshots/home.png)
```

### Quiz

```text
![Quiz Page](screenshots/quiz.png)
```

### Result

```text
![Result Page](screenshots/result.png)
```

### Admin Questions

```text
![Admin Questions](screenshots/admin-questions.png)
```

---

## Future improvements

The question bank can be expanded with additional Sirajganj-related categories:

* History & Heritage
* Tourist Attractions
* Culture & Tradition
* Liberation War
* Famous Personalities
* Rivers & Natural Resources
* Upazila & Union Information
* Agriculture & Industry
* Local Literature
* Important Historical Places

New questions can be added through the existing admin CRUD without changing the overall application architecture.

---

## Sources used for quiz facts

Quiz facts should be verified using reliable and official sources, such as:

* [District Administration, Sirajganj](https://www.sirajganj.gov.bd/)
* [Bangladesh National Portal](https://bangladesh.gov.bd/)
* [Bangladesh Bureau of Statistics](https://bbs.portal.gov.bd/)
* [Bangladesh Water Development Board](https://www.bwdb.gov.bd/)

Use official government and institutional sources when creating or updating the 20 quiz questions.

---

## Learning purpose

This project is designed as a beginner-friendly example of a Java web application using:

```text
Java
  ↓
Servlet
  ↓
JSP
  ↓
JDBC
  ↓
MySQL
```

It demonstrates:

* MVC architecture
* Servlet request/response handling
* JSP page rendering
* JDBC database connection
* DAO pattern
* CRUD operations
* HTTP Session
* MySQL transactions
* PreparedStatement
* SQL queries
* Admin authentication
* Server-side quiz evaluation

There is **no Spring Boot, Hibernate, React, or other large framework**, making the project suitable for learning the fundamentals of Java web development.
