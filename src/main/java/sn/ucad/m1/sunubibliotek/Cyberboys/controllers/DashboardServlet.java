package sn.ucad.m1.sunubibliotek.Cyberboys.controllers;

import sn.ucad.m1.sunubibliotek.Cyberboys.services.BibliothequeService;
import sn.ucad.m1.sunubibliotek.Cyberboys.services.EmpruntService;
import sn.ucad.m1.sunubibliotek.Cyberboys.services.UtilisateurService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    private BibliothequeService bibliothequeService;
    private UtilisateurService utilisateurService;
    private EmpruntService empruntService;

    @Override
    public void init() throws ServletException {
        super.init();
        bibliothequeService = new BibliothequeService();
        utilisateurService = new UtilisateurService();
        empruntService = new EmpruntService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        try {
            // Récupérer les statistiques
            Long totalDocuments = bibliothequeService.compterDocuments();
            Long totalUtilisateurs = utilisateurService.compterUtilisateurs();
            Long totalEmprunts = empruntService.compterEmprunts();
            Long empruntsEnCours = empruntService.compterEmpruntsEnCours();
            Long empruntsEnRetard = empruntService.compterEmpruntsEnRetard();
            
            // Récupérer les derniers emprunts
            req.setAttribute("derniersEmprunts", empruntService.listerEmpruntsEnCours());
            
            // Récupérer les emprunts en retard
            if (empruntsEnRetard > 0) {
                req.setAttribute("empruntsRetard", empruntService.listerEmpruntsEnRetard());
            }
            
            // Passer les statistiques à la vue
            req.setAttribute("totalDocuments", totalDocuments);
            req.setAttribute("totalUtilisateurs", totalUtilisateurs);
            req.setAttribute("totalEmprunts", totalEmprunts);
            req.setAttribute("empruntsEnCours", empruntsEnCours);
            req.setAttribute("empruntsEnRetard", empruntsEnRetard);
            
            // Calculer des pourcentages
            if (totalDocuments > 0) {
                double tauxOccupation = (empruntsEnCours * 100.0) / totalDocuments;
                req.setAttribute("tauxOccupation", String.format("%.1f", tauxOccupation));
            } else {
                req.setAttribute("tauxOccupation", "0.0");
            }
            
            req.getRequestDispatcher("/WEB-INF/pages/dashboard.jsp").forward(req, resp);
            
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Erreur lors du chargement du tableau de bord");
            req.getRequestDispatcher("/WEB-INF/pages/error.jsp").forward(req, resp);
        }
    }
}