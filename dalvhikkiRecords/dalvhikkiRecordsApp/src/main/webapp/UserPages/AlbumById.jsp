<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.example.dalvhikkirecordsapp.Objects.Albums" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.dalvhikkirecordsapp.DAO.AlbumsDAO" %>
<%@ page import="com.example.dalvhikkirecordsapp.Objects.Songs" %>
<%@ page import="com.example.dalvhikkirecordsapp.DAO.SongsDAO" %><%--
  Created by IntelliJ IDEA.
  User: User
  Date: 29.11.23
  Time: 00:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
    <style>
        *{
            font-family:'Franklin Gothic Medium';
        }
        .block .wrapper-audio,.block .wrapper-album{
            display:grid;
            grid-template-columns: 95% 5%;
        }
        audio{
            margin:1%;
            width:60%;
        }

        .block .wrapper-album .album{
            display:grid;
            grid-template-columns: 25% 75%;
        }
        .grid_markup{
            margin:5%;
            display: grid;
            text-align:center;
            grid-template-columns: 20% 20% 20%;
            grid-column-gap:5%;
        }
        .band_info{
            display:grid;
            grid-template-columns: 60% 30%;
            grid-column-gap:5%;
        }

        .logo-album{
            width:80%;
            margin:10%;
        }
    </style>
    <%
        Albums album=new Albums();
        List<Songs>songsList=new ArrayList<>();
        int albumId = Integer.parseInt(request.getParameter("album_id"));
        try{
            songsList=new SongsDAO().getSongsByAlbumId(albumId);
            album = new AlbumsDAO().getAlbumByAlbumId(albumId);
            request.setAttribute("album",album);
            request.setAttribute("songsList",songsList);
        }catch(Exception e){
            e.printStackTrace();
        }
    %>
</head>
<body>
<jsp:include page="../HeaderFooter/headerGuest.jsp"></jsp:include>
<jsp:useBean id="bands" class="com.example.dalvhikkirecordsapp.DAO.BandsDAO"></jsp:useBean>
<h1>${album.album_name}</h1>
<hr/>
<div>
    <div class="band_info">
        <div>
            <img src="../Images/${album.album_photo}" class="logo-album"/>
        </div>
        <div>
            <table border="0">
                <tbody>
                <tr>
                    <td>Band</td>
                    <td>${bands.getBandNameByBandId(album.band_id)}</td>
                </tr>
                <tr>
                    <td>Release</td>
                    <td>${album.release_date}</td>
                </tr>
                </tbody>
            </table>
            <div>
                <c:forEach var="songs" items="${songsList}">
                    <div class="block">
                        <div class="wrapper-audio">
                            <div class="element">
                                <h3>${songs.song_name}</h3>
                                <h5>
                                    <a href="GuestPages/bandInfo.jsp?bandId=${songs.band_id}">${bands.getBandNameByBandId(songs.band_id)}</a>
                                </h5>
                                <p>${songs.song_release}</p>
                                <audio controls>
                                    <source src="../Audio/${songs.song_file}" type="audio/mpeg"/>
                                </audio>
                            </div>
                            <div class="element">
                                <svg width="20" height="19" viewBox="0 0 20 19" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path fill-rule="evenodd" clip-rule="evenodd" d="M10 1.66446C15.5477 -4.11405 29.418 5.99771 10 19C-9.41803 5.99898 4.45235 -4.11405 10 1.66446Z" fill="#E1E1E1"/>
                                </svg>
                                <p>${songs.song_likes_count}</p>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>
</body>
</html>
