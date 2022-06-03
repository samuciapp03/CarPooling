<%--
  Created by IntelliJ IDEA.
  User: sam_ciappe
  Date: 20/05/22
  Time: 12:41
  To change this template use File | Settings | File Templates.
--%>
<%@page import="org.apache.commons.fileupload.*" %>
<%@page import="java.util.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>

<%@page import="com.example.carpooling.Functions" %>
<%@ page import="java.text.*" %>
<%@ page import="java.io.*" %>

<%@include file="../../database.jsp" %>

<%
    String parameter;
    Functions f = new Functions();
    String name = null;
    String surname = null;
    String dates = null;
    String email = null;
    String telephone = null;
    String username = null;
    String password1 = null;
    String password2 = null;

    File nuovoFile;
    File finaleFile = null;
    String recordFileName = null;

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
                    case "surnameP":
                        surname = item.getString();
                        if (surname.equals("")) {
                            response.sendRedirect("index.jsp");
                            return;
                        }
                        break;
                    case "nameP":
                        name = item.getString();
                        if (name.equals("")) {
                            response.sendRedirect("index.jsp");
                            return;
                        }
                        break;
                    case "dateP":
                        dates = item.getString();
                        if (dates.equals(null)) {
                            response.sendRedirect("index.jsp");
                            return;
                        }
                        break;
                    case "emailP":
                        email = item.getString();
                        if (email.equals("")) {
                            response.sendRedirect("index.jsp");
                            return;
                        }
                        break;
                    case "telephoneP":
                        telephone = item.getString();
                        if (telephone.equals("")) {
                            response.sendRedirect("index.jsp");
                            return;
                        }
                        break;
                    case "usernameP":
                        username = item.getString();
                        if (username.equals("")) {
                            response.sendRedirect("index.jsp");
                            return;
                        }
                        String sql = "SELECT * FROM utenti WHERE username='" + username + "'";
                        ResultSet rs = stmt.executeQuery(sql);

                        if (rs.next()) {
                            response.sendRedirect("index.jsp");
                            return;
                        }
                        break;
                    case "password1P":
                        password1 = item.getString();
                        if (password1.equals("")) {
                            response.sendRedirect("index.jsp");
                            return;
                        }
                        break;
                    case "password2P":
                        password2 = item.getString();
                        if (password2.equals("") || !password2.equals(password1)) {
                            response.sendRedirect("index.jsp");
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

                nuovoFile = new File(application.getRealPath("/img/propic"), fileName);
                recordFileName = username + "." + extension;
                finaleFile = new File(application.getRealPath("/img/propic"), recordFileName);

                item.write(finaleFile);
            }
        }

        String s;
        Process p;
        try {
            p = Runtime.getRuntime().exec("scp " + finaleFile + " samu_ciappesoni@34.121.51.33:/home/samu_ciappesoni/img/propic");
            BufferedReader br = new BufferedReader(
                    new InputStreamReader(p.getInputStream()));
            p.waitFor();
            p.destroy();
            try {
                p = Runtime.getRuntime().exec("rm " + finaleFile);
                br = new BufferedReader(
                        new InputStreamReader(p.getInputStream()));
                p.waitFor();
                p.destroy();
            } catch (Exception e) {
            }
        } catch (Exception e) {
        }

        String sql = "INSERT INTO utenti(cognome, nome, username, password, dataNascita, email, img, tel, ruolo, idcard, npatente, scadenza) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        prprstmt = cn.prepareStatement(sql);
        prprstmt.setString(1, surname);
        prprstmt.setString(2, name);
        prprstmt.setString(3, username);
        prprstmt.setString(4, f.get_SHA_512_SecurePassword(password1, "amma"));
        prprstmt.setString(5, dates);
        prprstmt.setString(6, email);
        prprstmt.setString(7, recordFileName);
        prprstmt.setString(8, telephone);
        prprstmt.setString(9, "p");
        prprstmt.setString(10, "null");
        prprstmt.setString(11, "null");
        prprstmt.setString(12, "null");

        int row = prprstmt.executeUpdate();
        if (row > 0) {
            response.sendRedirect("../../../index.jsp");
            return;
        }
    }
%>
