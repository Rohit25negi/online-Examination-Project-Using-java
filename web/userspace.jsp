
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<html>
<head>
    <title>Common Entrance Test</title>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
  <script>
    $(document).ready(function(){
      $(".heading1").click(function(){
        $(".data1").slideToggle("medium");
      });
    });
    $(document).ready(function(){
      $(".heading2").click(function(){
        $(".data2").slideToggle("medium");
      });
    });
    $(document).ready(function(){
      $(".heading3").click(function(){
        $(".data3").slideToggle("medium");
      });
    });
    $(document).ready(function(){
      $(".heading4").click(function(){
        $(".data4").slideToggle("medium");
      });
    });
  </script>
  <style>
    .menu
    {
      width:90%;
      height: auto;
      border-bottom: 2px solid white;
      margin-left: 2em;
      border-radius:3% ;
      box-shadow: 3px 2px 2px black;
    }
    .field
    {
    width: 90%;
      height: auto;
      border: 2px solid white;
      border-radius:2%;
      box-shadow: 3px 2px 2px black;
      margin-left: 2em;
      color:white;

    }
    .field h2,table
    {
      color:ghostwhite;
      font-family: cursive;



    }
    .field table{display:none;}
    .field table tr td{
      width:300px;
    }
    .field div table{
      color:white;
      display: table;
      margin-left: 200px;
      text-shadow: 5px 5px 2px black;
      border: 2px solid black;
      box-shadow: 3px 3px 3px black;
      border-radius: 5%;
    }
    .field div  table tr td{
      text-align: center;
      color:cyan;
    }
    .field div  table tr th{
      text-align: center;
      font-size:1.5em;
    }
    .field a
    {
      color: ghostwhite;
      text-decoration: none;
      font-family: cursive;

    }
    .field a h3:hover
    {
      background-color: #0080FF;
      color:black;
      text-decoration: none;
    }
    .field a:visited
    {
      color: ghostwhite;
      text-decoration: none;

    }
    .field div
    {
      color:white;
    }


    .menu ul
    {
      height:auto;
      width:auto;
      position:relative;
      display:inline-block;
      color:ghostwhite;
      font-family: cursive;
      margin-left: 10px;
      list-style: none;
      text-shadow: 2px 2px 2px black;
    }
    .menu ul li{
      border-bottom: 1px solid gray;
      border-right: 1px solid gray;
      box-shadow: 3px 2px 3px black;
      font-size: 1.5em;
      text-align: center;
      float:left;
      height: 1.5em;
      width:200px;
      margin-left: 20px;
    }

    .menu ul li:hover{
      background-color: #0080FF;
      color:black;


    }
    .menu ul li ul{
      list-style: none;
      padding: 0;
      margin-left: -20px;
      display: none;
    }
    .menu ul li:hover ul{
      display: block;
    }
    .menu ul a
    {
      color:ghostwhite;
    }
    .menu ul a:visited
    {
      color:ghostwhite;
    }





  </style>
