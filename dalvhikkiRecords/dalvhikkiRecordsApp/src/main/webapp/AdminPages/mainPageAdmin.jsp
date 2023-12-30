<%@ page import="com.example.dalvhikkirecordsapp.Objects.Songs" %>
<%@ page import="com.example.dalvhikkirecordsapp.Objects.Albums" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.dalvhikkirecordsapp.DAO.SongsDAO" %>
<%@ page import="com.example.dalvhikkirecordsapp.DAO.AlbumsDAO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 25.11.23
  Time: 14:32
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
        img{
            width:80%;
            margin:10%;
        }
        .block{
            display:block;
            background-color: #313131;
            margin:1%;
        }
        h3,h5,p,label{
            color:white;
            margin:1%;
        }
        .block .wrapper-audio,.block .wrapper-album{
            display:grid;
            grid-template-columns: 95% 5%;
        }
        .block .wrapper-album .album{
            display:grid;
            grid-template-columns: 25% 75%;
        }
        audio{
            margin:1%;
            width:60%;
        }
        audio::-webkit-media-controls-panel {
            background-color: #313131;
            color: white;
        }

        audio::-webkit-media-controls-play-button {
            color: #f1f1f1;
        }

        audio::-webkit-media-controls-volume-slider-container {
            width: 80%;
        }

        audio::-webkit-media-controls-seek-back-button {
            color: #f1f1f1;
        }

        audio::-webkit-media-controls-seek-forward-button {
            color: #f1f1f1;
        }

        audio::-webkit-media-controls-mute-button {
            color: #f1f1f1;
        }

        audio::-webkit-media-controls-current-time-display {
            color: #f1f1f1;
        }

        audio::-webkit-media-controls-time-remaining-display {
            color: #f1f1f1;
        }
        #grid-markup{
            display: grid;
            grid-template-columns: 1fr 1fr 1fr;
            grid-column-gap: 2vw;
            grid-row-gap: 5vh;
            text-align: center;
        }
        .like-button{
            background-color: transparent;
            background-repeat: no-repeat;
            border: none;
            cursor: pointer;
            overflow: hidden;
            outline: none;
        }
        #links_to_servlets{
            display:flex;
            width:40%;
        }
    </style>
</head>
<%
    List<Songs> songsList=new ArrayList<>();
    List<Albums>albumsList=new ArrayList<>();
    String bandName=null;
    try{
        songsList=new SongsDAO().getBestSongsAdmin();
        albumsList=new AlbumsDAO().getAllAlbums();
        request.setAttribute("songsList",songsList);
        request.setAttribute("albumsList",albumsList);
    }catch(Exception e){
        e.printStackTrace();
    }
%>
<body>
<jsp:include page="../HeaderFooter/HeaderAdmin.jsp"></jsp:include>
<jsp:useBean id="bands" class="com.example.dalvhikkirecordsapp.DAO.BandsDAO"></jsp:useBean>
<main>
    <h1>All Songs</h1>
    <hr/>
    <div>
        <c:forEach var="songs" items="${songsList}">
            <c:set var="song" value="${songs.song_id}"/>
            <div class="block">
                <div class="wrapper-audio">
                    <div class="element">
                        <h3>${songs.getSong_name()}</h3>
                        <h5>
                                ${bands.getBandNameByBandId(songs.band_id)}
                        </h5>
                        <p>${songs.song_release}</p>
                        <audio controls>
                            <source src="../Audio/${songs.song_file}" type="audio/mpeg"/>
                        </audio>
                    </div>
                    <div class="element">
                        <form action="${pageContext.request.contextPath}/LikeSongServlet" method="POST">
                            <button type="submit" name="like_but" value="${songs.song_id}" class="like-button">
                                <input type="number" value="${idUser}" style="display:none" name="idUser" id="noneseen"/>
                                <svg width="20" height="19" viewBox="0 0 20 19" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path fill-rule="evenodd" clip-rule="evenodd" d="M10 1.66446C15.5477 -4.11405 29.418 5.99771 10 19C-9.41803 5.99898 4.45235 -4.11405 10 1.66446Z" fill="rgb(225,225,225)"/>
                                </svg>
                                <label for="noneseen" name="likes_counter">${songs.song_likes_count}</label>
                            </button>
                        </form>
                    </div>
                    <div id="links_to_servlets">
                        <form action="updateSong.jsp?id=${songs.song_id}" method="post">
                            <button name="songRemover" value="Update">Update</button>
                        </form>
                        <form action="${pageContext.request.contextPath}/SongRemover" method="POST">
                            <button type="submit" value="${songs.song_id}" name="song_id">Delete</button>
                        </form>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
    <h1>All Albums</h1>
    <hr/>
    <div>
        <c:forEach var="albums" items="${albumsList}">
            <div class="block">
                <div class="wrapper-album">
                    <div class="album">
                        <div>
                            <img src="../Images/${albums.album_photo}" class="logo-album"/>
                        </div>
                        <div>
                            <h3><a href="../AdminPages/AlbumById.jsp?album_id=${albums.album_id}">${albums.album_name}</a></h3>
                            <h5>
                                <a href="#">${bands.getBandNameByBandId(albums.band_id)}</a>
                            </h5>
                            <p>${albums.release_date}</p>
                        </div>
                    </div>
                    <div class="like">
                        <svg width="20" height="19" viewBox="0 0 20 19" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path fill-rule="evenodd" clip-rule="evenodd" d="M10 1.66446C15.5477 -4.11405 29.418 5.99771 10 19C-9.41803 5.99898 4.45235 -4.11405 10 1.66446Z" fill="#E1E1E1"/>
                        </svg>
                        <p>${albums.album_likes_count}</p>
                    </div>
                </div>
                <div id="links_to_servlets">
                    <form action="updateAlbum.jsp?id=${albums.album_id}&band_id=${albums.band_id}" method="post">
                        <button name="songRemover" value="Update">Update</button>
                    </form>
                    <form action="${pageContext.request.contextPath}/AlbumRemover" method="POST">
                        <button type="submit" value="${albums.album_id}" name="album_id">Delete</button>
                    </form>
                </div>
            </div>
        </c:forEach>
    </div>
</main>
<jsp:include page="../HeaderFooter/Footer.jsp"></jsp:include>
</body>
</html>
