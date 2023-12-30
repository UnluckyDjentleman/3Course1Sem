package com.example.dalvhikkirecordsapp.Servlets;

import com.example.dalvhikkirecordsapp.DAO.BandMembersDAO;
import com.example.dalvhikkirecordsapp.Objects.BandMembers;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class AddBandMember extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int bandId=Integer.parseInt(req.getParameter("xd2"));
        String bandMemName=req.getParameter("BandMemName");
        String bandMemRole=req.getParameter("BandMemRole");
        BandMembers bandMem=new BandMembers();
        bandMem.setMember_name(bandMemName);
        bandMem.setBand_id(bandId);
        bandMem.setMember_instrument(bandMemRole);
        new BandMembersDAO().AddMemberInBand(bandMem);
        resp.sendRedirect("AdminPages/mainPageAdmin.jsp");
    }
}