</head>
<body background="bg.jpg">
<%!
  void profile(JspWriter P,Connection con,HttpServletRequest req)throws java.io.IOException,SQLException
  {
    PreparedStatement pre=con.prepareStatement("select * from cet_users where email=? and pass=?");
    Cookie c[]=req.getCookies();
    String email="",pass="";
    for(Cookie xx:c)
      if(xx.getName().equals("email"))email=xx.getValue();
      else if(xx.getName().equals("pass"))pass=xx.getValue();

    pre.setString(1, email);
    pre.setString(2, pass);
    ResultSet res=pre.executeQuery();
    if(res.next())
    {
      P.print("<hr><h2 class=heading1>Personals</h2>" +
              "" +
              "<table align=center class=data1>" +
              "<tr> <td> NAME</td><td>"+res.getString("f_name")+" "+res.getString("l_name")+"</td>" +
              "</tr>" +
              "<tr><td>Email</td><td>" +res.getString("email")+"</td></tr>"+
              "<tr><td>Gender</td><td>" +res.getString("gender")+"</td></tr>"+
              "<tr><td>Roll Number</td><td>" +res.getString("rollno")+"</td></tr>"+
              "<tr><td>year</td><td>" +res.getString("year")+"</td></tr>"+
              "</table>");
      P.print("<hr><h2 class=heading2>Exams Attended</h2>" +
              "" +
              "<table align=center class=data2>" +
              "<tr> <td> C</td><td>"+res.getLong("givenC")+"</td>" +
              "</tr>" +
              "<tr><td>C++</td><td>" +res.getLong("givenCPP")+"</td></tr>"+
              "<tr><td>JAVA</td><td>" +res.getLong("givenJAVA")+"</td></tr>"+
              "</table>");
      P.print("<hr><h2 class=heading3>TOTAL SCORE</h2>" +
              "" +
              "<table align=center class=data3>" +
              "<tr> <td> C</td><td>"+res.getLong("scoreC")+"</td>" +
              "</tr>" +
              "<tr><td>C++</td><td>" +res.getLong("ScoreCPP")+"</td></tr>"+
              "<tr><td>JAVA</td><td>" +res.getLong("scoreJAVA")+"</td></tr>"+
              "</table>");
      P.print("<hr><h2 class=heading4>Rank</h2>" +
              "" +
              "<table align=center class=data4>" +
              "<tr> <td> C</td><td>"+res.getLong("rankC")+"</td>" +
              "</tr>" +
              "<tr><td>C++</td><td>" +res.getLong("rankCPP")+"</td></tr>"+
              "<tr><td>JAVA</td><td>" +res.getLong("rankJAVA")+"</td></tr>"+
              "</table>");

    }
  }
  void logout(HttpServletResponse resp,Connection con )throws Exception
  { Cookie C=new Cookie("email",null);
    C.setMaxAge(0);
    resp.addCookie(C);
    C=new Cookie("pass",null);
    C.setMaxAge(0);
    resp.addCookie(C);
    con.close();
    resp.sendRedirect("index.jsp");
  }
  void exam(JspWriter out,Connection con,String type,HttpServletRequest req )throws SQLException,java.io.IOException
  { Cookie c[]=req.getCookies();
    String email="",pass="";
    for(Cookie xx:c)
      if(xx.getName().equals("email"))email=xx.getValue();
      else if(xx.getName().equals("pass"))pass=xx.getValue();

    PreparedStatement pre=con.prepareStatement("select * from tab where TNAME like ?");
   PreparedStatement pre2=con.prepareStatement("select * from cet_exam_rec where examcode=? and email=? and pass=?");
    pre.setString(1,"EXAM"+type.toUpperCase()+"_");
    pre2.setString(2,email);
    pre2.setString(3, pass);
    ResultSet res=pre.executeQuery(),res2=null;
    String op="";
    while(res.next())
    {
      pre2.setString(1,res.getString("TNAME"));
      res2=pre2.executeQuery();
      if(res2.next())
      {
        if(res2.getString("status").equals("done"))
        op="score";
        else
          op="cont";

      }
      else
      {op="start";
      }
      out.print("<a href=exam.jsp?type="+res.getString("TNAME")+"><h3 align=center>" +res.getString("TNAME")+": ");
      if(op.equals("start"))
        out.print("    START");
      else if(op.equals("score"))
           out.print("    VIEW SCORE");
      else out.println("     CONTINUE");

      out.print("</h3></a>");


    }



  }
  void score(JspWriter out,Connection con,String type,HttpServletRequest req)throws Exception
  {
    Cookie c[]=req.getCookies();
    String email="",pass="";

    for(Cookie xxx: c)
    {
      if("email".equals(xxx.getName()))email=xxx.getValue();
     else  if("pass".equals(xxx.getName()))pass=xxx.getValue();
    }

    String xx="EXAM"+type.toUpperCase()+"_";

    PreparedStatement pre=con.prepareStatement("select * from cet_exam_rec where examcode like '"+xx+"' and email=? and pass=? and status='done'");

    pre.setString(1, email);
    pre.setString(2,pass);
    int n=pre.executeUpdate();
    ResultSet res=pre.executeQuery();
    if(n==0)
      out.println("<div><table><tr><th> you have not given any exam of this type</th></tr></table></div>");
    else {
      out.println("<div><table><tr><th>EXAM NAME</th><th>SCORE</th></tr>");
      while (res.next()) {
        out.print("<tr><td>" + res.getString("examcode") + "</td><td>" + res.getLong("score") + "</td></tr>");
      }
      out.println("</table></div>");
    }
  }
  void rank(JspWriter out,Connection con,String type,HttpServletRequest req)throws Exception
  {
    String XXX="rank"+type;
    PreparedStatement pre=con.prepareStatement("select * from cet_users order by "+XXX);
    ResultSet res=pre.executeQuery();
    out.println("<div ><table><tr><th>RANK</th><th>NAME</th><th>score</th></tr>");
    while(res.next())
    {
      out.print("<tr><td>"+res.getLong(XXX)+"</td><td>"+res.getString("f_name")+" "+res.getString("l_name")+"</td>" +
              "<td>"+res.getInt("score"+type)+"</td></tr>");
    }
    out.println("</table></div>");
  }
%>
<%
  Cookie C[]=request.getCookies();
  if(C==null||C.length<3)
  {
    response.sendRedirect("index.jsp?error=Invalid_User");
  }
 else
  {try
  {Class.forName("oracle.jdbc.driver.OracleDriver");
    Connection Con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","system","~");


%>
<div class="menu">
  <img src="dp.jpg"  height="160px" width="1200px" alt="">
  <ul>
    <a href="userspace.jsp?choice=profile"><li>Profile</li></a>

    <li >Exams
    <ul>
      <a href="userspace.jsp?choice=exam&type=c"><li>C</li></a>
      <a href="userspace.jsp?choice=exam&type=cpp"><li>C++</li></a>
      <a href="userspace.jsp?choice=exam&type=java"><li>Java</li></a>
    </ul></li>
    <li >Your score
      <ul>
        <a href="userspace.jsp?choice=score&type=c"><li>C</li></a>
        <a href="userspace.jsp?choice=score&type=cpp"><li>C++</li></a>
        <a href="userspace.jsp?choice=score&type=java"><li>Java</li></a>
      </ul>
    </li>
    <li >Rank list
      <ul>
        <a href="userspace.jsp?choice=rank&type=c"><li>C</li></a>
        <a href="userspace.jsp?choice=rank&type=cpp"><li>C++</li></a>
        <a href="userspace.jsp?choice=rank&type=java"><li>Java</li></a>
      </ul>
    </li>
    <a href="userspace.jsp?choice=logout"><li>Logout</li></a>
  </ul>
  </div>
  <br>
<div class="field">
  <%
    if("profile".equals(request.getParameter("choice")))
      profile(out,Con,request);
    else if("logout".equals(request.getParameter("choice")))
      logout(response,Con);
    else if("exam".equals(request.getParameter("choice")))
    {
        exam(out,Con,request.getParameter("type"),request);
    }
    else if("score".equals(request.getParameter("choice")))
    {
      score(out, Con, request.getParameter("type"),request);
    }
    else if("rank".equals(request.getParameter("choice")))
    {
      rank(out, Con, request.getParameter("type"),request);
    }
  %>
</div>
<%
    }catch(Exception ex){} }
%>
</body>
</html>
