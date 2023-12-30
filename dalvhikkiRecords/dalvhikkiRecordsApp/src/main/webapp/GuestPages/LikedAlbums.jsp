<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 29.11.23
  Time: 00:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <style>
        *{
            font-family: 'Franklin Gothic Medium'
        }
        div{
            text-align:center;
        }
        ul li{
            display: inline;
            list-style-type: none;
            margin-right: 2vw;
        }
    </style>
</head>
<body>
<jsp:include page="../HeaderFooter/headerGuest.jsp"></jsp:include>
<div style="text-align:center;">
    <svg width="100px" height="100px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <path d="M12 8L16 12M16 12L12 16M16 12H3M3.33782 7C5.06687 4.01099 8.29859 2 12 2C17.5228 2 22 6.47715 22 12C22 17.5228 17.5228 22 12 22C8.29859 22 5.06687 19.989 3.33782 17" stroke="#e1e1e1" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"></path> </g></svg>
    <p style="text-align: center;">You should register of login for possibility to like songs</p>
    <ul>
        <li><a href="${pageContext.request.contextPath}/Auth/registration.jsp">Register</a></li>
        <li><a href="${pageContext.request.contextPath}/Auth/authorization.jsp">Login</a></li>
    </ul>
</div>
<jsp:include page="../HeaderFooter/Footer.jsp"></jsp:include>
</body>
</html>
