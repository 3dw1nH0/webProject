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

        <h2>Ticket #${ticket.id}</h2>
        <security:authorize access="isAuthenticated()">
            <security:authorize access="hasRole('ADMIN') or principal.username=='${ticket.userName}'">            
                [<a href="<c:url value="/ticket/edit/${ticket.id}" />">Edit</a>]
                [<a href="<c:url value="/ticket/delete/${ticket.id}" />">Delete</a>]
            </security:authorize>
            <security:authorize access="hasRole('ADMIN')">            
                [<a href="<c:url value="/ticket/delete/${ticket.id}" />">Delete</a>]
            </security:authorize>
        </security:authorize>
        [<a href="<c:url value="/ticket/view/${ticket.id}/bid" />">Add Bid</a>]
        [<a href="<c:url value="/ticket/view/${ticket.id}/guestbook" />">Add Comment</a>]
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

        ---------------------------------------------------------
        Bids<br/>
        <c:choose>
            <c:when test="${fn:length(bids) <= 0}">
                There are no bid in this item.<br/>
            </c:when>
            <c:otherwise>
                <ol>
                    <c:forEach items="${bids}" var="bid">
                        <c:if test="${ticket.id == bid.itemID}">
                            <li>
                                User: ${bid.username}<br/>
                                Price: ${bid.price}<br/>
                            </li>
                        </c:if>
                    </c:forEach>
                </ol>
            </c:otherwise>
        </c:choose>
        ---------------------------------------------------------
        Comment<br/>
        <c:choose>
            <c:when test="${fn:length(guestBooks) == 0}">
                <i>There are no bid in this item.</i>
            </c:when>
            <c:otherwise>
                <ol>
                    <c:forEach items="${guestBooks}" var="guestBook">
                        <c:if test="${ticket.id == guestBook.itemID}">
                            <li>
                                User: ${guestBook.name}<br/>
                                Message: ${guestBook.message} (${guestBook.date})<br/>
                            </li>
                        </c:if>
                    </c:forEach>
                </ol>
            </c:otherwise>
        </c:choose>
        <a href="<c:url value="/ticket" />">Return to list tickets</a>
    </body>
</html>