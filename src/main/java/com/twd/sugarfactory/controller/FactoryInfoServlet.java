package com.twd.sugarfactory.controller;

import com.google.gson.Gson;
import com.twd.sugarfactory.model.FactoryInfo;
import com.twd.sugarfactory.serviceinterface.FactoryInfoService;
import com.twd.sugarfactory.service.FactoryInfoServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/FactoryInfoServlet")
public class FactoryInfoServlet extends HttpServlet {
    
    private FactoryInfoService service = new FactoryInfoServiceImpl();
    private Gson gson = new Gson(); // Requires gson.jar in WEB-INF/lib

    // Used for GET/FIND requests
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        if ("find".equals(action)) {
            String seasonYear = request.getParameter("seasonYear");
            FactoryInfo info = service.getFactoryInfo(seasonYear);
            if (info != null) {
                out.print(gson.toJson(info));
            } else {
                out.print("{\"status\":\"error\", \"message\":\"Record not found\"}");
            }
        }
        out.flush();
    }

    // Used for SAVE, UPDATE, DELETE via JSON payload
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        // Read JSON payload from request body
        StringBuilder sb = new StringBuilder();
        BufferedReader reader = request.getReader();
        String line;
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }
        
        try {
            if ("save".equals(action)) {
                FactoryInfo info = gson.fromJson(sb.toString(), FactoryInfo.class);
                boolean success = service.saveFactoryInfo(info);
                out.print(success ? "{\"status\":\"success\", \"message\":\"Saved Successfully\"}" : "{\"status\":\"error\", \"message\":\"Failed to Save\"}");
            } 
            else if ("update".equals(action)) {
                FactoryInfo info = gson.fromJson(sb.toString(), FactoryInfo.class);
                boolean success = service.updateFactoryInfo(info);
                out.print(success ? "{\"status\":\"success\", \"message\":\"Updated Successfully\"}" : "{\"status\":\"error\", \"message\":\"Failed to Update\"}");
            }
            else if ("delete".equals(action)) {
                String seasonYear = request.getParameter("seasonYear");
                boolean success = service.deleteFactoryInfo(seasonYear);
                out.print(success ? "{\"status\":\"success\", \"message\":\"Deleted Successfully\"}" : "{\"status\":\"error\", \"message\":\"Failed to Delete\"}");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"status\":\"error\", \"message\":\"Server Error\"}");
        }
        out.flush();
    }
}