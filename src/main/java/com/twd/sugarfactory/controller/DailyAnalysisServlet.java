package com.twd.sugarfactory.controller;

import com.google.gson.Gson;
import com.twd.sugarfactory.model.DailyDataAnalysis;
import com.twd.sugarfactory.service.DailyAnalysisServiceImpl;
import com.twd.sugarfactory.serviceinterface.DailyAnalysisService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/DailyAnalysisServlet")
public class DailyAnalysisServlet extends HttpServlet {
    
    private DailyAnalysisService service = new DailyAnalysisServiceImpl();
    private Gson gson = new Gson();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        StringBuilder sb = new StringBuilder();
        BufferedReader reader = request.getReader();
        String line;
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }

        try {
            if ("save".equals(action) || "update".equals(action)) {
                DailyDataAnalysis analysisData = gson.fromJson(sb.toString(), DailyDataAnalysis.class);
                boolean success = service.saveDailyData(analysisData);
                
                if (success) {
                    out.print("{\"status\":\"success\", \"message\":\"Data " + action + "d successfully.\"}");
                } else {
                    out.print("{\"status\":\"error\", \"message\":\"Failed to " + action + " data.\"}");
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