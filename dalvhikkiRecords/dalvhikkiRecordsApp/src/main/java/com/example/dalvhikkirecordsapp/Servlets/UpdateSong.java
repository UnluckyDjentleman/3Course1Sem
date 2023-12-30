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
public class UpdateSong extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int songId= Integer.parseInt(req.getParameter("updateSong"));
        String songName=req.getParameter("songName");
        Part part=req.getPart("songFile");
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
        Songs song=new SongsDAO().getSongById(songId);
        song.setSong_name(songName);
        song.setSong_file(songFile);
        new SongsDAO().UpdateSong(song);
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
