package com.citywatch.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(urlPatterns = {"", "/about", "/contact"})
public class PublicController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        
        if (path.equals("/contact")) {
            req.getRequestDispatcher("/WEB-INF/views/public/contact.jsp").forward(req, resp);
        } else {
            // Default to about page for "" and "/about"
            req.getRequestDispatcher("/WEB-INF/views/public/about.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        if (path.equals("/contact")) {
            // Handle contact form submission
            String name = req.getParameter("name");
            String number = req.getParameter("number");
            String query = req.getParameter("query");

            // Basic validation
            if (name == null || name.trim().isEmpty() || 
                number == null || number.trim().isEmpty() || 
                query == null || query.trim().isEmpty()) {
                
                req.setAttribute("error", "All fields are required.");
                req.setAttribute("name", name);
                req.setAttribute("number", number);
                req.setAttribute("query", query);
                req.getRequestDispatcher("/WEB-INF/views/public/contact.jsp").forward(req, resp);
                return;
            }

            // Insert into Database
            com.citywatch.model.ContactQuery cq = new com.citywatch.model.ContactQuery(name, number, query);
            com.citywatch.dao.ContactQueryDao dao = new com.citywatch.dao.ContactQueryDao();
            boolean success = dao.insert(cq);

            if (success) {
                req.setAttribute("success", "Thank you, " + name + ". Your query has been received!");
            } else {
                req.setAttribute("error", "An error occurred while submitting your query. Please try again.");
                req.setAttribute("name", name);
                req.setAttribute("number", number);
                req.setAttribute("query", query);
            }
            req.getRequestDispatcher("/WEB-INF/views/public/contact.jsp").forward(req, resp);
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}
