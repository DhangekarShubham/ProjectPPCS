package com.twd.sugarfactory.controller;

import com.google.gson.Gson;
import com.twd.sugarfactory.model.DailyMfgSmall;
import com.twd.sugarfactory.service.ReportMfgSmallServiceImpl;
import com.twd.sugarfactory.serviceinterface.ReportMfgSmallService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/GenerateMfgSmallServlet")
public class GenerateMfgSmallServlet extends HttpServlet {

    private ReportMfgSmallService service = new ReportMfgSmallServiceImpl();
    private Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String reportDate = request.getParameter("reportDate");
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            DailyMfgSmall reportData = service.generateReport(reportDate);
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