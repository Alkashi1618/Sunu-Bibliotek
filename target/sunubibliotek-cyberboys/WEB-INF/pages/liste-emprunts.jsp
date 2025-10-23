<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="sn.ucad.m1.sunubibliotek.Cyberboys.entities.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gestion des Emprunts - Sunu Bibliotek</title>
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
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        .stat-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        .stat-card h3 {
            font-size: 0.9em;
            opacity: 0.9;
            margin-bottom: 10px;
        }
        .stat-card .number {
            font-size: 2.5em;
            font-weight: bold;
        }
        .nav-buttons {
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
        .btn-success {
            background: #48bb78;
            color: white;
            padding: 8px 15px;
            font-size: 0.9em;
        }
        .btn-success:hover {
            background: #38a169;
        }
        .btn-warning {
            background: #ed8936;
            color: white;
            padding: 8px 15px;
            font-size: 0.9em;
        }
        .btn-warning:hover {
            background: #dd6b20;
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
        .badge-en-cours {
            background: #bee3f8;
            color: #2c5282;
        }
        .badge-retourne {
            background: #c6f6d5;
            color: #22543d;
        }
        .badge-en-retard {
            background: #fed7d7;
            color: #742a2a;
        }
        .badge-perdu {
            background: #4a5568;
            color: white;
        }
        .alert {
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        .alert-warning {
            background: #feebc8;
            color: #744210;
            border-left: 4px solid #ed8936;
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
        <h1>Gestion des Emprunts</h1>
        <div class="subtitle">Sunu Bibliotek - Cyberboys</div>
        
        <div class="stats-grid">
            <div class="stat-card">
                <h3>Total Emprunts</h3>
                <div class="number"><c:out value="${count}"/></div>
            </div>
            <div class="stat-card">
                <h3>En Cours</h3>
                <div class="number"><c:out value="${countEnCours}"/></div>
            </div>
            <div class="stat-card">
                <h3>En Retard</h3>
                <div class="number"><c:out value="${countEnRetard}"/></div>
            </div>
        </div>

        <c:if test="${countEnRetard > 0}">
            <div class="alert alert-warning">
                <strong>Attention !</strong> Il y a <strong>${countEnRetard}</strong> emprunt(s) en retard.
                <a href="${pageContext.request.contextPath}/emprunts?action=retards" style="color: #744210; text-decoration: underline;">
                    Voir la liste
                </a>
            </div>
        </c:if>

        <div class="nav-buttons">
            <a href="${pageContext.request.contextPath}/emprunts?action=create" class="btn btn-primary">
                Nouvel Emprunt
            </a>
            <a href="${pageContext.request.contextPath}/emprunts?action=retards" class="btn btn-warning">
                Emprunts en Retard
            </a>
            <a href="${pageContext.request.contextPath}/documents" class="btn btn-secondary">
                Documents
            </a>
            <a href="${pageContext.request.contextPath}/utilisateurs" class="btn btn-secondary">
                Utilisateurs
            </a>
        </div>

        <c:choose>
            <c:when test="${empty emprunts}">
                <div class="empty-state">
                    <div style="font-size: 4em;">📚</div>
                    <h2>Aucun emprunt enregistré</h2>
                    <p>Commencez par créer votre premier emprunt</p>
                </div>
            </c:when>
            <c:otherwise>
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Utilisateur</th>
                            <th>Document</th>
                            <th>Date Emprunt</th>
                            <th>Retour Prévu</th>
                            <th>Statut</th>
                            <th>Pénalité</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${emprunts}" var="emprunt">
                            <%
                                Emprunt emprunt = (Emprunt) pageContext.getAttribute("emprunt");
                                StatutEmprunt statut = emprunt.getStatut();
                                String statutBadge = "";
                                switch(statut) {
                                    case EN_COURS: statutBadge = "badge-en-cours"; break;
                                    case RETOURNE: statutBadge = "badge-retourne"; break;
                                    case EN_RETARD: statutBadge = "badge-en-retard"; break;
                                    case PERDU: statutBadge = "badge-perdu"; break;
                                }
                                
                                boolean estEnRetard = emprunt.estEnRetard() && statut == StatutEmprunt.EN_COURS;
                            %>
                            <tr style="<%= estEnRetard ? "background: #fff5f5;" : "" %>">
                                <td><strong>#<%= emprunt.getId() %></strong></td>
                                <td>
                                    <strong><%= emprunt.getUtilisateur().getNomComplet() %></strong><br>
                                    <small style="color: #718096;"><%= emprunt.getUtilisateur().getNumeroCarte() %></small>
                                </td>
                                <td>
                                    <strong><%= emprunt.getDocument().getTitre() %></strong><br>
                                    <small style="color: #718096;">N°<%= emprunt.getDocument().getNumEnreg() %></small>
                                </td>
                                <td><%= emprunt.getDateEmprunt() %></td>
                                <td>
                                    <%= emprunt.getDateRetourPrevue() %>
                                    <% if (estEnRetard) { %>
                                        <br><small style="color: #e53e3e; font-weight: bold;">
                                            Retard: <%= emprunt.getJoursRetard() %> jour(s)
                                        </small>
                                    <% } %>
                                </td>
                                <td>
                                    <span class="badge <%= statutBadge %>"><%= statut.getLibelle() %></span>
                                    <% if (emprunt.getDateRetourEffective() != null) { %>
                                        <br><small style="color: #718096;">
                                            Retourné: <%= emprunt.getDateRetourEffective() %>
                                        </small>
                                    <% } %>
                                </td>
                                <td>
                                    <% if (emprunt.getPenalite() > 0) { %>
                                        <strong style="color: #e53e3e;"><%= String.format("%.0f", emprunt.getPenalite()) %> FCFA</strong>
                                    <% } else { %>
                                        <span style="color: #48bb78;">0 FCFA</span>
                                    <% } %>
                                </td>
                                <td>
                                    <% if (statut == StatutEmprunt.EN_COURS) { %>
                                        <a href="${pageContext.request.contextPath}/emprunts?action=retourner&id=<%= emprunt.getId() %>" 
                                           class="btn btn-success"
                                           onclick="return confirm('Confirmer le retour de ce document ?')">
                                           Retourner
                                        </a>
                                        <% if (!estEnRetard) { %>
                                            <a href="${pageContext.request.contextPath}/emprunts?action=prolonger&id=<%= emprunt.getId() %>&jours=7" 
                                               class="btn btn-warning"
                                               onclick="return confirm('Prolonger de 7 jours ?')">
                                               Prolonger
                                            </a>
                                        <% } %>
                                        <a href="${pageContext.request.contextPath}/emprunts?action=perdu&id=<%= emprunt.getId() %>" 
                                           class="btn btn-danger"
                                           onclick="return confirm('Marquer ce document comme PERDU ?')">
                                           Perdu
                                        </a>
                                    <% } else { %>
                                        <span style="color: #a0aec0;">-</span>
                                    <% } %>
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