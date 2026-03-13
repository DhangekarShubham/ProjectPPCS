package com.twd.sugarfactory.controller;

import com.google.gson.Gson;
import com.twd.sugarfactory.model.DailyStockReport;
import com.twd.sugarfactory.service.ReportDailyStockServiceImpl;
import com.twd.sugarfactory.serviceinterface.ReportDailyStockService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/GenerateDailyStockServlet")
public class GenerateDailyStockServlet extends HttpServlet {

    private ReportDailyStockService service = new ReportDailyStockServiceImpl();
    private Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String reportDate = request.getParameter("reportDate");
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            List<DailyStockReport> reportData = service.generateStockReport(reportDate);
            out.print(gson.toJson(reportData));
        } catch (Exception e) {
            e.printStackTrace();
            out.print("[]"); 
        } finally {
            out.flush();
        }
    }
}