package com.example.carpooling;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.mime.HttpMultipartMode;
import org.apache.http.entity.mime.MultipartEntityBuilder;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;

import javax.mail.*;
import javax.mail.internet.*;
import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Properties;
import java.util.Random;

public class Functions {

    public Functions() {

    }

    public String get_SHA_512_SecurePassword(String passwordToHash, String salt) {
        String generatedPassword = null;
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-512");
            md.update(salt.getBytes(StandardCharsets.UTF_8));
            byte[] bytes = md.digest(passwordToHash.getBytes(StandardCharsets.UTF_8));
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < bytes.length; i++) {
                sb.append(Integer.toString((bytes[i] & 0xff) + 0x100, 16).substring(1));
            }
            generatedPassword = sb.toString();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        return generatedPassword;
    }

    public void send(String to, String sub, String msg) {
        // Get properties object
        Properties props = System.getProperties();
        // Set manual Properties
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp-mail.outlook.com");
        props.put("mail.smtp.port", "587");

        final String from = "project.chungus@outlook.it", passwd = "Gigachungus";

        // get Session
        Session session = Session.getInstance(props,
                new Authenticator() {
                    @Override
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(from, passwd);
                    }
                });
        session.setDebug(true);

        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(from));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
            message.setSubject(sub);
            message.setText(msg);
            // send messagex
            Transport.send(message);

            System.out.println("Message sent");
        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }

    public String generateRandomPassword(int len) {
        String chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!@#$%&";
        Random rnd = new Random();
        StringBuilder sb = new StringBuilder(len);
        for (int i = 0; i < len; i++)
            sb.append(chars.charAt(rnd.nextInt(chars.length())));
        return sb.toString();
    }

    public String renderDate(String date) {
        String a[] = date.split("-");
        String y = a[0];
        String m = a[1];
        String d = a[2];
        String format = "";

        format = d + " ";

        switch (m) {
            case "01":
                format = format + "Gennaio ";
                break;
            case "02":
                format = format + "Febbraio ";
                break;
            case "03":
                format = format + "Marzo ";
                break;
            case "04":
                format = format + "Aprile ";
                break;
            case "05":
                format = format + "Maggio ";
                break;
            case "06":
                format = format + "Giugno ";
                break;
            case "07":
                format = format + "Luglio ";
                break;
            case "08":
                format = format + "Agosto ";
                break;
            case "09":
                format = format + "Settembre ";
                break;
            case "10":
                format = format + "Ottobre ";
                break;
            case "11":
                format = format + "Novembre ";
                break;
            case "12":
                format = format + "Dicembre ";
                break;
        }

        format = format + " " + y;
        return format;
    }

    public void sendImage(File f, String folder, String nameImg) {
        HttpPost post = new HttpPost("http://api:8080/images/CarPooling/" + folder);

        MultipartEntityBuilder builder = MultipartEntityBuilder.create();
        builder.setMode(HttpMultipartMode.BROWSER_COMPATIBLE);
        builder.addBinaryBody("profileImg", f, ContentType.DEFAULT_BINARY, nameImg);
        builder.addTextBody("nameImg", nameImg, ContentType.DEFAULT_BINARY);

        HttpEntity entity = builder.build();
        post.setEntity(entity);
        CloseableHttpClient client = HttpClients.createDefault();
        try {
            HttpResponse response = client.execute(post);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}
