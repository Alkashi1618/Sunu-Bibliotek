package sn.ucad.m1.sunubibliotek.Cyberboys.utils;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

public class JPAUtil {
    
    private static EntityManagerFactory emf;
    
    static {
        try {
            emf = Persistence.createEntityManagerFactory("bibliothequePU");
        } catch (Exception e) {
            e.printStackTrace();
            throw new ExceptionInInitializerError("Erreur d'initialisation JPA: " + e.getMessage());
        }
    }
    
    public static EntityManager getEntityManager() {
        if (emf == null) {
            throw new IllegalStateException("EntityManagerFactory n'est pas initialisé");
        }
        return emf.createEntityManager();
    }
    
    public static void close() {
        if (emf != null && emf.isOpen()) {
            emf.close();
        }
    }
}