<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sunu Bibliotek - Liste des Documents</title>
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
        .actions {
            display: flex;
            gap: 15px;
            margin-bottom: 30px;
            flex-wrap: wrap;
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
        }
        .btn-primary {
            background: #667eea;
            color: white;
        }
        .btn-primary:hover {
            background: #5568d3;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
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
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #a0aec0;
        }
        .empty-state i {
            font-size: 4em;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>📚 Sunu Bibliotek</h1>
        <div class="subtitle">Cyberboys Edition</div>
        <div class="stats">
            Total: <strong>${count}</strong> document(s)
        </div>

        <div class="actions">
            <a href="${pageContext.request.contextPath}/documents?action=add" class="btn btn-primary">
                ➕ Ajouter un document
            </a>
        </div>

        <form action="${pageContext.request.contextPath}/documents" method="get" class="search-box">
            <input type="hidden" name="action" value="search">
            <input type="text" name="titre" placeholder="Rechercher par titre..." 
                   value="${searchTerm}">
            <button type="submit" class="btn btn-primary">🔍 Rechercher</button>
            <a href="${pageContext.request.contextPath}/documents" class="btn btn-primary">
                Tout afficher
            </a>
        </form>

        <c:choose>
            <c:when test="${empty documents}">
                <div class="empty-state">
                    <div style="font-size: 4em;">📭</div>
                    <h2>Aucun document trouvé</h2>
                    <p>Commencez par ajouter votre premier document</p>
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
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${documents}" var="doc">
                            <tr>
                                <td>${doc.numEnreg}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${doc.class.simpleName == 'Livre'}">
                                            <span class="badge badge-livre">📖 Livre</span>
                                        </c:when>
                                        <c:when test="${doc.class.simpleName == 'Revue'}">
                                            <span class="badge badge-revue">📰 Revue</span>
                                        </c:when>
                                        <c:when test="${doc.class.simpleName == 'Dictionnaire'}">
                                            <span class="badge badge-dictionnaire">📕 Dictionnaire</span>
                                        </c:when>
                                    </c:choose>
                                </td>
                                <td><strong>${doc.titre}</strong></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${doc.class.simpleName == 'Livre'}">
                                            Auteur: ${doc.auteur} | Pages: ${doc.nbrPages}
                                        </c:when>
                                        <c:when test="${doc.class.simpleName == 'Revue'}">
                                            ${doc.mois}/${doc.annee}
                                        </c:when>
                                        <c:when test="${doc.class.simpleName == 'Dictionnaire'}">
                                            Langue: ${doc.langue}
                                        </c:when>
                                    </c:choose>
                                </td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/documents?action=edit&id=${doc.numEnreg}" 
                                       class="btn btn-edit">✏️ Modifier</a>
                                    <a href="${pageContext.request.contextPath}/documents?action=delete&id=${doc.numEnreg}" 
                                       class="btn btn-danger"
                                       onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce document ?')">
                                       🗑️ Supprimer
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