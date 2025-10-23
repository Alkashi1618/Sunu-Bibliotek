package sn.ucad.m1.sunubibliotek.Cyberboys.entities;

public enum StatutReservation {
    ACTIVE("Active", "#4299e1"),
    SATISFAITE("Satisfaite", "#48bb78"),
    ANNULEE("Annulée", "#718096"),
    EXPIREE("Expirée", "#e53e3e");

    private final String libelle;
    private final String couleur;

    StatutReservation(String libelle, String couleur) {
        this.libelle = libelle;
        this.couleur = couleur;
    }

    public String getLibelle() {
        return libelle;
    }

    public String getCouleur() {
        return couleur;
    }

    @Override
    public String toString() {
        return libelle;
    }
}