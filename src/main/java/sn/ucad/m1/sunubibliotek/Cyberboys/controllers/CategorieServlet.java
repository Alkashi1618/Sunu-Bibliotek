package sn.ucad.m1.sunubibliotek.Cyberboys.controllers;

import sn.ucad.m1.sunubibliotek.Cyberboys.entities.Categorie;
import sn.ucad.m1.sunubibliotek.Cyberboys.services.CategorieService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/categories")
public class CategorieServlet extends HttpServlet {

    private CategorieService categorieService;

    @Override
    public void init() throws ServletException {
        super.init();
        categorieService = new CategorieService();
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
                    listerCategories(req, resp);
                    break;
                case "add":
                    afficherFormulaireAjout(req, resp);
                    break;
                case "edit":
                    afficherFormulaireEdition(req, resp);
                    break;
                case "delete":
                    supprimerCategorie(req, resp);
                    break;
                default:
                    listerCategories(req, resp);
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
                creerCategorie(req, resp);
            } else if ("update".equals(action)) {
                modifierCategorie(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Erreur: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/pages/error.jsp").forward(req, resp);
        }
    }

    private void listerCategories(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        List<Categorie> categories = categorieService.listerToutesLesCategories();
        
        // Ajouter le nombre de documents pour chaque catégorie
        for (Categorie cat : categories) {
            Long nbDocs = categorieService.compterDocuments(cat.getId());
            req.setAttribute("nbDocs_" + cat.getId(), nbDocs);
        }
        
        req.setAttribute("categories", categories);
        req.setAttribute("count", categorieService.compterCategories());
        req.getRequestDispatcher("/WEB-INF/pages/liste-categories.jsp").forward(req, resp);
    }

    private void afficherFormulaireAjout(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/pages/ajouter-categorie.jsp").forward(req, resp);
    }

    private void afficherFormulaireEdition(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        Long id = Long.parseLong(req.getParameter("id"));
        Categorie categorie = categorieService.obtenirCategorie(id);
        req.setAttribute("categorie", categorie);
        req.getRequestDispatcher("/WEB-INF/pages/modifier-categorie.jsp").forward(req, resp);
    }

    private void creerCategorie(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        try {
            String nom = req.getParameter("nom");
            String code = req.getParameter("code");
            String description = req.getParameter("description");
            String couleur = req.getParameter("couleur");
            
            Categorie categorie = new Categorie(nom, code, description);
            categorie.setCouleur(couleur);
            
            categorieService.creerCategorie(categorie);
            req.getSession().setAttribute("success", "Catégorie créée avec succès");
            
        } catch (IllegalArgumentException e) {
            req.getSession().setAttribute("error", e.getMessage());
        }
        
        resp.sendRedirect(req.getContextPath() + "/categories?action=list");
    }

    private void modifierCategorie(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        Long id = Long.parseLong(req.getParameter("id"));
        Categorie categorie = categorieService.obtenirCategorie(id);
        
        if (categorie != null) {
            categorie.setNom(req.getParameter("nom"));
            categorie.setDescription(req.getParameter("description"));
            categorie.setCouleur(req.getParameter("couleur"));
            
            categorieService.modifierCategorie(categorie);
            req.getSession().setAttribute("success", "Catégorie modifiée avec succès");
        }
        
        resp.sendRedirect(req.getContextPath() + "/categories?action=list");
    }

    private void supprimerCategorie(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        try {
            Long id = Long.parseLong(req.getParameter("id"));
            categorieService.supprimerCategorie(id);
            req.getSession().setAttribute("success", "Catégorie supprimée avec succès");
            
        } catch (IllegalArgumentException e) {
            req.getSession().setAttribute("error", e.getMessage());
        }
        
        resp.sendRedirect(req.getContextPath() + "/categories?action=list");
    }
}