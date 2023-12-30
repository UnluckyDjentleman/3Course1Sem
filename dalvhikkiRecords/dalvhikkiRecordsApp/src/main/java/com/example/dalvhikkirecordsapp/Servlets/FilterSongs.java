package com.example.dalvhikkirecordsapp.Servlets;

import com.example.dalvhikkirecordsapp.DAO.BandsDAO;
import com.example.dalvhikkirecordsapp.DAO.SongsDAO;
import com.example.dalvhikkirecordsapp.DAO.UsersDAO;
import com.example.dalvhikkirecordsapp.Objects.Bands;
import com.example.dalvhikkirecordsapp.Objects.Songs;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class FilterSongs extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Songs> countries=new ArrayList();
        String nameCountry=req.getParameter("searcher");
        Integer id= Integer.parseInt(req.getParameter("userId"));
        try {
            if (req.getAttribute("songsList") != null) {
                req.removeAttribute("songsList");
            }
            if (id == 0) {
                countries = new SongsDAO().fullTextSearchSongsGuest(nameCountry);
            }
            else{
                if(new UsersDAO().UserRole(id).equals("user")){
                    countries = new SongsDAO().fullTextSearchSongsUser(nameCountry);
                }
                else if(new UsersDAO().UserRole(id).equals("admin")){
                    countries = new SongsDAO().fullTextSearchSongsAdmin(nameCountry);
                }
            }
            req.getSession().setAttribute("songsList", countries);
            if (id == 0) {
                if(!nameCountry.equals("")){
                    req.setAttribute("search",nameCountry);
                    resp.sendRedirect("GuestPages/AllSongs.jsp?search=" + nameCountry);
                }
                else{
                    if(new UsersDAO().UserRole(id).equals("user")){
                        resp.sendRedirect("UserPages/AllSongs.jsp?search=" + nameCountry);
                    }
                    else if(new UsersDAO().UserRole(id).equals("admin")){
                        resp.sendRedirect("AdminPages/AllSongs.jsp?search=" + nameCountry);
                    }
                }
            }
        }
        catch(Exception e){
            req.setAttribute("error",e.getMessage());
            resp.sendRedirect("error.jsp");
        }
    }
}
