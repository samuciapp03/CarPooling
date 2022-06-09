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
<%@ page import="java.util.Date" %>
<%@ page import="java.text.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.net.URL" %>
<%@include file="../../database.jsp" %>

<%
    String parameter;
    Functions f = new Functions();
    String name = null;
    String surname = null;
    String dates = null;
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    String email = null;
    String telephone = null;
    String ndriverslicence = null;
    String expire = null;
    String username = null;
    String password1 = null;
    String password2 = null;

    int count = 0;
    File nuovoFile;
    File finaleFile = null;
    String recordFileName1 = null;
    String recordFileName2 = null;

    String s;
    Process p = null;

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
                    case "surname":
                        surname = item.getString();
                        if (surname.equals("")) {
                            response.sendRedirect("index.jsp");
                            return;
                        }
                        break;
                    case "name":
                        name = item.getString();
                        if (name.equals("")) {
                            response.sendRedirect("index.jsp");
                            return;
                        }
                        break;
                    case "date":
                        dates = item.getString();
                        if (dates.equals(null)) {
                            response.sendRedirect("index.jsp");
                            return;
                        }
                        break;
                    case "email":
                        email = item.getString();
                        if (email.equals("")) {
                            response.sendRedirect("index.jsp");
                            return;
                        }
                        break;
                    case "telephone":
                        telephone = item.getString();
                        if (telephone.equals("")) {
                            response.sendRedirect("index.jsp");
                            return;
                        }
                        break;
                    case "ndriverslicence":
                        ndriverslicence = item.getString();
                        if (ndriverslicence.equals("")) {
                            response.sendRedirect("index.jsp");
                            return;
                        }
                        break;
                    case "expire":
                        expire = item.getString();
                        if (expire.equals("")) {
                            response.sendRedirect("index.jsp");
                            return;
                        }
                        break;
                    case "username":
                        username = item.getString();
                        if (username.equals("")) {
                            response.sendRedirect("index.jsp");
                            return;
                        }
                        String sql = "SELECT * FROM utenti WHERE username='" + username + "' OR (ruolo='a' AND email='" + email + "')";
                        ResultSet rs = stmt.executeQuery(sql);

                        if (rs.next()) {
                            response.sendRedirect("index.jsp");
                            return;
                        }
                        break;
                    case "password1":
                        password1 = item.getString();
                        if (password1.equals("")) {
                            response.sendRedirect("index.jsp");
                            return;
                        }
                        break;
                    case "password2":
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

                if (count == 0) {
                    nuovoFile = new File(application.getRealPath("/img/propic"), fileName);
                    recordFileName1 = username + "." + extension;
                    finaleFile = new File(application.getRealPath("/img/propic"), recordFileName1);

                    f.sendImage(finaleFile, "profile", recordFileName1);
                } else {
                    nuovoFile = new File(application.getRealPath("/img/idcard"), fileName);
                    recordFileName2 = username + "." + extension;
                    finaleFile = new File(application.getRealPath("/img/idcard"), recordFileName2);

                    f.sendImage(finaleFile, "idcard", recordFileName2);
                }
                count++;
            }
        }

        String sql = "INSERT INTO utenti(cognome, nome, username, password, dataNascita, email, img, tel, ruolo, idcard, npatente, scadenza) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        prprstmt = cn.prepareStatement(sql);
        prprstmt.setString(1, surname);
        prprstmt.setString(2, name);
        prprstmt.setString(3, username);
        prprstmt.setString(4, f.get_SHA_512_SecurePassword(password1, "amma"));
        prprstmt.setString(5, dates);
        prprstmt.setString(6, email);
        prprstmt.setString(7, recordFileName1);
        prprstmt.setString(8, telephone);
        prprstmt.setString(9, "a");
        prprstmt.setString(10, recordFileName2);
        prprstmt.setString(11, ndriverslicence);
        prprstmt.setString(12, expire);

        int row = prprstmt.executeUpdate();
        if (row > 0) {
            String code = f.generateRandomPassword(8);
            session.setAttribute("username", username);
            session.setAttribute("code", code);
            f.send(email, "Conferma Registrazione", "Il codice di verifica per confermare la registrazione e': " + code);
            response.sendRedirect("verificaCodice.jsp");
            return;
        }
    }
%>