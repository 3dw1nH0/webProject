<!DOCTYPE html>
<html>
    <head>
        <style>
            hr { 
                height: 30px; 
                border-style: solid; 
                border-color: #8c8b8b; 
                border-width: 1px 0 0 0; 
                border-radius: 20px; 
            } 
            hr:before { 
                display: block; 
                content: ""; 
                height: 30px; 
                margin-top: -31px; 
                border-style: solid; 
                border-color: #8c8b8b; 
                border-width: 0 0 1px 0; 
                border-radius: 20px; 
            }</style>
        <title>Customer Support</title>
    </head>
    <body>
        <security:authorize access="!isAuthenticated()">
            <a href="<c:url value="/login"/>"> Login </a>
        </security:authorize>    

        <security:authorize access="isAuthenticated()">
            <c:url var="logoutUrl" value="/logout"/>
            <form action="${logoutUrl}" method="post">
                <input type="submit" value="Log out" />
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            </form>
        </security:authorize> 

        <h2>Ticket #${ticket.id}</h2>
        <security:authorize access="isAuthenticated()">
            <security:authorize access="hasRole('ADMIN') or principal.username=='${ticket.userName}'">            
                [<a href="<c:url value="/ticket/edit/${ticket.id}" />">Edit</a>]
                [<a href="<c:url value="/ticket/delete/${ticket.id}" />">Delete</a>]
                [<a href="<c:url value="/ticket/view/${ticket.id}/bid" />">Add Bid</a>]
                [<a href="<c:url value="/ticket/view/${ticket.id}/guestbook" />">Add Comment</a>]
            </security:authorize>
        </security:authorize>

        <br /><br />
        <h3>Description: <c:out value="${ticket.description}" /></h3><br />
        <h3>Owner: <c:out value="${ticket.userName}" /></h3><br />
        <h3>Price: <c:out value="${ticket.price}"/></h3><br/>
        <h3>Status: <c:out value="${ticket.status}" /></h3><br />
        <h3>Winner: <c:out value="${ticket.winner}" /></h3><br />

        <c:if test="${fn:length(ticket.attachments) > 0}">
            Attachments:<br/>
            <c:forEach items="${ticket.attachments}" var="attachment"
                       varStatus="status">
                <img src="<c:url value="/ticket/${ticket.id}/attachment/${attachment.name}" />">
                <c:out value="${attachment.name}" /></a>
        </c:forEach><br /><br />
    </c:if>

    <hr>
    <br/><b>Bids</b><br/>
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

    <hr>
    <br/><b>Comment</b><br/>
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