<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="sn.ucad.m1.sunubibliotek.Cyberboys.entities.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tableau de Bord - Sunu Bibliotek</title>
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
        .welcome-card {
            background: white;
            border-radius: 12px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        .welcome-card h2 {
            color: #2d3748;
            margin-bottom: 10px;
            font-size: 2em;
        }
        .welcome-card p {
            color: #718096;
        }
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        .stat-card {
            background: white;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            display: flex;
            align-items: center;
            gap: 20px;
            transition: transform 0.3s;
        }
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }
        .stat-icon {
            font-size: 3em;
            width: 80px;
            height: 80px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 12px;
        }
        .stat-icon.blue {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        .stat-icon.green {
            background: linear-gradient(135deg, #48bb78 0%, #38a169 100%);
        }
        .stat-icon.orange {
            background: linear-gradient(135deg, #ed8936 0%, #dd6b20 100%);
        }
        .stat-icon.red {
            background: linear-gradient(135deg, #f56565 0%, #e53e3e 100%);
        }
        .stat-info h3 {
            color: #718096;
            font-size: 0.9em;
            margin-bottom: 5px;
        }
        .stat-info .number {
            font-size: 2.5em;
            font-weight: bold;
            color: #2d3748;
        }
        .content-grid {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 20px;
        }
        .card {
            background: white;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        .card h3 {
            color: #2d3748;
            margin-bottom: 20px;
            font-size: 1.3em;
        }
        .quick-actions {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 15px;
        }
        .quick-action-btn {
            padding: 20px;
            background: #f7fafc;
            border-radius: 8px;
            text-align: center;
            text-decoration: none;
            color: #2d3748;
            font-weight: 600;
            transition: all 0.3s;
            border: 2px solid transparent;
        }
        .quick-action-btn:hover {
            background: #667eea;
            color: white;
            transform: translateY(-2px);
            border-color: #667eea;
        }
        .info-item {
            padding: 12px 0;
            border-bottom: 1px solid #e2e8f0;
            display: flex;
            justify-content: space-between;
        }
        .info-item:last-child {
            border-bottom: none;
        }
        .info-label {
            color: #718096;
        }
        .info-value {
            color: #2d3748;
            font-weight: 600;
        }
        .alert-danger {
            background: #fff5f5;
            border-left: 4px solid #e53e3e;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 30px;
        }
        .alert-danger strong {
            color: #742a2a;
        }
        .alert-danger span {
            color: #742a2a;
        }
        .alert-danger a {
            color: #742a2a;
            text-decoration: underline;
            font-weight: bold;
            margin-left: 10px;
        }
        @media (max-width: 1024px) {
            .content-grid {
                grid-template-columns: 1fr;
            }
        }
        @media (max-width: 768px) {
            .stats-grid {
                grid-template-columns: 1fr;
            }
            .quick-actions {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <%
        Utilisateur user = (Utilisateur) session.getAttribute("utilisateur");
    %>
    
    <!-- Include Menu -->
    <jsp:include page="menu.jsp" />
    
    <div class="container">
        <div class="welcome-card">
            <h2>Bienvenue, <%= user.getPrenom() %> ! 👋</h2>
            <p>Voici un aperçu de l'activité de la bibliothèque</p>
        </div>
        
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon blue">📚</div>
                <div class="stat-info">
                    <h3>Documents</h3>
                    <div class="number"><c:out value="${totalDocuments}"/></div>
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon green">👥</div>
                <div class="stat-info">
                    <h3>Utilisateurs</h3>
                    <div class="number"><c:out value="${totalUtilisateurs}"/></div>
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon orange">📖</div>
                <div class="stat-info">
                    <h3>Emprunts en cours</h3>
                    <div class="number"><c:out value="${empruntsEnCours}"/></div>
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon red">⚠️</div>
                <div class="stat-info">
                    <h3>En retard</h3>
                    <div class="number"><c:out value="${empruntsEnRetard}"/></div>
                </div>
            </div>
        </div>
        
        <c:if test="${empruntsEnRetard > 0}">
            <div class="alert-danger">
                <strong>⚠️ Attention !</strong> 
                <span>
                    Il y a <strong>${empruntsEnRetard}</strong> emprunt(s) en retard.
                </span>
                <a href="${pageContext.request.contextPath}/emprunts?action=retards">
                    Voir la liste →
                </a>
            </div>
        </c:if>
        
        <div class="content-grid">
            <div class="card">
                <h3>🚀 Actions Rapides</h3>
                <div class="quick-actions">
                    <a href="${pageContext.request.contextPath}/documents" class="quick-action-btn">
                        📚 Consulter les documents
                    </a>
                    <a href="${pageContext.request.contextPath}/emprunts" class="quick-action-btn">
                        📖 Voir les emprunts
                    </a>
                    <% if (user.estBibliothecaire()) { %>
                        <a href="${pageContext.request.contextPath}/emprunts?action=create" class="quick-action-btn">
                            ➕ Nouvel emprunt
                        </a>
                        <a href="${pageContext.request.contextPath}/utilisateurs?action=add" class="quick-action-btn">
                            👤 Ajouter utilisateur
                        </a>
                        <a href="${pageContext.request.contextPath}/documents?action=add" class="quick-action-btn">
                            📖 Ajouter document
                        </a>
                        <a href="${pageContext.request.contextPath}/statistiques" class="quick-action-btn">
                            📊 Voir statistiques
                        </a>
                    <% } else { %>
                        <a href="${pageContext.request.contextPath}/reservations" class="quick-action-btn">
                            📋 Mes réservations
                        </a>
                        <a href="${pageContext.request.contextPath}/emprunts?action=historique&type=utilisateur&id=<%= user.getId() %>" class="quick-action-btn">
                            📜 Mon historique
                        </a>
                    <% } %>
                </div>
            </div>
            
            <div class="card">
                <h3>ℹ️ Informations</h3>
                <div class="info-item">
                    <span class="info-label">Taux d'occupation</span>
                    <span class="info-value">${tauxOccupation}%</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Total emprunts</span>
                    <span class="info-value">${totalEmprunts}</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Votre rôle</span>
                    <span class="info-value"><%= user.getRole().getLibelle() %></span>
                </div>
                <div class="info-item">
                    <span class="info-label">Votre type</span>
                    <span class="info-value"><%= user.getTypeUtilisateur().getLibelle() %></span>
                </div>
                <div class="info-item">
                    <span class="info-label">N° Carte</span>
                    <span class="info-value"><%= user.getNumeroCarte() %></span>
                </div>
                <div class="info-item">
                    <span class="info-label">Date d'inscription</span>
                    <span class="info-value"><%= user.getDateInscription() %></span>
                </div>
            </div>
        </div>
    </div>
</body>
</html>