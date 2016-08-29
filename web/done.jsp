<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Random" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>



<html>
<head>
  <title>Lazy Paper Generator</title>
  <link rel="stylesheet" href="css/generator.css">
</head>
<body>

<div id="form_div">
  <h1>On The Way o.O!!</h1>
  <%!
    //###################################################TestPattern class #################
    static class TestPattern {

      String syl;
      int no_of_sec;
      String secs[][],choice[][];
      TestPattern(int n,String secs[][],String choice[][],String syl)
      {
        int i=1;
        no_of_sec=n;
        this.secs=secs;
        this.choice=choice;
        this.syl=syl;

      }
    }

//#######################################################################################

    //#################################################Papers################################
   static  class Papers
    {ArrayList<Question>encoded_paper;
      Papers(ArrayList<Question>p)
      {
        encoded_paper=p;
      }

      void insert()
      {

      }
     static  ArrayList<Papers> read()throws Exception
      {   int i=0;
        ArrayList<Papers>list=new ArrayList();
        ArrayList<Question>list2=new ArrayList();
        Class.forName("com.mysql.jdbc.Driver");
        Connection con=DriverManager.getConnection("jdbc:mysql://127.6.95.130:3306/blazeroom","adminPnLMkaN","PEPWJqe5G1LA");
        while(true)
        {   list2.clear();
          try{
            PreparedStatement pre=con.prepareStatement("select * from paper"+(i++));
            ResultSet res=pre.executeQuery();
            while(res.next())
            {
              list2.add(new Question(res.getString("q_id"),null,null,0,null));
            }
            list.add(new Papers(list2));
          }catch(Exception e)
          {
            break;
          }

        }
        return list;
      }

    }

//#######################################################################################

//#####################################################Question##########################

   static class Question {

      String qid,ques,qtype;
      int qdifficulty;
      String f=null;
      Question(String a,String b,String c,int d,String belongs)
      {
        qid=a;
        ques=b;
        qtype=c;
        qdifficulty=d;

        this.f=belongs;
      }




      static ArrayList<Question> read(String db,String table)throws Exception
      {  ArrayList<Question> list=new ArrayList();
        Class.forName("com.mysql.jdbc.Driver");
        Connection con=DriverManager.getConnection("jdbc:mysql://127.6.95.130:3306/"+db,"adminPnLMkaN","PEPWJqe5G1LA");
        PreparedStatement pre=con.prepareStatement("select * from "+table);
        ResultSet res=pre.executeQuery();
        while(res.next())
        {
          list.add(new Question(res.getString("q_id"),res.getString("ques"),res.getString("type"),res.getInt("difficulty"),res.getString("belongs")));
        }
        con.close();
        return list;

      }



    }

//###########################################################################3333


    static TestPattern t;
          int diff,distinct=5;
    ArrayList<Question>encoded_paper;
    static ArrayList<Question> pop[];
    ArrayList<Question> hard2[];
    ArrayList<Question> simple2[];
    ArrayList<Question> normal2[];
    ArrayList<Question> list[];
    static String temp1;
          static int temp2,temp3;
//############################################# handling method ############################################

     ArrayList<Question> create(int n,int m,String secs[][],String choice[][],String syl)throws Exception
    {
      t=new TestPattern(n,secs,choice,syl);

      pop=createInitPop(m); // are are yaha bhai
      if(pop!=null)
      {int[][]fitness=new int[pop.length][];


        if(pop!=null) {
          fitness = evaluate();
          if(fitness!=null)
          {


            // new Papers().createPaper(pop[fitness[0][1]],p.diff,p.distinct,ReadyPaper.t);

            for (int i = 1; i <= 50 * distinct; i++) {


              crossover(fitness);

              if (new Random().nextInt(10) > 4) ;//p.mutation();
              fitness = evaluate();
            }
          return pop[0];

          }
          else
          {
            //  new Papers(ReadyPaper.t, p.distinct, p.diff, pop[new Random().nextInt(pop.length)]).insert();
return pop[0];
          }
        }
      }
      return null;
    }


