package com.example.dalvhikkirecordsapp.Servlets;

import com.example.dalvhikkirecordsapp.DAO.BandsDAO;
import com.example.dalvhikkirecordsapp.DAO.SongsDAO;
import com.example.dalvhikkirecordsapp.DAO.UsersDAO;
import com.example.dalvhikkirecordsapp.Objects.Bands;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class FilterBands extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Bands> countries=new ArrayList();
        String nameCountry=req.getParameter("searcher");
        Integer id= Integer.parseInt(req.getParameter("userId"));
        try {
            if (req.getAttribute("bandsList") != null) {
                req.removeAttribute("bandsList");
            }
            if (id == 0) {
                countries = new BandsDAO().fullTextSearchGuest(nameCountry);
            }
            else{
                if(new UsersDAO().UserRole(id).equals("user")){
                    countries = new BandsDAO().fullTextSearchBandsUser(nameCountry);
                }
                else if(new UsersDAO().UserRole(id).equals("admin")){
                    countries = new BandsDAO().fullTextSearchBandsAdmin(nameCountry);
                }
            }
            req.getSession().setAttribute("bandsList", countries);
            if (id == 0) {
                if(!nameCountry.equals("")){
                    req.setAttribute("search",nameCountry);
                    resp.sendRedirect("GuestPages/AllBands.jsp?search=" + nameCountry);
                }
                else{
                    if(new UsersDAO().UserRole(id).equals("user")){
                        resp.sendRedirect("UserPages/AllBands.jsp?id="+id+"?search=" + nameCountry);
                    }
                    else if(new UsersDAO().UserRole(id).equals("admin")){
                        resp.sendRedirect("AdminPages/AllBands.jsp?search=" + nameCountry);
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
