<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 25.11.23
  Time: 20:12
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
<div>
    <h1>${error}</h1>
    <svg width="100px" height="100px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <path d="M12 23.25C18.2132 23.25 23.25 18.2132 23.25 12C23.25 5.7868 18.2132 0.75 12 0.75C5.7868 0.75 0.75 5.7868 0.75 12C0.75 18.2132 5.7868 23.25 12 23.25Z" stroke="#e1e1e1" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"></path> <path d="M14.5176 9.02881C14.6749 9.45542 14.9578 9.82463 15.3294 10.0875C15.7094 10.3562 16.1633 10.5005 16.6287 10.5005C17.0941 10.5005 17.548 10.3562 17.9279 10.0875C18.2995 9.82463 18.5825 9.45542 18.7398 9.02881" stroke="#e1e1e1" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"></path> <path d="M5.26123 9.03113C5.41868 9.45676 5.70128 9.82511 6.07222 10.0875C6.45216 10.3562 6.90609 10.5005 7.37147 10.5005C7.83685 10.5005 8.29078 10.3562 8.67073 10.0875C9.04167 9.82511 9.32427 9.45676 9.48172 9.03113" stroke="#e1e1e1" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"></path> <path d="M5.98779 17.676C6.54712 16.583 7.39418 15.6627 8.43834 15.0148C9.50731 14.3515 10.7403 14 11.9984 14C13.2565 14 14.4895 14.3515 15.5585 15.0148C16.6026 15.6627 17.4497 16.583 18.009 17.676" stroke="#e1e1e1" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"></path> </g></svg>
    <ul>
        <li><a href="${pageContext.request.contextPath}/">Back to Home</a></li>
    </ul>
</div>
</body>
</html>
