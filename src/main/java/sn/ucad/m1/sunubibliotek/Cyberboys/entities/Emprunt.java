package sn.ucad.m1.sunubibliotek.Cyberboys.entities;

import javax.persistence.*;
import java.io.Serializable;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

@Entity
@Table(name = "emprunts")
public class Emprunt implements Serializable {

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

    @Column(name = "date_emprunt", nullable = false)
    private LocalDate dateEmprunt;

    @Column(name = "date_retour_prevue", nullable = false)
    private LocalDate dateRetourPrevue;

    @Column(name = "date_retour_effective")
    private LocalDate dateRetourEffective;

    @Enumerated(EnumType.STRING)
    @Column(name = "statut", nullable = false)
    private StatutEmprunt statut = StatutEmprunt.EN_COURS;

    @Column(name = "penalite")
    private Double penalite = 0.0;

    @Column(name = "remarque", length = 500)
    private String remarque;

    @Version
    private Long version;

    // Constantes
    public static final int DUREE_EMPRUNT_DEFAUT = 14; // 14 jours
    public static final double PENALITE_PAR_JOUR = 100.0; // 100 FCFA par jour

    public Emprunt() {
        this.dateEmprunt = LocalDate.now();
        this.dateRetourPrevue = LocalDate.now().plusDays(DUREE_EMPRUNT_DEFAUT);
        this.statut = StatutEmprunt.EN_COURS;
        this.penalite = 0.0;
    }

    public Emprunt(Document document, Utilisateur utilisateur) {
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

    public LocalDate getDateEmprunt() {
        return dateEmprunt;
    }

    public void setDateEmprunt(LocalDate dateEmprunt) {
        this.dateEmprunt = dateEmprunt;
    }

    public LocalDate getDateRetourPrevue() {
        return dateRetourPrevue;
    }

    public void setDateRetourPrevue(LocalDate dateRetourPrevue) {
        this.dateRetourPrevue = dateRetourPrevue;
    }

    public LocalDate getDateRetourEffective() {
        return dateRetourEffective;
    }

    public void setDateRetourEffective(LocalDate dateRetourEffective) {
        this.dateRetourEffective = dateRetourEffective;
    }

    public StatutEmprunt getStatut() {
        return statut;
    }

    public void setStatut(StatutEmprunt statut) {
        this.statut = statut;
    }

    public Double getPenalite() {
        return penalite;
    }

    public void setPenalite(Double penalite) {
        this.penalite = penalite;
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
    public boolean estEnRetard() {
        if (statut == StatutEmprunt.RETOURNE) {
            return false;
        }
        return LocalDate.now().isAfter(dateRetourPrevue);
    }

    public long getJoursRetard() {
        if (!estEnRetard()) {
            return 0;
        }
        LocalDate dateReference = dateRetourEffective != null ? dateRetourEffective : LocalDate.now();
        return ChronoUnit.DAYS.between(dateRetourPrevue, dateReference);
    }

    public double calculerPenalite() {
        long joursRetard = getJoursRetard();
        return joursRetard > 0 ? joursRetard * PENALITE_PAR_JOUR : 0.0;
    }

    public void retourner() {
        this.dateRetourEffective = LocalDate.now();
        this.statut = StatutEmprunt.RETOURNE;
        this.penalite = calculerPenalite();
    }

    public void prolonger(int jours) {
        if (statut == StatutEmprunt.EN_COURS && !estEnRetard()) {
            this.dateRetourPrevue = this.dateRetourPrevue.plusDays(jours);
        }
    }

    public long getJoursRestants() {
        if (statut == StatutEmprunt.RETOURNE) {
            return 0;
        }
        return ChronoUnit.DAYS.between(LocalDate.now(), dateRetourPrevue);
    }

    @Override
    public String toString() {
        return "Emprunt [" + utilisateur.getNumeroCarte() + " - " + document.getTitre() + " - " + statut + "]";
    }
}