package sn.ucad.m1.sunubibliotek.Cyberboys.filters;

import sn.ucad.m1.sunubibliotek.Cyberboys.entities.Role;
import sn.ucad.m1.sunubibliotek.Cyberboys.entities.Utilisateur;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(urlPatterns = {"/utilisateurs/*", "/statistiques/*", "/categories/*"})
public class AuthorizationFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialisation
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        HttpSession session = httpRequest.getSession(false);
        
        if (session != null) {
            Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
            
            if (utilisateur != null) {
                Role role = utilisateur.getRole();
                String requestURI = httpRequest.getRequestURI();
                
                // Admin et Bibliothécaire ont accès à tout
                if (role == Role.ADMIN || role == Role.BIBLIOTHECAIRE) {
                    chain.doFilter(request, response);
                    return;
                }
                
                // Lecteurs bloqués
                if (role == Role.LECTEUR) {
                    session.setAttribute("error", "Accès refusé. Droits insuffisants.");
                    httpResponse.sendRedirect(httpRequest.getContextPath() + "/dashboard");
                    return;
                }
            }
        }
        
        session = httpRequest.getSession(true);
        session.setAttribute("error", "Accès non autorisé");
        httpResponse.sendRedirect(httpRequest.getContextPath() + "/dashboard");
    }

    @Override
    public void destroy() {
        // Nettoyage
    }
}
