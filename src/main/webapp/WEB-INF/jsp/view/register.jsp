<!DOCTYPE html>
<html>
<head>
    <title>User Registration</title>
</head>
<body>

<h2>User Registration</h2>
<form:form method="POST" enctype="multipart/form-data"
           modelAttribute="register">
    <form:label path="username">Username</form:label><br/>
    <form:input type="text" path="username" /><br/><br/>
    <form:label path="password">Password</form:label><br/>
    <form:input type="text" path="password" /><br/><br/>
    <form:hidden path="roles" value="ROLE_USER" />
    <br />
    <input type="submit" value="Register"/>
</form:form>
</body>
</html>
