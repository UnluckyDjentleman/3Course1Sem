<%@ page import="com.example.dalvhikkirecordsapp.Objects.Albums" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.dalvhikkirecordsapp.DAO.AlbumsDAO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
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
        img{
            width:80%;
            margin:10%;
        }
        .block{
            display:block;
            background-color: #313131;
            margin:1%;
        }
        h3,h5,p{
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
    </style>
</head>
<%
    List<Albums> albumsList=new ArrayList<>();
    try{
        if(request.getSession().getAttribute("albumsList")==null){
            albumsList=new AlbumsDAO().getAllAlbums();
            request.setAttribute("albumsList",albumsList);
        }
    }catch(Exception e){
        e.printStackTrace();
    }
%>
<body>
<jsp:include page="../HeaderFooter/headerGuest.jsp"/>
<h1>All Bands</h1>
<hr/>
<form action="${pageContext.request.contextPath}/FilterAlbumServlet" method="get">
    <div>
        <input type="search" name="searcher"/>
        <input type="number" name="userId" style="display:none;" value="0"/>
        <input type="submit"/>
    </div>
    <div>
        <c:forEach var="albums" items="${albumsList}">
            <div class="block">
                <div class="wrapper-album">
                    <div class="album">
                        <div>
                            <img src="../Images/${albums.album_photo}"/>
                        </div>
                        <div>
                            <h3><a href="../GuestPages/AlbumById.jsp?album_id=${albums.album_id}">${albums.album_name}</a></h3>
                            <h5>
                                <a href="../GuestPages/bandInfo.jsp?bandId=${albums.band_id}">${bands.getBandNameByBandId(albums.band_id)}</a>
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
            </div>
        </c:forEach>
    </div>
</form>
<jsp:include page="../HeaderFooter/Footer.jsp"></jsp:include>
</body>
</html>
