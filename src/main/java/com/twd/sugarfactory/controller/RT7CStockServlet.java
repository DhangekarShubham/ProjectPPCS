package com.twd.sugarfactory.controller;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.twd.sugarfactory.model.RT7CStock;
import com.twd.sugarfactory.service.RT7CStockServiceImpl;
import com.twd.sugarfactory.serviceinterface.RT7CStockService;

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

@WebServlet("/RT7CStockServlet")
public class RT7CStockServlet extends HttpServlet {

    private RT7CStockService service = new RT7CStockServiceImpl();
    private Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String stockDate = request.getParameter("stockDate");
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        if ("load".equals(action)) {
            List<RT7CStock> list = service.getStockData(stockDate);
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
             String stockDate = request.getParameter("stockDate");
             boolean success = service.deleteStockData(stockDate);
             out.print(success ? "{\"status\":\"success\", \"message\":\"Deleted RT-7(C) Stock Successfully\"}" : "{\"status\":\"error\", \"message\":\"Failed to Delete\"}");
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
                Type listType = new TypeToken<List<RT7CStock>>(){}.getType();
                List<RT7CStock> stockList = gson.fromJson(sb.toString(), listType);
                
                boolean success = service.saveStockData(stockList);
                if (success) {
                    out.print("{\"status\":\"success\", \"message\":\"RT-7(C) Stock Data Saved Successfully.\"}");
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