# 📚 Sunu Bibliotek - Système de Gestion de Bibliothèque

![Build Status](https://github.com/Alkashi1618/Sunu-Bibliotek/workflows/Java%20CI/CD%20-%20Sunu%20Bibliotek/badge.svg)
![Java](https://img.shields.io/badge/Java-11-orange)
![Maven](https://img.shields.io/badge/Maven-3.6+-blue)
![License](https://img.shields.io/badge/License-Academic-green)

Application JEE de gestion de bibliothèque développée avec **Java EE**, **JPA/Hibernate**, et **MySQL**, déployée sur **Apache Tomcat**.

**Développé par** : Cyberboys Team 🚀  
**Établissement** : UCAD - Université Cheikh Anta Diop de Dakar 🇸🇳

---

## 📸 Aperçu

Application web complète permettant de gérer :
- 📖 **Documents** (Livres, Revues, Dictionnaires)
- 👥 **Utilisateurs** (Admin, Bibliothécaire, Lecteur)
- 🔄 **Emprunts** avec gestion des retards et pénalités
- 📋 **Réservations** de documents
- 📊 **Statistiques** avancées
- 🏷️ **Catégories** de documents

---

## ✨ Fonctionnalités Principales

### 🔐 Authentification & Sécurité
- ✅ Système de login/logout
- ✅ Gestion des rôles (Admin, Bibliothécaire, Lecteur)
- ✅ Sessions sécurisées (30 min)
- ✅ Filtres d'autorisation

### 📚 Gestion des Documents
- ✅ CRUD complet (Créer, Lire, Modifier, Supprimer)
- ✅ Recherche par titre
- ✅ Catégorisation
- ✅ Gestion des quantités et disponibilité
- ✅ ISBN, emplacement, date d'ajout

### 👥 Gestion des Utilisateurs
- ✅ Types : Étudiants, Enseignants, Personnel, Externes
- ✅ Profils détaillés
- ✅ Historique des emprunts
- ✅ Limites d'emprunts personnalisées

### 🔄 Gestion des Emprunts
- ✅ Création et retour d'emprunts
- ✅ Calcul automatique des pénalités (100 FCFA/jour)
- ✅ Alertes emprunts en retard
- ✅ Historique complet
- ✅ Durée standard : 14 jours

### 📋 Système de Réservations
- ✅ Réservation de documents non disponibles
- ✅ Durée de validité : 7 jours
- ✅ Notification automatique

### 📊 Statistiques Avancées
- ✅ Top documents empruntés
- ✅ Utilisateurs les plus actifs
- ✅ Répartition par types
- ✅ Emprunts par mois
- ✅ Taux de retour à temps

### 🎨 Interface Moderne
- ✅ Design responsive (mobile, tablette, desktop)
- ✅ Navigation intuitive avec menu global
- ✅ Messages flash (success, error, warning, info)
- ✅ Dashboards personnalisés par rôle
- ✅ Animations fluides

---

## 🛠️ Technologies Utilisées

### Backend
- **Java 11**
- **JPA 2.2** (Java Persistence API)
- **Hibernate 5.6.15** (ORM)
- **Servlets 4.0**
- **JSP 2.3** avec JSTL

### Frontend
- **HTML5 / CSS3**
- **JSP** (JavaServer Pages)
- **JSTL** (JSP Standard Tag Library)
- **Design Responsive**

### Base de Données
- **MySQL 8.0**
- **C3P0** (Connection Pool)

### Outils
- **Maven 3.6+** (Gestion des dépendances)
- **Apache Tomcat 9.x** (Serveur d'application)
- **GitHub Actions** (CI/CD)

---

## 📋 Prérequis

- ☕ **JDK 11** ou supérieur
- 🗄️ **MySQL 8.0** ou supérieur
- 🐱 **Apache Tomcat 9.x**
- 📦 **Maven 3.6+**
- 💻 **Eclipse IDE** (avec plugins Maven et Tomcat)

---

## 🚀 Installation Rapide

### 1️⃣ Cloner le projet

```bash
git clone https://github.com/Alkashi1618/Sunu-Bibliotek.git
cd Sunu-Bibliotek
```

### 2️⃣ Créer la base de données

```sql
CREATE DATABASE bibliotheque_ucad CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

Puis exécutez le script de données de test :
```bash
mysql -u root -p bibliotheque_ucad < donnees-test.sql
```

### 3️⃣ Configurer la connexion MySQL

Éditez `src/main/resources/META-INF/persistence.xml` :

```xml
<property name="javax.persistence.jdbc.user" value="VOTRE_USER"/>
<property name="javax.persistence.jdbc.password" value="VOTRE_PASSWORD"/>
```

### 4️⃣ Compiler le projet

```bash
mvn clean package
```

### 5️⃣ Déployer sur Tomcat

**Option 1 : Via Eclipse**
1. Clic droit sur le projet → **Run As → Run on Server**
2. Sélectionnez **Tomcat v9.0**
3. Cliquez **Finish**

**Option 2 : Manuellement**
```bash
cp target/sunubibliotek-cyberboys.war $TOMCAT_HOME/webapps/
```

### 6️⃣ Accéder à l'application

Ouvrez votre navigateur : 
```
http://localhost:8080/sunubibliotek-cyberboys/
```

---

## 🔑 Comptes de Démonstration

Après l'installation, connectez-vous avec :

| Rôle | Email | Mot de passe | Permissions |
|------|-------|--------------|-------------|
| **👨‍💼 Admin** | admin@bibliotek.sn | admin123 | Tout gérer |
| **👩‍💼 Bibliothécaire** | biblio@bibliotek.sn | biblio123 | Documents + Emprunts |
| **👤 Lecteur** | lecteur@bibliotek.sn | lecteur123 | Consultation + Ses emprunts |

---

## 📁 Structure du Projet

```
Sunu-Bibliotek/
├── src/main/java/
│   └── sn/ucad/m1/sunubibliotek/Cyberboys/
│       ├── entities/          # 11 entités JPA
│       ├── dao/               # 6 DAO
│       ├── services/          # 6 Services métier
│       ├── controllers/       # 9 Servlets
│       ├── filters/           # 2 Filtres de sécurité
│       └── utils/             # Utilitaires
├── src/main/resources/
│   └── META-INF/
│       └── persistence.xml    # Configuration JPA
├── src/main/webapp/
│   ├── index.jsp
│   └── WEB-INF/
│       ├── web.xml
│       └── pages/             # 20+ pages JSP
├── .github/
│   └── workflows/
│       └── maven.yml          # CI/CD GitHub Actions
├── .gitignore
├── pom.xml
├── donnees-test.sql
└── README.md
```

---

## 📊 Diagramme de Classes (Simplifié)

```
Document (abstract)
├── Livre
├── Revue
└── Dictionnaire

Utilisateur
├── TypeUtilisateur (enum)
└── Role (enum)

Emprunt
├── StatutEmprunt (enum)
└── Relations: Utilisateur ←→ Document

Reservation
├── StatutReservation (enum)
└── Relations: Utilisateur ←→ Document

Categorie
└── Relation OneToMany avec Document
```

---

## 🎯 Règles Métier

### Emprunts
- **Durée** : 14 jours
- **Pénalité** : 100 FCFA/jour de retard
- **Limites par type** :
  - Étudiants : 3 emprunts max
  - Enseignants : 10 emprunts max
  - Personnel : 5 emprunts max
  - Externes : 2 emprunts max

### Réservations
- **Durée de validité** : 7 jours
- Uniquement pour documents non disponibles

---

## 🔧 Configuration CI/CD

Le projet utilise **GitHub Actions** pour l'intégration continue :

- ✅ Compilation automatique à chaque push
- ✅ Exécution des tests
- ✅ Création du fichier WAR
- ✅ Badge de statut sur le README

Voir le fichier `.github/workflows/maven.yml` pour plus de détails.

---

## 📊 API / Endpoints

| Servlet | URL | Méthodes | Description |
|---------|-----|----------|-------------|
| LoginServlet | `/login` | GET, POST | Authentification |
| DashboardServlet | `/dashboard` | GET | Tableaux de bord |
| DocumentServlet | `/documents` | GET, POST | CRUD documents |
| UtilisateurServlet | `/utilisateurs` | GET, POST | CRUD utilisateurs |
| EmpruntServlet | `/emprunts` | GET, POST | Gestion emprunts |
| ReservationServlet | `/reservations` | GET, POST | Gestion réservations |
| CategorieServlet | `/categories` | GET, POST | CRUD catégories |
| StatistiqueServlet | `/statistiques` | GET | Statistiques |
| LogoutServlet | `/logout` | GET | Déconnexion |

---

## 🧪 Tests

```bash
# Exécuter les tests
mvn test

# Rapport de couverture (si configuré)
mvn jacoco:report
```

---

## 🐛 Dépannage

### Problème : Les tables ne sont pas créées

**Solution** : Vérifiez `hibernate.hbm2ddl.auto=update` dans `persistence.xml`.

### Problème : Erreur de connexion MySQL

**Solution** : Vérifiez que MySQL est démarré et que les identifiants sont corrects.

### Problème : Page blanche après login

**Solution** : Exécutez le script `donnees-test.sql` pour créer des données de test.

### Problème : Caractères accentués mal affichés

**Solution** : Vérifiez l'encodage UTF-8 dans `persistence.xml` et `web.xml`.

---

## 📈 Améliorations Futures

- [ ] Module Historique/Audit complet
- [ ] Notifications par email
- [ ] Export PDF/Excel des rapports
- [ ] Code-barres/QR codes
- [ ] API REST pour application mobile
- [ ] Dashboard temps réel (WebSockets)
- [ ] Support multilingue (i18n)
- [ ] Hashage BCrypt pour mots de passe
- [ ] Pagination des listes
- [ ] Recherche avancée avec filtres

---

## 👥 Contributeurs

**Cyberboys Team**  
Master 1 Informatique - UCAD  
📧 Contact : ousmane.deme@ucad.edu.sn

---

## 📄 Licence

Ce projet est développé dans un cadre académique à l'Université Cheikh Anta Diop de Dakar (UCAD).

---

## 🙏 Remerciements

- Équipe pédagogique M1 Informatique UCAD
- Communauté Hibernate et JPA
- Apache Software Foundation (Tomcat)
- MySQL Community
- GitHub pour l'hébergement

---

## 📞 Support

Pour toute question ou problème :
- 📧 Email : ousmane.deme@ucad.edu.sn
- 🐛 Issues GitHub : [Ouvrir une issue](https://github.com/Alkashi1618/Sunu-Bibliotek/issues)

---

**⭐ Si ce projet vous plaît, n'hésitez pas à lui donner une étoile !**

**Fait avec ❤️ à Dakar, Sénégal 🇸🇳**
