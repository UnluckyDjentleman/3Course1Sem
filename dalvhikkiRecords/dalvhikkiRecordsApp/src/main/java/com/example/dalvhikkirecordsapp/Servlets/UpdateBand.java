package com.example.dalvhikkirecordsapp.Servlets;

import com.example.dalvhikkirecordsapp.DAO.BandsDAO;
import com.example.dalvhikkirecordsapp.Objects.Bands;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.*;

@MultipartConfig
public class UpdateBand extends HttpServlet {

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

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id=Integer.parseInt(req.getParameter("band_id"));
        String bandName=req.getParameter("BandName");
        String bandLocation=req.getParameter("BandLocation");
        String bandGenre=req.getParameter("BandGenre");
        int bandYearOfCreation= Integer.parseInt(req.getParameter("BandYOC"));
        Part part=req.getPart("BandLogo");
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
        Bands band=new Bands();
        band.setBand_id(id);
        band.setBand_name(bandName);
        band.setBand_location(bandLocation);
        band.setBand_genre(bandGenre);
        band.setBand_year_of_creation(bandYearOfCreation);
        band.setBand_logo(logoFile);
        new BandsDAO().UpdateBand(band);
        resp.sendRedirect("AdminPages/mainPageAdmin.jsp");
    }
}
