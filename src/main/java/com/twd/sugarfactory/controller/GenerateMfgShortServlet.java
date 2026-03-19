package com.twd.sugarfactory.controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.twd.sugarfactory.model.DailyMfgShort;
import com.twd.sugarfactory.service.ReportMfgShortServiceImpl;
import com.twd.sugarfactory.serviceinterface.ReportMfgShortService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/GenerateMfgShortServlet")
public class GenerateMfgShortServlet extends HttpServlet {

    private ReportMfgShortService service = new ReportMfgShortServiceImpl();
    private Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String reportDate = request.getParameter("reportDate");
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        // Use JsonObject to create a structured response matching the JS expectations
        JsonObject jsonResp = new JsonObject();

        try {
            DailyMfgShort reportData = service.generateReport(reportDate);
            
            // Logic to verify if data exists for the selected date
            if (reportData != null && reportData.getReportDate() != null) {
                jsonResp.addProperty("status", "success");
                // Convert the POJO to a JSON tree to nest it under 'data'
                jsonResp.add("data", gson.toJsonTree(reportData));
            } else {
                // If no data is found, return an error status to keep the report hidden
                jsonResp.addProperty("status", "error");
                jsonResp.addProperty("message", "Selected date has no crushing records.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            jsonResp.addProperty("status", "error");
            jsonResp.addProperty("message", "Server Error: " + e.getMessage());
        } finally {
            out.print(gson.toJson(jsonResp));
            out.flush();
        }
    }
}