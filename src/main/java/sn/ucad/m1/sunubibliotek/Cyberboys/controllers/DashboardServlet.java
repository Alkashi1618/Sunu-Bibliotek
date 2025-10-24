package sn.ucad.m1.sunubibliotek.Cyberboys.controllers;

import sn.ucad.m1.sunubibliotek.Cyberboys.dao.*;
import sn.ucad.m1.sunubibliotek.Cyberboys.entities.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    private DocumentDAO documentDAO;
    private EmpruntDAO empruntDAO;
    private UtilisateurDAO utilisateurDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        documentDAO = new DocumentDAO();
        empruntDAO = new EmpruntDAO();
        utilisateurDAO = new UtilisateurDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        HttpSession session = req.getSession();
        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
        
        if (utilisateur == null) {
            resp.sendRedirect(req.getContextPath() + "/auth");
            return;
        }
        
        try {
            // Charger les statistiques selon le rôle
            switch (utilisateur.getRole()) {
                case ADMIN:
                    afficherDashboardAdmin(req, resp);
                    break;
                case BIBLIOTHECAIRE:
                    afficherDashboardBibliothecaire(req, resp);
                    break;
                case LECTEUR:
                    afficherDashboardLecteur(req, resp, utilisateur);
                    break;
                default:
                    resp.sendRedirect(req.getContextPath() + "/auth");
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Erreur: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/pages/error.jsp").forward(req, resp);
        }
    }

    private void afficherDashboardAdmin(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        // Statistiques globales
        Long totalDocuments = documentDAO.count();
        Long totalUtilisateurs = utilisateurDAO.count();
        Long totalEmprunts = empruntDAO.count();
        Long empruntsEnCours = empruntDAO.countByStatut(Emprunt.Statut.EN_COURS);
        Long empruntsEnRetard = empruntDAO.countEmpruntsEnRetard();
        
        // Statistiques par rôle
        Long countAdmins = utilisateurDAO.countByRole(Utilisateur.Role.ADMIN);
        Long countBibliothecaires = utilisateurDAO.countByRole(Utilisateur.Role.BIBLIOTHECAIRE);
        Long countLecteurs = utilisateurDAO.countByRole(Utilisateur.Role.LECTEUR);
        
        // Derniers emprunts
        List<Emprunt> derniersEmprunts = empruntDAO.findAll();
        if (derniersEmprunts.size() > 10) {
            derniersEmprunts = derniersEmprunts.subList(0, 10);
        }
        
        // Emprunts en retard
        List<Emprunt> empruntsRetard = empruntDAO.findEmpruntsEnRetard();
        
        req.setAttribute("totalDocuments", totalDocuments);
        req.setAttribute("totalUtilisateurs", totalUtilisateurs);
        req.setAttribute("totalEmprunts", totalEmprunts);
        req.setAttribute("empruntsEnCours", empruntsEnCours);
        req.setAttribute("empruntsEnRetard", empruntsEnRetard);
        req.setAttribute("countAdmins", countAdmins);
        req.setAttribute("countBibliothecaires", countBibliothecaires);
        req.setAttribute("countLecteurs", countLecteurs);
        req.setAttribute("derniersEmprunts", derniersEmprunts);
        req.setAttribute("empruntsRetard", empruntsRetard);
        
        req.getRequestDispatcher("/WEB-INF/pages/dashboard-admin.jsp").forward(req, resp);
    }

    private void afficherDashboardBibliothecaire(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        // Statistiques pour bibliothécaire
        Long totalDocuments = documentDAO.count();
        Long empruntsEnCours = empruntDAO.countByStatut(Emprunt.Statut.EN_COURS);
        Long empruntsEnRetard = empruntDAO.countEmpruntsEnRetard();
        
        // Emprunts récents
        List<Emprunt> empruntsRecents = empruntDAO.findEmpruntsEnCours();
        if (empruntsRecents.size() > 15) {
            empruntsRecents = empruntsRecents.subList(0, 15);
        }
        
        // Emprunts en retard
        List<Emprunt> empruntsRetard = empruntDAO.findEmpruntsEnRetard();
        
        // Documents récents
        List<Document> documentsRecents = documentDAO.findAll();
        if (documentsRecents.size() > 10) {
            documentsRecents = documentsRecents.subList(0, 10);
        }
        
        req.setAttribute("totalDocuments", totalDocuments);
        req.setAttribute("empruntsEnCours", empruntsEnCours);
        req.setAttribute("empruntsEnRetard", empruntsEnRetard);
        req.setAttribute("empruntsRecents", empruntsRecents);
        req.setAttribute("empruntsRetard", empruntsRetard);
        req.setAttribute("documentsRecents", documentsRecents);
        
        req.getRequestDispatcher("/WEB-INF/pages/dashboard-bibliothecaire.jsp").forward(req, resp);
    }

    private void afficherDashboardLecteur(HttpServletRequest req, HttpServletResponse resp, 
                                          Utilisateur utilisateur) 
            throws ServletException, IOException {
        
        // Emprunts du lecteur
        List<Emprunt> mesEmprunts = empruntDAO.findByUtilisateur(utilisateur.getId());
        
        // Compter les emprunts en cours
        long empruntsEnCours = mesEmprunts.stream()
            .filter(e -> e.getStatut() == Emprunt.Statut.EN_COURS)
            .count();
        
        // Compter les emprunts en retard
        long empruntsEnRetard = mesEmprunts.stream()
            .filter(Emprunt::isEnRetard)
            .count();
        
        // Documents disponibles (catalogue)
        List<Document> catalogueDocuments = documentDAO.findAll();
        if (catalogueDocuments.size() > 20) {
            catalogueDocuments = catalogueDocuments.subList(0, 20);
        }
        
        req.setAttribute("mesEmprunts", mesEmprunts);
        req.setAttribute("empruntsEnCours", empruntsEnCours);
        req.setAttribute("empruntsEnRetard", empruntsEnRetard);
        req.setAttribute("catalogueDocuments", catalogueDocuments);
        req.setAttribute("totalDocuments", documentDAO.count());
        
        req.getRequestDispatcher("/WEB-INF/pages/dashboard-lecteur.jsp").forward(req, resp);
    }
}