package sn.ucad.m1.sunubibliotek.Cyberboys.services;

import sn.ucad.m1.sunubibliotek.Cyberboys.dao.UtilisateurDAO;
import sn.ucad.m1.sunubibliotek.Cyberboys.entities.TypeUtilisateur;
import sn.ucad.m1.sunubibliotek.Cyberboys.entities.Utilisateur;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Random;

public class UtilisateurService {

    private UtilisateurDAO utilisateurDAO;

    public UtilisateurService() {
        this.utilisateurDAO = new UtilisateurDAO();
    }

    public void creerUtilisateur(Utilisateur utilisateur) {
        // Validation
        if (utilisateur == null) {
            throw new IllegalArgumentException("L'utilisateur ne peut pas être null");
        }
        
        if (utilisateur.getNom() == null || utilisateur.getNom().trim().isEmpty()) {
            throw new IllegalArgumentException("Le nom est obligatoire");
        }
        
        if (utilisateur.getPrenom() == null || utilisateur.getPrenom().trim().isEmpty()) {
            throw new IllegalArgumentException("Le prénom est obligatoire");
        }
        
        if (utilisateur.getEmail() == null || !utilisateur.getEmail().contains("@")) {
            throw new IllegalArgumentException("L'email est invalide");
        }
        
        // Vérifier si l'email existe déjà
        if (utilisateurDAO.emailExists(utilisateur.getEmail())) {
            throw new IllegalArgumentException("Cet email est déjà utilisé");
        }
        
        // Générer un numéro de carte unique
        utilisateur.setNumeroCarte(genererNumeroCarte(utilisateur.getTypeUtilisateur()));
        
        // Définir la date d'inscription si non définie
        if (utilisateur.getDateInscription() == null) {
            utilisateur.setDateInscription(LocalDate.now());
        }
        
        // Hasher le mot de passe (simple pour l'instant, à améliorer avec BCrypt)
        if (utilisateur.getMotDePasse() != null) {
            utilisateur.setMotDePasse(hashPassword(utilisateur.getMotDePasse()));
        }
        
        utilisateurDAO.create(utilisateur);
    }

    public Utilisateur obtenirUtilisateur(Long id) {
        return utilisateurDAO.findById(id);
    }

    public List<Utilisateur> listerTousLesUtilisateurs() {
        return utilisateurDAO.findAll();
    }

    public void modifierUtilisateur(Utilisateur utilisateur) {
        if (utilisateur == null || utilisateur.getId() == null) {
            throw new IllegalArgumentException("Utilisateur invalide pour la modification");
        }
        utilisateurDAO.update(utilisateur);
    }

    public void supprimerUtilisateur(Long id) {
        if (id == null) {
            throw new IllegalArgumentException("ID invalide");
        }
        utilisateurDAO.delete(id);
    }

    public Utilisateur authentifier(String email, String motDePasse) {
        if (email == null || motDePasse == null) {
            return null;
        }
        String hashedPassword = hashPassword(motDePasse);
        return utilisateurDAO.authenticate(email, hashedPassword);
    }

    public List<Utilisateur> rechercherParNom(String nom) {
        if (nom == null || nom.trim().isEmpty()) {
            return listerTousLesUtilisateurs();
        }
        return utilisateurDAO.rechercherParNom(nom);
    }

    public Long compterUtilisateurs() {
        return utilisateurDAO.count();
    }

    // Génération automatique du numéro de carte
    private String genererNumeroCarte(TypeUtilisateur type) {
        String prefix = type.getCode();
        String annee = LocalDate.now().format(DateTimeFormatter.ofPattern("yy"));
        String numero;
        
        do {
            int random = new Random().nextInt(9999) + 1;
            numero = prefix + annee + String.format("%04d", random);
        } while (utilisateurDAO.numeroCarteExists(numero));
        
        return numero;
    }

    // Hash simple du mot de passe (à améliorer avec BCrypt en production)
    private String hashPassword(String password) {
        // Pour l'instant, on utilise un hash simple
        // En production, utilisez BCrypt : BCrypt.hashpw(password, BCrypt.gensalt())
        return String.valueOf(password.hashCode());
    }

    public boolean verifierDisponibiliteEmail(String email) {
        return !utilisateurDAO.emailExists(email);
    }
}