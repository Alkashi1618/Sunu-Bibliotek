package sn.ucad.m1.sunubibliotek.Cyberboys.dao;

import sn.ucad.m1.sunubibliotek.Cyberboys.entities.*;
import sn.ucad.m1.sunubibliotek.Cyberboys.utils.JPAUtil;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.TypedQuery;
import java.time.LocalDate;
import java.util.List;

public class ReservationDAO {

    public void create(Reservation reservation) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = null;
        try {
            tx = em.getTransaction();
            tx.begin();
            em.persist(reservation);
            tx.commit();
        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            throw new RuntimeException("Erreur lors de la création de la réservation", e);
        } finally {
            em.close();
        }
    }

    public Reservation findById(Long id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(Reservation.class, id);
        } finally {
            em.close();
        }
    }

    public List<Reservation> findAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Reservation> query = em.createQuery(
                "SELECT r FROM Reservation r ORDER BY r.dateReservation DESC", 
                Reservation.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public void update(Reservation reservation) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = null;
        try {
            tx = em.getTransaction();
            tx.begin();
            em.merge(reservation);
            tx.commit();
        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            throw new RuntimeException("Erreur lors de la modification de la réservation", e);
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
            Reservation reservation = em.find(Reservation.class, id);
            if (reservation != null) {
                em.remove(reservation);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            throw new RuntimeException("Erreur lors de la suppression de la réservation", e);
        } finally {
            em.close();
        }
    }

    public List<Reservation> findByUtilisateur(Long utilisateurId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Reservation> query = em.createQuery(
                "SELECT r FROM Reservation r WHERE r.utilisateur.id = :userId ORDER BY r.dateReservation DESC", 
                Reservation.class);
            query.setParameter("userId", utilisateurId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public List<Reservation> findByDocument(Long documentId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Reservation> query = em.createQuery(
                "SELECT r FROM Reservation r WHERE r.document.numEnreg = :docId ORDER BY r.dateReservation", 
                Reservation.class);
            query.setParameter("docId", documentId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public List<Reservation> findReservationsActives() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Reservation> query = em.createQuery(
                "SELECT r FROM Reservation r WHERE r.statut = :statut AND r.dateExpiration >= :today ORDER BY r.dateReservation", 
                Reservation.class);
            query.setParameter("statut", StatutReservation.ACTIVE);
            query.setParameter("today", LocalDate.now());
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public List<Reservation> findReservationsExpirees() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Reservation> query = em.createQuery(
                "SELECT r FROM Reservation r WHERE r.statut = :statut AND r.dateExpiration < :today", 
                Reservation.class);
            query.setParameter("statut", StatutReservation.ACTIVE);
            query.setParameter("today", LocalDate.now());
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public List<Reservation> findReservationsActivesUtilisateur(Long utilisateurId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Reservation> query = em.createQuery(
                "SELECT r FROM Reservation r WHERE r.utilisateur.id = :userId AND r.statut = :statut", 
                Reservation.class);
            query.setParameter("userId", utilisateurId);
            query.setParameter("statut", StatutReservation.ACTIVE);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public List<Reservation> findReservationsActivesDocument(Long documentId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Reservation> query = em.createQuery(
                "SELECT r FROM Reservation r WHERE r.document.numEnreg = :docId AND r.statut = :statut ORDER BY r.dateReservation", 
                Reservation.class);
            query.setParameter("docId", documentId);
            query.setParameter("statut", StatutReservation.ACTIVE);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public boolean hasReservationActive(Long utilisateurId, Long documentId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery(
                "SELECT COUNT(r) FROM Reservation r WHERE r.utilisateur.id = :userId AND r.document.numEnreg = :docId AND r.statut = :statut", 
                Long.class);
            query.setParameter("userId", utilisateurId);
            query.setParameter("docId", documentId);
            query.setParameter("statut", StatutReservation.ACTIVE);
            return query.getSingleResult() > 0;
        } finally {
            em.close();
        }
    }

    public Long count() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery(
                "SELECT COUNT(r) FROM Reservation r", Long.class);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }

    public Long countActives() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery(
                "SELECT COUNT(r) FROM Reservation r WHERE r.statut = :statut", Long.class);
            query.setParameter("statut", StatutReservation.ACTIVE);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }
}