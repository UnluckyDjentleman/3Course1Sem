<%@ page import="com.example.dalvhikkirecordsapp.Objects.Songs" %>
<%@ page import="com.example.dalvhikkirecordsapp.DAO.SongsDAO" %><%--
  Created by IntelliJ IDEA.
  User: User
  Date: 04.12.23
  Time: 21:00
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
        input[type="password"]{
            height: 4vh;
            width:80%;
        }
        div{
            text-align:center;
            margin:2%;
        }
        input[type="submit"]{
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
    int bandId = Integer.parseInt(request.getParameter("band_id"));
    int albumId = Integer.parseInt(request.getParameter("album_id"));
%>
<body>
<form action="${pageContext.request.contextPath}/AddSongServlet" method="POST" enctype="multipart/form-data">
    <div>
        <table border="0" style="margin:0 auto">
            <tbody>
            <tr>
                <td style="width:5vw"><label for="songName">Name</label></td>
                <td style="width:30vw"><input type="text" name="SongName" id="songName"/></td>
            </tr>
            <tr>
                <td style="width:10vw"><label for="songFile">SongFile</label></td>
                <td style="width:30vw"><input type="file" name="SongFile" id="songFile"/><br/></td>
            </tr>
            </tbody>
            <input type="number" name="xd1" id="xd1" value="<%=albumId%>" style="display:none;"/>
            <input type="number" name="xd2" id="xd2" value="<%=bandId%>" style="display:none;"/>
        </table>
    </div>
    <div>
        <button type="submit">Add Song</button>
    </div>
</form>
</body>
</html>
