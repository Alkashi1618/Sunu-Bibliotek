package sn.ucad.m1.sunubibliotek.Cyberboys.entities;

import javax.persistence.*;
import java.io.Serializable;
import java.time.LocalDate;

@Entity
@Table(name = "documents")
@Inheritance(strategy = InheritanceType.JOINED)
@DiscriminatorColumn(name = "type_document")
public abstract class Document implements Serializable {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "num_enreg")
    private Long numEnreg;
    
    @Column(name = "titre", nullable = false, length = 200)
    private String titre;
    
    @Column(name = "isbn", length = 20)
    private String isbn;
    
    @Column(name = "quantite_totale", nullable = false)
    private Integer quantiteTotale = 1;
    
    @Column(name = "quantite_disponible", nullable = false)
    private Integer quantiteDisponible = 1;
    
    @Column(name = "emplacement", length = 50)
    private String emplacement;
    
    @Column(name = "date_ajout")
    private LocalDate dateAjout;
    
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "categorie_id")
    private Categorie categorie;
    
    @Version
    private Long version;

    public Document() {
        this.dateAjout = LocalDate.now();
        this.quantiteTotale = 1;
        this.quantiteDisponible = 1;
    }

    public Document(String titre) {
        this();
        this.titre = titre;
    }

    // Getters et Setters
    public Long getNumEnreg() {
        return numEnreg;
    }

    public void setNumEnreg(Long numEnreg) {
        this.numEnreg = numEnreg;
    }

    public String getTitre() {
        return titre;
    }

    public void setTitre(String titre) {
        this.titre = titre;
    }

    public String getIsbn() {
        return isbn;
    }

    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }

    public Integer getQuantiteTotale() {
        return quantiteTotale;
    }

    public void setQuantiteTotale(Integer quantiteTotale) {
        this.quantiteTotale = quantiteTotale;
    }

    public Integer getQuantiteDisponible() {
        return quantiteDisponible;
    }

    public void setQuantiteDisponible(Integer quantiteDisponible) {
        this.quantiteDisponible = quantiteDisponible;
    }

    public String getEmplacement() {
        return emplacement;
    }

    public void setEmplacement(String emplacement) {
        this.emplacement = emplacement;
    }

    public LocalDate getDateAjout() {
        return dateAjout;
    }

    public void setDateAjout(LocalDate dateAjout) {
        this.dateAjout = dateAjout;
    }

    public Long getVersion() {
        return version;
    }

    public void setVersion(Long version) {
        this.version = version;
    }
    
    public Categorie getCategorie() {
        return categorie;
    }

    public void setCategorie(Categorie categorie) {
        this.categorie = categorie;
    }

    // Méthodes métier
    public boolean estDisponible() {
        return quantiteDisponible != null && quantiteDisponible > 0;
    }

    public boolean emprunter() {
        if (estDisponible()) {
            quantiteDisponible--;
            return true;
        }
        return false;
    }

    public void retourner() {
        if (quantiteDisponible < quantiteTotale) {
            quantiteDisponible++;
        }
    }

    public int getNombreExemplairesEmpruntes() {
        return quantiteTotale - quantiteDisponible;
    }

    @Override
    public String toString() {
        return "Document [N°=" + numEnreg + ", Titre=" + titre + ", Dispo=" + quantiteDisponible + "/" + quantiteTotale + "]";
    }
}