<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 04.12.23
  Time: 22:46
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
        form{
            text-align:center;
        }
        input[type="text"]{
            height: 4vh;
            width:80%;
        }
        div{
            text-align:center;
            margin:2%;
        }
        button{
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
<form action="${pageContext.request.contextPath}/AddBandServlet" method="post" enctype="multipart/form-data">
        <div>
            <table border="0" style="margin:0 auto">
                <tbody>
                <tr>
                    <td style="width:5vw"><label for="bandName">Name</label></td>
                    <td style="width:30vw"><input type="text" name="BandName" id="bandName"/></td>
                </tr>
                <tr>
                    <td style="width:10vw"><label for="bandLocation">Location</label></td>
                    <td style="width:30vw"><input type="text" name="BandLocation" id="bandLocation"/><br/></td>
                </tr>
                <tr>
                    <td style="width:10vw"><label for="bandGenre">Genre</label></td>
                    <td style="width:30vw"><input type="text" name="BandGenre" id="bandGenre"/><br/></td>
                </tr>
                <tr>
                    <td style="width:10vw"><label for="bandYOC">Year Of Creation</label></td>
                    <td style="width:30vw"><input type="number" name="BandYOC" id="bandYOC"/><br/></td>
                </tr>
                <tr>
                    <td style="width:10vw"><label for="bandLogo">Logo</label></td>
                    <td style="width:30vw"><input type="file" name="BandLogo" id="bandLogo"/><br/></td>
                </tr>
                </tbody>
            </table>
        </div>
        <div>
            <button type="submit">Add Song</button>
        </div>
</form>
</body>
</html>
