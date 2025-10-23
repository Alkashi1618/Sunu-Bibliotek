package sn.ucad.m1.sunubibliotek.Cyberboys.services;

import sn.ucad.m1.sunubibliotek.Cyberboys.dao.*;
import sn.ucad.m1.sunubibliotek.Cyberboys.entities.*;
import sn.ucad.m1.sunubibliotek.Cyberboys.utils.JPAUtil;

import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;
import java.time.LocalDate;
import java.time.YearMonth;
import java.util.*;

public class StatistiqueService {

    private DocumentDAO documentDAO;
    private UtilisateurDAO utilisateurDAO;
    private EmpruntDAO empruntDAO;
    private ReservationDAO reservationDAO;

    public StatistiqueService() {
        this.documentDAO = new DocumentDAO();
        this.utilisateurDAO = new UtilisateurDAO();
        this.empruntDAO = new EmpruntDAO();
        this.reservationDAO = new ReservationDAO();
    }

    /**
     * Obtenir les statistiques globales
     */
    public Map<String, Object> getStatistiquesGlobales() {
        Map<String, Object> stats = new HashMap<>();
        
        stats.put("totalDocuments", documentDAO.count());
        stats.put("documentsDisponibles", documentDAO.countDisponibles());
        stats.put("totalUtilisateurs", utilisateurDAO.count());
        stats.put("totalEmprunts", empruntDAO.count());
        stats.put("empruntsEnCours", empruntDAO.countEnCours());
        stats.put("empruntsEnRetard", empruntDAO.countEnRetard());
        stats.put("totalReservations", reservationDAO.count());
        stats.put("reservationsActives", reservationDAO.countActives());
        
        // Calcul du taux d'occupation
        Long total = documentDAO.count();
        Long enCours = empruntDAO.countEnCours();
        double tauxOccupation = total > 0 ? (enCours * 100.0) / total : 0;
        stats.put("tauxOccupation", String.format("%.1f", tauxOccupation));
        
        return stats;
    }

    /**
     * Obtenir les documents les plus empruntés
     */
    public List<Map<String, Object>> getDocumentsLesPlusEmpruntes(int limit) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            String jpql = "SELECT d, COUNT(e) as nbEmprunts " +
                         "FROM Document d " +
                         "LEFT JOIN Emprunt e ON d.numEnreg = e.document.numEnreg " +
                         "GROUP BY d " +
                         "ORDER BY nbEmprunts DESC";
            
            TypedQuery<Object[]> query = em.createQuery(jpql, Object[].class);
            query.setMaxResults(limit);
            
            List<Object[]> results = query.getResultList();
            List<Map<String, Object>> documentStats = new ArrayList<>();
            
            for (Object[] row : results) {
                Map<String, Object> stat = new HashMap<>();
                stat.put("document", row[0]);
                stat.put("nbEmprunts", row[1]);
                documentStats.add(stat);
            }
            
