package sn.ucad.m1.sunubibliotek.Cyberboys.controllers;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        // Récupérer la session
        HttpSession session = req.getSession(false);
        
        if (session != null) {
            // Détruire la session
            session.invalidate();
        }
        
        // Rediriger vers la page de connexion avec un message
        req.getSession(true).setAttribute("info", "Vous avez été déconnecté avec succès");
        resp.sendRedirect(req.getContextPath() + "/login");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        doGet(req, resp);
    }
}