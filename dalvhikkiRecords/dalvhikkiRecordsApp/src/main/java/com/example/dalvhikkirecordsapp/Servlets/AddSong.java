package com.example.dalvhikkirecordsapp.Servlets;

import com.example.dalvhikkirecordsapp.DAO.SongsDAO;
import com.example.dalvhikkirecordsapp.Objects.Songs;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.*;
@MultipartConfig
public class AddSong extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int albumId= Integer.parseInt(req.getParameter("xd1"));
        int bandId= Integer.parseInt(req.getParameter("xd2"));
        String songName=req.getParameter("SongName");
        Part part=req.getPart("SongFile");
        String songFile=extractFileName(part);
        if(!new File(getServletContext().getRealPath("")+File.separator+"Audio").exists()){
            new File(getServletContext().getRealPath("")+File.separator+"Audio").mkdirs();
        }
        String savePath=getServletContext().getRealPath("")+File.separator+"Audio"+File.separator+songFile;
        InputStream fileContent = part.getInputStream();
        OutputStream out = new FileOutputStream(new File(savePath));
        int read = 0;
        byte[] bytes = new byte[1024];

        while ((read = fileContent.read(bytes)) != -1) {
            out.write(bytes, 0, read);
        }
        out.flush();
        out.close();
        Songs song=new Songs();
        song.setSong_name(songName);
        song.setAlbum_id(albumId);
        song.setBand_id(bandId);
        song.setSong_release(new java.sql.Date(System.currentTimeMillis()));
        song.setSong_likes_count(0);
        song.setSong_file(songFile);
        new SongsDAO().AddSong(song);
        resp.sendRedirect("AdminPages/mainPageAdmin.jsp");
    }
    private String extractFileName(Part part){
        String contentDrip=part.getHeader("content-disposition");
        String[] items=contentDrip.split(";");
        for(String s: items){
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "";
    }
}
