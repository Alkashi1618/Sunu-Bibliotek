package sn.ucad.m1.sunubibliotek.Cyberboys.services;

import sn.ucad.m1.sunubibliotek.Cyberboys.dao.DocumentDAO;
import sn.ucad.m1.sunubibliotek.Cyberboys.dao.EmpruntDAO;
import sn.ucad.m1.sunubibliotek.Cyberboys.dao.UtilisateurDAO;
import sn.ucad.m1.sunubibliotek.Cyberboys.entities.*;

import java.time.LocalDate;
import java.util.List;

public class EmpruntService {

    private EmpruntDAO empruntDAO;
    private DocumentDAO documentDAO;
    private UtilisateurDAO utilisateurDAO;

    // Limites d'emprunt par type d'utilisateur
    private static final int MAX_EMPRUNTS_ETUDIANT = 3;
    private static final int MAX_EMPRUNTS_ENSEIGNANT = 10;
    private static final int MAX_EMPRUNTS_PERSONNEL = 5;
    private static final int MAX_EMPRUNTS_EXTERNE = 2;

    public EmpruntService() {
        this.empruntDAO = new EmpruntDAO();
        this.documentDAO = new DocumentDAO();
        this.utilisateurDAO = new UtilisateurDAO();
    }

    /**
     * Emprunter un document
     */
    public Emprunt emprunterDocument(Long documentId, Long utilisateurId) {
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
            throw new IllegalArgumentException("Utilisateur inactif. Impossible d'emprunter.");
        }

        // Vérifier la disponibilité
        if (!document.estDisponible()) {
            throw new IllegalArgumentException("Document non disponible");
        }

        // Vérifier si l'utilisateur n'a pas déjà emprunté ce document
        if (empruntDAO.hasEmpruntEnCours(utilisateurId, documentId)) {
            throw new IllegalArgumentException("Vous avez déjà emprunté ce document");
        }

        // Vérifier le nombre maximum d'emprunts
        List<Emprunt> empruntsEnCours = empruntDAO.findEmpruntsUtilisateurEnCours(utilisateurId);
        int maxEmprunts = getMaxEmprunts(utilisateur.getTypeUtilisateur());
        
        if (empruntsEnCours.size() >= maxEmprunts) {
            throw new IllegalArgumentException(
                "Limite d'emprunts atteinte (" + maxEmprunts + " maximum pour " + 
                utilisateur.getTypeUtilisateur().getLibelle() + ")"
            );
        }

        // Vérifier si l'utilisateur a des retards
        for (Emprunt e : empruntsEnCours) {
            if (e.estEnRetard()) {
                throw new IllegalArgumentException(
                    "Vous avez des emprunts en retard. Veuillez les retourner avant d'emprunter à nouveau."
                );
            }
        }

        // Créer l'emprunt
        Emprunt emprunt = new Emprunt(document, utilisateur);
        
        // Décrémenter la quantité disponible
        document.emprunter();
        documentDAO.update(document);
        
        // Enregistrer l'emprunt
        empruntDAO.create(emprunt);
        
