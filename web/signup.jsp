
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>

<html>
<head>
    <title>Common Entrace Test</title>
  <style>
    div
    {
      height:600px;
      width:400px;
      margin-left:28em;
      margin-top: 2em;
      border: 2px solid dimgray;
      border-radius: 10%;
      box-shadow: 10px 10px 5px black;
      color: cornflowerblue;
      font-family: cursive;


    }
    form
    {
      position: relative;
      margin-top: 3em;
      margin-left: 2em;
    }
    .input
    {
      height: 1.8em;
      width:330px;
      font-size: 1.5em;
      font-family: cursive;
      color: #0080FF;
      text-shadow: 3px 1px 0.5px black;


    }
    .submit
    {
      width:100px;
      height:2em;
      font-size: 1.5em;
      font-family: cursive;
      box-shadow: 3px 5px 2px black;
      margin-left: 4.5em;


    }
    .submit:hover
    {
      background-color: #0080FF;
    }
    .message
    {
      height:150px;
      margin-top: 10em;
      color:#0080FF;
    }
    .login
    {
      position: relative;
     text-align: center;

      color: #0080FF;
    }
    a{  text-decoration: none;}
    .login:hover
    {
      color: deepskyblue;
    }
    .msg
    {
      position: relative;
      text-align: center;
    }
    select
    {
      width:100px;
      height:1.5em;
      font-size: 1.2em;
      font-family: cursive;
      box-shadow: 3px 5px 2px black;
      color: #0080FF;
    }

  </style>
</head>
<body background="bg.jpg">
<%
  if("signup".equals(request.getParameter("signup")))
  {
    String email=request.getParameter("email").trim();
    String f_name=request.getParameter("f_name");
    String l_name=request.getParameter("l_name");
    long rollno=Long.parseLong(request.getParameter("rollno"));
    String pass=request.getParameter("pass");
    String gender=request.getParameter("gender");
    String year=request.getParameter("year");
    Connection con=null;
    try
    {
      Class.forName("oracle.jdbc.driver.OracleDriver");
      con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","system","~");
      PreparedStatement res=con.prepareStatement("insert into cet_users values(?,?,?,?,?,?,?,0,0,0,?,?,?,0,0,0)");
      res.setString(1, email);
      res.setString(2, f_name);
      res.setString(3, l_name);
      res.setString(4, pass);
      res.setLong(5, rollno);
      res.setString(6, gender);
      res.setString(7, year);
      long x=con.prepareStatement("select * from cet_users ").executeUpdate();
      res.setLong(8,x);
      res.setLong(9,x);
      res.setLong(10,x);
      res.executeUpdate();
      con.close();
      out.println("<div class=message> <h3 class=msg>You Have Successfully Registered.</h3>" +
              " <a href=\"index.jsp\"><h1 class=login>Login</h1></a></div> ");
    }catch(Exception e)
    {
      e.printStackTrace();
    }
    finally
    {

    }
  }
  else
  {
%>
<div >
  <form action="signup.jsp" method="post">
    <input type="email" name="email" value="" placeholder="Email" class="input"><br><br>
    <input type="text" name="f_name" value="" placeholder="First Name" class="input"><br><br>
    <input type="text" name="l_name" value="" placeholder="Last Name" class="input"><br><br>
    <input type="text" name="rollno" value="" placeholder="Rollno" class="input"><br><br>
    <input type="password" name="pass" value="" placeholder="Password" class="input"><br><br>
    Male:<input type="radio" name="gender" value="male">
    Female:<input type="radio" name="gender" value="female">
    &nbsp;
     Choose Year:<select name="year" >
      <option>1st</option>
      <option>2nd</option>
      <option>3rd</option>
      <option>4th</option>
    </select>
    <br><br>
    <input type="submit" name="signup" value="signup" class="submit"><br><br>

  </form>
</div>
<%
  }
%>



</body>
</html>
