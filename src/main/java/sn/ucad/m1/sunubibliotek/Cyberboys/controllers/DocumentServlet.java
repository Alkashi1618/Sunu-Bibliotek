package sn.ucad.m1.sunubibliotek.Cyberboys.controllers;

import sn.ucad.m1.sunubibliotek.Cyberboys.entities.*;
import sn.ucad.m1.sunubibliotek.Cyberboys.services.BibliothequeService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/documents")
public class DocumentServlet extends HttpServlet {

    private BibliothequeService bibliothequeService;

    @Override
    public void init() throws ServletException {
        super.init();
        bibliothequeService = new BibliothequeService();
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
                    listerDocuments(req, resp);
                    break;
                case "add":
                    afficherFormulaireAjout(req, resp);
                    break;
                case "edit":
                    afficherFormulaireEdition(req, resp);
                    break;
                case "delete":
                    supprimerDocument(req, resp);
                    break;
                case "search":
                    rechercherDocuments(req, resp);
                    break;
                default:
                    listerDocuments(req, resp);
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
                creerDocument(req, resp);
            } else if ("update".equals(action)) {
                modifierDocument(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Erreur: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/pages/error.jsp").forward(req, resp);
        }
    }

    private void listerDocuments(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        List<Document> documents = bibliothequeService.listerTousLesDocuments();
        req.setAttribute("documents", documents);
        req.setAttribute("count", bibliothequeService.compterDocuments());
        req.getRequestDispatcher("/WEB-INF/pages/liste-documents.jsp").forward(req, resp);
    }

    private void afficherFormulaireAjout(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/pages/ajouter-document.jsp").forward(req, resp);
    }

    private void afficherFormulaireEdition(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        Long id = Long.parseLong(req.getParameter("id"));
        Document document = bibliothequeService.obtenirDocument(id);
        req.setAttribute("document", document);
        req.getRequestDispatcher("/WEB-INF/pages/modifier-document.jsp").forward(req, resp);
    }

    private void creerDocument(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        String type = req.getParameter("type");
        String titre = req.getParameter("titre");
        
        Document document = null;
        
        switch (type) {
            case "livre":
                String auteur = req.getParameter("auteur");
                Integer nbrPages = Integer.parseInt(req.getParameter("nbrPages"));
                document = new Livre(titre, auteur, nbrPages);
                break;
            case "revue":
                Integer mois = Integer.parseInt(req.getParameter("mois"));
                Integer annee = Integer.parseInt(req.getParameter("annee"));
                document = new Revue(titre, mois, annee);
                break;
            case "dictionnaire":
                String langue = req.getParameter("langue");
                document = new Dictionnaire(titre, langue);
                break;
        }
        
        if (document != null) {
            bibliothequeService.ajouterDocument(document);
            req.getSession().setAttribute("success", "Document ajouté avec succès");
        }
        
        resp.sendRedirect(req.getContextPath() + "/documents?action=list");
    }

    private void modifierDocument(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        Long id = Long.parseLong(req.getParameter("id"));
        Document document = bibliothequeService.obtenirDocument(id);
        
        if (document != null) {
            document.setTitre(req.getParameter("titre"));
            
            if (document instanceof Livre) {
                Livre livre = (Livre) document;
                livre.setAuteur(req.getParameter("auteur"));
                livre.setNbrPages(Integer.parseInt(req.getParameter("nbrPages")));
            } else if (document instanceof Revue) {
                Revue revue = (Revue) document;
                revue.setMois(Integer.parseInt(req.getParameter("mois")));
                revue.setAnnee(Integer.parseInt(req.getParameter("annee")));
            } else if (document instanceof Dictionnaire) {
                Dictionnaire dico = (Dictionnaire) document;
                dico.setLangue(req.getParameter("langue"));
            }
            
            bibliothequeService.modifierDocument(document);
            req.getSession().setAttribute("success", "Document modifié avec succès");
        }
        
        resp.sendRedirect(req.getContextPath() + "/documents?action=list");
    }

    private void supprimerDocument(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        Long id = Long.parseLong(req.getParameter("id"));
        bibliothequeService.supprimerDocument(id);
        req.getSession().setAttribute("success", "Document supprimé avec succès");
        resp.sendRedirect(req.getContextPath() + "/documents?action=list");
    }

    private void rechercherDocuments(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        String titre = req.getParameter("titre");
        List<Document> documents = bibliothequeService.rechercherParTitre(titre);
        req.setAttribute("documents", documents);
        req.setAttribute("searchTerm", titre);
        req.getRequestDispatcher("/WEB-INF/pages/liste-documents.jsp").forward(req, resp);
    }
}