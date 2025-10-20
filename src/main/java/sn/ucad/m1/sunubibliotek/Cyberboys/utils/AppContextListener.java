package sn.ucad.m1.sunubibliotek.Cyberboys.utils;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

/**
 * Listener pour gérer le cycle de vie de l'application
 * Ferme proprement l'EntityManagerFactory au shutdown
 */
@WebListener
public class AppContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("========================================");
        System.out.println("Application Sunu Bibliotek (Cyberboys) démarrée");
        System.out.println("Initialisation de JPA...");
        System.out.println("========================================");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("========================================");
        System.out.println("Arrêt de l'application...");
        System.out.println("Fermeture de JPA...");
        JPAUtil.close();
        System.out.println("Application arrêtée proprement");
        System.out.println("========================================");
    }
}