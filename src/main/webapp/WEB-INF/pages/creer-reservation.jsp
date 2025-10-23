<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="sn.ucad.m1.sunubibliotek.Cyberboys.entities.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Nouvelle Réservation - Sunu Bibliotek</title>
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
            max-width: 900px;
            margin: 0 auto;
            background: white;
            border-radius: 15px;
            padding: 40px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }
        h1 {
            color: #333;
            margin-bottom: 10px;
            font-size: 2em;
        }
        .subtitle {
            color: #667eea;
            font-weight: bold;
            margin-bottom: 30px;
        }
        .info-box {
            background: #ebf8ff;
            border-left: 4px solid #4299e1;
            padding: 15px;
            margin-bottom: 30px;
            border-radius: 8px;
        }
        .info-box h3 {
            color: #2c5282;
            margin-bottom: 10px;
        }
        .info-box ul {
            margin-left: 20px;
            color: #2d3748;
        }
        .info-box li {
            margin: 5px 0;
        }
        .form-group {
            margin-bottom: 25px;
        }
        label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: 600;
        }
        select {
            width: 100%;
            padding: 12px;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 1em;
            transition: border-color 0.3s;
        }
        select:focus {
            outline: none;
            border-color: #667eea;
        }
        .btn {
            padding: 12px 30px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 1em;
            font-weight: 600;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s ease;
        }
        .btn-primary {
            background: #667eea;
            color: white;
        }
        .btn-primary:hover {
            background: #5568d3;
            transform: translateY(-2px);
        }
        .btn-secondary {
            background: #cbd5e0;
            color: #2d3748;
            margin-left: 10px;
        }
        .btn-secondary:hover {
            background: #a0aec0;
        }
        .help-text {
            font-size: 0.85em;
            color: #718096;
            margin-top: 5px;
        }
        .search-box {
            margin-bottom: 15px;
        }
        .search-box input {
            width: 100%;
            padding: 10px;
            border: 1px solid #e2e8f0;
            border-radius: 6px;
        }
    </style>
    <script>
        function filterSelect(inputId, selectId) {
            var input = document.getElementById(inputId);
            var select = document.getElementById(selectId);
            var filter = input.value.toUpperCase();
            var options = select.getElementsByTagName('option');
            
            for (var i = 0; i < options.length; i++) {
                var txtValue = options[i].textContent || options[i].innerText;
                if (txtValue.toUpperCase().indexOf(filter) > -1) {
                    options[i].style.display = "";
                } else {
                    options[i].style.display = "none";
                }
            }
        }
    </script>
</head>
<body>
    <div class="container">
        <h1>Nouvelle Réservation</h1>
        <div class="subtitle">Sunu Bibliotek - Cyberboys</div>
        
        <div class="info-box">
            <h3>Informations sur les réservations</h3>
            <ul>
                <li><strong>Durée de validité :</strong> 7 jours</li>
                <li>Vous serez notifié quand le document devient disponible</li>
                <li>Vous pouvez réserver uniquement les documents <strong>non disponibles</strong></li>
                <li>Une seule réservation par document et par utilisateur</li>
            </ul>
        </div>
        
        <form action="${pageContext.request.contextPath}/reservations" method="post">
            <input type="hidden" name="action" value="reserver">
            
            <div class="form-group">
                <label for="utilisateurId">Utilisateur *</label>
                <div class="search-box">
                    <input type="text" id="searchUser" 
                           placeholder="Rechercher un utilisateur..." 
                           onkeyup="filterSelect('searchUser', 'utilisateurId')">
                </div>
                <select id="utilisateurId" name="utilisateurId" required size="8">
                    <option value="">-- Sélectionner un utilisateur --</option>
                    <c:forEach items="${utilisateurs}" var="user">
                        <%
                            Utilisateur user = (Utilisateur) pageContext.getAttribute("user");
                            if (user.getActif()) {
                        %>
                            <option value="<%= user.getId() %>">
                                <%= user.getNumeroCarte() %> - <%= user.getNomComplet() %> 
                                (<%= user.getTypeUtilisateur().getLibelle() %>)
                            </option>
                        <%
                            }
                        %>
                    </c:forEach>
                </select>
                <div class="help-text">Seuls les utilisateurs actifs sont affichés</div>
            </div>
            
            <div class="form-group">
                <label for="documentId">Document *</label>
                <div class="search-box">
                    <input type="text" id="searchDoc" 
                           placeholder="Rechercher un document..." 
                           onkeyup="filterSelect('searchDoc', 'documentId')">
                </div>
                <select id="documentId" name="documentId" required size="8">
                    <option value="">-- Sélectionner un document --</option>
                    <c:forEach items="${documents}" var="doc">
                        <%
                            Document doc = (Document) pageContext.getAttribute("doc");
                            // Afficher seulement les documents NON disponibles
                            if (!doc.estDisponible()) {
                                String docType = "";
                                if (doc instanceof Livre) {
                                    Livre livre = (Livre) doc;
                                    docType = "Livre - " + livre.getAuteur();
                                } else if (doc instanceof Revue) {
                                    Revue revue = (Revue) doc;
                                    docType = "Revue - " + revue.getMois() + "/" + revue.getAnnee();
                                } else if (doc instanceof Dictionnaire) {
                                    Dictionnaire dico = (Dictionnaire) doc;
                                    docType = "Dictionnaire - " + dico.getLangue();
                                }
                        %>
                            <option value="<%= doc.getNumEnreg() %>">
                                N°<%= doc.getNumEnreg() %> - <%= doc.getTitre() %> 
                                (<%= docType %>) - Non disponible
                            </option>
                        <%
                            }
                        %>
                    </c:forEach>
                </select>
                <div class="help-text">Seuls les documents NON disponibles peuvent être réservés</div>
            </div>
            
            <div style="margin-top: 30px;">
                <button type="submit" class="btn btn-primary">Créer la réservation</button>
                <a href="${pageContext.request.contextPath}/reservations" 
                   class="btn btn-secondary">Annuler</a>
            </div>
        </form>
    </div>
</body>
</html>