package com.example.dalvhikkirecordsapp.Servlets;

import com.example.dalvhikkirecordsapp.DAO.BandsDAO;
import com.example.dalvhikkirecordsapp.DAO.SongsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class DeleteBand extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int idBand= Integer.parseInt(req.getParameter("band_id"));
        new BandsDAO().DeleteBand(idBand);
        try {
            resp.sendRedirect("AdminPages/mainPageAdmin.jsp");
        }
        catch(Exception e){
            req.setAttribute("error",e.getMessage());
            resp.sendRedirect("error.jsp");
        }
    }
}
