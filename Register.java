package com.user;

import jakarta.servlet.ServletContext;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.sql.*;

@MultipartConfig

public class Register extends HttpServlet {

    private String file;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */

            //getting all the incoming detail from the request...
            String name = request.getParameter("user_name");
            String email = request.getParameter("user_email");
            String password = request.getParameter("user_password");
            Part part = request.getPart("user_image");
            String filename = part.getSubmittedFileName();
            
            //if we print all the below-mentioned in the console then the red-message comes because the "Done..." won't get the chance to go to the signup.jsp for the checking 
            //out.println(filename);//just for checking whether the file is going to the server or not...

            //checking the values in servlet...
            // out.println(name);
            //out.println(email);
            //out.println(password);
            //connecting with the help of jdbc
            try {

                Thread.sleep(3000);
                Class.forName("com.mysql.jdbc.Driver");

                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube", "root", "012345");

                //query
                String q = "insert into user (name,password,email,imageName) values(?,?,?,?)";
                PreparedStatement pstmt = con.prepareStatement(q);
                pstmt.setString(1, name);
                pstmt.setString(2, password);
                pstmt.setString(3, email);
                pstmt.setString(4, filename);

                 pstmt.executeUpdate();
                //uploading the file...
                InputStream is=part.getInputStream();
                byte []data=new byte[is.available()];
                
                
                is.read(data);
                //String path=request.getRealPath("/")+"img"+File.separator+filename;//
                ServletContext context = request.getServletContext();
                String path = context.getRealPath("/") + "img" + File.separator + filename;

                //out.println(path);
                        
                FileOutputStream fos=new FileOutputStream(path);
                fos.write(data);
                fos.close();
                
                out.println("Done...");//this should be copied as same as it is to the signup.jsp while printing the message
                
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<h1>Error..." + e.getMessage() + "...</h1>");
            }
                 
            }
        }

        // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
        /**
         * Handles the HTTP <code>GET</code> method.
         *
         * @param request servlet request
         * @param response servlet response
         * @throws ServletException if a servlet-specific error occurs
         * @throws IOException if an I/O error occurs
         */
        @Override
        protected void doGet
        (HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            processRequest(request, response);
        }

        /**
         * Handles the HTTP <code>POST</code> method.
         *
         * @param request servlet request
         * @param response servlet response
         * @throws ServletException if a servlet-specific error occurs
         * @throws IOException if an I/O error occurs
         */
        @Override
        protected void doPost
        (HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            processRequest(request, response);
        }

        /**
         * Returns a short description of the servlet.
         *
         * @return a String containing servlet description
         */
        @Override
        public String getServletInfo
        
            () {
        return "Short description";
        }// </editor-fold>

    }
