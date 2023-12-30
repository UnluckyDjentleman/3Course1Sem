package com.example.dalvhikkirecordsapp.Servlets;

import com.example.dalvhikkirecordsapp.DAO.AlbumsDAO;
import com.example.dalvhikkirecordsapp.DAO.BandsDAO;
import com.example.dalvhikkirecordsapp.DAO.UsersDAO;
import com.example.dalvhikkirecordsapp.Objects.Albums;
import com.example.dalvhikkirecordsapp.Objects.Bands;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class FilterAlbums extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Albums> countries=new ArrayList();
        String nameCountry=req.getParameter("searcher");
        Integer id= Integer.parseInt(req.getParameter("userId"));
        try {
            if (req.getAttribute("albumsList") != null) {
                req.removeAttribute("albumsList");
            }
            if (id == 0) {
                countries = new AlbumsDAO().fullTextSearchGuest(nameCountry);
            }
            else{
                if(new UsersDAO().UserRole(id).equals("user")){
                    countries = new AlbumsDAO().fullTextSearchAlbumsUser(nameCountry);
                }
                else if(new UsersDAO().UserRole(id).equals("admin")){
                    countries = new AlbumsDAO().fullTextSearchAlbumsAdmin(nameCountry);
                }
            }
            req.getSession().setAttribute("albumsList", countries);
            if (id == 0) {
                if(!nameCountry.equals("")){
                    req.setAttribute("search",nameCountry);
                    resp.sendRedirect("GuestPages/AllAlbums.jsp?search=" + nameCountry);
                }
                else{
                    if(new UsersDAO().UserRole(id).equals("user")){
                        resp.sendRedirect("UserPages/AllAlbums.jsp?search=" + nameCountry);
                    }
                    else if(new UsersDAO().UserRole(id).equals("admin")){
                        resp.sendRedirect("AdminPages/AllAlbums.jsp?search=" + nameCountry);
                    }
                }
            }
            else{

            }
        }
        catch(Exception e){
            req.setAttribute("error",e.getMessage());
            resp.sendRedirect("error.jsp");
        }
    }
}
