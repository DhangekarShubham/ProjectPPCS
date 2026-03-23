package com.twd.sugarfactory.controller;

import com.google.gson.Gson;
import com.twd.sugarfactory.model.DailyAnalysisReport;
import com.twd.sugarfactory.service.ReportDailyAnalysisServiceImpl;
import com.twd.sugarfactory.serviceinterface.ReportDailyAnalysisService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/ReportDailyAnalysisServlet")
public class ReportDailyAnalysisServlet extends HttpServlet {

    private ReportDailyAnalysisService service = new ReportDailyAnalysisServiceImpl();
    private Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String sampleDate = request.getParameter("sampleDate");

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        // Use a Map to build the response safely
        Map<String, Object> jsonResponse = new HashMap<>();

        try {
            if ("find".equals(action)) {
                // Prevent empty requests from hitting the database
                if (sampleDate == null || sampleDate.trim().isEmpty()) {
                    jsonResponse.put("status", "error");
                    jsonResponse.put("message", "Date parameter is missing.");
                } else {
                    DailyAnalysisReport reportData = service.getDailyAnalysis(sampleDate);

                    if (reportData != null) {
                        jsonResponse.put("status", "success");
                        jsonResponse.put("data", reportData);
                    } else {
                        jsonResponse.put("status", "error");
                        jsonResponse.put("message", "No analytical data found for the selected date.");
                    }
                }
            } else {
                jsonResponse.put("status", "error");
                jsonResponse.put("message", "Invalid action requested.");
            }
        } catch (Exception e) {
            e.printStackTrace(); // Keep this so you can see the error in Tomcat
            jsonResponse.put("status", "error");
            jsonResponse.put("message", "Server error: " + e.getMessage());
        } finally {
            // Gson will safely escape any weird characters or quotes in the error messages
            out.print(gson.toJson(jsonResponse));
            out.flush();
            out.close(); 
        }
    }
}