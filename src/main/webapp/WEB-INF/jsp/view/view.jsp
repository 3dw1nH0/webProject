<!DOCTYPE html>
<html>
    <head>
        <title>Customer Support</title>
    </head>
    <body>
        <c:url var="logoutUrl" value="/logout"/>
        <form action="${logoutUrl}" method="post">
            <input type="submit" value="Log out" />
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        </form>

        <h2>Ticket #${ticket.id}/></h2>
        <security:authorize access="hasRole('ADMIN') or principal.username=='${ticket.userName}'">            
            [<a href="<c:url value="/ticket/edit/${ticket.id}" />">Edit</a>]
        </security:authorize>
        <security:authorize access="hasRole('ADMIN')">            
            [<a href="<c:url value="/ticket/delete/${ticket.id}" />">Delete</a>]
        </security:authorize>
        <br /><br />
        <h3>Description: <c:out value="${ticket.description}" /></h3><br />
        <h3>Owner: <c:out value="${ticket.userName}" /></h3><br />
        <h3>Price: <c:out value="${ticket.price}"/></h3><br/>
        <h3>Status: <c:out value="${ticket.status}" /></h3><br />
        <h3>Winner: <c:out value="${ticket.winner}" /></h3><br />
        
        <c:if test="${fn:length(ticket.attachments) > 0}">
            Attachments:
            <c:forEach items="${ticket.attachments}" var="attachment"
                       varStatus="status">
                <c:if test="${!status.first}">, </c:if>
                <a href="<c:url value="/ticket/${ticket.id}/attachment/${attachment.name}" />">
                    <c:out value="${attachment.name}" /></a>
            </c:forEach><br /><br />
        </c:if>
        <a href="<c:url value="/ticket" />">Return to list tickets</a>
    </body>
</html>