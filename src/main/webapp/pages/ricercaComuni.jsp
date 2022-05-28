<%--
  Created by IntelliJ IDEA.
  User: marco
  Date: 21/05/2022
  Time: 17:43
  To change this template use File | Settings | File Templates.
--%>
<%@include file="database.jsp" %>
<%
    String stringa = request.getParameter("str");
    String risposta = "";

    String sql = "SELECT name FROM comuni WHERE lower(name) LIKE '" + stringa + "%' ORDER BY name LIMIT 10";
    ResultSet rs = stmt.executeQuery(sql);

    while (rs.next()) {
%>
<option value="<%=rs.getString("name")%>"/>
<%
    }
%>
