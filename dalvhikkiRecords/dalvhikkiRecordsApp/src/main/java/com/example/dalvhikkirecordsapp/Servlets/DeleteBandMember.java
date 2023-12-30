package com.example.dalvhikkirecordsapp.Servlets;
import com.example.dalvhikkirecordsapp.DAO.BandMembersDAO;
import com.example.dalvhikkirecordsapp.DAO.BandsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class DeleteBandMember extends HttpServlet{
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int idBand= Integer.parseInt(req.getParameter("xd"));
        new BandMembersDAO().DeleteBandMember(idBand);
        resp.sendRedirect("AdminPages/mainPageAdmin.jsp");
    }
}
