package sn.ucad.m1.sunubibliotek.Cyberboys.entities;

public enum StatutEmprunt {
    EN_COURS("En cours", "#4299e1"),
    RETOURNE("Retourné", "#48bb78"),
    EN_RETARD("En retard", "#f56565"),
    PERDU("Perdu", "#742a2a");

    private final String libelle;
    private final String couleur;

    StatutEmprunt(String libelle, String couleur) {
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