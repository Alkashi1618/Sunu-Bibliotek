<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="sn.ucad.m1.sunubibliotek.Cyberboys.entities.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Statistiques - Sunu Bibliotek</title>
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
        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px 40px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .container {
            max-width: 1400px;
            margin: 0 auto;
        }
        h1 {
            font-size: 2.5em;
            margin-bottom: 10px;
        }
        .subtitle {
            opacity: 0.9;
        }
        .content {
            padding: 30px 40px;
            max-width: 1400px;
            margin: 0 auto;
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
        }
        .stat-icon {
            width: 60px;
            height: 60px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2em;
        }
        .stat-icon.blue { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); }
        .stat-icon.green { background: linear-gradient(135deg, #48bb78 0%, #38a169 100%); }
        .stat-icon.orange { background: linear-gradient(135deg, #ed8936 0%, #dd6b20 100%); }
        .stat-icon.red { background: linear-gradient(135deg, #f56565 0%, #e53e3e 100%); }
        .stat-info h3 {
            color: #718096;
            font-size: 0.9em;
            margin-bottom: 5px;
        }
        .stat-info .number {
            font-size: 2em;
            font-weight: bold;
            color: #2d3748;
        }
        .charts-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        .chart-card {
            background: white;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        .chart-card h3 {
            color: #2d3748;
            margin-bottom: 20px;
            font-size: 1.2em;
        }
        .chart-bar {
            margin-bottom: 15px;
        }
        .chart-bar-label {
            display: flex;
            justify-content: space-between;
            margin-bottom: 5px;
            font-size: 0.9em;
        }
        .chart-bar-label span:first-child {
            color: #2d3748;
            font-weight: 600;
        }
        .chart-bar-label span:last-child {
            color: #667eea;
            font-weight: bold;
        }
        .chart-bar-fill {
            height: 30px;
            background: #e2e8f0;
            border-radius: 8px;
            overflow: hidden;
        }
        .chart-bar-progress {
            height: 100%;
            background: linear-gradient(90deg, #667eea 0%, #764ba2 100%);
            border-radius: 8px;
            transition: width 0.5s ease;
        }
        .ranking-list {
            list-style: none;
        }
        .ranking-item {
            display: flex;
            align-items: center;
            gap: 15px;
            padding: 15px;
            background: #f7fafc;
            border-radius: 8px;
            margin-bottom: 10px;
        }
        .ranking-number {
            width: 35px;
            height: 35px;
            background: #667eea;
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
        }
        .ranking-info {
            flex: 1;
        }
        .ranking-info strong {
            color: #2d3748;
            display: block;
            margin-bottom: 3px;
        }
        .ranking-info small {
            color: #718096;
        }
        .ranking-badge {
            background: #667eea;
            color: white;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 0.9em;
            font-weight: 600;
        }
        .btn {
            padding: 12px 25px;
            background: #667eea;
            color: white;
            border: none;
            border-radius: 8px;
            text-decoration: none;
            display: inline-block;
            font-weight: 600;
            transition: all 0.3s;
        }
        .btn:hover {
            background: #5568d3;
            transform: translateY(-2px);
        }
    </style>
</head>
<body>
    <%
        Map<String, Object> statsGlobales = (Map<String, Object>) request.getAttribute("statsGlobales");
    %>
    
    <div class="header">
        <div class="container">
            <h1>📊 Statistiques & Analyses</h1>
            <p class="subtitle">Vue d'ensemble des activités de la bibliothèque</p>
        </div>
    </div>
    
    <div class="content">
        <div style="margin-bottom: 30px;">
            <a href="${pageContext.request.contextPath}/dashboard" class="btn">
                ← Retour au tableau de bord
            </a>
        </div>
        
        <!-- Statistiques globales -->
        <h2 style="color: #2d3748; margin-bottom: 20px;">📈 Vue d'ensemble</h2>
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon blue">📚</div>
                <div class="stat-info">
                    <h3>Documents</h3>
                    <div class="number"><%= statsGlobales.get("totalDocuments") %></div>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon green">✓</div>
                <div class="stat-info">
                    <h3>Disponibles</h3>
                    <div class="number"><%= statsGlobales.get("documentsDisponibles") %></div>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon orange">📖</div>
                <div class="stat-info">
                    <h3>En cours</h3>
                    <div class="number"><%= statsGlobales.get("empruntsEnCours") %></div>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon red">⚠</div>
                <div class="stat-info">
                    <h3>En retard</h3>
                    <div class="number"><%= statsGlobales.get("empruntsEnRetard") %></div>
                </div>
            </div>
        </div>
        
        <!-- Graphiques -->
        <div class="charts-grid">
            <!-- Documents par type -->
            <div class="chart-card">
                <h3>📚 Documents par type</h3>
                <%
                    Map<String, Long> statsParType = (Map<String, Long>) request.getAttribute("statsParType");
                    if (statsParType != null && !statsParType.isEmpty()) {
                        long maxType = statsParType.values().stream().max(Long::compareTo).orElse(1L);
                        for (Map.Entry<String, Long> entry : statsParType.entrySet()) {
                            double percentage = (entry.getValue() * 100.0) / maxType;
                %>
                    <div class="chart-bar">
                        <div class="chart-bar-label">
                            <span><%= entry.getKey() %></span>
                            <span><%= entry.getValue() %></span>
                        </div>
                        <div class="chart-bar-fill">
                            <div class="chart-bar-progress" style="width: <%= percentage %>%;"></div>
                        </div>
                    </div>
                <%
                        }
                    }
                %>
            </div>
            
            <!-- Utilisateurs par type -->
            <div class="chart-card">
                <h3>👥 Utilisateurs par type</h3>
                <%
                    Map<String, Long> statsParTypeUser = (Map<String, Long>) request.getAttribute("statsParTypeUser");
                    if (statsParTypeUser != null && !statsParTypeUser.isEmpty()) {
                        long maxUser = statsParTypeUser.values().stream().max(Long::compareTo).orElse(1L);
                        for (Map.Entry<String, Long> entry : statsParTypeUser.entrySet()) {
                            double percentage = (entry.getValue() * 100.0) / maxUser;
                %>
                    <div class="chart-bar">
                        <div class="chart-bar-label">
                            <span><%= entry.getKey() %></span>
                            <span><%= entry.getValue() %></span>
                        </div>
                        <div class="chart-bar-fill">
                            <div class="chart-bar-progress" style="width: <%= percentage %>%;"></div>
                        </div>
                    </div>
                <%
                        }
                    }
                %>
            </div>
        </div>
        
        <!-- Classements -->
        <div class="charts-grid">
            <!-- Top documents -->
            <div class="chart-card">
                <h3>🏆 Documents les plus empruntés</h3>
                <ul class="ranking-list">
                    <%
                        List<Map<String, Object>> topDocuments = (List<Map<String, Object>>) request.getAttribute("topDocuments");
                        if (topDocuments != null) {
                            int rank = 1;
                            for (Map<String, Object> stat : topDocuments) {
                                Document doc = (Document) stat.get("document");
                                Long nbEmprunts = (Long) stat.get("nbEmprunts");
                    %>
                        <li class="ranking-item">
                            <div class="ranking-number"><%= rank++ %></div>
                            <div class="ranking-info">
                                <strong><%= doc.getTitre() %></strong>
                                <small>ID: <%= doc.getNumEnreg() %></small>
                            </div>
                            <div class="ranking-badge"><%= nbEmprunts %> emprunt(s)</div>
                        </li>
                    <%
                            }
                        }
                    %>
                </ul>
            </div>
            
            <!-- Top utilisateurs -->
            <div class="chart-card">
                <h3>⭐ Utilisateurs les plus actifs</h3>
                <ul class="ranking-list">
                    <%
                        List<Map<String, Object>> topUtilisateurs = (List<Map<String, Object>>) request.getAttribute("topUtilisateurs");
                        if (topUtilisateurs != null) {
                            int rank = 1;
                            for (Map<String, Object> stat : topUtilisateurs) {
                                Utilisateur user = (Utilisateur) stat.get("utilisateur");
                                Long nbEmprunts = (Long) stat.get("nbEmprunts");
                    %>
                        <li class="ranking-item">
                            <div class="ranking-number"><%= rank++ %></div>
                            <div class="ranking-info">
                                <strong><%= user.getNomComplet() %></strong>
                                <small><%= user.getNumeroCarte() %></small>
                            </div>
                            <div class="ranking-badge"><%= nbEmprunts %> emprunt(s)</div>
                        </li>
                    <%
                            }
                        }
                    %>
                </ul>
            </div>
        </div>
        
        <!-- Taux de retour -->
        <%
            Map<String, Object> tauxRetour = (Map<String, Object>) request.getAttribute("tauxRetour");
            if (tauxRetour != null) {
        %>
        <div class="chart-card" style="margin-top: 20px;">
            <h3>📊 Taux de retour à temps</h3>
            <div style="text-align: center; padding: 20px;">
                <div style="font-size: 3em; font-weight: bold; color: #667eea;">
                    <%= tauxRetour.get("tauxRetourTemps") %>%
                </div>
                <p style="color: #718096; margin-top: 10px;">
                    <%= tauxRetour.get("retoursTemps") %> retours à temps sur <%= tauxRetour.get("totalRetournes") %> retours
                </p>
            </div>
        </div>
        <% } %>
    </div>
</body>
</html>