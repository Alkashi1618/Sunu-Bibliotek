<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="sn.ucad.m1.sunubibliotek.Cyberboys.entities.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Utilisateurs - Sunu Bibliotek</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f7fafc;
            min-height: 100vh;
        }
        .container {
            max-width: 1400px;
            margin: 30px auto;
            padding: 0 40px;
        }
        .page-header {
            background: white;
            border-radius: 12px;
            padding: 25px;
            margin-bottom: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        .page-header h1 {
            color: #2d3748;
            font-size: 2em;
            margin-bottom: 10px;
        }
        .stats {
            color: #718096;
            font-size: 1.1em;
        }
        .actions-bar {
            display: flex;
            gap: 15px;
            margin-bottom: 25px;
            flex-wrap: wrap;
        }
        .search-box {
            flex: 1;
            display: flex;
            gap: 10px;
        }
        .search-box input {
            flex: 1;
            padding: 12px;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 1em;
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
        }
        .btn-edit {
            background: #48bb78;
            color: white;
            padding: 8px 15px;
            font-size: 0.9em;
        }
        .btn-danger {
            background: #f56565;
            color: white;
            padding: 8px 15px;
            font-size: 0.9em;
        }
        .btn-info {
            background: #4299e1;
            color: white;
            padding: 8px 15px;
            font-size: 0.9em;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        th {
            background: #667eea;
            color: white;
            padding: 15px;
            text-align: left;
            font-weight: 600;
        }
        td {
            padding: 15px;
            border-bottom: 1px solid #e2e8f0;
        }
        tr:hover {
            background: #f7fafc;
        }
        .badge {
            display: inline-block;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 0.85em;
            font-weight: 600;
        }
        .badge-etudiant {
            background: #bee3f8;
            color: #2c5282;
        }
        .badge-enseignant {
            background: #c6f6d5;
            color: #22543d;
        }
        .badge-personnel {
            background: #fbd38d;
            color: #744210;
        }
        .badge-externe {
            background: #fed7d7;
            color: #742a2a;
        }
        .badge-admin {
            background: #fc8181;
            color: #742a2a;
        }
        .badge-bibliothecaire {
            background: #9ae6b4;
            color: #22543d;
        }
        .badge-lecteur {
            background: #90cdf4;
            color: #2c5282;
        }
        .status-actif {
            color: #38a169;
            font-weight: bold;
        }
        .status-inactif {
            color: #e53e3e;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <!-- Include Menu -->
    <jsp:include page="menu.jsp" />
    
    <div class="container">
        <div class="page-header">
            <h1>👥 Gestion des Utilisateurs</h1>
            <div class="stats">
                Total: <strong><c:out value="${count}"/></strong> utilisateur(s)
            </div>
        </div>

        <div class="actions-bar">
            <form action="${pageContext.request.contextPath}/utilisateurs" method="get" class="search-box">
                <input type="hidden" name="action" value="search">
                <input type="text" name="nom" placeholder="Rechercher par nom ou prénom..." 
                       value="<c:out value='${searchTerm}'/>">
                <button type="submit" class="btn btn-primary">🔍 Rechercher</button>
                <a href="${pageContext.request.contextPath}/utilisateurs" class="btn btn-primary">
                    Tout afficher
                </a>
            </form>
            <a href="${pageContext.request.contextPath}/utilisateurs?action=add" class="btn btn-primary">
                ➕ Nouvel utilisateur
            </a>
        </div>

        <table>
            <thead>
                <tr>
                    <th>N° Carte</th>
                    <th>Nom Complet</th>
                    <th>Email</th>
                    <th>Type</th>
                    <th>Rôle</th>
                    <th>Statut</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${utilisateurs}" var="user">
                    <%
                        Utilisateur user = (Utilisateur) pageContext.getAttribute("user");
                        TypeUtilisateur type = user.getTypeUtilisateur();
                        Role role = user.getRole();
                        String typeBadge = "";
                        switch(type) {
                            case ETUDIANT: typeBadge = "badge-etudiant"; break;
                            case ENSEIGNANT: typeBadge = "badge-enseignant"; break;
                            case PERSONNEL: typeBadge = "badge-personnel"; break;
                            case EXTERNE: typeBadge = "badge-externe"; break;
                        }
                        String roleBadge = "";
                        switch(role) {
                            case ADMIN: roleBadge = "badge-admin"; break;
                            case BIBLIOTHECAIRE: roleBadge = "badge-bibliothecaire"; break;
                            case LECTEUR: roleBadge = "badge-lecteur"; break;
                        }
                    %>
                    <tr>
                        <td><strong><%= user.getNumeroCarte() %></strong></td>
                        <td><%= user.getNomComplet() %></td>
                        <td><%= user.getEmail() %></td>
                        <td><span class="badge <%= typeBadge %>"><%= type.getLibelle() %></span></td>
                        <td><span class="badge <%= roleBadge %>"><%= role.getLibelle() %></span></td>
                        <td>
                            <% if (user.getActif()) { %>
                                <span class="status-actif">✓ Actif</span>
                            <% } else { %>
                                <span class="status-inactif">✗ Inactif</span>
                            <% } %>
                        </td>
                        <td>
                            <a href="${pageContext.request.contextPath}/utilisateurs?action=details&id=<%= user.getId() %>" 
                               class="btn btn-info">Détails</a>
                            <a href="${pageContext.request.contextPath}/utilisateurs?action=edit&id=<%= user.getId() %>" 
                               class="btn btn-edit">Modifier</a>
                            <a href="${pageContext.request.contextPath}/utilisateurs?action=delete&id=<%= user.getId() %>" 
                               class="btn btn-danger"
                               onclick="return confirm('Supprimer cet utilisateur ?')">
                               Supprimer
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>