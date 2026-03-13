package com.twd.sugarfactory.controller;

import com.google.gson.Gson;
import com.twd.sugarfactory.model.RT8CPerformance;
import com.twd.sugarfactory.service.RT8CServiceImpl;
import com.twd.sugarfactory.serviceinterface.RT8CService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/RT8CServlet")
public class RT8CServlet extends HttpServlet {

    private RT8CService service = new RT8CServiceImpl();
    private Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String reportDate = request.getParameter("reportDate");
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        if ("find".equals(action)) {
            RT8CPerformance data = service.getRT8CData(reportDate);
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
             String reportDate = request.getParameter("reportDate");
             boolean success = service.deleteRT8CData(reportDate);
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
                RT8CPerformance reqData = gson.fromJson(sb.toString(), RT8CPerformance.class);
                boolean success = service.saveRT8CData(reqData);
                
                if (success) {
                    out.print("{\"status\":\"success\", \"message\":\"RT-8(C) Data Saved Successfully.\"}");
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