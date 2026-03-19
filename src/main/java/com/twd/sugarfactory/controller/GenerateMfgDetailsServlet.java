package com.twd.sugarfactory.controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.twd.sugarfactory.model.MfgReportDTO;
import com.twd.sugarfactory.service.ReportMfgDetailsServiceImpl;
import com.twd.sugarfactory.serviceinterface.ReportMfgDetailsService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/GenerateMfgDetailsServlet")
public class GenerateMfgDetailsServlet extends HttpServlet {

    private ReportMfgDetailsService service = new ReportMfgDetailsServiceImpl();
    private Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String reportDate = request.getParameter("reportDate");
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        JsonObject jsonResponse = new JsonObject();

        try {
            // Fetch the complex DTO containing all 3 sections of the report
            MfgReportDTO reportData = service.generateReport(reportDate);
            
            if (reportData != null && reportData.getMainList() != null && !reportData.getMainList().isEmpty()) {
                jsonResponse.addProperty("status", "success");
                jsonResponse.add("data", gson.toJsonTree(reportData));
            } else {
                jsonResponse.addProperty("status", "error");
                jsonResponse.addProperty("message", "No laboratory or manufacturing data found for this date.");
            }
            
            out.print(gson.toJson(jsonResponse));
            
        } catch (Exception e) {
            e.printStackTrace();
            jsonResponse.addProperty("status", "error");
            jsonResponse.addProperty("message", "Server Error: " + e.getMessage());
            out.print(gson.toJson(jsonResponse));
        } finally {
            out.flush();
        }
    }
}