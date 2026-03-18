package com.twd.sugarfactory.controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.reflect.TypeToken;
import com.twd.sugarfactory.model.ChemicalConsumption;
import com.twd.sugarfactory.service.ChemicalServiceImpl;
import com.twd.sugarfactory.serviceinterface.ChemicalService;

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

@WebServlet("/ChemicalServlet")
public class ChemicalServlet extends HttpServlet {

    private ChemicalService service = new ChemicalServiceImpl();
    private Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String sampleDate = request.getParameter("sampleDate");
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            // "load" handles fetching the blank master list
            // "find" handles fetching saved data for a specific date
            if ("load".equals(action) || "find".equals(action)) {
                List<ChemicalConsumption> list = service.getChemicals(sampleDate);
                if (list != null) {
                    out.print(gson.toJson(list));
                } else {
                    out.print("[]"); // Return empty array instead of null
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"status\":\"error\", \"message\":\"" + e.getMessage() + "\"}");
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
            // 1. Handle Delete
            if ("delete".equals(action)) {
                 String sampleDate = request.getParameter("sampleDate");
                 boolean success = service.deleteChemicals(sampleDate);
                 out.print(success ? "{\"status\":\"success\", \"message\":\"Deleted Successfully\"}" 
                                   : "{\"status\":\"error\", \"message\":\"Failed to Delete Record\"}");
                 return;
            }

            // 2. Handle Save/Update (Reading the Wrapper Object from JS)
            StringBuilder sb = new StringBuilder();
            String line;
            try (BufferedReader reader = request.getReader()) {
                while ((line = reader.readLine()) != null) {
                    sb.append(line);
                }
            }

            if ("save".equals(action) || "update".equals(action)) {
                // Parse the wrapper object: { sampleDate: '...', consumptions: [...] }
                JsonObject jsonObject = gson.fromJson(sb.toString(), JsonObject.class);
                String date = jsonObject.get("sampleDate").getAsString();
                
                Type listType = new TypeToken<List<ChemicalConsumption>>(){}.getType();
                List<ChemicalConsumption> chemicalList = gson.fromJson(jsonObject.get("consumptions"), listType);
                
                // Ensure every item has the date set
                for(ChemicalConsumption item : chemicalList) {
                    item.setSampleDate(date);
                }

                boolean success = service.saveChemicals(chemicalList);
                
                if (success) {
                    out.print("{\"status\":\"success\", \"message\":\"Chemical Data " + action + "d successfully.\"}");
                } else {
                    out.print("{\"status\":\"error\", \"message\":\"Database error during " + action + ".\"}");
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