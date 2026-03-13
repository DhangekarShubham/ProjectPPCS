package com.twd.sugarfactory.controller;

import com.google.gson.Gson;
import com.twd.sugarfactory.model.DailyTonReport;
import com.twd.sugarfactory.service.ReportDailyTonServiceImpl;
import com.twd.sugarfactory.serviceinterface.ReportDailyTonService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/GenerateDailyTonServlet")
public class GenerateDailyTonServlet extends HttpServlet {

    private ReportDailyTonService service = new ReportDailyTonServiceImpl();
    private Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String reportDate = request.getParameter("reportDate");
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            DailyTonReport reportData = service.generateTonReport(reportDate);
            if(reportData != null) {
                out.print(gson.toJson(reportData));
            } else {
                out.print("{}"); 
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.print("{}"); 
        } finally {
            out.flush();
        }
    }
}