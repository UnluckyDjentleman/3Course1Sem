package com.example.dalvhikkirecordsapp.Servlets;

import com.example.dalvhikkirecordsapp.DAO.BandMembersDAO;
import com.example.dalvhikkirecordsapp.Objects.BandMembers;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class UpdateBandMember extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int bandId=Integer.parseInt(req.getParameter("xd2"));
        int memberId= Integer.parseInt(req.getParameter("xd1"));
        String memberName=req.getParameter("BandMemName");
        String memberRole=req.getParameter("BandMemRole");
        BandMembers bandMem=new BandMembers();
        bandMem.setMember_id(memberId);
        bandMem.setMember_name(memberName);
        bandMem.setMember_instrument(memberRole);
        bandMem.setBand_id(bandId);
        new BandMembersDAO().UpdateMemberInBand(bandMem);
        resp.sendRedirect("AdminPages/mainPageAdmin.jsp");
    }
}
