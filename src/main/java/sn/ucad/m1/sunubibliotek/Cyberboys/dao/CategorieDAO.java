package sn.ucad.m1.sunubibliotek.Cyberboys.dao;

import sn.ucad.m1.sunubibliotek.Cyberboys.entities.Categorie;
import sn.ucad.m1.sunubibliotek.Cyberboys.utils.JPAUtil;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.NoResultException;
import javax.persistence.TypedQuery;
import java.util.List;

public class CategorieDAO {

    public void create(Categorie categorie) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = null;
        try {
            tx = em.getTransaction();
            tx.begin();
            em.persist(categorie);
            tx.commit();
        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            throw new RuntimeException("Erreur lors de la création de la catégorie", e);
        } finally {
            em.close();
        }
    }

    public Categorie findById(Long id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(Categorie.class, id);
        } finally {
            em.close();
        }
    }

    public List<Categorie> findAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Categorie> query = em.createQuery(
                "SELECT c FROM Categorie c ORDER BY c.nom", 
                Categorie.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public void update(Categorie categorie) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = null;
        try {
            tx = em.getTransaction();
            tx.begin();
            em.merge(categorie);
            tx.commit();
        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            throw new RuntimeException("Erreur lors de la modification de la catégorie", e);
        } finally {
            em.close();
        }
    }

    public void delete(Long id) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = null;
        try {
            tx = em.getTransaction();
            tx.begin();
            Categorie categorie = em.find(Categorie.class, id);
            if (categorie != null) {
                em.remove(categorie);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            throw new RuntimeException("Erreur lors de la suppression de la catégorie", e);
        } finally {
            em.close();
        }
    }

    public Categorie findByCode(String code) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Categorie> query = em.createQuery(
                "SELECT c FROM Categorie c WHERE c.code = :code", 
                Categorie.class);
            query.setParameter("code", code);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }

    public Categorie findByNom(String nom) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Categorie> query = em.createQuery(
                "SELECT c FROM Categorie c WHERE c.nom = :nom", 
                Categorie.class);
            query.setParameter("nom", nom);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }

    public Long count() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery(
                "SELECT COUNT(c) FROM Categorie c", Long.class);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }

    public Long countDocuments(Long categorieId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery(
                "SELECT COUNT(d) FROM Document d WHERE d.categorie.id = :catId", 
                Long.class);
            query.setParameter("catId", categorieId);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }
}