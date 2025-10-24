<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard Bibliothécaire - Sunu Bibliotek</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f7fa;
        }
        
        .navbar {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .navbar-brand {
            font-size: 1.5em;
            font-weight: bold;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .navbar-menu {
            display: flex;
            gap: 20px;
            align-items: center;
        }
        
        .nav-link {
            color: white;
            text-decoration: none;
            padding: 8px 16px;
            border-radius: 8px;
            transition: all 0.3s;
        }
        
        .nav-link:hover {
            background: rgba(255,255,255,0.2);
        }
        
        .nav-user {
            display: flex;
            align-items: center;
            gap: 15px;
            padding-left: 20px;
            border-left: 1px solid rgba(255,255,255,0.3);
        }
        
        .container {
            max-width: 1400px;
            margin: 30px auto;
            padding: 0 30px;
        }
        
        .page-header {
            margin-bottom: 30px;
        }
        
        .page-header h1 {
            color: #333;
            font-size: 2em;
            margin-bottom: 10px;
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .stat-card {
            background: white;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
            transition: transform 0.3s;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
        }
        
        .stat-icon {
            font-size: 2.5em;
            margin-bottom: 15px;
        }
        
        .stat-value {
            font-size: 2.5em;
            font-weight: bold;
            color: #333;
        }
        
        .stat-label {
            color: #666;
            font-size: 0.95em;
        }
        
        .card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
            margin-bottom: 20px;
        }
        
        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 2px solid #f5f7fa;
        }
        
        .card-title {
            font-size: 1.3em;
            color: #333;
            font-weight: 600;
        }
        
        .btn {
            padding: 8px 16px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            text-decoration: none;
            font-size: 0.9em;
            font-weight: 600;
            transition: all 0.3s;
            display: inline-block;
        }
        
        .btn-primary {
            background: #667eea;
            color: white;
        }
        
        .btn-primary:hover {
            background: #5568d3;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
        }
        
        th {
            background: #f5f7fa;
            padding: 12px;
            text-align: left;
            font-weight: 600;
            color: #333;
            font-size: 0.9em;
        }
        
        td {
            padding: 12px;
            border-bottom: 1px solid #f5f7fa;
            color: #666;
        }
        
        tr:hover {
            background: #fafbfc;
        }
        
        .badge {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 12px;
            font-size: 0.85em;
            font-weight: 600;
        }
        
        .badge-success {
            background: #c6f6d5;
            color: #22543d;
        }
        
        .badge-danger {
            background: #fed7d7;
            color: #742a2a;
        }
        
        .alert-box {
            padding: 15px;
            background: #fff5f5;
            border-left: 4px solid #f56565;
            border-radius: 8px;
            margin-bottom: 10px;
        }
        
        .alert-title {
            font-weight: 600;
            color: #c53030;
            margin-bottom: 5px;
        }
        
        .alert-text {
            font-size: 0.9em;
            color: #666;
        }
    </style>
</head>
<body>
    <nav class="navbar">
        <div class="navbar-brand">
            <span>📚</span>
            <span>Sunu Bibliotek</span>
        </div>
        <div class="navbar-menu">
            <a href="${pageContext.request.contextPath}/dashboard" class="nav-link">
                🏠 Dashboard
            </a>
            <a href="${pageContext.request.contextPath}/documents" class="nav-link">
                📖 Documents
            </a>
            <a href="${pageContext.request.contextPath}/emprunts" class="nav-link">
                🔄 Emprunts
            </a>
            <div class="nav-user">
                <div style="text-align: right;">
                    <div style="font-weight: 600;">${sessionScope.userNom}</div>
                    <div style="font-size: 0.85em; opacity: 0.9;">👩‍💼 Bibliothécaire</div>
                </div>
                <a href="${pageContext.request.contextPath}/auth?action=logout" class="nav-link">
                    🚪 Déconnexion
                </a>
            </div>
        </div>
    </nav>

    <div class="container">
        <div class="page-header">
            <h1>👩‍💼 Dashboard Bibliothécaire</h1>
            <p>Gestion des documents et emprunts</p>
        </div>

        <div class="stats-grid">
            <div class="stat-card" style="border-left: 4px solid #667eea;">
                <div class="stat-icon">📚</div>
                <div class="stat-value">${totalDocuments}</div>
                <div class="stat-label">Documents au catalogue</div>
            </div>
            
            <div class="stat-card" style="border-left: 4px solid #48bb78;">
                <div class="stat-icon">🔄</div>
                <div class="stat-value">${empruntsEnCours}</div>
                <div class="stat-label">Emprunts en cours</div>
            </div>
            
            <div class="stat-card" style="border-left: 4px solid #f56565;">
                <div class="stat-icon">⚠️</div>
                <div class="stat-value">${empruntsEnRetard}</div>
                <div class="stat-label">Emprunts en retard</div>
            </div>
        </div>

        <!-- Emprunts en retard -->
        <c:if test="${not empty empruntsRetard}">
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">⚠️ Emprunts en retard - Action requise</h2>
                </div>
                
                <c:forEach items="${empruntsRetard}" var="emprunt">
                    <div class="alert-box">
                        <div class="alert-title">
                            ${emprunt.utilisateur.nomComplet} - ${emprunt.joursRetard} jour(s) de retard
                        </div>
                        <div class="alert-text">
                            Document: ${emprunt.document.titre}<br>
                            Retour prévu: ${emprunt.dateRetourPrevue}
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:if>

        <!-- Emprunts en cours -->
        <div class="card">
            <div class="card-header">
                <h2 class="card-title">📋 Emprunts en cours</h2>
                <a href="${pageContext.request.contextPath}/emprunts?action=add" class="btn btn-primary">
                    ➕ Nouvel emprunt
                </a>
            </div>
            
            <c:choose>
                <c:when test="${empty empruntsRecents}">
                    <div style="text-align: center; padding: 40px; color: #999;">
                        <div style="font-size: 3em; margin-bottom: 10px;">📭</div>
                        <p>Aucun emprunt en cours</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <table>
                        <thead>
                            <tr>
                                <th>Lecteur</th>
                                <th>Document</th>
                                <th>Date emprunt</th>
                                <th>Retour prévu</th>
                                <th>Statut</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${empruntsRecents}" var="emprunt">
                                <tr>
                                    <td>${emprunt.utilisateur.nomComplet}</td>
                                    <td>${emprunt.document.titre}</td>
                                    <td>${emprunt.dateEmprunt}</td>
                                    <td>${emprunt.dateRetourPrevue}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${emprunt.isEnRetard()}">
                                                <span class="badge badge-danger">En retard</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-success">En cours</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/emprunts?action=retour&id=${emprunt.id}" 
                                           class="btn btn-primary" style="font-size: 0.85em; padding: 6px 12px;">
                                            ✅ Retour
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Actions rapides -->
        <div class="card">
            <div class="card-header">
                <h2 class="card-title">⚡ Actions rapides</h2>
            </div>
            
            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 15px;">
                <a href="${pageContext.request.contextPath}/documents?action=add" class="btn btn-primary" 
                   style="padding: 15px; text-align: center;">
                    ➕ Ajouter un document
                </a>
                <a href="${pageContext.request.contextPath}/emprunts?action=add" class="btn btn-primary"
                   style="padding: 15px; text-align: center;">
                    📤 Nouvel emprunt
                </a>
                <a href="${pageContext.request.contextPath}/documents" class="btn btn-primary"
                   style="padding: 15px; text-align: center;">
                    📚 Voir tous les documents
                </a>
            </div>
        </div>
    </div>
</body>
</html>