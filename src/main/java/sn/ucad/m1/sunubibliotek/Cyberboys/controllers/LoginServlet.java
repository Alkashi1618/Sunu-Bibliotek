package sn.ucad.m1.sunubibliotek.Cyberboys.controllers;

import sn.ucad.m1.sunubibliotek.Cyberboys.entities.Utilisateur;
import sn.ucad.m1.sunubibliotek.Cyberboys.services.UtilisateurService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private UtilisateurService utilisateurService;

    @Override
    public void init() throws ServletException {
        super.init();
        utilisateurService = new UtilisateurService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        // Si l'utilisateur est déjà connecté, rediriger vers le dashboard
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("utilisateur") != null) {
            resp.sendRedirect(req.getContextPath() + "/dashboard");
            return;
        }
        
        // Afficher la page de connexion
        req.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        req.setCharacterEncoding("UTF-8");
        
        String email = req.getParameter("email");
        String motDePasse = req.getParameter("motDePasse");
        
        // Validation des champs
        if (email == null || email.trim().isEmpty() || 
            motDePasse == null || motDePasse.trim().isEmpty()) {
            req.setAttribute("error", "Email et mot de passe sont obligatoires");
            req.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(req, resp);
            return;
        }
        
        try {
            // Authentification
            Utilisateur utilisateur = utilisateurService.authentifier(email, motDePasse);
            
            if (utilisateur != null) {
                // Créer une session
                HttpSession session = req.getSession(true);
                session.setAttribute("utilisateur", utilisateur);
                session.setAttribute("userId", utilisateur.getId());
                session.setAttribute("userRole", utilisateur.getRole());
                session.setAttribute("userName", utilisateur.getNomComplet());
                
                // Durée de session : 30 minutes
                session.setMaxInactiveInterval(30 * 60);
                
                // Message de succès
                session.setAttribute("success", "Bienvenue " + utilisateur.getNomComplet() + " !");
                
                // Redirection selon le rôle
                String redirectUrl = req.getContextPath() + "/dashboard";
                resp.sendRedirect(redirectUrl);
                
            } else {
                // Échec de l'authentification
                req.setAttribute("error", "Email ou mot de passe incorrect");
                req.setAttribute("email", email); // Garder l'email saisi
                req.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(req, resp);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Erreur lors de la connexion : " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(req, resp);
        }
    }
}