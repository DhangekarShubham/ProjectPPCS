package com.twd.sugarfactory.controller;

import com.google.gson.Gson;
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

        if ("find".equals(action)) {
            try {
                Integer stoppageId = Integer.parseInt(request.getParameter("stoppageId"));
                StoppageLog log = service.getStoppageData(stoppageId);
                if (log != null) {
                    out.print(gson.toJson(log));
                } else {
                    out.print("{\"status\":\"error\", \"message\":\"Stoppage not found.\"}");
                }
            } catch (NumberFormatException e) {
                 out.print("{\"status\":\"error\", \"message\":\"Invalid Stoppage ID.\"}");
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
            Integer stoppageId = Integer.parseInt(request.getParameter("stoppageId"));
            boolean success = service.deleteStoppageData(stoppageId);
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
                StoppageLog logData = gson.fromJson(sb.toString(), StoppageLog.class);
                StoppageLog savedLog = service.saveStoppageData(logData);
                
                if (savedLog != null) {
                    // Return the saved object so the UI can update the Stoppage Number
                    String jsonResponse = gson.toJson(savedLog);
                    out.print("{\"status\":\"success\", \"message\":\"Data Saved Successfully.\", \"data\":" + jsonResponse + "}");
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