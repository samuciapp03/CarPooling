<%
    if (session.getAttribute("username").equals("") || !session.getAttribute("ruolo").equals("a")) {
        response.sendRedirect("../../index.jsp");
        return;
    }
%>
<html>
<body>
<%=request.getParameter("id")%>
</body>
</html>