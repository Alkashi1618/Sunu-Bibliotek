<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="sn.ucad.m1.sunubibliotek.Cyberboys.entities.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Modifier un Document - Sunu Bibliotek</title>
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
            padding: 20px;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            border-radius: 15px;
            padding: 40px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }
        h1 {
            color: #333;
            margin-bottom: 10px;
            font-size: 2em;
        }
        .subtitle {
            color: #667eea;
            font-weight: bold;
            margin-bottom: 30px;
        }
        .form-group {
            margin-bottom: 25px;
        }
        label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: 600;
        }
        input[type="text"],
        input[type="number"],
        select {
            width: 100%;
            padding: 12px;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 1em;
            transition: border-color 0.3s;
        }
        input:focus, select:focus {
            outline: none;
            border-color: #667eea;
        }
        .btn {
            padding: 12px 30px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 1em;
            font-weight: 600;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s ease;
        }
        .btn-primary {
            background: #667eea;
            color: white;
        }
        .btn-primary:hover {
            background: #5568d3;
            transform: translateY(-2px);
        }
        .btn-secondary {
            background: #cbd5e0;
            color: #2d3748;
            margin-left: 10px;
        }
        .btn-secondary:hover {
            background: #a0aec0;
        }
        .badge {
            display: inline-block;
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 0.9em;
            font-weight: 600;
            margin-bottom: 20px;
        }
        .badge-livre {
            background: #bee3f8;
            color: #2c5282;
        }
        .badge-revue {
            background: #fbd38d;
            color: #744210;
        }
        .badge-dictionnaire {
            background: #c6f6d5;
            color: #22543d;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Modifier un Document</h1>
        <div class="subtitle">Sunu Bibliotek - Cyberboys</div>
        
        <%
            Document document = (Document) request.getAttribute("document");
            boolean isLivre = document instanceof Livre;
            boolean isRevue = document instanceof Revue;
            boolean isDictionnaire = document instanceof Dictionnaire;
        %>
        
        <% if (isLivre) { %>
            <span class="badge badge-livre">Livre</span>
        <% } else if (isRevue) { %>
            <span class="badge badge-revue">Revue</span>
        <% } else { %>
            <span class="badge badge-dictionnaire">Dictionnaire</span>
        <% } %>
        
        <form action="${pageContext.request.contextPath}/documents" method="post">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="id" value="<%= document.getNumEnreg() %>">
            
            <div class="form-group">
                <label for="titre">Titre *</label>
                <input type="text" id="titre" name="titre" required 
                       value="<%= document.getTitre() %>">
            </div>
            
            <!-- Champs pour Livre -->
            <% if (isLivre) {
                Livre livre = (Livre) document;
            %>
                <div class="form-group">
                    <label for="auteur">Auteur *</label>
                    <input type="text" id="auteur" name="auteur" 
                           value="<%= livre.getAuteur() %>" required>
                </div>
                <div class="form-group">
                    <label for="nbrPages">Nombre de pages *</label>
                    <input type="number" id="nbrPages" name="nbrPages" min="1"
                           value="<%= livre.getNbrPages() %>" required>
                </div>
            <% } %>
            
            <!-- Champs pour Revue -->
            <% if (isRevue) {
                Revue revue = (Revue) document;
                int moisActuel = revue.getMois();
            %>
                <div class="form-group">
                    <label for="mois">Mois *</label>
                    <select id="mois" name="mois" required>
                        <option value="1" <%= moisActuel == 1 ? "selected" : "" %>>Janvier</option>
                        <option value="2" <%= moisActuel == 2 ? "selected" : "" %>>Février</option>
                        <option value="3" <%= moisActuel == 3 ? "selected" : "" %>>Mars</option>
                        <option value="4" <%= moisActuel == 4 ? "selected" : "" %>>Avril</option>
                        <option value="5" <%= moisActuel == 5 ? "selected" : "" %>>Mai</option>
                        <option value="6" <%= moisActuel == 6 ? "selected" : "" %>>Juin</option>
                        <option value="7" <%= moisActuel == 7 ? "selected" : "" %>>Juillet</option>
                        <option value="8" <%= moisActuel == 8 ? "selected" : "" %>>Août</option>
                        <option value="9" <%= moisActuel == 9 ? "selected" : "" %>>Septembre</option>
                        <option value="10" <%= moisActuel == 10 ? "selected" : "" %>>Octobre</option>
                        <option value="11" <%= moisActuel == 11 ? "selected" : "" %>>Novembre</option>
                        <option value="12" <%= moisActuel == 12 ? "selected" : "" %>>Décembre</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="annee">Année *</label>
                    <input type="number" id="annee" name="annee" min="1900" max="2100"
                           value="<%= revue.getAnnee() %>" required>
                </div>
            <% } %>
            
            <!-- Champs pour Dictionnaire -->
            <% if (isDictionnaire) {
                Dictionnaire dico = (Dictionnaire) document;
            %>
                <div class="form-group">
                    <label for="langue">Langue *</label>
                    <input type="text" id="langue" name="langue" 
                           value="<%= dico.getLangue() %>" required>
                </div>
            <% } %>
            
            <div style="margin-top: 30px;">
                <button type="submit" class="btn btn-primary">Enregistrer</button>
                <a href="${pageContext.request.contextPath}/documents" 
                   class="btn btn-secondary">Annuler</a>
            </div>
        </form>
    </div>
</body>
</html>