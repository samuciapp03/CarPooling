<%--
  Created by IntelliJ IDEA.
  User: marco
  Date: 17/05/2022
  Time: 18:10
  To change this template use File | Settings | File Templates.
--%>
<%@page import="org.apache.commons.fileupload.*" %>
<%@page import="java.util.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>

<%@page import="com.example.carpooling.Functions" %>
<%@ page import="java.io.*" %>
<%@include file="../database.jsp" %>

<%
    if (!session.getAttribute("ruolo").equals("a")) {
        response.sendRedirect("index.jsp");
        return;
    }
    String parameter;
    Functions f = new Functions();
    String marca = null;
    String modello = null;
    String targa = null;
    String annoImm = null;

    File nuovoFile;
    File finaleFile;
    String recordFileName = null;

    int id = 0;
    int num = 1;

    String sql = "SELECT COUNT(*) AS TOT FROM automobili WHERE idUtente=(SELECT idUtente FROM utenti WHERE username='" + session.getAttribute("username") + "') GROUP BY idUtente";
    ResultSet rs = stmt.executeQuery(sql);

    while (rs.next()) {
        num = Integer.valueOf(rs.getString("TOT")) + 1;
    }

    boolean isMultipart = ServletFileUpload.isMultipartContent(request);
    if (!isMultipart) {

    } else {
        FileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
        List items = null;
        try {
            items = upload.parseRequest(request);
        } catch (FileUploadException e) {
            e.printStackTrace();
        }
        Iterator itr = items.iterator();
        while (itr.hasNext()) {
            FileItem item = (FileItem) itr.next();
            if (item.isFormField()) {
                parameter = item.getFieldName();
                switch (parameter) {
                    case "marca":
                        marca = item.getString();
                        if (marca.equals("")) {
                            response.sendRedirect("inserimentoAuto.jsp");
                            return;
                        }
                        break;
                    case "modello":
                        modello = item.getString();
                        if (modello.equals("")) {
                            response.sendRedirect("inserimentoAuto.jsp");
                            return;
                        }
                        break;
                    case "targa":
                        targa = item.getString();
                        if (targa.equals(null) || targa.length() != 7) {
                            response.sendRedirect("inserimentoAuto.jsp");
                            return;
                        }
                        break;
                    case "annoImm":
                        annoImm = item.getString();
                        if (annoImm.equals("")) {
                            response.sendRedirect("inserimentoAuto.jsp");
                            return;
                        }
                        break;
                }
            } else {
                if (item.getName().equals("")) {
                    response.sendRedirect("index.jsp");
                    return;
                }
                String fileName = item.getName();
                int posSeparator = fileName.lastIndexOf(File.separator);
                String extension = fileName.substring(fileName.lastIndexOf(".") + 1);
                if (posSeparator != -1) {
                    fileName = fileName.substring(posSeparator + 1);
                } else {
                    fileName = fileName.substring(fileName.lastIndexOf("\\") + 1);
                }

                nuovoFile = new File(application.getRealPath("/img/cars"), fileName);
                recordFileName = session.getAttribute("username") + String.valueOf(num) + "." + extension;
                finaleFile = new File(application.getRealPath("/img/cars"), recordFileName);

                item.write(finaleFile);
            }
        }


        sql = "SELECT idUtente FROM utenti WHERE username='" + session.getAttribute("username") + "'";
        rs = stmt.executeQuery(sql);

        while (rs.next()) {
            id = Integer.parseInt(rs.getString("idUtente"));
        }
        rs.close();

        sql = "INSERT INTO automobili(marca, modello, idUtente, annoImm, img, targa) values (?, ?, ?, ?, ?, ?)";
        prprstmt = cn.prepareStatement(sql);
        prprstmt.setString(1, marca);
        prprstmt.setString(2, modello);
        prprstmt.setString(3, String.valueOf(id));
        prprstmt.setString(4, annoImm);
        prprstmt.setString(5, recordFileName);
        prprstmt.setString(6, targa);

        int row = prprstmt.executeUpdate();
        if (row > 0) {
            response.sendRedirect("index.jsp");
            return;
        }
    }
%>