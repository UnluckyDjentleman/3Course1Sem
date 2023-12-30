<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 21.11.23
  Time: 00:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
    <style>
        *{
            font-family:'Franklin Gothic Medium'
        }
        form{
            text-align:center;
        }
        input[type="text"]{
            height: 4vh;
            width:80%;
        }
        input[type="password"]{
            height: 4vh;
            width:80%;
        }
        div{
            text-align:center;
            margin:2%;
        }
        input[type="submit"]{
            height: 4vh;
            background-color:#313131;
            border: 3px #e1e1e1 solid;
            color: white;
            border-radius: 10%;
            width:25vw;
        }
    </style>
</head>
<body>
<form action="${pageContext.request.contextPath}/GetUserServlet" method="POST">
    <div>
        <table border="0" style="margin:0 auto">
            <tbody>
            <tr>
                <td style="width:5vw"><label for="username">Name</label></td>
                <td style="width:30vw"><input type="text" name="username" id="username" placeholder="Your name"/></td>
            </tr>
            <tr>
                <td style="width:10vw"><label for="password">Password</label></td>
                <td style="width:30vw"><input type="password" name="user_password" id="password" placeholder="Your name"/><br/></td>
            </tr>
            </tbody>
        </table>
    </div>
    <div>
        <input type="submit" value="Log In"/>
    </div>
</form>
</body>
</html>
