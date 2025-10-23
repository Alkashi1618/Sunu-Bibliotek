package sn.ucad.m1.sunubibliotek.Cyberboys.entities;

import javax.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "utilisateurs")
public class Utilisateur {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "nom", nullable = false, length = 100)
    private String nom;

    @Column(name = "prenom", nullable = false, length = 100)
    private String prenom;

    @Column(name = "email", unique = true, nullable = false, length = 150)
    private String email;

    @Column(name = "telephone", length = 20)
    private String telephone;

    @Enumerated(EnumType.STRING)
    @Column(name = "type_utilisateur", nullable = false)
    private TypeUtilisateur typeUtilisateur;

    @Column(name = "numero_carte", unique = true, nullable = false, length = 20)
    private String numeroCarte;

    @Column(name = "date_inscription", nullable = false)
    private LocalDate dateInscription;

    @Column(name = "actif", nullable = false)
    private Boolean actif = true;

    @Column(name = "mot_de_passe", nullable = false)
    private String motDePasse;

    @Enumerated(EnumType.STRING)
    @Column(name = "role", nullable = false)
    private Role role = Role.LECTEUR;

    @Version
    private Long version;

    // Constructeurs
    public Utilisateur() {
        this.dateInscription = LocalDate.now();
        this.actif = true;
    }

    public Utilisateur(String nom, String prenom, String email, TypeUtilisateur typeUtilisateur) {
        this();
        this.nom = nom;
        this.prenom = prenom;
        this.email = email;
        this.typeUtilisateur = typeUtilisateur;
    }

    // Getters et Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getPrenom() {
        return prenom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public TypeUtilisateur getTypeUtilisateur() {
        return typeUtilisateur;
    }

    public void setTypeUtilisateur(TypeUtilisateur typeUtilisateur) {
        this.typeUtilisateur = typeUtilisateur;
    }

    public String getNumeroCarte() {
        return numeroCarte;
    }

    public void setNumeroCarte(String numeroCarte) {
        this.numeroCarte = numeroCarte;
    }

    public LocalDate getDateInscription() {
        return dateInscription;
    }

    public void setDateInscription(LocalDate dateInscription) {
        this.dateInscription = dateInscription;
    }

    public Boolean getActif() {
        return actif;
    }

    public void setActif(Boolean actif) {
        this.actif = actif;
    }

    public String getMotDePasse() {
        return motDePasse;
    }

    public void setMotDePasse(String motDePasse) {
        this.motDePasse = motDePasse;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public Long getVersion() {
        return version;
    }

    public void setVersion(Long version) {
        this.version = version;
    }

    // Méthodes utilitaires
    public String getNomComplet() {
        return prenom + " " + nom;
    }

    public boolean estActif() {
        return actif != null && actif;
    }

    public boolean estAdmin() {
        return role == Role.ADMIN;
    }

    public boolean estBibliothecaire() {
        return role == Role.BIBLIOTHECAIRE || role == Role.ADMIN;
    }

    @Override
    public String toString() {
        return "Utilisateur [" + numeroCarte + "] " + getNomComplet() + 
               " (" + typeUtilisateur + ", " + role + ")";
    }
}