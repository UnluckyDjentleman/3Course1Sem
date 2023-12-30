package com.example.dalvhikkirecordsapp.Servlets;

import com.example.dalvhikkirecordsapp.DAO.LikedSongsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Arrays;

public class LikeSongServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int idSong = Integer.parseInt(req.getParameter("like_but"));
            int idUser = Integer.parseInt(req.getParameter("idUser"));
            if (!new LikedSongsDAO().LikedSong(idUser, idSong)) {
                new LikedSongsDAO().LikeSong(idUser, idSong);
            }
            resp.sendRedirect("UserPages/mainPageUser.jsp?id=" + idUser);
        }
        catch(Exception e){
            e.printStackTrace();
        }
    }
}
