<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Common Entrance Test</title>
</head>
<body background="bg.jpg">
<%
  if(request.getParameter("submit")==null)
  {response.sendRedirect("index.jsp?error=Invalid_User");}
  else
  {String email=request.getParameter("email").trim();
    String pass=request.getParameter("pass");
    Connection con=null;
    try {Class.forName("oracle.jdbc.driver.OracleDriver");
      con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system", "~");
      Statement res = con.createStatement();
      //res.setString(1,email);
      //res.setString(2,pass);
      ResultSet resp=res.executeQuery("select * from cet_users where email='"+email+"' and pass='"+pass+"'");
      if(resp.next())
      {
       Cookie C1=new Cookie("email",email);
       Cookie C2=new Cookie("pass",pass);
       response.addCookie(C1);
        response.addCookie(C2);
        con.close();
        response.sendRedirect("userspace.jsp");}
      else
      {con.close();
        response.sendRedirect("index.jsp?error=Invalid_User");}
    }catch(Exception e)
    {e.printStackTrace();
    }
  }
%>
</body>
</html>