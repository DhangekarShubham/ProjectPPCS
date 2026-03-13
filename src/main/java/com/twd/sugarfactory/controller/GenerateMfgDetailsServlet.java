package com.twd.sugarfactory.controller;

import com.google.gson.Gson;
import com.twd.sugarfactory.model.DailyMfgDetails;
import com.twd.sugarfactory.service.ReportMfgDetailsServiceImpl;
import com.twd.sugarfactory.serviceinterface.ReportMfgDetailsService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/GenerateMfgDetailsServlet")
public class GenerateMfgDetailsServlet extends HttpServlet {

    private ReportMfgDetailsService service = new ReportMfgDetailsServiceImpl();
    private Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String reportDate = request.getParameter("reportDate");
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            List<DailyMfgDetails> reportData = service.generateReport(reportDate);
            out.print(gson.toJson(reportData));
        } catch (Exception e) {
            e.printStackTrace();
            out.print("[]"); // Return empty array on error
        } finally {
            out.flush();
        }
    }
}