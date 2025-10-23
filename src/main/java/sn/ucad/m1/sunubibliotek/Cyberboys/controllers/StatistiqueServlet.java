package sn.ucad.m1.sunubibliotek.Cyberboys.controllers;

import sn.ucad.m1.sunubibliotek.Cyberboys.services.StatistiqueService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/statistiques")
public class StatistiqueServlet extends HttpServlet {

    private StatistiqueService statistiqueService;

    @Override
    public void init() throws ServletException {
        super.init();
        statistiqueService = new StatistiqueService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        try {
            // Statistiques globales
            Map<String, Object> statsGlobales = statistiqueService.getStatistiquesGlobales();
            req.setAttribute("statsGlobales", statsGlobales);
            
            // Documents les plus empruntés
            List<Map<String, Object>> topDocuments = statistiqueService.getDocumentsLesPlusEmpruntes(5);
            req.setAttribute("topDocuments", topDocuments);
            
            // Utilisateurs les plus actifs
            List<Map<String, Object>> topUtilisateurs = statistiqueService.getUtilisateursLesPlusActifs(5);
            req.setAttribute("topUtilisateurs", topUtilisateurs);
            
            // Statistiques par type de document
            Map<String, Long> statsParType = statistiqueService.getStatistiquesParType();
            req.setAttribute("statsParType", statsParType);
            
            // Statistiques par type d'utilisateur
            Map<String, Long> statsParTypeUser = statistiqueService.getStatistiquesParTypeUtilisateur();
            req.setAttribute("statsParTypeUser", statsParTypeUser);
            
            // Emprunts par mois
            Map<String, Long> statsEmpruntsParMois = statistiqueService.getStatistiquesEmpruntsParMois();
            req.setAttribute("statsEmpruntsParMois", statsEmpruntsParMois);
            
            // Taux de retour à temps
            Map<String, Object> tauxRetour = statistiqueService.getTauxRetourTemps();
            req.setAttribute("tauxRetour", tauxRetour);
            
            // Pénalités totales
            Double penalitesTotales = statistiqueService.getPenalitesTotales();
            req.setAttribute("penalitesTotales", penalitesTotales);
            
            req.getRequestDispatcher("/WEB-INF/pages/statistiques.jsp").forward(req, resp);
            
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Erreur lors du chargement des statistiques");
            req.getRequestDispatcher("/WEB-INF/pages/error.jsp").forward(req, resp);
        }
    }
}