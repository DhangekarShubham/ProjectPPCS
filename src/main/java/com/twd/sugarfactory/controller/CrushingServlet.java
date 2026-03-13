package com.twd.sugarfactory.controller;

import com.google.gson.Gson;
import com.twd.sugarfactory.model.DailyCrushing;
import com.twd.sugarfactory.service.DailyCrushingServiceImpl;
import com.twd.sugarfactory.serviceinterface.DailyCrushingService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/CrushingServlet")
public class CrushingServlet extends HttpServlet {

    private DailyCrushingService service = new DailyCrushingServiceImpl();
    private Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String crushDate = request.getParameter("crushDate");
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        if ("find".equals(action)) {
            DailyCrushing data = service.getCrushingData(crushDate);
            if (data != null) {
                out.print(gson.toJson(data));
            } else {
                out.print("{\"status\":\"error\", \"message\":\"No data found for this date.\"}");
            }
        }
        out.flush();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        if ("delete".equals(action)) {
             String crushDate = request.getParameter("crushDate");
             boolean success = service.deleteCrushingData(crushDate);
             out.print(success ? "{\"status\":\"success\", \"message\":\"Deleted Successfully\"}" : "{\"status\":\"error\", \"message\":\"Failed to Delete\"}");
             out.flush();
             return;
        }

        StringBuilder sb = new StringBuilder();
        BufferedReader reader = request.getReader();
        String line;
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }

        try {
            if ("save".equals(action) || "update".equals(action)) {
                DailyCrushing reqData = gson.fromJson(sb.toString(), DailyCrushing.class);
                boolean success = service.saveCrushingData(reqData);
                
                if (success) {
                    out.print("{\"status\":\"success\", \"message\":\"Crushing Data Saved Successfully.\"}");
                } else {
                    out.print("{\"status\":\"error\", \"message\":\"Failed to Save Data.\"}");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"status\":\"error\", \"message\":\"Server Error: " + e.getMessage() + "\"}");
        } finally {
            out.flush();
        }
    }
}