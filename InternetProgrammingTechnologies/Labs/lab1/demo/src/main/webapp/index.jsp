<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Message</title>
</head>
<body>
    <form action="/SenderServlet" method="get">
        <input type="text" placeholder="message" name="message"/>
        <input type="submit"/>
    </form>
</body>
</html>