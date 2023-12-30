package com.example.dalvhikkirecordsapp.Servlets;

import com.example.dalvhikkirecordsapp.DAO.AlbumsDAO;
import com.example.dalvhikkirecordsapp.DAO.SongsDAO;
import com.example.dalvhikkirecordsapp.DAO.UsersDAO;
import com.example.dalvhikkirecordsapp.Objects.Albums;
import com.example.dalvhikkirecordsapp.Objects.Songs;
import com.example.dalvhikkirecordsapp.Objects.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

public class GetUserServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name= req.getParameter("username");
        String password=req.getParameter("user_password");
        try {
            Users user = new UsersDAO().getUserByNameAndPassword(name, password);
            if (user!=null&& Objects.equals(user.getRole(), "admin")) {
                List<Songs> songsList=new ArrayList<>();
                List<Albums>albumsList=new ArrayList<>();
                try{
                    songsList=new SongsDAO().getBestSongsAdmin();
                    albumsList=new AlbumsDAO().getAllAlbums();
                    req.setAttribute("songsList",songsList);
                    req.setAttribute("albumsList",albumsList);
                }catch(Exception e){
                    e.printStackTrace();
                }
                req.setAttribute("username",user.getName());
                resp.sendRedirect("AdminPages/mainPageAdmin.jsp");
            } else if (user!=null&& Objects.equals(user.getRole(), "user")) {
                List<Songs> songsList=new ArrayList<>();
                List<Albums>albumsList=new ArrayList<>();
                try{
                    songsList=new SongsDAO().getBestSongsUser();
                    albumsList=new AlbumsDAO().getAllAlbums();
                }catch(Exception e){
                    e.printStackTrace();
                }
                req.getSession().setAttribute("songsList",songsList);
                req.getSession().setAttribute("albumsList",albumsList);
                req.getSession().setAttribute("idUser",user.getId());
                req.getSession().setAttribute("username",user.getName());
                resp.sendRedirect("UserPages/mainPageUser.jsp?id="+user.getId());
            }
            else{
                req.setAttribute("error","Oops... Wrong name or password");
                req.getRequestDispatcher("error.jsp").forward(req,resp);
            }
        }
        catch(Exception e){
            e.printStackTrace();
        }
    }
}
