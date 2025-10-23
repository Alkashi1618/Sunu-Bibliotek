package sn.ucad.m1.sunubibliotek.Cyberboys.services;

import sn.ucad.m1.sunubibliotek.Cyberboys.dao.DocumentDAO;
import sn.ucad.m1.sunubibliotek.Cyberboys.dao.ReservationDAO;
import sn.ucad.m1.sunubibliotek.Cyberboys.dao.UtilisateurDAO;
import sn.ucad.m1.sunubibliotek.Cyberboys.entities.*;

import java.util.List;

public class ReservationService {

    private ReservationDAO reservationDAO;
    private DocumentDAO documentDAO;
    private UtilisateurDAO utilisateurDAO;

    public ReservationService() {
        this.reservationDAO = new ReservationDAO();
        this.documentDAO = new DocumentDAO();
        this.utilisateurDAO = new UtilisateurDAO();
    }

    /**
     * Réserver un document
     */
    public Reservation reserverDocument(Long documentId, Long utilisateurId) {
        // Récupérer les entités
        Document document = documentDAO.findById(documentId);
        Utilisateur utilisateur = utilisateurDAO.findById(utilisateurId);

        // Validations
        if (document == null) {
            throw new IllegalArgumentException("Document introuvable");
        }

        if (utilisateur == null) {
            throw new IllegalArgumentException("Utilisateur introuvable");
        }

        if (!utilisateur.estActif()) {
            throw new IllegalArgumentException("Utilisateur inactif. Impossible de réserver.");
        }

        // Vérifier si le document est disponible
        if (document.estDisponible()) {
            throw new IllegalArgumentException("Document disponible. Veuillez l'emprunter directement.");
        }

        // Vérifier si l'utilisateur n'a pas déjà réservé ce document
        if (reservationDAO.hasReservationActive(utilisateurId, documentId)) {
            throw new IllegalArgumentException("Vous avez déjà réservé ce document");
        }

        // Créer la réservation
        Reservation reservation = new Reservation(document, utilisateur);
        reservationDAO.create(reservation);

        return reservation;
    }

    /**
     * Annuler une réservation
     */
    public void annulerReservation(Long reservationId, String motif) {
        Reservation reservation = reservationDAO.findById(reservationId);

        if (reservation == null) {
            throw new IllegalArgumentException("Réservation introuvable");
        }

        if (reservation.getStatut() != StatutReservation.ACTIVE) {
            throw new IllegalArgumentException("Cette réservation ne peut pas être annulée");
        }

        reservation.annuler(motif);
        reservationDAO.update(reservation);
    }

    /**
     * Satisfaire une réservation (quand le document devient disponible)
     */
    public void satisfaireReservation(Long reservationId) {
        Reservation reservation = reservationDAO.findById(reservationId);

        if (reservation == null) {
            throw new IllegalArgumentException("Réservation introuvable");
        }

        if (reservation.getStatut() != StatutReservation.ACTIVE) {
            throw new IllegalArgumentException("Cette réservation n'est plus active");
        }

        // Vérifier que le document est maintenant disponible
        if (!reservation.getDocument().estDisponible()) {
            throw new IllegalArgumentException("Le document n'est pas encore disponible");
        }

        reservation.satisfaire();
        reservationDAO.update(reservation);
    }

    /**
     * Vérifier et expirer les réservations obsolètes
     */
    public int verifierExpirations() {
        List<Reservation> reservationsExpirees = reservationDAO.findReservationsExpirees();
        int count = 0;

        for (Reservation reservation : reservationsExpirees) {
            reservation.expirer();
            reservationDAO.update(reservation);
            count++;
        }

        return count;
    }

    /**
     * Notifier l'utilisateur quand son document est disponible
     */
    public void notifierDisponibilite(Long documentId) {
        List<Reservation> reservations = reservationDAO.findReservationsActivesDocument(documentId);

        if (!reservations.isEmpty()) {
            // Notifier le premier de la file d'attente
            Reservation premiere = reservations.get(0);
            premiere.setNotifie(true);
            premiere.setRemarque("Document disponible - Notification envoyée");
            reservationDAO.update(premiere);
        }
    }

    /**
     * Obtenir la position dans la file d'attente
     */
    public int getPositionFileAttente(Long reservationId) {
        Reservation reservation = reservationDAO.findById(reservationId);

        if (reservation == null) {
            return -1;
        }

        List<Reservation> fileAttente = reservationDAO.findReservationsActivesDocument(
            reservation.getDocument().getNumEnreg()
        );

        for (int i = 0; i < fileAttente.size(); i++) {
            if (fileAttente.get(i).getId().equals(reservationId)) {
                return i + 1;
            }
        }

        return -1;
    }

    /**
     * Lister toutes les réservations
     */
    public List<Reservation> listerToutesLesReservations() {
        return reservationDAO.findAll();
    }

    /**
     * Lister les réservations d'un utilisateur
     */
    public List<Reservation> listerReservationsUtilisateur(Long utilisateurId) {
        return reservationDAO.findByUtilisateur(utilisateurId);
    }

    /**
     * Lister les réservations actives
     */
    public List<Reservation> listerReservationsActives() {
        return reservationDAO.findReservationsActives();
    }

    /**
     * Obtenir une réservation
     */
    public Reservation obtenirReservation(Long id) {
        return reservationDAO.findById(id);
    }

    /**
     * Compter les réservations
     */
    public Long compterReservations() {
        return reservationDAO.count();
    }

    /**
     * Compter les réservations actives
     */
    public Long compterReservationsActives() {
        return reservationDAO.countActives();
    }

    /**
     * Obtenir les réservations actives d'un utilisateur
     */
    public List<Reservation> getReservationsActivesUtilisateur(Long utilisateurId) {
        return reservationDAO.findReservationsActivesUtilisateur(utilisateurId);
    }

    /**
     * Vérifier si un utilisateur peut réserver
     */
    public boolean peutReserver(Long utilisateurId, Long documentId) {
        Utilisateur utilisateur = utilisateurDAO.findById(utilisateurId);

        if (utilisateur == null || !utilisateur.estActif()) {
            return false;
        }

        Document document = documentDAO.findById(documentId);
        if (document == null || document.estDisponible()) {
            return false;
        }

        return !reservationDAO.hasReservationActive(utilisateurId, documentId);
    }
}