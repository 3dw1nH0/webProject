<!DOCTYPE html>
<html>
    <head>
        <title>Edit Your Item</title>
    </head>
    <body>
        <c:url var="logoutUrl" value="/logout"/>
        <form action="${logoutUrl}" method="post">
            <input type="submit" value="Log out" />
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        </form>

        <h2>Item #${ticket.id}</h2>
        <form:form method="POST" enctype="multipart/form-data" modelAttribute="bidForm">
            <form:label path="userName">Owner</form:label><br/>
            <form:input type="hidden" path="userName"  value="${owner}"/><br/><br/>
            
            <form:label path="description">Description</form:label><br/>
            <form:input type="text" path="description" /><br/><br/>
            
            <form:label path="price">Expected Price</form:label><br/>
            <form:input type="text" path="price" /><br/><br/>
            
            <form:label path="status">Status</form:label><br/>
            <form:radiobutton path="status" value="Available" />Available
            <form:radiobutton path="status" value="Ended" />Ended
            <br/><br/>
            
            <form:label path="winner">Winner</form:label><br/>
            <form:input type="text" path="winner" /><br/><br/>
            <c:if test="${fn:length(ticket.attachments) > 0}">
                <b>Attachments:</b><br/>
                <ul>
                    <c:forEach items="${ticket.attachments}" var="attachment">
                        <li>
                            <c:out value="${attachment.name}" />
                            [<a href="<c:url 
                                    value="/ticket/${ticket.id}/delete/${attachment.name}"
                                    />">Delete</a>]
                        </li>
                    </c:forEach>
                </ul>
            </c:if>
            <b>Add attachments</b><br />
            <input type="file" name="attachments" multiple="multiple"/><br/><br/>
            <input type="submit" value="Save"/><br/><br/>
        </form:form>
        <a href="<c:url value="/ticket" />">Return to list tickets</a>
    </body>
</html>