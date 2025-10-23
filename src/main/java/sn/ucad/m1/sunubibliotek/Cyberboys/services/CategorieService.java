package sn.ucad.m1.sunubibliotek.Cyberboys.services;

import sn.ucad.m1.sunubibliotek.Cyberboys.dao.CategorieDAO;
import sn.ucad.m1.sunubibliotek.Cyberboys.entities.Categorie;

import java.util.List;

public class CategorieService {

    private CategorieDAO categorieDAO;

    public CategorieService() {
        this.categorieDAO = new CategorieDAO();
    }

    public void creerCategorie(Categorie categorie) {
        if (categorie == null) {
            throw new IllegalArgumentException("La catégorie ne peut pas être null");
        }

        if (categorie.getNom() == null || categorie.getNom().trim().isEmpty()) {
            throw new IllegalArgumentException("Le nom de la catégorie est obligatoire");
        }

        if (categorie.getCode() == null || categorie.getCode().trim().isEmpty()) {
            throw new IllegalArgumentException("Le code de la catégorie est obligatoire");
        }

        // Vérifier si le code existe déjà
        if (categorieDAO.findByCode(categorie.getCode()) != null) {
            throw new IllegalArgumentException("Ce code de catégorie existe déjà");
        }

        // Vérifier si le nom existe déjà
        if (categorieDAO.findByNom(categorie.getNom()) != null) {
            throw new IllegalArgumentException("Cette catégorie existe déjà");
        }

        categorieDAO.create(categorie);
    }

    public Categorie obtenirCategorie(Long id) {
        return categorieDAO.findById(id);
    }

    public List<Categorie> listerToutesLesCategories() {
        return categorieDAO.findAll();
    }

    public void modifierCategorie(Categorie categorie) {
        if (categorie == null || categorie.getId() == null) {
            throw new IllegalArgumentException("Catégorie invalide pour la modification");
        }
        categorieDAO.update(categorie);
    }

    public void supprimerCategorie(Long id) {
        if (id == null) {
            throw new IllegalArgumentException("ID invalide");
        }

        // Vérifier qu'il n'y a pas de documents dans cette catégorie
        Long nbDocuments = categorieDAO.countDocuments(id);
        if (nbDocuments > 0) {
            throw new IllegalArgumentException(
                "Impossible de supprimer cette catégorie. Elle contient " + nbDocuments + " document(s)."
            );
        }

        categorieDAO.delete(id);
    }

    public Long compterCategories() {
        return categorieDAO.count();
    }

    public Long compterDocuments(Long categorieId) {
        return categorieDAO.countDocuments(categorieId);
    }

    public Categorie obtenirParCode(String code) {
        return categorieDAO.findByCode(code);
    }
}