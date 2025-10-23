package sn.ucad.m1.sunubibliotek.Cyberboys.controllers;

import sn.ucad.m1.sunubibliotek.Cyberboys.entities.*;
import sn.ucad.m1.sunubibliotek.Cyberboys.services.UtilisateurService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/utilisateurs")
public class UtilisateurServlet extends HttpServlet {

    private UtilisateurService utilisateurService;

    @Override
    public void init() throws ServletException {
        super.init();
        utilisateurService = new UtilisateurService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        String action = req.getParameter("action");
        
        if (action == null) {
            action = "list";
        }
        
        try {
            switch (action) {
                case "list":
                    listerUtilisateurs(req, resp);
                    break;
                case "add":
                    afficherFormulaireAjout(req, resp);
                    break;
                case "edit":
                    afficherFormulaireEdition(req, resp);
                    break;
                case "delete":
                    supprimerUtilisateur(req, resp);
                    break;
                case "search":
                    rechercherUtilisateurs(req, resp);
                    break;
                case "details":
                    afficherDetails(req, resp);
                    break;
                default:
                    listerUtilisateurs(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Erreur: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/pages/error.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        
        try {
            if ("create".equals(action)) {
                creerUtilisateur(req, resp);
            } else if ("update".equals(action)) {
                modifierUtilisateur(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Erreur: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/pages/error.jsp").forward(req, resp);
        }
    }

    private void listerUtilisateurs(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        List<Utilisateur> utilisateurs = utilisateurService.listerTousLesUtilisateurs();
        req.setAttribute("utilisateurs", utilisateurs);
        req.setAttribute("count", utilisateurService.compterUtilisateurs());
        req.getRequestDispatcher("/WEB-INF/pages/liste-utilisateurs.jsp").forward(req, resp);
    }

    private void afficherFormulaireAjout(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/pages/ajouter-utilisateur.jsp").forward(req, resp);
    }

    private void afficherFormulaireEdition(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        Long id = Long.parseLong(req.getParameter("id"));
        Utilisateur utilisateur = utilisateurService.obtenirUtilisateur(id);
        req.setAttribute("utilisateur", utilisateur);
        req.getRequestDispatcher("/WEB-INF/pages/modifier-utilisateur.jsp").forward(req, resp);
    }

    private void afficherDetails(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        Long id = Long.parseLong(req.getParameter("id"));
        Utilisateur utilisateur = utilisateurService.obtenirUtilisateur(id);
        req.setAttribute("utilisateur", utilisateur);
        req.getRequestDispatcher("/WEB-INF/pages/details-utilisateur.jsp").forward(req, resp);
    }

    private void creerUtilisateur(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        String nom = req.getParameter("nom");
        String prenom = req.getParameter("prenom");
        String email = req.getParameter("email");
        String telephone = req.getParameter("telephone");
        String typeStr = req.getParameter("typeUtilisateur");
        String roleStr = req.getParameter("role");
        String motDePasse = req.getParameter("motDePasse");
        
        TypeUtilisateur type = TypeUtilisateur.valueOf(typeStr);
        Role role = Role.valueOf(roleStr);
        
        Utilisateur utilisateur = new Utilisateur(nom, prenom, email, type);
        utilisateur.setTelephone(telephone);
        utilisateur.setRole(role);
        utilisateur.setMotDePasse(motDePasse);
        
        utilisateurService.creerUtilisateur(utilisateur);
        req.getSession().setAttribute("success", "Utilisateur créé avec succès");
        
        resp.sendRedirect(req.getContextPath() + "/utilisateurs?action=list");
    }

    private void modifierUtilisateur(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        Long id = Long.parseLong(req.getParameter("id"));
        Utilisateur utilisateur = utilisateurService.obtenirUtilisateur(id);
        
        if (utilisateur != null) {
            utilisateur.setNom(req.getParameter("nom"));
            utilisateur.setPrenom(req.getParameter("prenom"));
            utilisateur.setEmail(req.getParameter("email"));
            utilisateur.setTelephone(req.getParameter("telephone"));
            utilisateur.setTypeUtilisateur(TypeUtilisateur.valueOf(req.getParameter("typeUtilisateur")));
            utilisateur.setRole(Role.valueOf(req.getParameter("role")));
            
            String actifStr = req.getParameter("actif");
            utilisateur.setActif("on".equals(actifStr) || "true".equals(actifStr));
            
            utilisateurService.modifierUtilisateur(utilisateur);
            req.getSession().setAttribute("success", "Utilisateur modifié avec succès");
        }
        
        resp.sendRedirect(req.getContextPath() + "/utilisateurs?action=list");
    }

    private void supprimerUtilisateur(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        Long id = Long.parseLong(req.getParameter("id"));
        utilisateurService.supprimerUtilisateur(id);
        req.getSession().setAttribute("success", "Utilisateur supprimé avec succès");
        resp.sendRedirect(req.getContextPath() + "/utilisateurs?action=list");
    }

    private void rechercherUtilisateurs(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        String nom = req.getParameter("nom");
        List<Utilisateur> utilisateurs = utilisateurService.rechercherParNom(nom);
        req.setAttribute("utilisateurs", utilisateurs);
        req.setAttribute("searchTerm", nom);
        req.getRequestDispatcher("/WEB-INF/pages/liste-utilisateurs.jsp").forward(req, resp);
    }
}