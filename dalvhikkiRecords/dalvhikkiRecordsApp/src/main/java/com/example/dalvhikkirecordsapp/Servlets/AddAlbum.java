package com.example.dalvhikkirecordsapp.Servlets;

import com.example.dalvhikkirecordsapp.DAO.AlbumsDAO;
import com.example.dalvhikkirecordsapp.Objects.Albums;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.*;

@MultipartConfig
public class AddAlbum extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int bandId= Integer.parseInt(req.getParameter("bandId"));
        String albumName=req.getParameter("AlbumName");
        Part part=req.getPart("AlbumLogo");
        String logoFile=extractFileName(part);
        if(!new File(getServletContext().getRealPath("")+File.separator+"Images").exists()){
            new File(getServletContext().getRealPath("")+File.separator+"Images").mkdirs();
        }
        String savePath=getServletContext().getRealPath("")+File.separator+"Images"+File.separator+logoFile;
        InputStream fileContent = part.getInputStream();
        OutputStream out = new FileOutputStream(new File(savePath));
        int read = 0;
        byte[] bytes = new byte[1024];

        while ((read = fileContent.read(bytes)) != -1) {
            out.write(bytes, 0, read);
        }
        out.flush();
        out.close();
        Albums album=new Albums();
        album.setAlbum_name(albumName);
        album.setBand_id(bandId);
        album.setAlbum_likes_count(0);
        album.setAlbum_photo(logoFile);
        try {
            new AlbumsDAO().AddAlbumToBand(album);
        }
        catch(Exception e){
            req.setAttribute("error",e.getMessage());
            resp.sendRedirect("error.jsp");
        }
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
