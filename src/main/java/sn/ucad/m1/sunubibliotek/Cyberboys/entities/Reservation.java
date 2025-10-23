package sn.ucad.m1.sunubibliotek.Cyberboys.entities;

import javax.persistence.*;
import java.io.Serializable;
import java.time.LocalDate;

@Entity
@Table(name = "reservations")
public class Reservation implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "document_id", nullable = false)
    private Document document;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "utilisateur_id", nullable = false)
    private Utilisateur utilisateur;

    @Column(name = "date_reservation", nullable = false)
    private LocalDate dateReservation;

    @Column(name = "date_expiration", nullable = false)
    private LocalDate dateExpiration;

    @Enumerated(EnumType.STRING)
    @Column(name = "statut", nullable = false)
    private StatutReservation statut = StatutReservation.ACTIVE;

    @Column(name = "notifie")
    private Boolean notifie = false;

    @Column(name = "remarque", length = 500)
    private String remarque;

    @Version
    private Long version;

    // Constante : durée de validité d'une réservation (7 jours)
    public static final int DUREE_VALIDITE_JOURS = 7;

    public Reservation() {
        this.dateReservation = LocalDate.now();
        this.dateExpiration = LocalDate.now().plusDays(DUREE_VALIDITE_JOURS);
        this.statut = StatutReservation.ACTIVE;
        this.notifie = false;
    }

    public Reservation(Document document, Utilisateur utilisateur) {
        this();
        this.document = document;
        this.utilisateur = utilisateur;
    }

    // Getters et Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Document getDocument() {
        return document;
    }

    public void setDocument(Document document) {
        this.document = document;
    }

    public Utilisateur getUtilisateur() {
        return utilisateur;
    }

    public void setUtilisateur(Utilisateur utilisateur) {
        this.utilisateur = utilisateur;
    }

    public LocalDate getDateReservation() {
        return dateReservation;
    }

    public void setDateReservation(LocalDate dateReservation) {
        this.dateReservation = dateReservation;
    }

    public LocalDate getDateExpiration() {
        return dateExpiration;
    }

    public void setDateExpiration(LocalDate dateExpiration) {
        this.dateExpiration = dateExpiration;
    }

    public StatutReservation getStatut() {
        return statut;
    }

    public void setStatut(StatutReservation statut) {
        this.statut = statut;
    }

    public Boolean getNotifie() {
        return notifie;
    }

    public void setNotifie(Boolean notifie) {
        this.notifie = notifie;
    }

    public String getRemarque() {
        return remarque;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

    public Long getVersion() {
        return version;
    }

    public void setVersion(Long version) {
        this.version = version;
    }

    // Méthodes métier
    public boolean estExpiree() {
        return LocalDate.now().isAfter(dateExpiration) && statut == StatutReservation.ACTIVE;
    }

    public boolean estActive() {
        return statut == StatutReservation.ACTIVE && !estExpiree();
    }

    public void satisfaire() {
        this.statut = StatutReservation.SATISFAITE;
        this.notifie = true;
    }

    public void annuler(String motif) {
        this.statut = StatutReservation.ANNULEE;
        this.remarque = motif;
    }

    public void expirer() {
        if (estExpiree()) {
            this.statut = StatutReservation.EXPIREE;
        }
    }

    public long getJoursRestants() {
        if (statut != StatutReservation.ACTIVE) {
            return 0;
        }
        long jours = java.time.temporal.ChronoUnit.DAYS.between(LocalDate.now(), dateExpiration);
        return Math.max(0, jours);
    }

    @Override
    public String toString() {
        return "Reservation [" + utilisateur.getNumeroCarte() + " - " + 
               document.getTitre() + " - " + statut + "]";
    }
}