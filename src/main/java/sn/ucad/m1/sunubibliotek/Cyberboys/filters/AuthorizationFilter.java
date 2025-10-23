package sn.ucad.m1.sunubibliotek.Cyberboys.filters;

import sn.ucad.m1.sunubibliotek.Cyberboys.entities.Role;
import sn.ucad.m1.sunubibliotek.Cyberboys.entities.Utilisateur;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Filtre pour vérifier les autorisations selon les rôles
 * Admin et Bibliothécaire ont accès à tout
 * Lecteur a accès limité
 */
@WebFilter(urlPatterns = {"/utilisateurs/*", "/emprunts/*"})
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
                
                // Les admins et bibliothécaires ont accès à tout
                if (role == Role.ADMIN || role == Role.BIBLIOTHECAIRE) {
                    chain.doFilter(request, response);
                    return;
                }
                
                // Les lecteurs ont un accès limité
                if (role == Role.LECTEUR) {
                    // Autoriser seulement la consultation et son propre profil
                    String action = httpRequest.getParameter("action");
                    
                    // Bloquer les actions de création, modification, suppression
                    if ("add".equals(action) || "create".equals(action) || 
                        "edit".equals(action) || "update".equals(action) || 
                        "delete".equals(action)) {
                        
                        session.setAttribute("error", "Accès refusé. Droits insuffisants.");
                        httpResponse.sendRedirect(httpRequest.getContextPath() + "/dashboard");
                        return;
                    }
                    
                    // Autoriser la consultation
                    chain.doFilter(request, response);
                    return;
                }
            }
        }
        
        // Par défaut, bloquer l'accès
        session = httpRequest.getSession(true);
        session.setAttribute("error", "Accès non autorisé");
        httpResponse.sendRedirect(httpRequest.getContextPath() + "/dashboard");
    }

    @Override
    public void destroy() {
        // Nettoyage
    }
}