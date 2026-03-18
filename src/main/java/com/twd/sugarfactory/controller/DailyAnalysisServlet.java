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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            if ("find".equals(action)) {
                String sampleDate = request.getParameter("sampleDate");
                DailyDataAnalysis data = service.getDailyData(sampleDate);
                
                if (data != null && data.getSampleDate() != null) {
                    // Send the populated object back. 
                    // Gson will turn the Java Object into a JSON string Angular can read.
                    out.print(gson.toJson(data));
                } else {
                    // Send a clear error status so the AngularJS .then() logic can catch it
                    out.print("{\"status\":\"error\", \"message\":\"No lab analysis found for " + sampleDate + ".\"}");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"status\":\"error\", \"message\":\"Server Error: " + e.getMessage() + "\"}");
        } finally {
            out.flush();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            // 1. Handle Delete
            if ("delete".equals(action)) {
                String sampleDate = request.getParameter("sampleDate");
                boolean success = service.deleteDailyData(sampleDate); 
                
                if (success) {
                    out.print("{\"status\":\"success\", \"message\":\"Data deleted successfully.\"}");
                } else {
                    out.print("{\"status\":\"error\", \"message\":\"Failed to delete data.\"}");
                }
            } 
            // 2. Handle Save & Update
            else if ("save".equals(action) || "update".equals(action)) {
                StringBuilder sb = new StringBuilder();
                String line;
                try (BufferedReader reader = request.getReader()) {
                    while ((line = reader.readLine()) != null) {
                        sb.append(line);
                    }
                }

                DailyDataAnalysis analysisData = gson.fromJson(sb.toString(), DailyDataAnalysis.class);
                boolean success = service.saveDailyData(analysisData);
                
                if (success) {
                    out.print("{\"status\":\"success\", \"message\":\"Data " + action + "d successfully.\"}");
                } else {
                    out.print("{\"status\":\"error\", \"message\":\"Could not " + action + " analysis. Check database constraints.\"}");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"status\":\"error\", \"message\":\"Exception: " + e.getMessage() + "\"}");
        } finally {
            out.flush();
        }
    }
}