<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="sn.ucad.m1.sunubibliotek.Cyberboys.entities.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gestion des Catégories - Sunu Bibliotek</title>
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
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }
        h1 {
            color: #333;
            margin-bottom: 10px;
            font-size: 2.5em;
        }
        .subtitle {
            color: #667eea;
            font-weight: bold;
            margin-bottom: 20px;
        }
        .stats {
            color: #666;
            margin-bottom: 30px;
            font-size: 1.1em;
        }
        .nav-buttons {
            display: flex;
            gap: 15px;
            margin-bottom: 30px;
        }
        .btn {
            padding: 12px 25px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            text-decoration: none;
            font-size: 1em;
            transition: all 0.3s ease;
            font-weight: 600;
            display: inline-block;
        }
        .btn-primary {
            background: #667eea;
            color: white;
        }
        .btn-primary:hover {
            background: #5568d3;
            transform: translateY(-2px);
        }
        .btn-edit {
            background: #48bb78;
            color: white;
            padding: 8px 15px;
            font-size: 0.9em;
        }
        .btn-edit:hover {
            background: #38a169;
        }
        .btn-danger {
            background: #f56565;
            color: white;
            padding: 8px 15px;
            font-size: 0.9em;
        }
        .btn-danger:hover {
            background: #e53e3e;
        }
        .btn-secondary {
            background: #718096;
            color: white;
        }
        .btn-secondary:hover {
            background: #4a5568;
        }
        .categories-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 20px;
            margin-top: 30px;
        }
        .category-card {
            background: white;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            border-left: 5px solid;
            transition: all 0.3s;
        }
        .category-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 20px rgba(0,0,0,0.15);
        }
        .category-header {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 15px;
        }
        .category-icon {
            width: 50px;
            height: 50px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5em;
        }
        .category-info h3 {
            color: #2d3748;
            font-size: 1.2em;
            margin-bottom: 5px;
        }
        .category-code {
            color: #718096;
            font-size: 0.85em;
            font-weight: 600;
        }
        .category-description {
            color: #4a5568;
            margin-bottom: 15px;
            line-height: 1.5;
        }
        .category-stats {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 10px;
            background: #f7fafc;
            border-radius: 8px;
            margin-bottom: 15px;
        }
        .category-stats strong {
            color: #667eea;
        }
        .category-actions {
            display: flex;
            gap: 10px;
        }
        .alert {
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        .alert-success {
            background: #c6f6d5;
            color: #22543d;
            border-left: 4px solid #48bb78;
        }
        .alert-error {
            background: #fed7d7;
            color: #742a2a;
            border-left: 4px solid #e53e3e;
        }
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #a0aec0;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Gestion des Catégories</h1>
        <div class="subtitle">Sunu Bibliotek - Cyberboys</div>
        <div class="stats">
            Total: <strong><c:out value="${count}"/></strong> catégorie(s)
        </div>

        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
            <% session.removeAttribute("success"); %>
        </c:if>
        
        <c:if test="${not empty error}">
            <div class="alert alert-error">${error}</div>
            <% session.removeAttribute("error"); %>
        </c:if>

        <div class="nav-buttons">
            <a href="${pageContext.request.contextPath}/categories?action=add" class="btn btn-primary">
                Ajouter une catégorie
            </a>
            <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-secondary">
                Tableau de bord
            </a>
        </div>

        <c:choose>
            <c:when test="${empty categories}">
                <div class="empty-state">
                    <div style="font-size: 4em;">📁</div>
                    <h2>Aucune catégorie</h2>
                    <p>Commencez par créer votre première catégorie</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="categories-grid">
                    <c:forEach items="${categories}" var="cat">
                        <%
                            Categorie cat = (Categorie) pageContext.getAttribute("cat");
                            String couleur = cat.getCouleur() != null ? cat.getCouleur() : "#667eea";
                        %>
                        <div class="category-card" style="border-left-color: <%= couleur %>;">
                            <div class="category-header">
                                <div class="category-icon" style="background: <%= couleur %>20;">
                                    📚
                                </div>
                                <div class="category-info">
                                    <h3><%= cat.getNom() %></h3>
                                    <div class="category-code"><%= cat.getCode() %></div>
                                </div>
                            </div>
                            
                            <% if (cat.getDescription() != null && !cat.getDescription().isEmpty()) { %>
                                <div class="category-description">
                                    <%= cat.getDescription() %>
                                </div>
                            <% } %>
                            
                            <div class="category-stats">
                                <strong><c:out value="${nbDocs_}"/><%= cat.getId() %></strong> document(s)
                            </div>
                            
                            <div class="category-actions">
                                <a href="${pageContext.request.contextPath}/categories?action=edit&id=<%= cat.getId() %>" 
                                   class="btn btn-edit">Modifier</a>
                                <a href="${pageContext.request.contextPath}/categories?action=delete&id=<%= cat.getId() %>" 
                                   class="btn btn-danger"
                                   onclick="return confirm('Supprimer cette catégorie ?')">
                                   Supprimer
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>