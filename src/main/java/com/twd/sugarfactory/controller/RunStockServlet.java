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
        String sampleDate = request.getParameter("sampleDate");
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        if ("load".equals(action)) {
            List<RunStock> list = service.getStockData(sampleDate);
            out.print(gson.toJson(list));
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
             String sampleDate = request.getParameter("sampleDate");
             boolean success = service.deleteStockData(sampleDate);
             out.print(success ? "{\"status\":\"success\", \"message\":\"Deleted Run Stock Successfully\"}" : "{\"status\":\"error\", \"message\":\"Failed to Delete\"}");
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
                Type listType = new TypeToken<List<RunStock>>(){}.getType();
                List<RunStock> stockList = gson.fromJson(sb.toString(), listType);
                
                boolean success = service.saveStockData(stockList);
                if (success) {
                    out.print("{\"status\":\"success\", \"message\":\"Run Stock Data Saved Successfully.\"}");
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