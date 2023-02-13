<%--
  Created by IntelliJ IDEA.
  User: marco
  Date: 15/05/2022
  Time: 11:42
  To change this template use File | Settings | File Templates.
--%>

<%@page import="java.sql.*" %>
<%
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection cn = DriverManager.getConnection("jdbc:mysql://database/carpooling", "app", "supremaziauomo");
    Statement stmt = cn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
    PreparedStatement prprstmt;
%>