//#########################################################################################################


    //###############################################mutation####################################

    void mutation()
    {
      Random rand=new Random();
      int x=rand.nextInt((int)(pop.length*.1)),k,add;

      ArrayList<Question> A;
      ArrayList<Integer> selected=new ArrayList();
      ArrayList<Integer>geneSel=new ArrayList();
      ArrayList<Question> yoyo;

      for(int i=0;i<x;i++)
      {   while(true)
      {
        int m=rand.nextInt(pop.length);
        if(!selected.contains(m))
        {
          selected.add(m);break;
        }

      }
      }

      for(int i=0;i<x;i++)
      {A=pop[selected.get(i)];

        geneSel.clear();
        for(int j=0;j<A.size()*.4;j++)
        {
          while(true)
          {int m=rand.nextInt(A.size());
            if(!geneSel.contains(m)){geneSel.add(m);break;}
          }
        }

        for(int j=0;j<geneSel.size();j++)
        {int sec=-1;
          if((A.get(geneSel.get(j)).qid+"").equals("null"))continue;

          for(int find=0;find<geneSel.get(j);find++)
          {
            if((A.get(find).qid+"").equals("null"))sec++;
          }
          yoyo=new ArrayList(list[sec]);
          for(int del=0;del<A.size();del++)
          {
            for(int dellist=0;dellist<yoyo.size();dellist++)
              if((A.get(del).qid+"").equals(yoyo.get(dellist).qid+""))
              {
                yoyo.remove(dellist);dellist--;
              }
          }
          ArrayList<Question>tempo=new ArrayList(yoyo);
          for(int sexo=0;sexo<tempo.size();sexo++)
            if(!(A.get(geneSel.get(j)).f.toString()).equals(tempo.get(sexo).toString()))
            {tempo.remove(sexo--);}

          if(!tempo.isEmpty())
            A.set(geneSel.get(j),tempo.get(rand.nextInt(tempo.size())));
            //if(add==yoyo.size())
          else A.set(geneSel.get(j),yoyo.get(rand.nextInt(yoyo.size())));

        }
      }
    }
    //########################################ends######################################3

    //###################################### reproduction##########################
    void crossover(int fitness[][])
    {

      int x=(int)(fitness.length*0.1),p1,p2,add;
      Random rand=new Random(),rand2=new Random();
      ArrayList<Question>A;
      Question temp;
      int g,sec=-1;
      ArrayList<Question>list2;

      for(int i=0;i<x;i++)
      {

        A=new ArrayList();
        sec=-1;
        p1=fitness[rand.nextInt(fitness.length/2)][1];

        while((p2=fitness[rand2.nextInt(1+rand.nextInt(fitness.length/2))][1])==p1);

        for(int j=0;j<pop[p1].size();j++) {
          if (pop[p1].get(j).qid == null) {
            A.add(new Question(null, null, null, 0, null));
            sec++;
          }
          else{if(pop[p1].get(j).qid != null && pop[p1].get(j).qid.equals(pop[p2].get(j).qid))
          {
            temp = pop[p1].get(j);

            A.add(temp);

          }
          else if (rand.nextInt(2) == 0) {
            temp = pop[p1].get(j);

            for (g = 0; g < A.size(); g++)
              if (A.get(g).qid != null && temp.qid != null && (A.get(g).qid).equals(temp.qid)) break;
            if (g == A.size()) A.add(temp);
            else {
              temp = pop[p2].get(j);
              for (g = 0; g < A.size(); g++)
                if (A.get(g).qid != null && temp.qid != null && (A.get(g).qid).equals(temp.qid)) break;
              if (g == A.size()) A.add(temp);
              else {
                // aadding the new  in reproduction
                list2 = new ArrayList(list[sec]);
                for (int dellist = 0; dellist < list2.size(); dellist++)
                {for (int del = 0; del < A.size(); del++)
                  if (A.get(del).qid != null && list2.get(dellist).qid != null && (A.get(del).qid).equals(list2.get(dellist).qid)) {
                    list2.remove(dellist);
                    dellist--;break;
                  }
                }
                //ensurity of same topic of question
                ArrayList<Question> tempo = new ArrayList(list2);
                for (int sexo = 0; sexo < tempo.size(); sexo++)
                  if (!(((pop[p2].get(j).f.toString()).equals(tempo.get(sexo).f.toString())) || ((pop[p1].get(j).f.toString()).equals(tempo.get(sexo).f.toString())))) {
                    tempo.remove(sexo--);
                  }

                if (!tempo.isEmpty()) A.add(tempo.get(rand2.nextInt(1+rand.nextInt(tempo.size()))));
                else A.add(list2.get(rand2.nextInt(1+rand.nextInt(list2.size()))));
                // added the new0
              }
            }
          } else {
            temp = pop[p2].get(j);

            for (g = 0; g < A.size(); g++)
              if (A.get(g).qid != null && temp.qid != null && (A.get(g).qid).equals(temp.qid)) break;
            if (g == A.size()) A.add(temp);
            else {
              temp = pop[p1].get(j);
              for (g = 0; g < A.size(); g++)
                if (A.get(g).qid != null && (A.get(g).qid).equals(temp.qid)) break;
              if (g == A.size()) A.add(temp);
              else {
                //adding new
                list2 = new ArrayList(list[sec]);
                for (int dellist = 0; dellist < list2.size(); dellist++){
                  for (int del = 0; del < A.size(); del++)
                    if (A.get(del).qid != null && (A.get(del).qid).equals(list2.get(dellist).qid)) {
                      list2.remove(dellist);
                      dellist--;break;
                    }
                }
                ArrayList<Question> tempo = new ArrayList(list2);
                for (int sexo = 0; sexo < tempo.size(); sexo++)
                  if (!(((pop[p2].get(j).f.toString()).equals(tempo.get(sexo).f.toString())) || ((pop[p1].get(j).f.toString()).equals(tempo.get(sexo).f.toString())))) {
                    tempo.remove(sexo--);
                  }

                if (!tempo.isEmpty()) A.add(tempo.get(rand2.nextInt(rand.nextInt(tempo.size())+1)));
                else A.add(list2.get(rand2.nextInt(rand.nextInt(list2.size())+1)));

                //added new question
              }

            }
          }
          }
        }

        pop[fitness[fitness.length-1-i][1]]=A;

      }
    }

    //#################################################################################

    //#############################################create it babay###############################3
    ArrayList<Question>[] createInitPop(int m)
    {
      this.diff=m;


      ArrayList<Question>A[];//=new ArrayList();
      int Short=0,medium=0,Long=0;
      int temp=0,temp2=0;
      for(String sec[]:t.secs)
      {
        temp+=Integer.parseInt((String)sec[0]);
        if("short".equalsIgnoreCase((String)sec[1]))Short+=Integer.parseInt((String)sec[0]);
        else if("long".equalsIgnoreCase((String)sec[1]))Long+=Integer.parseInt((String)sec[0]);
        else if("medium".equalsIgnoreCase((String)sec[1]))medium+=Integer.parseInt((String)sec[0]);
        else
        {
          Short+=Integer.parseInt((String)sec[0])/3;
          Long+=Integer.parseInt((String)sec[0])/3;
          medium+=Integer.parseInt((String)sec[0])/3;
        }
      }
      Question temp_ppr[]=new Question[temp+2];

      {
        int sexy=t.no_of_sec;
        ArrayList<Question> ques=new ArrayList();
        ArrayList<Question> hard[]=new ArrayList[sexy];
        ArrayList<Question> simple[]=new ArrayList[sexy];
        ArrayList<Question> normal[]=new ArrayList[sexy];
        hard2=new ArrayList[sexy];
        simple2=new ArrayList[sexy];
        normal2=new ArrayList[sexy];
        list=new ArrayList[sexy];
        for(int i=0;i<sexy;i++)
        {int x;


          ques.clear();


          for(int j=0;j<t.choice[i].length;j++)
          {

            try{
              ques.addAll(Question.read(t.syl,t.choice[i][j]));
            }catch(Exception e)
            {

            }

          }


          if(!(t.secs[i][1]).equalsIgnoreCase("Mixed"))
            for(int k=0;k<ques.size();k++)
              if(!ques.get(k).qtype.equalsIgnoreCase(t.secs[i][1]))
                ques.remove(k--);


          hard[i]=new ArrayList();
          normal[i]=new ArrayList();
          simple[i]=new ArrayList();

          list[i]=new ArrayList(ques);
          for (Question xx : ques) {
            if (xx.qdifficulty == 3) hard[i].add(xx);
            else if (xx.qdifficulty == 2) normal[i].add(xx);
            else if (xx.qdifficulty == 1) simple[i].add(xx);
          }


        }

        for(int i=0;i<sexy;i++)
        {

          hard2[i]=new ArrayList(hard[i]);
          simple2[i]=new ArrayList(simple[i]);
          normal2[i]=new ArrayList(normal[i]);


        }

        int xnxx,vin,xx;
        Random rand=new Random(),rand2=new Random();
        A=new ArrayList[this.distinct*100+10];
        for(int i=0;i<A.length;i++)
        {  A[i]=new ArrayList();
          for(int j=0;j<sexy;j++)
          {

            vin=3;
            A[i].add(new Question(null,null,null,0,null));
            for(int k=0;k<Integer.parseInt(t.secs[j][0]);k++)
            {   while(true) {
              xnxx = rand.nextInt(vin);
              if (xnxx == 0 && !hard[j].isEmpty()) {
                xx =rand2.nextInt(rand.nextInt(hard[j].size())+1);
                A[i].add(hard[j].get(xx));
                hard[j].remove(xx);
                if (hard[j].isEmpty()) vin--; break;

              } else if (xnxx == 1 && !simple[j].isEmpty() || (xnxx == 0 && hard[j].isEmpty() && !simple[j].isEmpty())) {
                xx = rand2.nextInt(rand.nextInt(simple[j].size())+1);
                A[i].add(simple[j].get(xx));
                simple[j].remove(xx);
                if (simple[j].isEmpty()) vin--;break;

              } else if (xnxx == 2 && !normal[j].isEmpty() || (xnxx == 1 && hard[j].isEmpty() && !normal[j].isEmpty()) || (xnxx == 1 && simple[j].isEmpty() && !normal[j].isEmpty()) || (xnxx == 0 && hard[j].isEmpty() && simple[j].isEmpty() && !normal[j].isEmpty())) {
                xx = rand2.nextInt(rand.nextInt(normal[j].size())+1);
                A[i].add(normal[j].get(xx));
                normal[j].remove(xx);
                if (normal[j].isEmpty()) vin--;break;
              }

            }
            }
          }

          for(int j=0;j<sexy;j++)
          {
            hard[j]=new ArrayList(hard2[j]);
            simple[j]=new ArrayList(simple2[j]);
            normal[j]=new ArrayList(normal2[j]);
          }

        }


      }

      return A;
    }
