<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 22.11.23
  Time: 22:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <style>
        header{
            background-color:#313131;
            width:100%;
            height:10vh
        }
        header nav a.point,header nav a.point:hover, header nav a.point:active{
            color:white;
            font-size: 14px;
            text-decoration: none;
        }

        header nav a.link,header nav a.link:hover, header nav a.link:active{
            color:white;
            font-size: 14px;
            text-decoration: none;
        }
        .header_list{
            display:flex;
            flex-wrap:wrap;
            list-style-type: none;
        }
        .header_item{
            font-size: 24px;
            text-decoration: none;
            margin-right: 2vw;
        }
        .header_list:first-child .header_item:last-child{
            margin-right:40vw;
        }
        .header-navigation{
            display:flex;
            flex-wrap:wrap;
        }
    </style>
</head>
<body>
<jsp:useBean id="user" class="com.example.dalvhikkirecordsapp.DAO.UsersDAO"></jsp:useBean>
<header>
    <nav class="header-navigation">
        <ul class="header_list">
            <li class="header_item">
                <a class="point" href="${pageContext.request.contextPath}/GuestPages/AllBands.jsp">Bands</a>
            </li>
            <li class="header_item">
                <a class="point" href="${pageContext.request.contextPath}/GuestPages/AllAlbums.jsp">Albums</a>
            </li>
            <li class="header_item">
                <a class="point" href="${pageContext.request.contextPath}/GuestPages/AllSongs.jsp">Songs</a>
            </li>
            <li class="header_item">
                <a class="point" href="${pageContext.request.contextPath}/GuestPages/LikedSongs.jsp">My Liked Songs</a>
            </li>
            <li class="header_item">
                <a class="point" href="${pageContext.request.contextPath}/GuestPages/LikedAlbums.jsp">My Liked Albums</a>
            </li>
        </ul>
        <ul class="header_list">
            <li class="header_item">
                <a class="link" href="${pageContext.request.contextPath}/Auth/registration.jsp">Registration</a>
            </li>
            <li class="header_item">
                <a class="link" href="${pageContext.request.contextPath}/Auth/authorization.jsp">Authorization</a>
            </li>
        </ul>
    </nav>
</header>
</body>
</html>
