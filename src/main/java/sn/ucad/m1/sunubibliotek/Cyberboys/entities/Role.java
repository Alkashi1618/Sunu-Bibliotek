package sn.ucad.m1.sunubibliotek.Cyberboys.entities;

public enum Role {
    ADMIN("Administrateur"),
    BIBLIOTHECAIRE("Bibliothécaire"),
    LECTEUR("Lecteur");

    private final String libelle;

    Role(String libelle) {
        this.libelle = libelle;
    }

    public String getLibelle() {
        return libelle;
    }

    @Override
    public String toString() {
        return libelle;
    }
}