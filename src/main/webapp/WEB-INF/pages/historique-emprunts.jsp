<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="sn.ucad.m1.sunubibliotek.Cyberboys.entities.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Historique - Sunu Bibliotek</title>
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
            margin-bottom: 20px;
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
        .badge-retourne {
            background: #c6f6d5;
            color: #22543d;
        }
        .badge-en-cours {
            background: #bee3f8;
            color: #2c5282;
        }
        .badge-en-retard {
            background: #fed7d7;
            color: #742a2a;
        }
        .badge-perdu {
            background: #4a5568;
            color: white;
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
        <h1><c:out value="${titre}"/></h1>
        <div class="subtitle">Sunu Bibliotek - Cyberboys</div>
        
        <a href="${pageContext.request.contextPath}/emprunts" class="btn btn-primary">
            Retour aux emprunts
        </a>

        <c:choose>
            <c:when test="${empty emprunts}">
                <div class="empty-state">
                    <div style="font-size: 4em;">📋</div>
                    <h2>Aucun historique</h2>
                </div>
            </c:when>
            <c:otherwise>
                <table>
                    <thead>
                        <tr>
                            <th>Date emprunt</th>
                            <th>Document</th>
                            <th>Utilisateur</th>
                            <th>Retour prévu</th>
                            <th>Retour effectif</th>
                            <th>Statut</th>
                            <th>Pénalité</th>
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
                            %>
                            <tr>
                                <td><%= emprunt.getDateEmprunt() %></td>
                                <td>
                                    <strong><%= emprunt.getDocument().getTitre() %></strong><br>
                                    <small style="color: #718096;">
                                        N°<%= emprunt.getDocument().getNumEnreg() %>
                                    </small>
                                </td>
                                <td>
                                    <%= emprunt.getUtilisateur().getNomComplet() %><br>
                                    <small style="color: #718096;">
                                        <%= emprunt.getUtilisateur().getNumeroCarte() %>
                                    </small>
                                </td>
                                <td><%= emprunt.getDateRetourPrevue() %></td>
                                <td>
                                    <%= emprunt.getDateRetourEffective() != null ? 
                                        emprunt.getDateRetourEffective() : "-" %>
                                </td>
                                <td>
                                    <span class="badge <%= statutBadge %>">
                                        <%= statut.getLibelle() %>
                                    </span>
                                </td>
                                <td>
                                    <% if (emprunt.getPenalite() > 0) { %>
                                        <strong style="color: #e53e3e;">
                                            <%= String.format("%.0f", emprunt.getPenalite()) %> FCFA
                                        </strong>
                                    <% } else { %>
                                        <span style="color: #48bb78;">0 FCFA</span>
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