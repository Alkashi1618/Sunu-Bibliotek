<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="sn.ucad.m1.sunubibliotek.Cyberboys.entities.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Liste des Utilisateurs - Sunu Bibliotek</title>
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
            max-width: 1400px;
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
        .btn-secondary {
            background: #718096;
            color: white;
        }
        .btn-secondary:hover {
            background: #4a5568;
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
        .btn-edit {
            background: #48bb78;
            color: white;
            padding: 8px 15px;
            font-size: 0.9em;
        }
        .btn-edit:hover {
            background: #38a169;
        }
        .btn-info {
            background: #4299e1;
            color: white;
            padding: 8px 15px;
            font-size: 0.9em;
        }
        .btn-info:hover {
            background: #3182ce;
        }
        .search-box {
            display: flex;
            gap: 10px;
            margin-bottom: 30px;
        }
        .search-box input {
            flex: 1;
            padding: 12px;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 1em;
        }
        .search-box input:focus {
            outline: none;
            border-color: #667eea;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
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
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #a0aec0;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Gestion des Utilisateurs</h1>
        <div class="subtitle">Sunu Bibliotek - Cyberboys</div>
        <div class="stats">
            Total: <strong><c:out value="${count}"/></strong> utilisateur(s)
        </div>

        <div class="nav-buttons">
            <a href="${pageContext.request.contextPath}/utilisateurs?action=add" class="btn btn-primary">
                Ajouter un utilisateur
            </a>
            <a href="${pageContext.request.contextPath}/documents" class="btn btn-secondary">
                Retour aux documents
            </a>
        </div>

        <form action="${pageContext.request.contextPath}/utilisateurs" method="get" class="search-box">
            <input type="hidden" name="action" value="search">
            <input type="text" name="nom" placeholder="Rechercher par nom ou prénom..." 
                   value="<c:out value='${searchTerm}'/>">
            <button type="submit" class="btn btn-primary">Rechercher</button>
            <a href="${pageContext.request.contextPath}/utilisateurs" class="btn btn-primary">
                Tout afficher
            </a>
        </form>

        <c:choose>
            <c:when test="${empty utilisateurs}">
                <div class="empty-state">
                    <div style="font-size: 4em;">👥</div>
                    <h2>Aucun utilisateur trouvé</h2>
                    <p>Commencez par ajouter votre premier utilisateur</p>
                </div>
            </c:when>
            <c:otherwise>
                <table>
                    <thead>
                        <tr>
                            <th>Numero Carte</th>
                            <th>Nom Complet</th>
                            <th>Email</th>
                            <th>Type</th>
                            <th>Role</th>
                            <th>Statut</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${utilisateurs}" var="user">
                            <tr>
                                <td><strong><c:out value="${user.numeroCarte}"/></strong></td>
                                <td><c:out value="${user.nomComplet}"/></td>
                                <td><c:out value="${user.email}"/></td>
                                <td>
                                    <%
                                        Utilisateur user = (Utilisateur) pageContext.getAttribute("user");
                                        TypeUtilisateur type = user.getTypeUtilisateur();
                                        String badgeClass = "";
                                        switch(type) {
                                            case ETUDIANT: badgeClass = "badge-etudiant"; break;
                                            case ENSEIGNANT: badgeClass = "badge-enseignant"; break;
                                            case PERSONNEL: badgeClass = "badge-personnel"; break;
                                            case EXTERNE: badgeClass = "badge-externe"; break;
                                        }
                                    %>
                                    <span class="badge <%= badgeClass %>"><%= type.getLibelle() %></span>
                                </td>
                                <td>
                                    <%
                                        Role role = user.getRole();
                                        String roleBadgeClass = "";
                                        switch(role) {
                                            case ADMIN: roleBadgeClass = "badge-admin"; break;
                                            case BIBLIOTHECAIRE: roleBadgeClass = "badge-bibliothecaire"; break;
                                            case LECTEUR: roleBadgeClass = "badge-lecteur"; break;
                                        }
                                    %>
                                    <span class="badge <%= roleBadgeClass %>"><%= role.getLibelle() %></span>
                                </td>
                                <td>
                                    <%
                                        if (user.getActif()) {
                                    %>
                                        <span class="status-actif">Actif</span>
                                    <%
                                        } else {
                                    %>
                                        <span class="status-inactif">Inactif</span>
                                    <%
                                        }
                                    %>
                                </td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/utilisateurs?action=details&id=${user.id}" 
                                       class="btn btn-info">Détails</a>
                                    <a href="${pageContext.request.contextPath}/utilisateurs?action=edit&id=${user.id}" 
                                       class="btn btn-edit">Modifier</a>
                                    <a href="${pageContext.request.contextPath}/utilisateurs?action=delete&id=${user.id}" 
                                       class="btn btn-danger"
                                       onclick="return confirm('Voulez-vous vraiment supprimer cet utilisateur ?')">
                                       Supprimer
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>