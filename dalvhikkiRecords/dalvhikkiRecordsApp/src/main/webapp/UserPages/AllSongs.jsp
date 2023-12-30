<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.dalvhikkirecordsapp.Objects.Songs" %>
<%@ page import="java.util.List" %>
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
    <title>Title</title>
    <style>
        *{
            font-family:'Franklin Gothic Medium'
        }
        button{
            background-color: transparent;
            background-repeat: no-repeat;
            border: none;
            cursor: pointer;
            overflow: hidden;
            outline: none;
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
            display:block;
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
    </style>
</head>
<%
    int id= Integer.parseInt(request.getParameter("id"));
    request.setAttribute("idUser",id);
    List<Songs>songsList=new ArrayList<>();
    try{
        if(request.getSession().getAttribute("songsList")==null){
            songsList=new SongsDAO().getAllSongsGuest();
            request.setAttribute("songsList",songsList);
        }
    }catch(Exception e){
        e.printStackTrace();
    }
%>
<body>
<jsp:include page="../HeaderFooter/headerUA.jsp"></jsp:include>
<h1>
    All Songs
</h1>
<main>
    <form action="${pageContext.request.contextPath}/FilterSongsServlet" method="get">
        <div>
            <input type="search" name="searcher"/>
            <input type="number" name="userId" style="display:none;" value="${idUser}"/>
            <input type="submit"/>
        </div>
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
                                <button type="submit" name="like_but" value="${songs.song_id}">
                                    <input type="number" value="${idUser}" style="display:none" name="idUser" id="noneseen"/>
                                    <svg width="20" height="19" viewBox="0 0 20 19" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path fill-rule="evenodd" clip-rule="evenodd" d="M10 1.66446C15.5477 -4.11405 29.418 5.99771 10 19C-9.41803 5.99898 4.45235 -4.11405 10 1.66446Z" fill="${likedSongs.LikedSong(idUser,song)?liked:notliked}" id="like-button"/>
                                    </svg>
                                </button>
                                <label for="noneseen" name="likes_counter">${songs.song_likes_count}</label>
                            </form>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </form>
</main>
<jsp:include page="../HeaderFooter/Footer.jsp"></jsp:include>
</body>
</html>
