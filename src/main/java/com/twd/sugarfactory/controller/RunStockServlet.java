package com.twd.sugarfactory.controller;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.twd.sugarfactory.model.RunStock;
import com.twd.sugarfactory.service.RunStockServiceImpl;
import com.twd.sugarfactory.serviceinterface.RunStockService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Type;
import java.util.List;

@WebServlet("/RunStockServlet")
public class RunStockServlet extends HttpServlet {

    private RunStockService service = new RunStockServiceImpl();
    private Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        // Updated to use Season Year and Run Number instead of sampleDate
        String seasonYear = request.getParameter("seasonYear");
        String runNumber = request.getParameter("runNumber");
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        if ("load".equals(action)) {
            // Note: You will need to update your Service/DAO to accept these two parameters
            List<RunStock> list = service.getStockData(seasonYear, runNumber);
            if (list != null) {
                out.print(gson.toJson(list));
            } else {
                out.print("{\"status\":\"error\", \"message\":\"No data found for this Run Number.\"}");
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

        try {
            // 1. DELETE ACTION
            if ("delete".equals(action)) {
                 String seasonYear = request.getParameter("seasonYear");
                 String runNumber = request.getParameter("runNumber");
                 
                 if (seasonYear != null && runNumber != null) {
                     boolean success = service.deleteStockData(seasonYear, runNumber);
                     out.print(success ? "{\"status\":\"success\", \"message\":\"Deleted Run Stock Successfully\"}" : "{\"status\":\"error\", \"message\":\"Failed to Delete Run Stock\"}");
                 } else {
                     out.print("{\"status\":\"error\", \"message\":\"Season Year and Run Number are required for deletion.\"}");
                 }
                 return;
            }

            // 2. SAVE OR UPDATE ACTION
            StringBuilder sb = new StringBuilder();
            String line;
            try (BufferedReader reader = request.getReader()) {
                while ((line = reader.readLine()) != null) {
                    sb.append(line);
                }
            }

            if ("save".equals(action) || "update".equals(action)) {
                Type listType = new TypeToken<List<RunStock>>(){}.getType();
                List<RunStock> stockList = gson.fromJson(sb.toString(), listType);
                
                if (stockList != null && !stockList.isEmpty()) {
                    boolean success = service.saveStockData(stockList);
                    if (success) {
                        out.print("{\"status\":\"success\", \"message\":\"Run Stock Data " + action + "d Successfully.\"}");
                    } else {
                        out.print("{\"status\":\"error\", \"message\":\"Database Error: Failed to " + action + " Data.\"}");
                    }
                } else {
                    out.print("{\"status\":\"error\", \"message\":\"Payload is empty.\"}");
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