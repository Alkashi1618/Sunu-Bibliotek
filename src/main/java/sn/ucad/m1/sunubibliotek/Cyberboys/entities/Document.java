package sn.ucad.m1.sunubibliotek.Cyberboys.entities;

import javax.persistence.*;
import java.io.Serializable;

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
    
    @Version
    private Long version;

    public Document() {
    }

    public Document(String titre) {
        this.titre = titre;
    }

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

    public Long getVersion() {
        return version;
    }

    public void setVersion(Long version) {
        this.version = version;
    }

    @Override
    public String toString() {
        return "Document [N°=" + numEnreg + ", Titre=" + titre + "]";
    }
}