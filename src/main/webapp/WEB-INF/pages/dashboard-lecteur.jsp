<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Mon Espace - Sunu Bibliotek</title>
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
        
        .emprunt-item {
            padding: 15px;
            background: #f7fafc;
            border-radius: 10px;
            margin-bottom: 15px;
            border-left: 4px solid #667eea;
        }
        
        .emprunt-item.retard {
            background: #fff5f5;
            border-left-color: #f56565;
        }
        
        .emprunt-title {
            font-weight: 600;
            color: #333;
            font-size: 1.1em;
            margin-bottom: 8px;
        }
        
        .emprunt-details {
            font-size: 0.9em;
            color: #666;
            line-height: 1.6;
        }
        
        .badge {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 12px;
            font-size: 0.85em;
            font-weight: 600;
            margin-left: 10px;
        }
        
        .badge-success {
            background: #c6f6d5;
            color: #22543d;
        }
        
        .badge-danger {
            background: #fed7d7;
            color: #742a2a;
        }
        
        .document-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 20px;
        }
        
        .document-card {
            background: white;
            border: 2px solid #e2e8f0;
            border-radius: 10px;
            padding: 20px;
            transition: all 0.3s;
        }
        
        .document-card:hover {
            border-color: #667eea;
            transform: translateY(-5px);
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }
        
        .document-icon {
            font-size: 3em;
            margin-bottom: 10px;
        }
        
        .document-title {
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
        }
        
        .document-details {
            font-size: 0.9em;
            color: #666;
            line-height: 1.5;
        }
        
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #999;
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
                🏠 Mon Espace
            </a>
            <a href="${pageContext.request.contextPath}/documents" class="nav-link">
                📖 Catalogue
            </a>
            <div style="display: flex; align-items: center; gap: 15px; padding-left: 20px; border-left: 1px solid rgba(255,255,255,0.3);">
                <div style="text-align: right;">
                    <div style="font-weight: 600;">${sessionScope.userNom}</div>
                    <div style="font-size: 0.85em; opacity: 0.9;">👤 Lecteur</div>
                </div>
                <a href="${pageContext.request.contextPath}/auth?action=logout" class="nav-link">
                    🚪 Déconnexion
                </a>
            </div>
        </div>
    </nav>

    <div class="container">
        <div class="page-header">
            <h1>👤 Mon Espace Lecteur</h1>
            <p>Bienvenue ${sessionScope.userNom}</p>
        </div>

        <!-- Statistiques -->
        <div class="stats-grid">
            <div class="stat-card" style="border-left: 4px solid #48bb78;">
                <div class="stat-icon">📚</div>
                <div class="stat-value">${empruntsEnCours}</div>
                <div class="stat-label">Emprunts en cours</div>
            </div>
            
            <div class="stat-card" style="border-left: 4px solid #f56565;">
                <div class="stat-icon">⚠️</div>
                <div class="stat-value">${empruntsEnRetard}</div>
                <div class="stat-label">Emprunts en retard</div>
            </div>
            
            <div class="stat-card" style="border-left: 4px solid #667eea;">
                <div class="stat-icon">📖</div>
                <div class="stat-value">${totalDocuments}</div>
                <div class="stat-label">Documents disponibles</div>
            </div>
        </div>

        <!-- Mes emprunts -->
        <div class="card">
            <div class="card-header">
                <h2 class="card-title">📋 Mes emprunts</h2>
            </div>
            
            <c:choose>
                <c:when test="${empty mesEmprunts}">
                    <div class="empty-state">
                        <div style="font-size: 4em; margin-bottom: 15px;">📭</div>
                        <h3>Aucun emprunt</h3>
                        <p>Explorez notre catalogue pour emprunter votre premier document</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${mesEmprunts}" var="emprunt">
                        <div class="emprunt-item ${emprunt.isEnRetard() ? 'retard' : ''}">
                            <div class="emprunt-title">
                                ${emprunt.document.titre}
                                <c:choose>
                                    <c:when test="${emprunt.statut == 'RENDU'}">
                                        <span class="badge badge-success">✅ Rendu</span>
                                    </c:when>
                                    <c:when test="${emprunt.isEnRetard()}">
                                        <span class="badge badge-danger">⚠️ En retard (${emprunt.joursRetard}j)</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge badge-success">🔄 En cours</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="emprunt-details">
                                📅 Emprunté le: ${emprunt.dateEmprunt}<br>
                                📆 Retour prévu: ${emprunt.dateRetourPrevue}
                                <c:if test="${emprunt.statut == 'RENDU'}">
                                    <br>✅ Rendu le: ${emprunt.dateRetourEffective}
                                </c:if>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Catalogue de documents -->
        <div class="card">
            <div class="card-header">
                <h2 class="card-title">📚 Catalogue de documents</h2>
                <a href="${pageContext.request.contextPath}/documents" 
                   style="color: #667eea; text-decoration: none; font-weight: 600;">
                    Voir tout le catalogue →
                </a>
            </div>
            
            <div class="document-grid">
                <c:forEach items="${catalogueDocuments}" var="doc">
                    <div class="document-card">
                        <div class="document-icon">
                            <c:choose>
                                <c:when test="${doc.class.simpleName == 'Livre'}">📖</c:when>
                                <c:when test="${doc.class.simpleName == 'Revue'}">📰</c:when>
                                <c:when test="${doc.class.simpleName == 'Dictionnaire'}">📕</c:when>
                            </c:choose>
                        </div>
                        <div class="document-title">${doc.titre}</div>
                        <div class="document-details">
                            <c:choose>
                                <c:when test="${doc.class.simpleName == 'Livre'}">
                                    Auteur: ${doc.auteur}<br>
                                    Pages: ${doc.nbrPages}
                                </c:when>
                                <c:when test="${doc.class.simpleName == 'Revue'}">
                                    Date: ${doc.mois}/${doc.annee}
                                </c:when>
                                <c:when test="${doc.class.simpleName == 'Dictionnaire'}">
                                    Langue: ${doc.langue}
                                </c:when>
                            </c:choose>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <!-- Message d'information -->
        <div style="background: #ebf8ff; border-left: 4px solid #4299e1; padding: 20px; border-radius: 10px;">
            <div style="font-weight: 600; color: #2c5282; margin-bottom: 8px;">
                ℹ️ Informations
            </div>
            <div style="color: #2d3748; font-size: 0.95em;">
                • Les emprunts sont d'une durée de 14 jours<br>
                • Pour emprunter un document, contactez le bibliothécaire<br>
                • Pensez à rendre vos documents à temps pour éviter les pénalités
            </div>
        </div>
    </div>
</body>
</html>