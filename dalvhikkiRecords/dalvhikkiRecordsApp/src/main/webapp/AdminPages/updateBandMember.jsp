<%@ page import="com.example.dalvhikkirecordsapp.Objects.BandMembers" %>
<%@ page import="com.example.dalvhikkirecordsapp.DAO.BandMembersDAO" %><%--
  Created by IntelliJ IDEA.
  User: User
  Date: 05.12.23
  Time: 08:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <style>
        *{
            font-family:'Franklin Gothic Medium'
        }
        form{
            text-align:center;
        }
        input[type="text"]{
            height: 4vh;
            width:80%;
        }
        div{
            text-align:center;
            margin:2%;
        }
        button{
            height: 4vh;
            background-color:#313131;
            border: 3px #e1e1e1 solid;
            color: white;
            border-radius: 10%;
            width:25vw;
        }
    </style>
</head>
<%
    int bandId= Integer.parseInt(request.getParameter("band_id"));
    int memberId=Integer.parseInt(request.getParameter("band_member_id"));
    BandMembers bandMem=new BandMembersDAO().getMember(bandId,memberId);
%>
<body>
<form action="${pageContext.request.contextPath}/UpdateBandMemberServlet" method="post">
    <div>
        <table border="0" style="margin:0 auto">
            <tbody>
            <tr>
                <td style="width:5vw"><label for="bandMemberName">Name</label></td>
                <td style="width:30vw"><input type="text" name="BandMemName" id="bandMemberName" value="<%=bandMem.getMember_name()%>"/></td>
            </tr>
            <tr>
                <td style="width:10vw"><label for="bandMemberRole">SongFile</label></td>
                <td style="width:30vw"><input type="text" name="BandMemRole" id="bandMemberRole" value="<%=bandMem.getMember_instrument()%>"/><br/></td>
            </tr>
            </tbody>
            <input type="number" name="xd1" id="xd1" value="<%=memberId%>" style="display:none;"/>
            <input type="number" name="xd2" id="xd2" value="<%=bandId%>" style="display:none;"/>
        </table>
    </div>
    <div>
        <button type="submit">Add Song</button>
    </div>
</form>
</body>
</html>
