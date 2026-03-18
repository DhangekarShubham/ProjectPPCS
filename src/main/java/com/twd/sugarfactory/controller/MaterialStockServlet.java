package com.twd.sugarfactory.controller;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.twd.sugarfactory.model.MaterialStock;
import com.twd.sugarfactory.service.MaterialStockServiceImpl;
import com.twd.sugarfactory.serviceinterface.MaterialStockService;

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

@WebServlet("/MaterialStockServlet")
public class MaterialStockServlet extends HttpServlet {

    private MaterialStockService service = new MaterialStockServiceImpl();
    private Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String sampleDate = request.getParameter("sampleDate");
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            // "load" fetches the blank master list
            // "find" fetches saved data for a specific date
            if ("load".equals(action) || "find".equals(action)) {
                List<MaterialStock> list = service.getStockData(sampleDate);
                if (list != null) {
                    out.print(gson.toJson(list));
                } else {
                    out.print("[]"); // Return empty array to keep Angular happy
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
            // 1. Handle Delete Logic
            if ("delete".equals(action)) {
                 String sampleDate = request.getParameter("sampleDate");
                 boolean success = service.deleteStockData(sampleDate);
                 if (success) {
                     out.print("{\"status\":\"success\", \"message\":\"Stock records deleted successfully.\"}");
                 } else {
                     out.print("{\"status\":\"error\", \"message\":\"No records found to delete for this date.\"}");
                 }
                 return;
            }

            // 2. Handle Save/Update Logic (Reading JSON body)
            StringBuilder sb = new StringBuilder();
            String line;
            try (BufferedReader reader = request.getReader()) {
                while ((line = reader.readLine()) != null) {
                    sb.append(line);
                }
            }

            if ("save".equals(action) || "update".equals(action)) {
                Type listType = new TypeToken<List<MaterialStock>>(){}.getType();
                List<MaterialStock> stockList = gson.fromJson(sb.toString(), listType);
                
                if (stockList == null || stockList.isEmpty()) {
                    out.print("{\"status\":\"error\", \"message\":\"No data received to save.\"}");
                    return;
                }

                boolean success = service.saveStockData(stockList);
                
                if (success) {
                    out.print("{\"status\":\"success\", \"message\":\"Stock data " + action + "d successfully.\"}");
                } else {
                    out.print("{\"status\":\"error\", \"message\":\"Failed to " + action + " stock data.\"}");
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