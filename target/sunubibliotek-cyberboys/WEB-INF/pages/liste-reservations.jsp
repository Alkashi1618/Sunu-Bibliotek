<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="sn.ucad.m1.sunubibliotek.Cyberboys.entities.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gestion des Réservations - Sunu Bibliotek</title>
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
        .badge-active {
            background: #bee3f8;
            color: #2c5282;
        }
        .badge-satisfaite {
            background: #c6f6d5;
            color: #22543d;
        }
        .badge-annulee {
            background: #e2e8f0;
            color: #4a5568;
        }
        .badge-expiree {
            background: #fed7d7;
            color: #742a2a;
        }
        .alert {
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        .alert-success {
            background: #c6f6d5;
            color: #22543d;
            border-left: 4px solid #48bb78;
        }
        .alert-error {
            background: #fed7d7;
            color: #742a2a;
            border-left: 4px solid #e53e3e;
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
        <h1>Gestion des Réservations</h1>
        <div class="subtitle">Sunu Bibliotek - Cyberboys</div>
        
        <div class="stats-grid">
            <div class="stat-card">
                <h3>Total Réservations</h3>
                <div class="number"><c:out value="${count}"/></div>
            </div>
            <div class="stat-card">
                <h3>Actives</h3>
                <div class="number"><c:out value="${countActives}"/></div>
            </div>
        </div>

        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
            <% session.removeAttribute("success"); %>
        </c:if>
        
        <c:if test="${not empty error}">
            <div class="alert alert-error">${error}</div>
            <% session.removeAttribute("error"); %>
        </c:if>

        <div class="nav-buttons">
            <a href="${pageContext.request.contextPath}/reservations?action=create" class="btn btn-primary">
                Nouvelle Réservation
            </a>
            <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-secondary">
                Tableau de bord
            </a>
            <a href="${pageContext.request.contextPath}/documents" class="btn btn-secondary">
                Documents
            </a>
        </div>

        <c:choose>
            <c:when test="${empty reservations}">
                <div class="empty-state">
                    <div style="font-size: 4em;">📋</div>
                    <h2>Aucune réservation</h2>
                    <p>Aucune réservation n'a été enregistrée</p>
                </div>
            </c:when>
            <c:otherwise>
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Utilisateur</th>
                            <th>Document</th>
                            <th>Date Réservation</th>
                            <th>Expiration</th>
                            <th>Statut</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${reservations}" var="reservation">
                            <%
                                Reservation reservation = (Reservation) pageContext.getAttribute("reservation");
                                StatutReservation statut = reservation.getStatut();
                                String statutBadge = "";
                                switch(statut) {
                                    case ACTIVE: statutBadge = "badge-active"; break;
                                    case SATISFAITE: statutBadge = "badge-satisfaite"; break;
                                    case ANNULEE: statutBadge = "badge-annulee"; break;
                                    case EXPIREE: statutBadge = "badge-expiree"; break;
                                }
                            %>
                            <tr>
                                <td><strong>#<%= reservation.getId() %></strong></td>
                                <td>
                                    <strong><%= reservation.getUtilisateur().getNomComplet() %></strong><br>
                                    <small style="color: #718096;">
                                        <%= reservation.getUtilisateur().getNumeroCarte() %>
                                    </small>
                                </td>
                                <td>
                                    <strong><%= reservation.getDocument().getTitre() %></strong><br>
                                    <small style="color: #718096;">
                                        N°<%= reservation.getDocument().getNumEnreg() %>
                                    </small>
                                </td>
                                <td><%= reservation.getDateReservation() %></td>
                                <td>
                                    <%= reservation.getDateExpiration() %>
                                    <% if (reservation.estActive()) { %>
                                        <br><small style="color: #4299e1; font-weight: bold;">
                                            <%= reservation.getJoursRestants() %> jour(s) restant(s)
                                        </small>
                                    <% } %>
                                </td>
                                <td>
                                    <span class="badge <%= statutBadge %>">
                                        <%= statut.getLibelle() %>
                                    </span>
                                    <% if (reservation.getNotifie()) { %>
                                        <br><small style="color: #48bb78;">✓ Notifié</small>
                                    <% } %>
                                </td>
                                <td>
                                    <% if (statut == StatutReservation.ACTIVE) { %>
                                        <a href="${pageContext.request.contextPath}/reservations?action=satisfaire&id=<%= reservation.getId() %>" 
                                           class="btn btn-success"
                                           onclick="return confirm('Satisfaire cette réservation ?')">
                                           Satisfaire
                                        </a>
                                        <a href="${pageContext.request.contextPath}/reservations?action=annuler&id=<%= reservation.getId() %>" 
                                           class="btn btn-danger"
                                           onclick="return confirm('Annuler cette réservation ?')">
                                           Annuler
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