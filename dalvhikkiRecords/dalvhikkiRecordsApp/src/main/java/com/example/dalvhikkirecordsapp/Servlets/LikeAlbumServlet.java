package com.example.dalvhikkirecordsapp.Servlets;

import com.example.dalvhikkirecordsapp.DAO.LikedAlbumsDAO;
import com.example.dalvhikkirecordsapp.DAO.LikedSongsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class LikeAlbumServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int idAlbum= Integer.parseInt(req.getParameter("like_but"));
        int idUser= Integer.parseInt(req.getParameter("idUser"));
        if(!new LikedAlbumsDAO().LikedAlbum(idUser, idAlbum)) {
            new LikedAlbumsDAO().LikeAlbum(idUser, idAlbum);
        }
        resp.sendRedirect("UserPages/mainPageUser.jsp?id="+idUser);
    }
}