        return emprunt;
    }

    /**
     * Retourner un document
     */
    public void retournerDocument(Long empruntId) {
        Emprunt emprunt = empruntDAO.findById(empruntId);
        
        if (emprunt == null) {
            throw new IllegalArgumentException("Emprunt introuvable");
        }

        if (emprunt.getStatut() == StatutEmprunt.RETOURNE) {
            throw new IllegalArgumentException("Document déjà retourné");
        }

        // Marquer comme retourné et calculer la pénalité
        emprunt.retourner();
        
        // Incrémenter la quantité disponible
        Document document = emprunt.getDocument();
        document.retourner();
        documentDAO.update(document);
        
        // Mettre à jour l'emprunt
        empruntDAO.update(emprunt);
    }

    /**
     * Prolonger un emprunt
     */
    public void prolongerEmprunt(Long empruntId, int jours) {
        Emprunt emprunt = empruntDAO.findById(empruntId);
        
        if (emprunt == null) {
            throw new IllegalArgumentException("Emprunt introuvable");
        }

        if (emprunt.getStatut() != StatutEmprunt.EN_COURS) {
            throw new IllegalArgumentException("Impossible de prolonger un emprunt terminé");
        }

        if (emprunt.estEnRetard()) {
            throw new IllegalArgumentException("Impossible de prolonger un emprunt en retard");
        }

        emprunt.prolonger(jours);
        empruntDAO.update(emprunt);
    }

    /**
     * Vérifier la disponibilité d'un document
     */
    public boolean verifierDisponibilite(Long documentId) {
        Document document = documentDAO.findById(documentId);
        return document != null && document.estDisponible();
    }

    /**
     * Calculer la pénalité d'un emprunt
     */
    public double calculerPenalite(Long empruntId) {
        Emprunt emprunt = empruntDAO.findById(empruntId);
        return emprunt != null ? emprunt.calculerPenalite() : 0.0;
    }

    /**
     * Marquer un emprunt comme perdu
     */
    public void marquerCommePerdu(Long empruntId, String remarque) {
        Emprunt emprunt = empruntDAO.findById(empruntId);
        
        if (emprunt == null) {
            throw new IllegalArgumentException("Emprunt introuvable");
        }

        emprunt.setStatut(StatutEmprunt.PERDU);
        emprunt.setRemarque(remarque);
        emprunt.setDateRetourEffective(LocalDate.now());
        
        // Calculer une pénalité élevée pour perte
        emprunt.setPenalite(50000.0); // 50 000 FCFA
        
        empruntDAO.update(emprunt);
    }

    /**
     * Lister tous les emprunts
     */
    public List<Emprunt> listerTousLesEmprunts() {
        return empruntDAO.findAll();
    }

    /**
     * Lister les emprunts d'un utilisateur
     */
    public List<Emprunt> listerEmpruntsUtilisateur(Long utilisateurId) {
        return empruntDAO.findByUtilisateur(utilisateurId);
    }

    /**
     * Lister l'historique d'un document
     */
    public List<Emprunt> historiqueDocument(Long documentId) {
        return empruntDAO.findByDocument(documentId);
    }

    /**
     * Lister les emprunts en cours
     */
    public List<Emprunt> listerEmpruntsEnCours() {
        return empruntDAO.findEmpruntsEnCours();
    }

    /**
     * Lister les emprunts en retard
     */
    public List<Emprunt> listerEmpruntsEnRetard() {
        return empruntDAO.findEmpruntsEnRetard();
    }

    /**
     * Obtenir un emprunt par ID
     */
    public Emprunt obtenirEmprunt(Long id) {
        return empruntDAO.findById(id);
    }

    /**
     * Compter les emprunts
     */
    public Long compterEmprunts() {
        return empruntDAO.count();
    }

    /**
     * Compter les emprunts en cours
     */
    public Long compterEmpruntsEnCours() {
        return empruntDAO.countEnCours();
    }

    /**
     * Compter les emprunts en retard
     */
    public Long compterEmpruntsEnRetard() {
        return empruntDAO.countEnRetard();
    }

    /**
     * Obtenir le nombre maximum d'emprunts selon le type d'utilisateur
     */
    private int getMaxEmprunts(TypeUtilisateur type) {
        switch (type) {
            case ETUDIANT:
                return MAX_EMPRUNTS_ETUDIANT;
            case ENSEIGNANT:
                return MAX_EMPRUNTS_ENSEIGNANT;
            case PERSONNEL:
                return MAX_EMPRUNTS_PERSONNEL;
            case EXTERNE:
                return MAX_EMPRUNTS_EXTERNE;
            default:
                return MAX_EMPRUNTS_ETUDIANT;
        }
    }

    /**
     * Vérifier si un utilisateur peut emprunter
     */
    public boolean peutEmprunter(Long utilisateurId) {
        Utilisateur utilisateur = utilisateurDAO.findById(utilisateurId);
        
        if (utilisateur == null || !utilisateur.estActif()) {
            return false;
        }

        List<Emprunt> empruntsEnCours = empruntDAO.findEmpruntsUtilisateurEnCours(utilisateurId);
        int maxEmprunts = getMaxEmprunts(utilisateur.getTypeUtilisateur());
        
        if (empruntsEnCours.size() >= maxEmprunts) {
            return false;
        }

        // Vérifier s'il a des retards
        for (Emprunt e : empruntsEnCours) {
            if (e.estEnRetard()) {
                return false;
            }
        }

        return true;
    }

    /**
     * Obtenir les emprunts en cours d'un utilisateur
     */
    public List<Emprunt> getEmpruntsEnCoursUtilisateur(Long utilisateurId) {
        return empruntDAO.findEmpruntsUtilisateurEnCours(utilisateurId);
    }
}