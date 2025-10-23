package sn.ucad.m1.sunubibliotek.Cyberboys.dao;

import sn.ucad.m1.sunubibliotek.Cyberboys.entities.*;
import sn.ucad.m1.sunubibliotek.Cyberboys.utils.JPAUtil;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.TypedQuery;
import java.time.LocalDate;
import java.util.List;

public class EmpruntDAO {

    public void create(Emprunt emprunt) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = null;
        try {
            tx = em.getTransaction();
            tx.begin();
            em.persist(emprunt);
            tx.commit();
        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            throw new RuntimeException("Erreur lors de la création de l'emprunt", e);
        } finally {
            em.close();
        }
    }

    public Emprunt findById(Long id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(Emprunt.class, id);
        } finally {
            em.close();
        }
    }

    public List<Emprunt> findAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Emprunt> query = em.createQuery(
                "SELECT e FROM Emprunt e ORDER BY e.dateEmprunt DESC", 
                Emprunt.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public void update(Emprunt emprunt) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = null;
        try {
            tx = em.getTransaction();
            tx.begin();
            em.merge(emprunt);
            tx.commit();
        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            throw new RuntimeException("Erreur lors de la modification de l'emprunt", e);
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
            Emprunt emprunt = em.find(Emprunt.class, id);
            if (emprunt != null) {
                em.remove(emprunt);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            throw new RuntimeException("Erreur lors de la suppression de l'emprunt", e);
        } finally {
            em.close();
        }
    }

    public List<Emprunt> findByUtilisateur(Long utilisateurId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Emprunt> query = em.createQuery(
                "SELECT e FROM Emprunt e WHERE e.utilisateur.id = :userId ORDER BY e.dateEmprunt DESC", 
                Emprunt.class);
            query.setParameter("userId", utilisateurId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public List<Emprunt> findByDocument(Long documentId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Emprunt> query = em.createQuery(
                "SELECT e FROM Emprunt e WHERE e.document.numEnreg = :docId ORDER BY e.dateEmprunt DESC", 
                Emprunt.class);
            query.setParameter("docId", documentId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public List<Emprunt> findEmpruntsEnCours() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Emprunt> query = em.createQuery(
                "SELECT e FROM Emprunt e WHERE e.statut = :statut ORDER BY e.dateEmprunt DESC", 
                Emprunt.class);
            query.setParameter("statut", StatutEmprunt.EN_COURS);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public List<Emprunt> findEmpruntsEnRetard() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Emprunt> query = em.createQuery(
                "SELECT e FROM Emprunt e WHERE e.statut = :statut AND e.dateRetourPrevue < :today ORDER BY e.dateRetourPrevue", 
                Emprunt.class);
            query.setParameter("statut", StatutEmprunt.EN_COURS);
            query.setParameter("today", LocalDate.now());
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public List<Emprunt> findEmpruntsUtilisateurEnCours(Long utilisateurId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Emprunt> query = em.createQuery(
                "SELECT e FROM Emprunt e WHERE e.utilisateur.id = :userId AND e.statut = :statut", 
                Emprunt.class);
            query.setParameter("userId", utilisateurId);
            query.setParameter("statut", StatutEmprunt.EN_COURS);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public boolean hasEmpruntEnCours(Long utilisateurId, Long documentId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery(
                "SELECT COUNT(e) FROM Emprunt e WHERE e.utilisateur.id = :userId AND e.document.numEnreg = :docId AND e.statut = :statut", 
                Long.class);
            query.setParameter("userId", utilisateurId);
            query.setParameter("docId", documentId);
            query.setParameter("statut", StatutEmprunt.EN_COURS);
            return query.getSingleResult() > 0;
        } finally {
            em.close();
        }
    }

    public Long count() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery(
                "SELECT COUNT(e) FROM Emprunt e", Long.class);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }

    public Long countEnCours() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery(
                "SELECT COUNT(e) FROM Emprunt e WHERE e.statut = :statut", Long.class);
            query.setParameter("statut", StatutEmprunt.EN_COURS);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }

    public Long countEnRetard() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery(
                "SELECT COUNT(e) FROM Emprunt e WHERE e.statut = :statut AND e.dateRetourPrevue < :today", 
                Long.class);
            query.setParameter("statut", StatutEmprunt.EN_COURS);
            query.setParameter("today", LocalDate.now());
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }
}