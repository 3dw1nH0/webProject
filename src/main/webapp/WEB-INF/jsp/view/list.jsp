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

        <h2>Tickets</h2>
        
        <!-- if admin the show-->
        <security:authorize access="hasRole('ADMIN')">    
            <a href="<c:url value="/user" />">Manage User Accounts</a><br /><br />
        </security:authorize>
            
            
        <a href="<c:url value="/ticket/create" />">Create a Ticket</a><br /><br />

        <c:choose>
            <c:when test="${fn:length(ticketDatabase) == 0}">
                <i>There are no tickets in the system.</i>
            </c:when>
            <c:otherwise>
                <c:forEach items="${ticketDatabase}" var="ticket">
                    Ticket ${ticket.id}:
                    <a href="<c:url value="/ticket/view/${ticket.id}" />">
                        <c:out value="${ticket.id}" /></a>
                    (user:<c:out value="${ticket.userName}" />)
                    (description: <c:out value="${ticket.description}" />)
                    (status: <c:out value="${ticket.status}" />)
                    <security:authorize access="isAuthenticated()">
<<<<<<< HEAD
<<<<<<< HEAD
                        <security:authorize access="hasRole('ADMIN') or 
                                            principal.username=='${ticket.userName}'">
                            [<a href="<c:url value="/ticket/edit/${ticket.id}" />">Edit</a>]          
                            [<a href="<c:url value="/ticket/delete/${ticket.id}" />">Delete</a>]
                        </security:authorize>
=======
                    <security:authorize access="hasRole('ADMIN') or 
                                        principal.username=='${ticket.userName}'">
                        [<a href="<c:url value="/ticket/edit/${ticket.id}" />">Edit</a>]
                    </security:authorize>
                    <security:authorize access="hasRole('ADMIN')">            
                        [<a href="<c:url value="/ticket/delete/${ticket.id}" />">Delete</a>]
                    </security:authorize>
>>>>>>> parent of dba1b82... delete function work
=======
                    <security:authorize access="hasRole('ADMIN') or 
                                        principal.username=='${ticket.userName}'">
                        [<a href="<c:url value="/ticket/edit/${ticket.id}" />">Edit</a>]          
                        [<a href="<c:url value="/ticket/delete/${ticket.id}" />">Delete</a>]
                    </security:authorize>
>>>>>>> parent of 2688977... css to view.jsp 
                    </security:authorize>
                    <br /><br />
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </body>
</html>
