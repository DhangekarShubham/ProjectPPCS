package com.twd.sugarfactory.controller;

import com.google.gson.Gson;
import com.twd.sugarfactory.model.WeeklyReport;
import com.twd.sugarfactory.service.ReportWeeklyServiceImpl;
import com.twd.sugarfactory.serviceinterface.ReportWeeklyService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/GenerateWeeklyReportServlet")
public class GenerateWeeklyReportServlet extends HttpServlet {

    private ReportWeeklyService service = new ReportWeeklyServiceImpl();
    private Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fromDate = request.getParameter("fromDate");
        String toDate = request.getParameter("toDate");
        
        Integer weekNo = null;
        try {
            weekNo = Integer.parseInt(request.getParameter("weekNo"));
        } catch (NumberFormatException e) {
            weekNo = 0;
        }
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            WeeklyReport reportData = service.generateWeeklyReport(weekNo, fromDate, toDate);
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