<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="sn.ucad.m1.sunubibliotek.Cyberboys.entities.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Documents - Sunu Bibliotek</title>
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
        .search-box input:focus {
            outline: none;
            border-color: #667eea;
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
        .badge-disponible {
            background: #c6f6d5;
            color: #22543d;
        }
        .badge-indisponible {
            background: #fed7d7;
            color: #742a2a;
        }
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #a0aec0;
            background: white;
            border-radius: 12px;
        }
    </style>
</head>
<body>
    <%
        Utilisateur currentUser = (Utilisateur) session.getAttribute("utilisateur");
    %>
    
    <!-- Include Menu -->
    <jsp:include page="menu.jsp" />
    
    <div class="container">
        <div class="page-header">
            <h1>📚 Catalogue des Documents</h1>
            <div class="stats">
                Total: <strong><c:out value="${count}"/></strong> document(s)
            </div>
        </div>

        <div class="actions-bar">
            <form action="${pageContext.request.contextPath}/documents" method="get" class="search-box">
                <input type="hidden" name="action" value="search">
                <input type="text" name="titre" placeholder="Rechercher un document par titre..." 
                       value="<c:out value='${searchTerm}'/>">
                <button type="submit" class="btn btn-primary">🔍 Rechercher</button>
                <a href="${pageContext.request.contextPath}/documents" class="btn btn-primary">
                    Tout afficher
                </a>
            </form>
            <% if (currentUser.estBibliothecaire()) { %>
                <a href="${pageContext.request.contextPath}/documents?action=add" class="btn btn-primary">
                    ➕ Nouveau document
                </a>
            <% } %>
        </div>

        <c:choose>
            <c:when test="${empty documents}">
                <div class="empty-state">
                    <div style="font-size: 4em;">📭</div>
                    <h2>Aucun document trouvé</h2>
                    <p>Aucun document ne correspond à votre recherche</p>
                </div>
            </c:when>
            <c:otherwise>
                <table>
                    <thead>
                        <tr>
                            <th>N°</th>
                            <th>Type</th>
                            <th>Titre</th>
                            <th>Détails</th>
                            <th>Disponibilité</th>
                            <% if (currentUser.estBibliothecaire()) { %>
                                <th>Actions</th>
                            <% } %>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${documents}" var="doc">
                            <%
                                Document doc = (Document) pageContext.getAttribute("doc");
                            %>
                            <tr>
                                <td><strong><%= doc.getNumEnreg() %></strong></td>
                                <td>
                                    <%
                                        if (doc instanceof Livre) {
                                    %>
                                        <span class="badge badge-livre">Livre</span>
                                    <%
                                        } else if (doc instanceof Revue) {
                                    %>
                                        <span class="badge badge-revue">Revue</span>
                                    <%
                                        } else {
                                    %>
                                        <span class="badge badge-dictionnaire">Dictionnaire</span>
                                    <%
                                        }
                                    %>
                                </td>
                                <td><strong><%= doc.getTitre() %></strong></td>
                                <td>
                                    <%
                                        if (doc instanceof Livre) {
                                            Livre livre = (Livre) doc;
                                    %>
                                        Auteur: <%= livre.getAuteur() %> | <%= livre.getNbrPages() %> pages
                                    <%
                                        } else if (doc instanceof Revue) {
                                            Revue revue = (Revue) doc;
                                    %>
                                        <%= revue.getMois() %>/<%= revue.getAnnee() %>
                                    <%
                                        } else {
                                            Dictionnaire dico = (Dictionnaire) doc;
                                    %>
                                        Langue: <%= dico.getLangue() %>
                                    <%
                                        }
                                    %>
                                </td>
                                <td>
                                    <% if (doc.estDisponible()) { %>
                                        <span class="badge badge-disponible">
                                            ✓ <%= doc.getQuantiteDisponible() %>/<%= doc.getQuantiteTotale() %> dispo
                                        </span>
                                    <% } else { %>
                                        <span class="badge badge-indisponible">
                                            ✗ Non disponible
                                        </span>
                                    <% } %>
                                </td>
                                <% if (currentUser.estBibliothecaire()) { %>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/documents?action=edit&id=<%= doc.getNumEnreg() %>" 
                                           class="btn btn-edit">Modifier</a>
                                        <a href="${pageContext.request.contextPath}/documents?action=delete&id=<%= doc.getNumEnreg() %>" 
                                           class="btn btn-danger"
                                           onclick="return confirm('Supprimer ce document ?')">
                                           Supprimer
                                        </a>
                                    </td>
                                <% } %>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>