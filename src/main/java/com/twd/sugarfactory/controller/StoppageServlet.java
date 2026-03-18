package com.twd.sugarfactory.controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.twd.sugarfactory.model.StoppageLog;
import com.twd.sugarfactory.service.StoppageServiceImpl;
import com.twd.sugarfactory.serviceinterface.StoppageService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/StoppageServlet")
public class StoppageServlet extends HttpServlet {

    private StoppageService service = new StoppageServiceImpl();
    private Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            if ("find".equals(action)) {
                String idParam = request.getParameter("stoppageId");
                if (idParam != null && !idParam.isEmpty()) {
                    Integer stoppageId = Integer.parseInt(idParam);
                    StoppageLog log = service.getStoppageData(stoppageId);
                    
                    if (log != null) {
                        out.print(gson.toJson(log));
                    } else {
                        out.print("{\"status\":\"error\", \"message\":\"Downtime log #" + stoppageId + " not found.\"}");
                    }
                } else {
                    out.print("{\"status\":\"error\", \"message\":\"Stoppage ID is required for search.\"}");
                }
            }
        } catch (NumberFormatException e) {
            out.print("{\"status\":\"error\", \"message\":\"Invalid Stoppage ID format.\"}");
        } catch (Exception e) {
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
            // 1. Handle Delete Action
            if ("delete".equals(action)) {
                String idParam = request.getParameter("stoppageId");
                if (idParam != null) {
                    Integer stoppageId = Integer.parseInt(idParam);
                    boolean success = service.deleteStoppageData(stoppageId);
                    out.print(success ? "{\"status\":\"success\", \"message\":\"Log deleted successfully.\"}" 
                                     : "{\"status\":\"error\", \"message\":\"Failed to delete log. It may not exist.\"}");
                }
                return;
            }

            // 2. Handle Save & Update Actions (Read JSON Body)
            StringBuilder sb = new StringBuilder();
            String line;
            try (BufferedReader reader = request.getReader()) {
                while ((line = reader.readLine()) != null) {
                    sb.append(line);
                }
            }

            if ("save".equals(action) || "update".equals(action)) {
                StoppageLog logData = gson.fromJson(sb.toString(), StoppageLog.class);
                StoppageLog savedLog = service.saveStoppageData(logData);
                
                if (savedLog != null) {
                    // Create a clean JSON response including the status, message, and the object
                    JsonObject jsonResp = new JsonObject();
                    jsonResp.addProperty("status", "success");
                    jsonResp.addProperty("message", "Downtime log " + action + "d successfully.");
                    jsonResp.add("data", gson.toJsonTree(savedLog));
                    
                    out.print(gson.toJson(jsonResp));
                } else {
                    out.print("{\"status\":\"error\", \"message\":\"Failed to " + action + " downtime log.\"}");
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