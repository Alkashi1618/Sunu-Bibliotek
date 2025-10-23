package sn.ucad.m1.sunubibliotek.Cyberboys.controllers;

import sn.ucad.m1.sunubibliotek.Cyberboys.services.EmpruntService;
import sn.ucad.m1.sunubibliotek.Cyberboys.entities.Emprunt;
import sn.ucad.m1.sunubibliotek.Cyberboys.services.BibliothequeService;
import sn.ucad.m1.sunubibliotek.Cyberboys.services.UtilisateurService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/emprunts")
public class EmpruntServlet extends HttpServlet {

    private EmpruntService empruntService;
    private BibliothequeService bibliothequeService;
    private UtilisateurService utilisateurService;

    @Override
    public void init() throws ServletException {
        super.init();
        empruntService = new EmpruntService();
        bibliothequeService = new BibliothequeService();
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
                    listerEmprunts(req, resp);
                    break;
                case "create":
                    afficherFormulaireCreation(req, resp);
                    break;
                case "retourner":
                    retournerDocument(req, resp);
                    break;
                case "prolonger":
                    prolongerEmprunt(req, resp);
                    break;
                case "retards":
                    listerEmpruntsEnRetard(req, resp);
                    break;
                case "historique":
                    afficherHistorique(req, resp);
                    break;
                case "perdu":
                    marquerCommePerdu(req, resp);
                    break;
                default:
                    listerEmprunts(req, resp);
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
            if ("emprunter".equals(action)) {
                emprunterDocument(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Erreur: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/pages/error.jsp").forward(req, resp);
        }
    }

    private void listerEmprunts(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        List<Emprunt> emprunts = empruntService.listerTousLesEmprunts();
        req.setAttribute("emprunts", emprunts);
        req.setAttribute("count", empruntService.compterEmprunts());
        req.setAttribute("countEnCours", empruntService.compterEmpruntsEnCours());
        req.setAttribute("countEnRetard", empruntService.compterEmpruntsEnRetard());
        req.getRequestDispatcher("/WEB-INF/pages/liste-emprunts.jsp").forward(req, resp);
    }

    private void afficherFormulaireCreation(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        // Charger les documents disponibles et les utilisateurs actifs
        req.setAttribute("documents", bibliothequeService.listerTousLesDocuments());
        req.setAttribute("utilisateurs", utilisateurService.listerTousLesUtilisateurs());
        req.getRequestDispatcher("/WEB-INF/pages/creer-emprunt.jsp").forward(req, resp);
    }

    private void emprunterDocument(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        try {
            Long documentId = Long.parseLong(req.getParameter("documentId"));
            Long utilisateurId = Long.parseLong(req.getParameter("utilisateurId"));
            
            Emprunt emprunt = empruntService.emprunterDocument(documentId, utilisateurId);
            req.getSession().setAttribute("success", 
                "Document emprunté avec succès. Date de retour: " + emprunt.getDateRetourPrevue());
            
        } catch (IllegalArgumentException e) {
            req.getSession().setAttribute("error", e.getMessage());
        }
        
        resp.sendRedirect(req.getContextPath() + "/emprunts?action=list");
    }

    private void retournerDocument(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        try {
            Long empruntId = Long.parseLong(req.getParameter("id"));
            empruntService.retournerDocument(empruntId);
            
            Emprunt emprunt = empruntService.obtenirEmprunt(empruntId);
            if (emprunt.getPenalite() > 0) {
                req.getSession().setAttribute("warning", 
                    "Document retourné. Pénalité: " + emprunt.getPenalite() + " FCFA");
            } else {
                req.getSession().setAttribute("success", "Document retourné avec succès");
            }
            
        } catch (IllegalArgumentException e) {
            req.getSession().setAttribute("error", e.getMessage());
        }
        
        resp.sendRedirect(req.getContextPath() + "/emprunts?action=list");
    }

    private void prolongerEmprunt(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        try {
            Long empruntId = Long.parseLong(req.getParameter("id"));
            int jours = Integer.parseInt(req.getParameter("jours"));
            
            empruntService.prolongerEmprunt(empruntId, jours);
            req.getSession().setAttribute("success", "Emprunt prolongé de " + jours + " jours");
            
        } catch (IllegalArgumentException e) {
            req.getSession().setAttribute("error", e.getMessage());
        }
        
        resp.sendRedirect(req.getContextPath() + "/emprunts?action=list");
    }

    private void listerEmpruntsEnRetard(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        List<Emprunt> emprunts = empruntService.listerEmpruntsEnRetard();
        req.setAttribute("emprunts", emprunts);
        req.setAttribute("count", emprunts.size());
        req.getRequestDispatcher("/WEB-INF/pages/emprunts-en-retard.jsp").forward(req, resp);
    }

    private void afficherHistorique(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        String type = req.getParameter("type");
        Long id = Long.parseLong(req.getParameter("id"));
        
        List<Emprunt> emprunts;
        String titre;
        
        if ("utilisateur".equals(type)) {
            emprunts = empruntService.listerEmpruntsUtilisateur(id);
            titre = "Historique de l'utilisateur";
        } else {
            emprunts = empruntService.historiqueDocument(id);
            titre = "Historique du document";
        }
        
        req.setAttribute("emprunts", emprunts);
        req.setAttribute("titre", titre);
        req.getRequestDispatcher("/WEB-INF/pages/historique-emprunts.jsp").forward(req, resp);
    }

    private void marquerCommePerdu(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        try {
            Long empruntId = Long.parseLong(req.getParameter("id"));
            String remarque = req.getParameter("remarque");
            
            empruntService.marquerCommePerdu(empruntId, remarque);
            req.getSession().setAttribute("warning", "Document marqué comme perdu. Pénalité appliquée.");
            
        } catch (IllegalArgumentException e) {
            req.getSession().setAttribute("error", e.getMessage());
        }
        
        resp.sendRedirect(req.getContextPath() + "/emprunts?action=list");
    }
}