            return documentStats;
        } finally {
            em.close();
        }
    }

    /**
     * Obtenir les utilisateurs les plus actifs
     */
    public List<Map<String, Object>> getUtilisateursLesPlusActifs(int limit) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            String jpql = "SELECT u, COUNT(e) as nbEmprunts " +
                         "FROM Utilisateur u " +
                         "LEFT JOIN Emprunt e ON u.id = e.utilisateur.id " +
                         "GROUP BY u " +
                         "ORDER BY nbEmprunts DESC";
            
            TypedQuery<Object[]> query = em.createQuery(jpql, Object[].class);
            query.setMaxResults(limit);
            
            List<Object[]> results = query.getResultList();
            List<Map<String, Object>> userStats = new ArrayList<>();
            
            for (Object[] row : results) {
                Map<String, Object> stat = new HashMap<>();
                stat.put("utilisateur", row[0]);
                stat.put("nbEmprunts", row[1]);
                userStats.add(stat);
            }
            
            return userStats;
        } finally {
            em.close();
        }
    }

    /**
     * Statistiques par type de document
     */
    public Map<String, Long> getStatistiquesParType() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            String jpql = "SELECT d.class, COUNT(d) " +
                         "FROM Document d " +
                         "GROUP BY d.class";
            
            TypedQuery<Object[]> query = em.createQuery(jpql, Object[].class);
            List<Object[]> results = query.getResultList();
            
            Map<String, Long> stats = new HashMap<>();
            for (Object[] row : results) {
                String type = ((Class<?>) row[0]).getSimpleName();
                Long count = (Long) row[1];
                stats.put(type, count);
            }
            
            return stats;
        } finally {
            em.close();
        }
    }

    /**
     * Statistiques des emprunts par mois (6 derniers mois)
     */
    public Map<String, Long> getStatistiquesEmpruntsParMois() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            LocalDate sixMoisAvant = LocalDate.now().minusMonths(6);
            
            String jpql = "SELECT FUNCTION('YEAR', e.dateEmprunt), " +
                         "FUNCTION('MONTH', e.dateEmprunt), " +
                         "COUNT(e) " +
                         "FROM Emprunt e " +
                         "WHERE e.dateEmprunt >= :dateDebut " +
                         "GROUP BY FUNCTION('YEAR', e.dateEmprunt), FUNCTION('MONTH', e.dateEmprunt) " +
                         "ORDER BY FUNCTION('YEAR', e.dateEmprunt), FUNCTION('MONTH', e.dateEmprunt)";
            
            TypedQuery<Object[]> query = em.createQuery(jpql, Object[].class);
            query.setParameter("dateDebut", sixMoisAvant);
            
            List<Object[]> results = query.getResultList();
            Map<String, Long> stats = new LinkedHashMap<>();
            
            for (Object[] row : results) {
                int annee = (Integer) row[0];
                int mois = (Integer) row[1];
                Long count = (Long) row[2];
                
                String cle = String.format("%02d/%d", mois, annee);
                stats.put(cle, count);
            }
            
            return stats;
        } finally {
            em.close();
        }
    }

    /**
     * Statistiques par type d'utilisateur
     */
    public Map<String, Long> getStatistiquesParTypeUtilisateur() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            String jpql = "SELECT u.typeUtilisateur, COUNT(u) " +
                         "FROM Utilisateur u " +
                         "GROUP BY u.typeUtilisateur";
            
            TypedQuery<Object[]> query = em.createQuery(jpql, Object[].class);
            List<Object[]> results = query.getResultList();
            
            Map<String, Long> stats = new HashMap<>();
            for (Object[] row : results) {
                TypeUtilisateur type = (TypeUtilisateur) row[0];
                Long count = (Long) row[1];
                stats.put(type.getLibelle(), count);
            }
            
            return stats;
        } finally {
            em.close();
        }
    }

    /**
     * Obtenir le taux de retour à temps
     */
    public Map<String, Object> getTauxRetourTemps() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            String jpqlTotal = "SELECT COUNT(e) FROM Emprunt e WHERE e.statut = :statut";
            TypedQuery<Long> queryTotal = em.createQuery(jpqlTotal, Long.class);
            queryTotal.setParameter("statut", StatutEmprunt.RETOURNE);
            Long totalRetournes = queryTotal.getSingleResult();
            
            String jpqlTemps = "SELECT COUNT(e) FROM Emprunt e " +
                              "WHERE e.statut = :statut " +
                              "AND e.dateRetourEffective <= e.dateRetourPrevue";
            TypedQuery<Long> queryTemps = em.createQuery(jpqlTemps, Long.class);
            queryTemps.setParameter("statut", StatutEmprunt.RETOURNE);
            Long retoursTemps = queryTemps.getSingleResult();
            
            Map<String, Object> stats = new HashMap<>();
            stats.put("totalRetournes", totalRetournes);
            stats.put("retoursTemps", retoursTemps);
            stats.put("retoursRetard", totalRetournes - retoursTemps);
            
            double taux = totalRetournes > 0 ? (retoursTemps * 100.0) / totalRetournes : 0;
            stats.put("tauxRetourTemps", String.format("%.1f", taux));
            
            return stats;
        } finally {
            em.close();
        }
    }

    /**
     * Calcul des pénalités totales
     */
    public Double getPenalitesTotales() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            String jpql = "SELECT SUM(e.penalite) FROM Emprunt e WHERE e.penalite > 0";
            TypedQuery<Double> query = em.createQuery(jpql, Double.class);
            Double total = query.getSingleResult();
            return total != null ? total : 0.0;
        } finally {
            em.close();
        }
    }

    /**
     * Obtenir les dernières activités
     */
    public List<Emprunt> getDernieresActivites(int limit) {
        return empruntDAO.findAll().subList(0, Math.min(limit, empruntDAO.findAll().size()));
    }
}