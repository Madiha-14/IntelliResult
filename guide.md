##GUIDE TO SETUP STUDENT RESULTS JAVA Project  ......
 ~irr
---

🧱 STEP 0 — Install Required Things

1. Install Java JDK

Download JDK (17 or above)

Install it

Set environment variable:


JAVA_HOME = C:\Program Files\Java\jdk-17


---

2. Install Eclipse IDE (Enterprise Edition)

Download: 👉 Eclipse IDE for Enterprise Java and Web Developers


---

3. Install Apache Tomcat

Download Tomcat (v9 or v10)

Extract it somewhere like:


C:\apache-tomcat-9


---

4. Install MySQL

Install MySQL Server

Remember:

username = root

password = your_password




---

🗄️ STEP 1 — Setup Database

Open MySQL Workbench or CLI and run:

CREATE DATABASE studentdb;

USE studentdb;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50),
    password VARCHAR(50)
);

INSERT INTO users VALUES (1, 'student1', '1234');

CREATE TABLE results (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50),
    subject VARCHAR(50),
    marks INT
);

INSERT INTO results VALUES
(1, 'student1', 'Math', 85),
(2, 'student1', 'Science', 90);


---

🧩 STEP 2 — Setup Eclipse for Web Dev

1. Open Eclipse

2. Create Dynamic Web Project

File → New → Dynamic Web Project

Fill:

Project Name: StudentResultSystem
Target Runtime: Apache Tomcat (add it if not listed)
Dynamic Web Module Version: 3.1

Click Finish


---

🔌 STEP 3 — Add Tomcat to Eclipse

If not configured:

Window → Preferences → Server → Runtime Environments → Add
→ Apache Tomcat v9
→ Browse Tomcat folder
→ Finish


---

📦 STEP 4 — Add MySQL Connector (VERY IMPORTANT)

Download:

MySQL Connector J (JDBC Driver)

Add in Eclipse:

Right click project → Build Path → Configure Build Path
→ Libraries → Add External JARs
→ Select mysql-connector-j.jar


---

📁 STEP 5 — Create Project Files

Now IR, follow structure carefully 👇


---

📄 1. Create Java Package

Right Click src → New → Package → name: com.app


---

🔌 2. DBConnection.java

Right click package → New → Class

package com.app;

import java.sql.*;

public class DBConnection {
    public static Connection getConnection() {
        Connection con = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/studentdb",
                "root",
                "password" // change this
            );

        } catch (Exception e) {
            e.printStackTrace();
        }
        return con;
    }
}


---

🔐 3. LoginServlet.java

package com.app;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String user = request.getParameter("username");
        String pass = request.getParameter("password");

        try {
            Connection con = DBConnection.getConnection();

            String query = "SELECT * FROM users WHERE username=? AND password=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, user);
            ps.setString(2, pass);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);

                response.sendRedirect("dashboard.html");
            } else {
                response.getWriter().println("Invalid Login");
            }

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}


---

📊 4. ResultServlet.java

package com.app;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class ResultServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String user = (String) session.getAttribute("user");

        try {
            Connection con = DBConnection.getConnection();

            String query = "SELECT * FROM results WHERE username=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, user);

            ResultSet rs = ps.executeQuery();

            request.setAttribute("resultSet", rs);

            RequestDispatcher rd = request.getRequestDispatcher("showResult.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}


---

🌐 STEP 6 — Create Web Files

Inside:

WebContent → Right Click → New → HTML File


---

🖥️ login.html

<!DOCTYPE html>
<html>
<head>
<title>Login</title>
<style>
body { text-align:center; margin-top:100px; font-family:Arial; }
input { padding:10px; margin:10px; }
</style>
</head>

<body>

<h2>Login</h2>

<form action="LoginServlet" method="post">
<input type="text" name="username" placeholder="Username" required><br>
<input type="password" name="password" placeholder="Password" required><br>
<button type="submit">Login</button>
</form>

</body>
</html> 

---

📊 dashboard.html

<!DOCTYPE html>
<html>
<head>
<title>Dashboard</title>

<style>
body { text-align:center; margin-top:50px; font-family:Arial; }
</style>

<script>
function loadResults() {
    window.location.href = "ResultServlet";
}
</script>

</head>

<body>

<h2>Dashboard</h2>
<button onclick="loadResults()">View Results</button>

</body>
</html>


---

📄 showResult.jsp

Right click → New → JSP File

<%@ page import="java.sql.*" %>

<html>
<body>

<h2>Results</h2>

<table border="1">
<tr>
<th>Subject</th>
<th>Marks</th>
</tr>

<%
ResultSet rs = (ResultSet) request.getAttribute("resultSet");

while(rs.next()) {
%>

<tr>
<td><%= rs.getString("subject") %></td>
<td><%= rs.getInt("marks") %></td>
</tr>

<%
}
%>

</table>

</body>
</html>


---

⚙️ STEP 7 — Configure web.xml

Go to:

WebContent → WEB-INF → web.xml

Paste:

<web-app>

<servlet>
<servlet-name>LoginServlet</servlet-name>
<servlet-class>com.app.LoginServlet</servlet-class>
</servlet>

<servlet-mapping>
<servlet-name>LoginServlet</servlet-name>
<url-pattern>/LoginServlet</url-pattern>
</servlet-mapping>

<servlet>
<servlet-name>ResultServlet</servlet-name>
<servlet-class>com.app.ResultServlet</servlet-class>
</servlet>

<servlet-mapping>
<servlet-name>ResultServlet</servlet-name>
<url-pattern>/ResultServlet</url-pattern>
</servlet-mapping>

</web-app>


---

▶️ STEP 8 — Run Project

1. Right Click Project

Run As → Run on Server

2. Choose Tomcat

3. Open Browser

http://localhost:8080/StudentResultSystem/login.html


---

🔥 TEST LOGIN

username: student1
password: 1234


---

⚠️ COMMON ERRORS (VERY IMPORTANT)

❌ 404 Error

→ Check URL mapping in web.xml

❌ DB Not Connecting

→ Check:

password

MySQL running

connector jar added


❌ ClassNotFoundException

→ JDBC jar missing


