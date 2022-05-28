package com.example.carpooling;

import javax.mail.*;
import javax.mail.internet.*;
import java.io.*;
import java.nio.charset.*;
import java.security.*;
import java.util.*;

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
        //Get properties object
        Properties props = System.getProperties();
        // Set manual Properties
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp-mail.outlook.com");
        props.put("mail.smtp.port", "587");

        final String from = "project.chungus@outlook.it", passwd = "Gigachungus";

        //get Session
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
            //send messagex
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

        switch (m) {
            case "01":
                format = "January ";
                break;
            case "02":
                format = "February ";
                break;
            case "03":
                format = "March ";
                break;
            case "04":
                format = "April ";
                break;
            case "05":
                format = "May ";
                break;
            case "06":
                format = "June ";
                break;
            case "07":
                format = "July ";
                break;
            case "08":
                format = "August ";
                break;
            case "09":
                format = "September ";
                break;
            case "10":
                format = "October ";
                break;
            case "11":
                format = "November ";
                break;
            case "12":
                format = "December ";
                break;
        }

        switch (d) {
            case "01":
            case "21":
            case "31":
                format = format + String.valueOf(Integer.valueOf(d)) + "st";
                break;
            case "02":
            case "22":
                format = format + String.valueOf(Integer.valueOf(d)) + "nd";
                break;
            case "03":
            case "23":
                format = format + String.valueOf(Integer.valueOf(d)) + "rd";
                break;
            default:
                format = format + String.valueOf(Integer.valueOf(d)) + "th";
                break;

        }
        format = format + " " + y;
        return format;
    }
}



