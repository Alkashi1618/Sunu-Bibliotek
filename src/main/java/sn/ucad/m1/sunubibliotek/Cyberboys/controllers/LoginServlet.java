package sn.ucad.m1.sunubibliotek.Cyberboys.controllers;

import sn.ucad.m1.sunubibliotek.Cyberboys.dao.UtilisateurDAO;
import sn.ucad.m1.sunubibliotek.Cyberboys.entities.Utilisateur;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/auth")
public class AuthServlet extends HttpServlet {

    private UtilisateurDAO utilisateurDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        utilisateurDAO = new UtilisateurDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        String action = req.getParameter("action");
        
        if ("logout".equals(action)) {
            logout(req, resp);
        } else {
            afficherPageLogin(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        
        if ("login".equals(action)) {
            login(req, resp);
        }
    }

    private void afficherPageLogin(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(req, resp);
    }

    private void login(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        String email = req.getParameter("email");
        String motDePasse = req.getParameter("motDePasse");
        
        try {
            Utilisateur utilisateur = utilisateurDAO.authentifier(email, motDePasse);
            
            if (utilisateur != null) {
                HttpSession session = req.getSession();
                session.setAttribute("utilisateur", utilisateur);
                session.setAttribute("userId", utilisateur.getId());
                session.setAttribute("userRole", utilisateur.getRole().name());
                session.setAttribute("userNom", utilisateur.getNomComplet());
                
                // Redirection selon le rôle
                String redirect = req.getContextPath();
                switch (utilisateur.getRole()) {
                    case ADMIN:
                        redirect += "/dashboard?role=admin";
                        break;
                    case BIBLIOTHECAIRE:
                        redirect += "/dashboard?role=bibliothecaire";
                        break;
                    case LECTEUR:
                        redirect += "/dashboard?role=lecteur";
                        break;
                }
                
                resp.sendRedirect(redirect);
            } else {
                req.setAttribute("error", "Email ou mot de passe incorrect");
                req.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Erreur lors de la connexion : " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(req, resp);
        }
    }

    private void logout(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        HttpSession session = req.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        
        resp.sendRedirect(req.getContextPath() + "/auth");
    }
}