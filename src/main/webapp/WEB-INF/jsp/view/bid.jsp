<%-- 
    Document   : bid
    Created on : Apr 18, 2018, 9:02:15 PM
    Author     : BunnyFung
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Bid</title>
    </head>
    <body>
        <h1>Bid</h1>

        <form:form method="POST" enctype="multipart/form-data" modelAttribute="bidForm">
            <form:label path="price">Price:</form:label> 
            <form:input type="text" path="price" />
            <input type="submit" name="bid" value="bid" />
        </form:form>
    </body>
</html>

