<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.example.dalvhikkirecordsapp.Objects.Bands" %>
<%@ page import="com.example.dalvhikkirecordsapp.DAO.BandsDAO" %><%--
  Created by IntelliJ IDEA.
  User: User
  Date: 29.11.23
  Time: 00:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <style>
        *{
            font-family:'Franklin Gothic Medium';
        }
        h3,h5,p{
            color:white;
        }
        .band_info{
            display:grid;
            grid-template-columns: 60% 30%;
            grid-column-gap:5%;
        }
        .block{
            display:block;
            background-color: #313131;
            margin:1%;
        }
        .logo-band{
            width:60%;
            border:1px solid #313131
        }
        .logo-album{
            width:80%;
            margin:10%;
        }
        .block .wrapper-album{
            display:grid;
            grid-template-columns: 95% 5%;
        }
        .block .wrapper-album .album{
            display:grid;
            grid-template-columns: 25% 75%;
        }
    </style>
</head>
<%
    int id= Integer.parseInt(request.getParameter("bandId"));
    try {
        Bands band = new BandsDAO().getBandByBandId(id);
        request.setAttribute("band",band);
    }catch(Exception e){
        e.printStackTrace();
    }
%>
<body>
<jsp:include page="../HeaderFooter/HeaderAdmin.jsp"></jsp:include>
<jsp:useBean id="bandMembers" class="com.example.dalvhikkirecordsapp.DAO.BandMembersDAO"></jsp:useBean>
<h1>${band.band_name}</h1>
<hr/>
<div>
    <div class="band_info">
        <div>
            <img src="../Images/${band.band_logo}" class="logo-band"/>
        </div>
        <div>
            <table border="0">
                <tbody>
                    <tr>
                        <td>Location</td>
                        <td>${band.band_location}</td>
                    </tr>
                    <tr>
                        <td>Genre</td>
                        <td>${band.band_genre}</td>
                    </tr>
                    <tr>
                        <td>Created</td>
                        <td>${band.band_year_of_creation}</td>
                    </tr>
                    <tr>
                        <td>Members</td>
                        <td>
                            <ul>
                                <c:forEach var="bandMem" items="${bandMembers.getMembersOfBand(band.band_id)}">
                                    <li>
                                            ${bandMem.member_name}(${bandMem.member_instrument})
                                    </li>
                                    <form action="${pageContext.request.contextPath}/DeleteBandMemberServlet" method="post">
                                        <button type="submit" value="${bandMem.member_id}" name="xd">Delete</button>
                                    </form>
                                    <form action="updateBandMember.jsp?band_id=${band.band_id}&band_member_id=${bandMem.member_id}" method="post">
                                        <button type="submit">Update</button>
                                    </form>
                                </c:forEach>
                            </ul>
                            <form action="addBandMember.jsp?band_id=${band.band_id}" method="post">
                                <button type="submit">Add Member</button>
                            </form>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>
<h1>
    Albums
</h1>
<hr/>
<div>
    <jsp:useBean id="albumsBand" class="com.example.dalvhikkirecordsapp.DAO.AlbumsDAO"></jsp:useBean>
    <c:forEach var="albums" items="${albumsBand.getAlbumsByBandId(band.band_id)}">
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
                    <button type="submit" value="${albums.album_id}" name="song_id">Delete</button>
                </form>
            </div>
        </div>
    </c:forEach>
    <div>
        <form action="addAlbum.jsp?band_id=${band.band_id}" method="post">
            <button type="submit">Add Album</button>
        </form>
    </div>
</div>
<jsp:include page="../HeaderFooter/Footer.jsp"></jsp:include>
</body>
</html>
