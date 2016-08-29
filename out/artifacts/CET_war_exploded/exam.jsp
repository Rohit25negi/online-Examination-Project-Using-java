
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*,java.util.Random"%>
<%@ page import="java.util.Vector" %>
<html>
<head>
    <title></title>
  <style>
    body div
    {
      color:ghostwhite;
      font-family: cursive;
      font-size: 2em;
      height: 200px;
      width:70%;
      border: 2px solid gray;
      box-shadow: 5px 5px 2px black;
      border-radius: 10%;
      margin-top: 230px;
      margin-left: 200px;
      text-align: center;

    }
    body div a{
      color: ghostwhite;
      text-decoration: none;
      text-shadow: 2px 2px 2px black;
      border: 2px solid black;
      box-shadow: 2px 2px 2px black;
      border-radius: 4%;
    }
    body div a:visited{
      color: ghostwhite;
      text-decoration: none;
      text-shadow: 3px 5px 2px black;
      border: 2px solid black;
      box-shadow: 2px 2px 2px black;
      border-radius: 4%;
    }

    body div a:hover{
      background-color: #0080FF;
      color: black;
      border: 1px solid black;
      box-shadow: 2px 2px 2px black;
      text-shadow: 2px 2px 2px black;
    }
    form
    {
      font-family: cursive;
      color: ghostwhite;
      width: 60%;
      height: 500px;
      margin-top:100px;
      margin-left: 200px;
      border: 1px solid black;
      box-shadow: 5px 5px 2px black;
      text-shadow: 3px 3px 2px black;

    }
    form input
    {
      margin-left: 5em;
      background-color:cyan;
      font-size: 1.5em;
      box-shadow: 2px 2px 2px black;
      border-radius: 10%;



    }
    form input:hover
    {
      margin-left: 5em;
      background-color: #0080FF;
      font-size: 1.5em;
      box-shadow: 2px 2px 2px black;



    }
    form a{
      color: ghostwhite;
      text-decoration: none;
      text-shadow: 2px 2px 2px black;
      border: 2px solid black;
      box-shadow: 2px 2px 2px black;
      border-radius: 4%;
      float:left;
    }
    form  a:visited{
      color: ghostwhite;
      text-decoration: none;
      text-shadow: 3px 5px 2px black;
      border: 2px solid black;
      box-shadow: 2px 2px 2px black;
      border-radius: 4%;
    }

    form a:hover{
      background-color: #0080FF;
      color: black;
      border: 1px solid black;
      box-shadow: 2px 2px 2px black;
      text-shadow: 2px 2px 2px black;
    }
    form .btn
    {
      margin-right:10px;
      float:right;
    }

  </style>

</head>
<body background="bg.jpg">
<%!
  void validOperation(HttpServletRequest req,JspWriter out,ServletContext application)throws Exception
  {
    String type=req.getParameter("type").toUpperCase();
    Cookie c[]=req.getCookies();
    String email="",pass="";
    for(Cookie xx:c)
      if(xx.getName().equals("email"))email=xx.getValue();
      else if(xx.getName().equals("pass"))pass=xx.getValue();

    Class.forName("oracle.jdbc.driver.OracleDriver");
    Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","system","~");
    PreparedStatement pre=con.prepareStatement("select * from CET_EXAM_REC where examcode=? and email=? and pass=?");
    pre.setString(1,type);
    pre.setString(2,email);
    pre.setString(3,pass);
    ResultSet res=pre.executeQuery();
    if(res.next())
    {
        if(res.getString("status").equalsIgnoreCase("done"))
        {
          out.print("<div >You Have Already Given This Exam<br> Your Marks :"+res.getLong("score")+"<br><br>" +
                  "<a href=userspace.jsp>Home</a></div>");
        }
        else {

          startExam(Integer.parseInt(res.getString("status")), type, email, pass, out, con);}
    }
    else
    {
      startExam(0, type, email, pass, out, con);}
    con.close();
  }
  void startExam(int n,String type,String email,String pass,JspWriter out,Connection con)throws Exception
  {

    if(n==0)
    {

      Random ran=new Random();
      String A="";int x;
      for(int i=0;i<10;i++)
      {
            while(true) {

              x = ran.nextInt(10);
              if(!A.contains((char)('A'+x)+""))
              {
                A=A+(char)('A'+x);
                break;
              }

            }

      }

      PreparedStatement pre=con.prepareStatement("insert into CET_EXAM_REC values(?,?,?,?,?,?)");
      pre.setString(1,type);
      pre.setString(2,email);
      pre.setString(3,pass);
      pre.setString(4,"1");
      pre.setInt(5, 0);
      pre.setString(6, A);
      pre.executeUpdate();

      startExam(1, type, email, pass, out, con);
    }
    else
    {

      PreparedStatement pre,pre2;
      ResultSet res,res2;
      pre=con.prepareStatement("select * from " + type);
      res=pre.executeQuery();
      pre2=con.prepareStatement("select * from CET_EXAM_REC where email=? and pass=?");
      pre2.setString(1,email);
      pre2.setString(2,pass);
      res2=pre2.executeQuery();

      res2.next();
      String A=res2.getString("pattern");

      String questions[][]=new String[1][6];int i=0;
      while(res.next())
      {
          i++;
        if(i==A.charAt(n-1)-64)break;
      }
      questions[0][0]=res.getString("ques");
      questions[0][1]=res.getString("op1");
      questions[0][2]=res.getString("op2");
      questions[0][3]=res.getString("op3");
      questions[0][4]=res.getString("op4");
      questions[0][5]=res.getString("correct");
      String value;
      if(n==10)value="evaluate";
      else value="next";
      con.close();
      out.print("<form action=evaluate.jsp method=post>");
      out.print("<h2>QUESTION "+n+":-"+questions[0][0]+"</h2><br>");
      out.print("<input  type=radio name=choice value=\""+questions[0][1]+"\">"+questions[0][1]+"<br><br>");
      out.print("<input type=radio name=choice value=\""+questions[0][2]+"\">"+questions[0][2]+"<br><br>");
      out.print("<input type=radio name=choice value=\""+questions[0][3]+"\">"+questions[0][3]+"<br><br>");
      out.print("<input type=radio name=choice value=\""+questions[0][4]+"\">"+questions[0][4]+"<br><br>");
      out.print("<input type=hidden name=correct value=\""+questions[0][5]+"\">" +
              "<input type=hidden name=number value="+n+"><br>"+
              "<a href=userspace.jsp>Leave and Continue later</a><br>" +
              "<input class=btn type=submit name=next value="+value+">" +

              "<input type=hidden name=type value="+type+">" +
              "</form>");

    }

  }

%>
<%

Cookie C[]=request.getCookies();
if(C==null||C.length<3)
{
response.sendRedirect("index.jsp?error=Invalid_User");
}
else
{try {
  validOperation(request, out,application);
}catch(Exception ex)
{
  ex.printStackTrace();
}
}
  %>
</body>
</html>