//###############################################################################################

    //################################Evaluation of the population###################################
    int[][] evaluate()throws Exception
    {
      ArrayList<Papers>papers=Papers.read();
      int h=0,e=0,m=0,quess=pop[0].size()-1;
      if(papers!=null)
      {
        int fitness[][] = new int[pop.length][2], x;

        for (int i = 0; i < pop.length; i++) {
          x = 0;h=e=m=0;
          for (int j = 0; j < papers.size(); j++) {
            for (int k = 0; k < pop[i].size(); k++) {
              if(pop[i].get(k).qid!=null&&pop[i].get(k).qdifficulty==3)h++;
              if(pop[i].get(k).qid!=null&&pop[i].get(k).qdifficulty==2)m++;
              if(pop[i].get(k).qid!=null&&pop[i].get(k).qdifficulty==1)e++;


              for (int l = 0; l < papers.get(j).encoded_paper.size(); l++) {//System.out.println(pop[i].get(k)[0]+":");
                if((pop[i].get(k).qid+"").equals(""+papers.get(j).encoded_paper.get(l).qid)) {
                  x++;
                  break;
                }
              }
            }

          }


          fitness[i][0] = x;
          fitness[i][1] = i;

          if(this.diff==3)
          {
            fitness[i][0]+=(int)(long)Math.abs(h-(.8*quess));
          }
          else if(this.diff==2)
          {
            fitness[i][0]+=(int)(long)Math.abs(m-(.8*quess));
          }
          else if(this.diff==1)
          {
            fitness[i][0]+=(int)(long)Math.abs(e-(.8*quess));
          }



        }

        for (int i = 0; i < fitness.length - 1; i++) {
          for (int j = i + 1; j < fitness.length; j++) {
            if (fitness[i][0] > fitness[j][0]) {
              fitness[i][0] = fitness[i][0] ^ fitness[j][0];
              fitness[j][0] = fitness[i][0] ^ fitness[j][0];
              fitness[i][0] = fitness[i][0] ^ fitness[j][0];
              fitness[i][1] = fitness[i][1] ^ fitness[j][1];
              fitness[j][1] = fitness[i][1] ^ fitness[j][1];
              fitness[i][1] = fitness[i][1] ^ fitness[j][1];
            }
          }
        }



        return fitness;

      }
      return null;
    }

//###############################################################################################

  %>
  <%
    String subject=request.getParameter("subject");
    int no_of_sec=Integer.parseInt(request.getParameter("no_of_sec"));
    String u_name=request.getParameter("u_name");
    String u_email=request.getParameter("u_email");
    int difficulty=Integer.parseInt(request.getParameter("difficulty"));
    String sec[][]=new String[no_of_sec][2];
    String choice[][]=new String[no_of_sec][];
    ArrayList<Question>list=new ArrayList();
    for(int i=0;i<no_of_sec;i++)
    { sec[i][0]=request.getParameter("noquesInSecs"+i);
      sec[i][1]=request.getParameter("typeInSec"+i);
      choice[i]=request.getParameterValues("topicInSec"+i);
    }
   try{
    list= create(no_of_sec,difficulty,sec,choice,subject);
     for(int i=0;i<list.size();i++)
       out.println(list.get(i).ques+"<br>");
   }catch(Exception e)
   {

   }

  %>

</div>
</body>
</html>