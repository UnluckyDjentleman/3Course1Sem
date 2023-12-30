<%@ page import="com.example.dalvhikkirecordsapp.Objects.Bands" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.dalvhikkirecordsapp.DAO.BandsDAO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
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
        .grid_markup{
            margin:5%;
            display: grid;
            text-align:center;
            grid-template-columns: 20% 20% 20%;
            grid-column-gap:5%;
        }
    </style>
    <%
        int id= Integer.parseInt(request.getParameter("id"));
        request.setAttribute("idUser",id);
        List<Bands> bandsList=new ArrayList<>();
        try{
            if(request.getSession().getAttribute("bandsList")==null){
                bandsList=new BandsDAO().getAllBands();
                request.setAttribute("bandsList",bandsList);
            }
        }catch(Exception e){
            e.printStackTrace();
        }
    %>
</head>
<body>
<jsp:include page="../HeaderFooter/headerGuest.jsp"/>
<h1>All Bands</h1>
<hr/>
<div class="grid_markup">
    <c:forEach var="bands" items="${bandsList}">
        <div>
            <img src="../Images/${bands.band_logo}" style="width:20%"/>
            <p><a href="bandInfo.jsp?bandId=${bands.band_id}">${bands.band_name}</a></p>
        </div>
    </c:forEach>
</div>
<jsp:include page="../HeaderFooter/Footer.jsp"></jsp:include>
</body>
</html>
