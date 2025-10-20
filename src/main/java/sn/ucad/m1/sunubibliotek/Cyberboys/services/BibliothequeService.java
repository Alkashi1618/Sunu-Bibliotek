package sn.ucad.m1.sunubibliotek.Cyberboys.services;

import sn.ucad.m1.sunubibliotek.Cyberboys.dao.DocumentDAO;
import sn.ucad.m1.sunubibliotek.Cyberboys.entities.Document;

import java.util.List;

public class BibliothequeService {

    private DocumentDAO documentDAO;

    public BibliothequeService() {
        this.documentDAO = new DocumentDAO();
    }

    public void ajouterDocument(Document document) {
        if (document != null && document.getTitre() != null && !document.getTitre().trim().isEmpty()) {
            documentDAO.create(document);
        } else {
            throw new IllegalArgumentException("Document invalide");
        }
    }

    public Document obtenirDocument(Long id) {
        return documentDAO.findById(id);
    }

    public List<Document> listerTousLesDocuments() {
        return documentDAO.findAll();
    }

    public void modifierDocument(Document document) {
        if (document != null && document.getNumEnreg() != null) {
            documentDAO.update(document);
        } else {
            throw new IllegalArgumentException("Document invalide pour la modification");
        }
    }

    public void supprimerDocument(Long id) {
        if (id != null) {
            documentDAO.delete(id);
        }
    }

    public List<Document> rechercherParTitre(String titre) {
        if (titre == null || titre.trim().isEmpty()) {
            return listerTousLesDocuments();
        }
        return documentDAO.findByTitre(titre);
    }

    public Long compterDocuments() {
        return documentDAO.count();
    }
}