<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard Admin - Sunu Bibliotek</title>
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
        
        /* Navigation */
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
            display: flex;
            align-items: center;
            gap: 5px;
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
        
        .user-info {
            text-align: right;
        }
        
        .user-name {
            font-weight: 600;
        }
        
        .user-role {
            font-size: 0.85em;
            opacity: 0.9;
        }
        
        /* Container */
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
        
        .page-header p {
            color: #666;
        }
        
        /* Stats Cards */
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
            box-shadow: 0 5px 20px rgba(0,0,0,0.12);
        }
        
        .stat-icon {
            font-size: 2.5em;
            margin-bottom: 15px;
        }
        
        .stat-value {
            font-size: 2.5em;
            font-weight: bold;
            color: #333;
            margin-bottom: 5px;
        }
        
        .stat-label {
            color: #666;
            font-size: 0.95em;
        }
        
        .stat-card.primary { border-left: 4px solid #667eea; }
        .stat-card.success { border-left: 4px solid #48bb78; }
        .stat-card.warning { border-left: 4px solid #ed8936; }
        .stat-card.danger { border-left: 4px solid #f56565; }
        .stat-card.info { border-left: 4px solid #4299e1; }
        
        /* Content Grid */
        .content-grid {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
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
        
        /* Table */
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
        
        .badge-warning {
            background: #feebc8;
            color: #744210;
        }
        
        .badge-danger {
            background: #fed7d7;
            color: #742a2a;
        }
        
        .empty-state {
            text-align: center;
            padding: 40px;
            color: #999;
        }
        
        @media (max-width: 1024px) {
            .content-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <!-- Navigation -->
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
            <a href="${pageContext.request.contextPath}/utilisateurs" class="nav-link">
                👥 Utilisateurs
            </a>
            <div class="nav-user">
                <div class="user-info">
                    <div class="user-name">${sessionScope.userNom}</div>
                    <div class="user-role">👨‍💼 Administrateur</div>
                </div>
                <a href="${pageContext.request.contextPath}/auth?action=logout" class="nav-link">
                    🚪 Déconnexion
                </a>
            </div>
        </div>
    </nav>

    <div class="container">
        <div class="page-header">
            <h1>👨‍💼 Dashboard Administrateur</h1>
            <p>Vue d'ensemble du système de gestion de bibliothèque</p>
        </div>

        <!-- Statistiques -->
        <div class="stats-grid">
            <div class="stat-card primary">
                <div class="stat-icon">📚</div>
                <div class="stat-value">${totalDocuments}</div>
                <div class="stat-label">Documents</div>
            </div>
            
            <div class="stat-card info">
                <div class="stat-icon">👥</div>
                <div class="stat-value">${totalUtilisateurs}</div>
                <div class="stat-label">Utilisateurs</div>
            </div>
            
            <div class="stat-card success">
                <div class="stat-icon">🔄</div>
                <div class="stat-value">${empruntsEnCours}</div>
                <div class="stat-label">Emprunts en cours</div>
            </div>
            
            <div class="stat-card danger">
                <div class="stat-icon">⚠️</div>
                <div class="stat-value">${empruntsEnRetard}</div>
                <div class="stat-label">Emprunts en retard</div>
            </div>
        </div>

        <!-- Répartition des utilisateurs -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon">👨‍💼</div>
                <div class="stat-value">${countAdmins}</div>
                <div class="stat-label">Administrateurs</div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon">👩‍💼</div>
                <div class="stat-value">${countBibliothecaires}</div>
                <div class="stat-label">Bibliothécaires</div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon">👤</div>
                <div class="stat-value">${countLecteurs}</div>
                <div class="stat-label">Lecteurs</div>
            </div>
        </div>

        <!-- Contenu principal -->
        <div class="content-grid">
            <!-- Derniers emprunts -->
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">📋 Derniers emprunts</h2>
                    <a href="${pageContext.request.contextPath}/emprunts" class="btn btn-primary">
                        Voir tout
                    </a>
                </div>
                
                <c:choose>
                    <c:when test="${empty derniersEmprunts}">
                        <div class="empty-state">
                            <div style="font-size: 3em; margin-bottom: 10px;">📭</div>
                            <p>Aucun emprunt enregistré</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <table>
                            <thead>
                                <tr>
                                    <th>Lecteur</th>
                                    <th>Document</th>
                                    <th>Date</th>
                                    <th>Statut</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${derniersEmprunts}" var="emprunt">
                                    <tr>
                                        <td>${emprunt.utilisateur.nomComplet}</td>
                                        <td>${emprunt.document.titre}</td>
                                        <td>${emprunt.dateEmprunt}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${emprunt.statut == 'EN_COURS'}">
                                                    <span class="badge badge-success">En cours</span>
                                                </c:when>
                                                <c:when test="${emprunt.statut == 'EN_RETARD'}">
                                                    <span class="badge badge-danger">En retard</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge badge-warning">Rendu</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Emprunts en retard -->
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">⚠️ Emprunts en retard</h2>
                </div>
                
                <c:choose>
                    <c:when test="${empty empruntsRetard}">
                        <div class="empty-state">
                            <div style="font-size: 3em; margin-bottom: 10px;">✅</div>
                            <p>Aucun retard</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${empruntsRetard}" var="emprunt">
                            <div style="padding: 15px; background: #fff5f5; border-radius: 8px; margin-bottom: 10px;">
                                <div style="font-weight: 600; color: #c53030; margin-bottom: 5px;">
                                    ${emprunt.utilisateur.nomComplet}
                                </div>
                                <div style="font-size: 0.9em; color: #666; margin-bottom: 5px;">
                                    ${emprunt.document.titre}
                                </div>
                                <div style="font-size: 0.85em; color: #999;">
                                    Retard: ${emprunt.joursRetard} jour(s)
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
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
                <a href="${pageContext.request.contextPath}/utilisateurs?action=add" class="btn btn-primary"
                   style="padding: 15px; text-align: center;">
                    👤 Ajouter un utilisateur
                </a>
            </div>
        </div>
    </div>
</body>
</html>