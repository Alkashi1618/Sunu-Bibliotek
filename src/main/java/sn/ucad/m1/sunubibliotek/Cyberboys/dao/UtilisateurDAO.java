package sn.ucad.m1.sunubibliotek.Cyberboys.dao;

import sn.ucad.m1.sunubibliotek.Cyberboys.entities.Utilisateur;
import sn.ucad.m1.sunubibliotek.Cyberboys.utils.JPAUtil;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.NoResultException;
import javax.persistence.TypedQuery;
import java.util.List;

public class UtilisateurDAO {

    public void create(Utilisateur utilisateur) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = null;
        try {
            tx = em.getTransaction();
            tx.begin();
            em.persist(utilisateur);
            tx.commit();
        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            throw new RuntimeException("Erreur lors de la création de l'utilisateur", e);
        } finally {
            em.close();
        }
    }

    public Utilisateur findById(Long id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(Utilisateur.class, id);
        } finally {
            em.close();
        }
    }

    public List<Utilisateur> findAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Utilisateur> query = em.createQuery(
                "SELECT u FROM Utilisateur u ORDER BY u.nom, u.prenom", 
                Utilisateur.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public Utilisateur findByEmail(String email) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Utilisateur> query = em.createQuery(
                "SELECT u FROM Utilisateur u WHERE u.email = :email", 
                Utilisateur.class);
            query.setParameter("email", email);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }

    public Utilisateur findByNumeroCarte(String numeroCarte) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Utilisateur> query = em.createQuery(
                "SELECT u FROM Utilisateur u WHERE u.numeroCarte = :numero", 
                Utilisateur.class);
            query.setParameter("numero", numeroCarte);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }

    public void update(Utilisateur utilisateur) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = null;
        try {
            tx = em.getTransaction();
            tx.begin();
            em.merge(utilisateur);
            tx.commit();
        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            throw new RuntimeException("Erreur lors de la modification de l'utilisateur", e);
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
            Utilisateur utilisateur = em.find(Utilisateur.class, id);
            if (utilisateur != null) {
                em.remove(utilisateur);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            throw new RuntimeException("Erreur lors de la suppression de l'utilisateur", e);
        } finally {
            em.close();
        }
    }

    public Utilisateur authenticate(String email, String motDePasse) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Utilisateur> query = em.createQuery(
                "SELECT u FROM Utilisateur u WHERE u.email = :email AND u.motDePasse = :mdp AND u.actif = true", 
                Utilisateur.class);
            query.setParameter("email", email);
            query.setParameter("mdp", motDePasse);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }

    public List<Utilisateur> rechercherParNom(String nom) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Utilisateur> query = em.createQuery(
                "SELECT u FROM Utilisateur u WHERE LOWER(u.nom) LIKE LOWER(:nom) OR LOWER(u.prenom) LIKE LOWER(:nom)", 
                Utilisateur.class);
            query.setParameter("nom", "%" + nom + "%");
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public Long count() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery(
                "SELECT COUNT(u) FROM Utilisateur u", 
                Long.class);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }

    public boolean emailExists(String email) {
        return findByEmail(email) != null;
    }

    public boolean numeroCarteExists(String numeroCarte) {
        return findByNumeroCarte(numeroCarte) != null;
    }
}