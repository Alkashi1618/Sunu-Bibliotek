package sn.ucad.m1.sunubibliotek.Cyberboys.entities;

public enum TypeUtilisateur {
    ETUDIANT("Étudiant", "ETU"),
    ENSEIGNANT("Enseignant", "ENS"),
    PERSONNEL("Personnel", "PER"),
    EXTERNE("Externe", "EXT");

    private final String libelle;
    private final String code;

    TypeUtilisateur(String libelle, String code) {
        this.libelle = libelle;
        this.code = code;
    }

    public String getLibelle() {
        return libelle;
    }

    public String getCode() {
        return code;
    }

    @Override
    public String toString() {
        return libelle;
    }
}