<%-- 
    Document   : addBidding
    Created on : 2018/4/17, 下午 04:34:11
    Author     : Edwin
--%>

<!DOCTYPE html>
<html>
    <head>
        <title>Add item for bidding</title>
    </head>
    <body>
        <c:url var="logoutUrl" value="/logout"/>
        <form action="${logoutUrl}" method="post">
            <input type="submit" value="Log out" />
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        </form>
        <br/><br/><a href="<c:url value="/ticket" />">Return to bidding lists</a>
        <h2>Create an item for bidding</h2>
        
        <form:form method="POST" enctype="multipart/form-data" modelAttribute="bidForm">
            <form:label path="userName">Owner: ${owner}</form:label><br/>
            <form:input type="hidden" path="userName"  value="${owner}"/><br/><br/>
            <form:label path="description">Description</form:label><br/>
            <form:input type="text" path="description" /><br/><br/>
            <form:label path="expectedPrice">Expected Price</form:label><br/>
            <form:input type="text" path="expectedPrice"/><br/><br/>
            <form:label path="status">Status</form:label><br/>
            <form:radiobutton path="status" value="Available" />Available
            <form:radiobutton path="status" value="Ended" />Ended
            <br/><br/>
            <form:label path="winner">Winner</form:label><br/>
            <form:input type="text" path="winner" /><br/><br/>
            <b>Attachments</b><br/>
            <input type="file" name="attachments" multiple="multiple"/><br/><br/>
            <input type="submit" value="Submit"/>
        </form:form>
    </body>
</html>

