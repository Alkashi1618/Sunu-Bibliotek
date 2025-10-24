package sn.ucad.m1.sunubibliotek.Cyberboys.filters;

import sn.ucad.m1.sunubibliotek.Cyberboys.entities.Utilisateur;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(urlPatterns = {
    "/documents", "/documents/*",
    "/emprunts", "/emprunts/*",
    "/reservations", "/reservations/*",
    "/categories", "/categories/*",
    "/utilisateurs", "/utilisateurs/*",
    "/statistiques", "/statistiques/*",
    "/dashboard"
})
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialisation
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);
        
        // Vérifier si l'utilisateur est connecté
        if (session == null || session.getAttribute("utilisateur") == null) {
            session = req.getSession(true);
            session.setAttribute("error", "Veuillez vous connecter pour accéder à cette page");
            resp.sendRedirect(req.getContextPath() + "/auth");
            return;
        }
        
        // Continuer la chaîne de filtres
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Nettoyage
    }
}