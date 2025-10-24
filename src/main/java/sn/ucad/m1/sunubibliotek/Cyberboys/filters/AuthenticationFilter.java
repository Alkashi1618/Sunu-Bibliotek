package sn.ucad.m1.sunubibliotek.Cyberboys.filters;

import sn.ucad.m1.sunubibliotek.Cyberboys.entities.Utilisateur;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(urlPatterns = {"/documents", "/emprunts", "/dashboard", "/utilisateurs"})
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialisation si nécessaire
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);
        
        String requestURI = req.getRequestURI();
        
        // Vérifier si l'utilisateur est connecté
        if (session == null || session.getAttribute("utilisateur") == null) {
            resp.sendRedirect(req.getContextPath() + "/auth");
            return;
        }
        
        // Récupérer l'utilisateur
        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
        
        // Vérifier les permissions selon le rôle
        if (requestURI.contains("/utilisateurs")) {
            // Seuls les ADMIN peuvent gérer les utilisateurs
            if (!utilisateur.isAdmin()) {
                resp.sendRedirect(req.getContextPath() + "/dashboard");
                return;
            }
        }
        
        if (requestURI.contains("/emprunts")) {
            String action = req.getParameter("action");
            // Les LECTEURS ne peuvent voir que leurs propres emprunts
            if (utilisateur.isLecteur() && !"mes-emprunts".equals(action)) {
                resp.sendRedirect(req.getContextPath() + "/emprunts?action=mes-emprunts");
                return;
            }
        }
        
        // Continuer la chaîne de filtres
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Nettoyage si nécessaire
    }
}