package com.example.dalvhikkirecordsapp.Servlets;

import com.example.dalvhikkirecordsapp.Connections.GuestConnection;
import com.example.dalvhikkirecordsapp.DAO.AlbumsDAO;
import com.example.dalvhikkirecordsapp.DAO.SongsDAO;
import com.example.dalvhikkirecordsapp.DAO.UsersDAO;
import com.example.dalvhikkirecordsapp.Objects.Albums;
import com.example.dalvhikkirecordsapp.Objects.Songs;
import com.example.dalvhikkirecordsapp.Objects.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import oracle.jdbc.OracleConnection;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class NewUserServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name= req.getParameter("username");
        String email=req.getParameter("email");
        String password=req.getParameter("user_password");
        Users newUser=new UsersDAO().UserRegistration(name,email,password);
        try{
            List<Songs> songsList=new ArrayList<>();
            List<Albums>albumsList=new ArrayList<>();
            String bandName=null;
            try{
                songsList=new SongsDAO().getBestSongsUser();
                albumsList=new AlbumsDAO().getAllAlbums();
            }catch(Exception e){
                e.printStackTrace();
            }
            req.getSession().setAttribute("songsList",songsList);
            req.getSession().setAttribute("albumsList",albumsList);
            req.getSession().setAttribute("idUser",newUser.getId());
            req.getSession().setAttribute("username",newUser.getName());
            resp.sendRedirect("UserPages/mainPageUser.jsp?id="+newUser.getId());
        }
        catch(Exception e){
            req.setAttribute("error","Registration failed...");
            resp.sendRedirect("error.jsp");
        }
    }
}
