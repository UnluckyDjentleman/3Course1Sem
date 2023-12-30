<%@ page import="com.example.dalvhikkirecordsapp.DAO.AlbumsDAO" %>
<%@ page import="com.example.dalvhikkirecordsapp.Objects.Albums" %><%--
  Created by IntelliJ IDEA.
  User: User
  Date: 05.12.23
  Time: 13:16
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
int id= Integer.parseInt(request.getParameter("id"));
int band_id= Integer.parseInt(request.getParameter("band_id"));
Albums album=new AlbumsDAO().getAlbumByAlbumId(id);
%>
<body>
<form action="${pageContext.request.contextPath}/UpdateAlbumServlet" method="POST" enctype="multipart/form-data">
  <div>
    <table border="0" style="margin:0 auto">
      <tbody>
      <tr>
        <td style="width:5vw"><label for="albumName">Name</label></td>
        <td style="width:30vw"><input type="text" name="AlbumName" id="albumName" value="<%=album.getAlbum_name()%>"/></td>
      </tr>
      <tr>
        <td style="width:10vw"><label for="albumLogo">Album Logo</label></td>
        <td style="width:30vw"><input type="file" name="AlbumLogo" id="albumLogo"/><br/></td>
      </tr>
      </tbody>
      <input type="number" name="id" value="<%=id%>" style="display: none"/>
      <input type="number" name="band_id" value="<%=band_id%>" style="display: none"/>
    </table>
  </div>
  <div>
    <button type="submit">Add Album</button>
  </div>
</form>
</body>
</html>
