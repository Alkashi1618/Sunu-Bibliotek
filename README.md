# 📚 Bibliothèque UCAD - Système de Gestion

Application JEE de gestion de bibliothèque développée avec **Java EE**, **JPA/Hibernate**, et **MySQL**, déployée sur **Apache Tomcat**.

## 📸 Aperçu

Application web permettant de gérer les documents d'une bibliothèque universitaire :
- 📖 **Livres** (avec auteur et nombre de pages)
- 📰 **Revues** (avec mois et année de publication)
- 📕 **Dictionnaires** (avec langue)

## ✨ Fonctionnalités

- ✅ CRUD complet (Créer, Lire, Modifier, Supprimer)
- ✅ Recherche de documents par titre
- ✅ Interface web moderne et responsive
- ✅ Gestion de l'héritage avec JPA (stratégie JOINED)
- ✅ Persistance des données dans MySQL
- ✅ Architecture en couches professionnelle

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

### Base de Données
- **MySQL 8.0**
- **C3P0** (Connection Pool)

### Outils
- **Maven 3.6+** (Gestion des dépendances)
- **Apache Tomcat 9.x** (Serveur d'application)
- **Eclipse IDE**

## 📋 Prérequis

- ☕ **JDK 11** ou supérieur
- 🗄️ **MySQL 8.0** ou supérieur
- 🐱 **Apache Tomcat 9.x**
- 📦 **Maven 3.6+**
- 💻 **Eclipse IDE** (avec plugins Maven et Tomcat)

## 🚀 Installation

### 1. Cloner le projet

```bash
git clone https://github.com/votre-username/bibliotheque-jee.git
cd bibliotheque-jee
```

### 2. Créer la base de données

```sql
CREATE DATABASE bibliotheque_ucad CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

Ou exécutez le script fourni :
```bash
mysql -u root -p < setup-database.sql
```

### 3. Configurer la connexion MySQL

Éditez `src/main/resources/META-INF/persistence.xml` :

```xml
<property name="javax.persistence.jdbc.url" 
          value="jdbc:mysql://localhost:3306/bibliotheque_ucad?useUnicode=true&amp;characterEncoding=UTF-8&amp;serverTimezone=UTC"/>
<property name="javax.persistence.jdbc.user" value="VOTRE_USER"/>
<property name="javax.persistence.jdbc.password" value="VOTRE_PASSWORD"/>
```

### 4. Compiler le projet

```bash
mvn clean package
```

### 5. Déployer sur Tomcat

#### Option 1 : Via Eclipse
1. Clic droit sur le projet → **Run As → Run on Server**
2. Sélectionnez **Tomcat v9.0**
3. Cliquez **Finish**

#### Option 2 : Manuellement
```bash
cp target/bibliotheque-ucad.war $TOMCAT_HOME/webapps/
```

### 6. Accéder à l'application

Ouvrez votre navigateur : **http://localhost:8080/bibliotheque-ucad/**

## 📁 Structure du Projet

```
bibliotheque-jee/
├── src/main/java/
│   └── sn/ucad/m1/soir/OusmaneDEME/
│       ├── entities/          # Entités JPA
│       ├── dao/               # Data Access Objects
│       ├── services/          # Couche métier
│       ├── controllers/       # Servlets
│       └── utils/             # Classes utilitaires
├── src/main/resources/
│   └── META-INF/
│       └── persistence.xml    # Configuration JPA
├── src/main/webapp/
│   ├── index.jsp
│   └── WEB-INF/
│       ├── web.xml
│       └── pages/             # Vues JSP
└── pom.xml                    # Configuration Maven
```

## 🗄️ Modèle de Données

### Entités JPA

```
Document (abstract)
├── numEnreg : Long (PK)
├── titre : String
└── version : Long

Livre extends Document
├── auteur : String
└── nbrPages : Integer

Revue extends Document
├── mois : Integer
└── annee : Integer

Dictionnaire extends Document
└── langue : String
```

### Stratégie d'héritage : JOINED

- Table `documents` : Contient les attributs communs
- Tables `livres`, `revues`, `dictionnaires` : Contiennent les attributs spécifiques
- Jointure via clé étrangère `num_enreg`

## 🎯 Utilisation

### Ajouter un document

1. Cliquez sur **"➕ Ajouter un document"**
2. Sélectionnez le type (Livre, Revue ou Dictionnaire)
3. Remplissez le formulaire
4. Cliquez sur **"✅ Enregistrer"**

### Rechercher un document

1. Utilisez la barre de recherche en haut de la liste
2. Entrez un titre (partiel ou complet)
3. Cliquez sur **"🔍 Rechercher"**

### Modifier un document

1. Cliquez sur **"✏️ Modifier"** dans la ligne du document
2. Modifiez les informations
3. Cliquez sur **"✅ Enregistrer"**

### Supprimer un document

1. Cliquez sur **"🗑️ Supprimer"** dans la ligne du document
2. Confirmez la suppression

## 📊 API / Endpoints

| Méthode | URL | Action |
|---------|-----|--------|
| GET | `/documents` | Liste tous les documents |
| GET | `/documents?action=add` | Affiche le formulaire d'ajout |
| POST | `/documents?action=create` | Crée un nouveau document |
| GET | `/documents?action=edit&id={id}` | Affiche le formulaire de modification |
| POST | `/documents?action=update` | Modifie un document |
| GET | `/documents?action=delete&id={id}` | Supprime un document |
| GET | `/documents?action=search&titre={titre}` | Recherche par titre |

## 🔧 Configuration

### persistence.xml

```xml
<persistence-unit name="bibliothequePU" transaction-type="RESOURCE_LOCAL">
    <!-- Configuration JPA pour Tomcat -->
    <property name="hibernate.hbm2ddl.auto" value="update"/>
    <property name="hibernate.show_sql" value="true"/>
    <property name="hibernate.dialect" value="org.hibernate.dialect.MySQL8Dialect"/>
</persistence-unit>
```

### web.xml

```xml
<!-- Filtre d'encodage UTF-8 -->
<filter>
    <filter-name>encodingFilter</filter-name>
    <filter-class>org.apache.catalina.filters.SetCharacterEncodingFilter</filter-class>
    <init-param>
        <param-name>encoding</param-name>
        <param-value>UTF-8</param-value>
    </init-param>
</filter>
```

## 🧪 Tests

### Données de test

Après le premier démarrage (quand Hibernate a créé les tables), vous pouvez insérer des données de test :

```sql
-- Voir le fichier setup-database.sql pour plus de détails
INSERT INTO documents (dtype, titre, version) VALUES ('Livre', 'Le Pagne Noir', 0);
-- ...
```

## 🐛 Dépannage

### Problème : Erreur de connexion MySQL

**Solution** : Vérifiez que MySQL est démarré et que les identifiants dans `persistence.xml` sont corrects.

### Problème : Les tables ne sont pas créées

**Solution** : Vérifiez `hibernate.hbm2ddl.auto=update` dans `persistence.xml`.

### Problème : Erreur 404

**Solution** : Vérifiez l'URL et que l'application est bien déployée sur Tomcat.

### Problème : Caractères accentués mal affichés

**Solution** : Vérifiez l'encodage UTF-8 dans `persistence.xml` et `web.xml`.

## 📈 Améliorations Futures

- [ ] Authentification et gestion des utilisateurs
- [ ] Gestion des emprunts et retours
- [ ] Pagination de la liste des documents
- [ ] Upload d'images de couverture
- [ ] Export PDF et Excel
- [ ] API REST
- [ ] Dashboard avec statistiques
- [ ] Notifications par email
- [ ] Support multilingue (i18n)

## 👥 Auteur

**Ousmane DEME**  
Master 1 Informatique - UCAD  
📧 ousmane.deme@ucad.edu.sn

## 📄 Licence

Ce projet est développé dans un cadre académique à l'Université Cheikh Anta Diop de Dakar (UCAD).

## 🙏 Remerciements

- Équipe pédagogique M1 Informatique UCAD
- Communauté Hibernate et JPA
- Apache Software Foundation (Tomcat)

---

**Fait avec ❤️ à Dakar, Sénégal 🇸🇳**