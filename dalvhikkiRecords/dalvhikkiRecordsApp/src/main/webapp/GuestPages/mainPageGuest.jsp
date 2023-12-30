<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ page import="com.example.dalvhikkirecordsapp.Connections.GuestConnection" %>
<%@ page import="com.example.dalvhikkirecordsapp.Objects.Songs" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.dalvhikkirecordsapp.DAO.SongsDAO" %>
<%@ page import="com.example.dalvhikkirecordsapp.Objects.Bands" %>
<%@ page import="com.example.dalvhikkirecordsapp.DAO.BandsDAO" %>
<%@ page import="com.example.dalvhikkirecordsapp.Objects.Albums" %>
<%@ page import="com.example.dalvhikkirecordsapp.DAO.AlbumsDAO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>JSP - Hello World</title>
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
  List<Songs>songsList=new ArrayList<>();
  List<Albums>albumsList=new ArrayList<>();
  List<Songs>songsListNew=new ArrayList<>();
  List<Albums>albumsListNew=new ArrayList<>();
  String bandName=null;
  try{
    songsList=new SongsDAO().getBestSongsGuest();
    albumsList=new AlbumsDAO().getBestAlbums();
    songsListNew=new SongsDAO().getNewSongs();
    albumsListNew=new AlbumsDAO().getNewAlbums();
    request.setAttribute("songsList",songsList);
    request.setAttribute("albumsList",albumsList);
    request.setAttribute("songsListNew",songsListNew);
    request.setAttribute("albumsListNew",albumsListNew);
  }catch(Exception e){
    e.printStackTrace();
  }
%>
<body>
<jsp:include page="../HeaderFooter/headerGuest.jsp"/>
<main>
<h1>Best Songs</h1>
<hr/>
<jsp:useBean class="com.example.dalvhikkirecordsapp.DAO.BandsDAO" id="bands"></jsp:useBean>
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
          <source src="Audio/${songs.song_file}" type="audio/mpeg"/>
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
  <h1>Best Albums</h1>
  <hr/>
  <div>
    <c:forEach var="albums" items="${albumsList}">
      <div class="block">
        <div class="wrapper-album">
          <div class="album">
            <div>
              <img src="Images/${albums.album_photo}"/>
            </div>
            <div>
              <h3><a href="./GuestPages/AlbumById.jsp?album_id=${albums.album_id}">${albums.album_name}</a></h3>
              <h5>
                <a href="./GuestPages/bandInfo.jsp?bandId=${albums.band_id}">${bands.getBandNameByBandId(albums.band_id)}</a>
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
  <h1>New Songs</h1>
  <hr/>
  <div>
    <c:forEach var="songs" items="${songsListNew}">
      <div class="block">
        <div class="wrapper-audio">
          <div class="element">
            <h3>${songs.song_name}</h3>
            <h5>
              <a href="GuestPages/bandInfo.jsp?bandId=${songs.band_id}">${bands.getBandNameByBandId(songs.band_id)}</a>
            </h5>
            <p>${songs.song_release}</p>
            <audio controls>
              <source src="Audio/${songs.song_file}" type="audio/mpeg"/>
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
  <h1>New Albums</h1>
  <hr/>
  <div>
    <c:forEach var="albums" items="${albumsListNew}">
      <div class="block">
        <div class="wrapper-album">
          <div class="album">
            <div>
              <img src="Images/${albums.album_photo}"/>
            </div>
            <div>
              <h3><a href="./GuestPages/AlbumById.jsp?album_id=${albums.album_id}">${albums.album_name}</a></h3>
              <h5>
                <a href="./GuestPages/bandInfo.jsp?bandId=${albums.band_id}">${bands.getBandNameByBandId(albums.band_id)}</a>
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
</main>
<jsp:include page="../HeaderFooter/Footer.jsp"></jsp:include>
</body>
</html>