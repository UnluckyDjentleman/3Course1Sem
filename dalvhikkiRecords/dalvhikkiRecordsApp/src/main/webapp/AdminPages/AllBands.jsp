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
        #links_to_servlets{
            display:flex;
            width:40%;
        }
    </style>
    <%
        List<Bands> bandsList=new ArrayList<>();
        try{
            bandsList=new BandsDAO().getAllBands();
            request.setAttribute("bandsList",bandsList);
        }catch(Exception e){
            e.printStackTrace();
        }
    %>
</head>
<body>
<jsp:include page="../HeaderFooter/HeaderAdmin.jsp"/>
<h1>All Bands</h1>
<hr/>
    <div>
        <input type="search" name="searcher"/>
        <input type="number" name="userId" style="display:none;" value="0"/>
        <input type="submit"/>
    </div>
    <form action="${pageContext.request.contextPath}/FilterBandsServlet" method="get">
        <div class="grid_markup">
            <c:forEach var="bands" items="${bandsList}">
                <div>
                    <img src="../Images/${bands.band_logo}" style="width:20%"/>
                    <p><a href="bandInfo.jsp?bandId=${bands.band_id}">${bands.band_name}</a></p>
                    <div id="links_to_servlets">
                        <form action="updateBand.jsp?band_id=${bands.band_id}" method="post">
                            <button name="songRemover" value="Update">Update</button>
                        </form>
                        <form action="${pageContext.request.contextPath}/BandRemover" method="POST">
                            <button type="submit" value="${bands.band_id}" name="band_id">Delete</button>
                        </form>
                    </div>
                </div>
            </c:forEach>
        </div>
    </form>
</div>
<div style="text-align:center;">
    <form action="addBand.jsp" method="post">
        <button type="submit">Add band</button>
    </form>
</div>
<jsp:include page="../HeaderFooter/Footer.jsp"></jsp:include>
</body>
</html>
