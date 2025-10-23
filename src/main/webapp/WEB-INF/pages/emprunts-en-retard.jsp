<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="sn.ucad.m1.sunubibliotek.Cyberboys.entities.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Emprunts en Retard - Sunu Bibliotek</title>
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
            color: #e53e3e;
            margin-bottom: 10px;
            font-size: 2.5em;
        }
        .subtitle {
            color: #667eea;
            font-weight: bold;
            margin-bottom: 20px;
        }
        .alert {
            background: #fff5f5;
            border-left: 4px solid #e53e3e;
            padding: 20px;
            margin-bottom: 30px;
            border-radius: 8px;
        }
        .alert h2 {
            color: #742a2a;
            margin-bottom: 10px;
        }
        .alert p {
            color: #742a2a;
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
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th {
            background: #e53e3e;
            color: white;
            padding: 15px;
            text-align: left;
            font-weight: 600;
        }
        td {
            padding: 15px;
            border-bottom: 1px solid #e2e8f0;
            background: #fff5f5;
        }
        tr:hover td {
            background: #fed7d7;
        }
        .retard-badge {
            background: #742a2a;
            color: white;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 0.85em;
            font-weight: 600;
        }
        .penalite {
            color: #e53e3e;
            font-weight: bold;
            font-size: 1.1em;
        }
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #48bb78;
        }
        .empty-state h2 {
            color: #48bb78;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>⚠️ Emprunts en Retard</h1>
        <div class="subtitle">Sunu Bibliotek - Cyberboys</div>
        
        <c:if test="${count > 0}">
            <div class="alert">
                <h2>Attention : ${count} emprunt(s) en retard !</h2>
                <p>Ces documents doivent être retournés de toute urgence. Des pénalités s'appliquent.</p>
            </div>
        </c:if>

        <div class="nav-buttons">
            <a href="${pageContext.request.contextPath}/emprunts" class="btn btn-primary">
                Retour aux emprunts
            </a>
        </div>

        <c:choose>
            <c:when test="${empty emprunts}">
                <div class="empty-state">
                    <div style="font-size: 4em;">✅</div>
                    <h2>Aucun emprunt en retard !</h2>
                    <p>Tous les emprunts sont à jour</p>
                </div>
            </c:when>
            <c:otherwise>
                <table>
                    <thead>
                        <tr>
                            <th>Utilisateur</th>
                            <th>Contact</th>
                            <th>Document</th>
                            <th>Retour prévu</th>
                            <th>Jours de retard</th>
                            <th>Pénalité estimée</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${emprunts}" var="emprunt">
                            <%
                                Emprunt emprunt = (Emprunt) pageContext.getAttribute("emprunt");
                                long joursRetard = emprunt.getJoursRetard();
                                double penalite = emprunt.calculerPenalite();
                            %>
                            <tr>
                                <td>
                                    <strong><%= emprunt.getUtilisateur().getNomComplet() %></strong><br>
                                    <small style="color: #718096;">
                                        <%= emprunt.getUtilisateur().getNumeroCarte() %>
                                    </small>
                                </td>
                                <td>
                                    <%= emprunt.getUtilisateur().getEmail() %><br>
                                    <small style="color: #718096;">
                                        <%= emprunt.getUtilisateur().getTelephone() != null ? 
                                            emprunt.getUtilisateur().getTelephone() : "N/A" %>
                                    </small>
                                </td>
                                <td>
                                    <strong><%= emprunt.getDocument().getTitre() %></strong><br>
                                    <small style="color: #718096;">
                                        N°<%= emprunt.getDocument().getNumEnreg() %>
                                    </small>
                                </td>
                                <td>
                                    <strong style="color: #e53e3e;">
                                        <%= emprunt.getDateRetourPrevue() %>
                                    </strong>
                                </td>
                                <td>
                                    <span class="retard-badge">
                                        <%= joursRetard %> jour<%= joursRetard > 1 ? "s" : "" %>
                                    </span>
                                </td>
                                <td>
                                    <span class="penalite">
                                        <%= String.format("%.0f", penalite) %> FCFA
                                    </span>
                                </td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/emprunts?action=retourner&id=<%= emprunt.getId() %>" 
                                       class="btn btn-success"
                                       onclick="return confirm('Confirmer le retour ? Pénalité : <%= String.format("%.0f", penalite) %> FCFA')">
                                       Retourner
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