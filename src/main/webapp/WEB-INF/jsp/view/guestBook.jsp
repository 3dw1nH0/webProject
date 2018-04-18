<%-- 
    Document   : guestBook
    Created on : Apr 18, 2018, 11:02:27 PM
    Author     : BunnyFung
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Guest Book</title>
    </head>
    <body>
        <h1>Guest Book</h1>

        <form:form method="POST" enctype="multipart/form-data" modelAttribute="guestBookForm">
            <form:label path="message">message</form:label><br/> 
            <form:textarea rows="4" cols="100" maxlength="500" path="message"></form:textarea><br/>
            <input type="submit" name="add message" value="add message" />
        </form:form>
    </body>
</html>