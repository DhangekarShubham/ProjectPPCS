package com.twd.sugarfactory.controller;

import com.google.gson.Gson;
import com.twd.sugarfactory.model.BatchProcessRequest;
import com.twd.sugarfactory.serviceinterface.BatchProcessService;
import com.twd.sugarfactory.service.BatchProcessServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/BatchProcessServlet")
public class BatchProcessServlet extends HttpServlet {

    private BatchProcessService service = new BatchProcessServiceImpl();
    private Gson gson = new Gson();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        // Read JSON payload
        StringBuilder sb = new StringBuilder();
        BufferedReader reader = request.getReader();
        String line;
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }

        try {
            // Parse JSON into Request Object
            BatchProcessRequest processRequest = gson.fromJson(sb.toString(), BatchProcessRequest.class);
            
            // Execute Business Logic
            boolean success = service.executeBatchProcess(processRequest);

            if (success) {
                out.print("{\"status\":\"success\", \"message\":\"Batch Process completed successfully.\"}");
            } else {
                out.print("{\"status\":\"error\", \"message\":\"Failed to complete the batch process.\"}");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"status\":\"error\", \"message\":\"Server Error: " + e.getMessage() + "\"}");
        } finally {
            out.flush();
        }
    }
}