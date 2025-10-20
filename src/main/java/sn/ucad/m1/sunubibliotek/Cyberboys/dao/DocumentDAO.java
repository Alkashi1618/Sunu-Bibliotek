package sn.ucad.m1.sunubibliotek.Cyberboys.dao;

import sn.ucad.m1.sunubibliotek.Cyberboys.entities.Document;
import sn.ucad.m1.sunubibliotek.Cyberboys.utils.JPAUtil;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.TypedQuery;
import java.util.List;

public class DocumentDAO {

    public void create(Document document) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = null;
        try {
            tx = em.getTransaction();
            tx.begin();
            em.persist(document);
            tx.commit();
        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            throw new RuntimeException("Erreur lors de la création du document", e);
        } finally {
            em.close();
        }
    }

    public Document findById(Long id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(Document.class, id);
        } finally {
            em.close();
        }
    }

    public List<Document> findAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Document> query = em.createQuery(
                "SELECT d FROM Document d ORDER BY d.numEnreg DESC", Document.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public void update(Document document) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = null;
        try {
            tx = em.getTransaction();
            tx.begin();
            em.merge(document);
            tx.commit();
        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            throw new RuntimeException("Erreur lors de la modification du document", e);
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
            Document document = em.find(Document.class, id);
            if (document != null) {
                em.remove(document);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            throw new RuntimeException("Erreur lors de la suppression du document", e);
        } finally {
            em.close();
        }
    }

    public List<Document> findByTitre(String titre) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Document> query = em.createQuery(
                "SELECT d FROM Document d WHERE LOWER(d.titre) LIKE LOWER(:titre)", 
                Document.class);
            query.setParameter("titre", "%" + titre + "%");
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public Long count() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery(
                "SELECT COUNT(d) FROM Document d", Long.class);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }
}