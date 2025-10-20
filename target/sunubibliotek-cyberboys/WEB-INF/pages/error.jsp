<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Erreur - Sunu Bibliotek</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }
        .container {
            background: white;
            border-radius: 20px;
            padding: 50px;
            max-width: 600px;
            text-align: center;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
        }
        .error-icon {
            font-size: 5em;
            margin-bottom: 20px;
        }
        h1 {
            color: #e53e3e;
            font-size: 2.5em;
            margin-bottom: 20px;
        }
        p {
            color: #666;
            font-size: 1.2em;
            margin-bottom: 30px;
            line-height: 1.6;
        }
        .error-details {
            background: #f7fafc;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 30px;
            text-align: left;
        }
        .error-details strong {
            color: #333;
        }
        .error-details code {
            display: block;
            margin-top: 10px;
            padding: 10px;
            background: white;
            border-radius: 5px;
            color: #e53e3e;
            font-size: 0.9em;
            word-wrap: break-word;
        }
        .btn {
            display: inline-block;
            padding: 15px 40px;
            background: #667eea;
            color: white;
            text-decoration: none;
            border-radius: 10px;
            font-size: 1.1em;
            font-weight: 600;
            transition: all 0.3s ease;
            margin: 5px;
        }
        .btn:hover {
            background: #5568d3;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }
        .btn-secondary {
            background: #718096;
        }
        .btn-secondary:hover {
            background: #4a5568;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="error-icon">⚠️</div>
        <h1>Oups ! Une erreur est survenue</h1>
        
        <% if (request.getAttribute("error") != null) { %>
            <div class="error-details">
                <strong>Message d'erreur :</strong>
                <code><%= request.getAttribute("error") %></code>
            </div>
        <% } else if (exception != null) { %>
            <div class="error-details">
                <strong>Erreur :</strong>
                <code><%= exception.getMessage() %></code>
            </div>
        <% } else { %>
            <p>Nous sommes désolés, une erreur inattendue s'est produite.</p>
        <% } %>
        
        <div>
            <a href="javascript:history.back()" class="btn btn-secondary">
                ← Retour
            </a>
            <a href="${pageContext.request.contextPath}/documents" class="btn">
                🏠 Accueil
            </a>
        </div>
    </div>
</body>
</html>
<!-- ```

---

## 📋 Récapitulatif Final - Structure du Projet Cyberboys
```
cyberboys-bibliotheque/
├── src/main/java/
│   └── sn/ucad/m1/sunubibliotek/Cyberboys/
│       ├── entities/
│       │   ├── Document.java
│       │   ├── Livre.java
│       │   ├── Revue.java
│       │   └── Dictionnaire.java
│       ├── dao/
│       │   └── DocumentDAO.java
│       ├── services/
│       │   └── BibliothequeService.java
│       ├── controllers/
│       │   └── DocumentServlet.java
│       └── utils/
│           ├── JPAUtil.java
│           └── AppContextListener.java
├── src/main/resources/
│   └── META-INF/
│       └── persistence.xml
├── src/main/webapp/
│   ├── index.jsp
│   └── WEB-INF/
│       ├── web.xml
│       └── pages/
│           ├── liste-documents.jsp
│           ├── ajouter-document.jsp
│           └── error.jsp
└── pom.xml -->