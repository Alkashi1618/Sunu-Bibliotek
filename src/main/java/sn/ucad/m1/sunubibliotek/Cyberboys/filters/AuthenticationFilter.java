package sn.ucad.m1.sunubibliotek.Cyberboys.filters;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Filtre pour vérifier l'authentification sur toutes les pages protégées
 */
@WebFilter(urlPatterns = {"/documents", "/utilisateurs", "/emprunts", "/reservations", "/dashboard", "/profil"})
public class AuthenticationFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialisation du filtre
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        // Récupérer la session
        HttpSession session = httpRequest.getSession(false);
        
        // Vérifier si l'utilisateur est connecté
        boolean isLoggedIn = (session != null && session.getAttribute("utilisateur") != null);
        
        if (isLoggedIn) {
            // L'utilisateur est connecté, continuer
            chain.doFilter(request, response);
        } else {
            // L'utilisateur n'est pas connecté, rediriger vers login
            session = httpRequest.getSession(true);
            session.setAttribute("error", "Vous devez vous connecter pour accéder à cette page");
            
            // Sauvegarder l'URL demandée pour redirection après login
            String requestedUrl = httpRequest.getRequestURI();
            session.setAttribute("redirectAfterLogin", requestedUrl);
            
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
        }
    }

    @Override
    public void destroy() {
        // Nettoyage
    }
}