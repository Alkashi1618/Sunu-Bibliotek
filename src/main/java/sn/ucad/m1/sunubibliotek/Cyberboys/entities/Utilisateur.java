package sn.ucad.m1.sunubibliotek.Cyberboys.entities;

import javax.persistence.*;
import java.io.Serializable;
import java.time.LocalDate;
import java.util.List;

@Entity
@Table(name = "utilisateurs")
public class Utilisateur implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 100)
    private String nom;

    @Column(nullable = false, length = 100)
    private String prenom;

    @Column(nullable = false, unique = true, length = 100)
    private String email;

    @Column(name = "mot_de_passe", nullable = false, length = 255)
    private String motDePasse;

    @Column(name = "numero_carte", unique = true, length = 20)
    private String numeroCarte;

    @Column(length = 20)
    private String telephone;

    @Enumerated(EnumType.STRING)
    @Column(name = "type_utilisateur", nullable = false)
    private TypeUtilisateur typeUtilisateur;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private Role role;

    @Column(nullable = false)
    private Boolean actif = true;

    @Column(name = "date_inscription")
    private LocalDate dateInscription;

    @OneToMany(mappedBy = "utilisateur", cascade = CascadeType.ALL)
    private List<Emprunt> emprunts;

    @OneToMany(mappedBy = "utilisateur", cascade = CascadeType.ALL)
    private List<Reservation> reservations;

    @Version
    private Long version;

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
        this.role = Role.LECTEUR;
    }

    // Getters et Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }

    public String getPrenom() { return prenom; }
    public void setPrenom(String prenom) { this.prenom = prenom; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getMotDePasse() { return motDePasse; }
    public void setMotDePasse(String motDePasse) { this.motDePasse = motDePasse; }

    public String getNumeroCarte() { return numeroCarte; }
    public void setNumeroCarte(String numeroCarte) { this.numeroCarte = numeroCarte; }

    public String getTelephone() { return telephone; }
    public void setTelephone(String telephone) { this.telephone = telephone; }

    public TypeUtilisateur getTypeUtilisateur() { return typeUtilisateur; }
    public void setTypeUtilisateur(TypeUtilisateur typeUtilisateur) { this.typeUtilisateur = typeUtilisateur; }

    public Role getRole() { return role; }
    public void setRole(Role role) { this.role = role; }

    public Boolean getActif() { return actif; }
    public void setActif(Boolean actif) { this.actif = actif; }

    public LocalDate getDateInscription() { return dateInscription; }
    public void setDateInscription(LocalDate dateInscription) { this.dateInscription = dateInscription; }

    public List<Emprunt> getEmprunts() { return emprunts; }
    public void setEmprunts(List<Emprunt> emprunts) { this.emprunts = emprunts; }

    public List<Reservation> getReservations() { return reservations; }
    public void setReservations(List<Reservation> reservations) { this.reservations = reservations; }

    public Long getVersion() { return version; }
    public void setVersion(Long version) { this.version = version; }

    // Méthodes métier
    public String getNomComplet() {
        return prenom + " " + nom;
    }

    public boolean estActif() {
        return actif != null && actif;
    }

    public boolean isAdmin() {
        return role == Role.ADMIN;
    }

    public boolean isBibliothecaire() {
        return role == Role.BIBLIOTHECAIRE;
    }

    public boolean isLecteur() {
        return role == Role.LECTEUR;
    }

    public boolean estBibliothecaire() {
        return role == Role.ADMIN || role == Role.BIBLIOTHECAIRE;
    }

    @Override
    public String toString() {
        return "Utilisateur [" + id + " - " + getNomComplet() + " (" + email + ") - " + role + "]";
    }
}