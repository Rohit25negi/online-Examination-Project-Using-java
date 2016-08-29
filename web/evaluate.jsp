<%@ page import="java.util.Vector,java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>lo ji kallo bat</title>
  <style>
    h1
    {
      color:ghostwhite;
      font-family: cursive;
      font-size: 2em;
      text-align: center;
      text-shadow: 3px 3px 3px black;
    }

    div table tr th{
      color:ghostwhite;
      font-family: cursive;
      font-size: 1.5em;
      text-align: center;
      text-shadow: 3px 3px 3px black;
      width:400px;}
    div {
      color:ghostwhite;
      font-family: cursive;
      margin-left:280px ;
      font-size: 1.5em;
      margin-top: 0px;
      text-align: center;
      text-shadow: 3px 3px 3px black;
      width:800px;
    border: 2px solid darkgray;
      box-shadow: 3px 3px 3px black;
    }

    div table tr td{
      color:ghostwhite;
      font-family: cursive;
      font-size: 1em;
      text-align: center;
      text-shadow: 3px 3px 3px black;
      width:400px;

    }
    body a{
      color: ghostwhite;
      text-decoration: none;
      text-shadow: 2px 2px 2px black;
      border: 2px solid black;
      box-shadow: 2px 2px 2px black;
      border-radius: 4%;
      font-family: cursive;
      margin-left: 650px;
      font-size: 1.5em;
    }
    body a:visited{
      color: ghostwhite;
      text-decoration: none;
      text-shadow: 3px 5px 2px black;
      border: 2px solid black;
      box-shadow: 2px 2px 2px black;
      border-radius: 4%;
    }

    body  a:hover{
      background-color: #0080FF;
      color: black;
      border: 1px solid black;
      box-shadow: 2px 2px 2px black;
      text-shadow: 2px 2px 2px black;
    }
  </style>

</head>
<body background="bg.jpg">

<%
  try {
  Cookie C[]=request.getCookies();
  if(C==null||C.length<3)
  {
    response.sendRedirect("index.jsp?error=Invalid_User");
  }

    else{

      Class.forName("oracle.jdbc.driver.OracleDriver");
      Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system", "~");

      PreparedStatement pre;
      String email = "", pass = "";
      for (Cookie xx : C) {
        if (xx.getName().equalsIgnoreCase("email")) email = xx.getValue();
        if (xx.getName().equalsIgnoreCase("pass")) pass = xx.getValue();
      }
      String choice = request.getParameter("choice");
      if (request.getParameter("next")==null) {
        con.close();
        response.sendRedirect("userspace.jsp");
      } else if(choice==null)
      {
        con.close();
        response.sendRedirect("exam.jsp?type="+request.getParameter("type"));
      }
      if (!request.getParameter("number").equals("10")) {


        pre = con.prepareStatement("insert into user_exam_status values(?,?,?,?,?)");
        pre.setString(1, email);
        pre.setString(2, pass);
        pre.setString(3, request.getParameter("type"));
        pre.setString(4, request.getParameter("correct"));
        pre.setString(5, choice);
        pre.executeUpdate();

        pre = con.prepareStatement("update CET_EXAM_REC set status=? where email=? and pass=? and examcode=?");
        pre.setString(1, Integer.parseInt(request.getParameter("number")) + 1 + "");
        pre.setString(2, email);
        pre.setString(3, pass);
        pre.setString(4, request.getParameter("type"));
        pre.executeUpdate();
        con.close();
        response.sendRedirect("exam.jsp?type=" + request.getParameter("type"));


      } else {


        pre = con.prepareStatement("insert into user_exam_status values(?,?,?,?,?)");
        pre.setString(1, email);
        pre.setString(2, pass);
        pre.setString(3, request.getParameter("type"));
        pre.setString(4, request.getParameter("correct"));
        pre.setString(5, choice);
        pre.executeUpdate();

        pre=con.prepareStatement("select * from user_exam_status where email=? and pass=? and examcode=?");
        pre.setString(1,email);
        pre.setString(2,pass);
        pre.setString(3,request.getParameter("type"));
        ResultSet res=pre.executeQuery();
        int x=0,i=1;
        out.println("<h1> Test Result</h1><div><table><tr><th>Question No.</th>" +
                "<th>correct answer</th><th> your answer</th></tr>");
        while(res.next())
        {out.print("<tr><td>" + (i++) + "</td><td>");
          out.print(res.getString("correct")+"</td><td>"+res.getString("choice")+"</td></tr>");
          if( res.getString("correct").equals(res.getString("choice")))
            x++;

        }

        out.println("</table><br>");
        out.println("Total:         "+10);
        out.println("<br>obtained:  "+x+"</div><br>");
        out.print("<a href=userspace.jsp>Home</a><br>");


        pre=con.prepareStatement("delete from user_exam_status where email=? and pass=? and examcode=?");
        pre.setString(1, email);
        pre.setString(2,pass);
        pre.setString(3,request.getParameter("type"));
        pre.executeUpdate();

        pre=con.prepareStatement("update cet_exam_rec set status=?,score=? where email=? and pass=?");
        pre.setString(1, "done");
        pre.setInt(2,x);
        pre.setString(3,email);
        pre.setString(4,pass);
        pre.executeUpdate();


        pre=con.prepareStatement("select *  from cet_users where email=? and pass=?");
        pre.setString(1,email);
        pre.setString(2,pass);
        res=pre.executeQuery();
        int given=0,score=0;
        String type=request.getParameter("type");
        type=type.substring(type.lastIndexOf('M') + 1, type.length() - 1);

        if(res.next())
        {
          given=res.getInt("given"+type);
          score=res.getInt("score"+type);

        }
        String g="GIVEN"+type,s="SCORE"+type,r="rank"+type;
        String quer="update cet_users set "+g+"="+(given+1)+","+s+"="+(score+x)+" where email='"+email+"' and pass='"+pass+"'";

        Statement pr=con.createStatement();
        pr.executeUpdate(quer);

        pre=con.prepareStatement("select * from cet_users order by "+s+" desc");
        res=pre.executeQuery();
        String temp_email,temp_pass;
        int xx=1;
        while(res.next())
        {
          temp_email=res.getString("email");
          temp_pass=res.getString("pass");
          pre=con.prepareStatement("update cet_users set "+r+"=? where email=? and pass=?");
          pre.setInt(1,xx++);
          pre.setString(2,temp_email);
          pre.setString(3,temp_pass);
          pre.executeUpdate();
        }



      }
    con.close();
    }

  }catch(Exception ex)
    {
         System.out.println(ex);
    }

%>
</body>
</html>
