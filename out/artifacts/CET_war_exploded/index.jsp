
<html>
  <head>
    <title>Common Entrance Test</title>
    <style>
      div
      {
        height:400px;
        width:400px;
        margin-left:28em;
        margin-top: 12em;
        border: 2px solid dimgray;
        border-radius: 10%;
        box-shadow: 10px 10px 5px black;



      }
      form
      {
        position: relative;
        margin-top: 3em;
        margin-left: 2em;
      }
      .input
      {
      height: 2em;
        width:330px;
        font-size: 2em;
        font-family: cursive;
        color: cornflowerblue;
        text-shadow: 3px 2px 0.5px black;

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
      .warning
      {
        color:Red;
        font-family: cursive;
      }
      a{
        margin-left: 4.7em;
        font-size: 1.5em;
        font-family: cursive;
        text-decoration: none;

        text-shadow: 3px 2px 0.5px black;
      }

      a:visited
      {
        color:blue;
      }
      a:hover
      {
        color: cornflowerblue;
      }

    </style>
  </head>
  <body background="bg.jpg">
  <div class="form">
    <form action="auth.jsp" method="post">
      <input type="email" name="email" value="" placeholder="Email" class="input"><br><br><br>
     <input type="password" name="pass" value="" placeholder="Password" class="input"><br>
      <%
        if ("Invalid_User".equals(request.getParameter("error")))
          out.print("<font class=\"warning\">Invalid Email/Password</font>");
      %>

     <br><br><input type="submit" name="submit" value="login" class="submit"><br><br>
      <a href="signup.jsp"><b>Sign Up</b></a>
    </form>
  </div>
  </body>
</html>
