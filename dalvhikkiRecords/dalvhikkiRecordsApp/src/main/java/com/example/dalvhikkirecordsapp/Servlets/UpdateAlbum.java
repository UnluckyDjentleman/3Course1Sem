package com.example.dalvhikkirecordsapp.Servlets;

import com.example.dalvhikkirecordsapp.Connections.AdminConnection;
import com.example.dalvhikkirecordsapp.DAO.AlbumsDAO;
import com.example.dalvhikkirecordsapp.Objects.Albums;
import com.example.dalvhikkirecordsapp.Objects.Bands;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import oracle.jdbc.OracleConnection;

import java.io.*;
import java.sql.SQLException;
@MultipartConfig
public class UpdateAlbum extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try(OracleConnection conn= AdminConnection.getConn()) {
            int band_id=Integer.parseInt(req.getParameter("band_id"));
            int id=Integer.parseInt(req.getParameter("id"));
            String name=req.getParameter("AlbumName");
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
            album.setBand_id(band_id);
            album.setAlbum_id(id);
            album.setAlbum_name(name);
            album.setAlbum_photo(logoFile);
            new AlbumsDAO().UpdateAlbum(album);
            resp.sendRedirect("AdminPages/mainPageAdmin.jsp");
        } catch (Exception e) {
            e.printStackTrace();
        }
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
