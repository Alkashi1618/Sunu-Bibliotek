package sn.ucad.m1.sunubibliotek.Cyberboys.controllers;

import sn.ucad.m1.sunubibliotek.Cyberboys.entities.Reservation;
import sn.ucad.m1.sunubibliotek.Cyberboys.services.ReservationService;
import sn.ucad.m1.sunubibliotek.Cyberboys.services.BibliothequeService;
import sn.ucad.m1.sunubibliotek.Cyberboys.services.UtilisateurService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/reservations")
public class ReservationServlet extends HttpServlet {

    private ReservationService reservationService;
    private BibliothequeService bibliothequeService;
    private UtilisateurService utilisateurService;

    @Override
    public void init() throws ServletException {
        super.init();
        reservationService = new ReservationService();
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
                    listerReservations(req, resp);
                    break;
                case "create":
                    afficherFormulaireCreation(req, resp);
                    break;
                case "mes-reservations":
                    afficherMesReservations(req, resp);
                    break;
                case "annuler":
                    annulerReservation(req, resp);
                    break;
                case "satisfaire":
                    satisfaireReservation(req, resp);
                    break;
                default:
                    listerReservations(req, resp);
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
            if ("reserver".equals(action)) {
                creerReservation(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Erreur: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/pages/error.jsp").forward(req, resp);
        }
    }

    private void listerReservations(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        List<Reservation> reservations = reservationService.listerToutesLesReservations();
        req.setAttribute("reservations", reservations);
        req.setAttribute("count", reservationService.compterReservations());
        req.setAttribute("countActives", reservationService.compterReservationsActives());
        req.getRequestDispatcher("/WEB-INF/pages/liste-reservations.jsp").forward(req, resp);
    }

    private void afficherFormulaireCreation(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        req.setAttribute("documents", bibliothequeService.listerTousLesDocuments());
        req.setAttribute("utilisateurs", utilisateurService.listerTousLesUtilisateurs());
        req.getRequestDispatcher("/WEB-INF/pages/creer-reservation.jsp").forward(req, resp);
    }

    private void afficherMesReservations(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        Long userId = (Long) req.getSession().getAttribute("userId");
        List<Reservation> reservations = reservationService.listerReservationsUtilisateur(userId);
        req.setAttribute("reservations", reservations);
        req.getRequestDispatcher("/WEB-INF/pages/mes-reservations.jsp").forward(req, resp);
    }

    private void creerReservation(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        try {
            Long documentId = Long.parseLong(req.getParameter("documentId"));
            Long utilisateurId = Long.parseLong(req.getParameter("utilisateurId"));
            
            Reservation reservation = reservationService.reserverDocument(documentId, utilisateurId);
            req.getSession().setAttribute("success", 
                "Réservation créée avec succès. Expiration: " + reservation.getDateExpiration());
            
        } catch (IllegalArgumentException e) {
            req.getSession().setAttribute("error", e.getMessage());
        }
        
        resp.sendRedirect(req.getContextPath() + "/reservations?action=list");
    }

    private void annulerReservation(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        try {
            Long reservationId = Long.parseLong(req.getParameter("id"));
            String motif = req.getParameter("motif");
            
            if (motif == null || motif.trim().isEmpty()) {
                motif = "Annulation par l'utilisateur";
            }
            
            reservationService.annulerReservation(reservationId, motif);
            req.getSession().setAttribute("success", "Réservation annulée");
            
        } catch (IllegalArgumentException e) {
            req.getSession().setAttribute("error", e.getMessage());
        }
        
        resp.sendRedirect(req.getContextPath() + "/reservations?action=list");
    }

    private void satisfaireReservation(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        try {
            Long reservationId = Long.parseLong(req.getParameter("id"));
            reservationService.satisfaireReservation(reservationId);
            req.getSession().setAttribute("success", "Réservation satisfaite. L'utilisateur peut emprunter le document.");
            
        } catch (IllegalArgumentException e) {
            req.getSession().setAttribute("error", e.getMessage());
        }
        
        resp.sendRedirect(req.getContextPath() + "/reservations?action=list");
    }
}