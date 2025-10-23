<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="sn.ucad.m1.sunubibliotek.Cyberboys.entities.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Modifier un Utilisateur - Sunu Bibliotek</title>
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
            max-width: 800px;
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
            background: #f7fafc;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 30px;
        }
        .info-box p {
            margin: 5px 0;
            color: #4a5568;
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
        input[type="text"],
        input[type="email"],
        input[type="tel"],
        select {
            width: 100%;
            padding: 12px;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 1em;
            transition: border-color 0.3s;
        }
        input:focus, select:focus {
            outline: none;
            border-color: #667eea;
        }
        .checkbox-group {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .checkbox-group input[type="checkbox"] {
            width: auto;
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
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }
    </style>
</head>
<body>
    <%
        Utilisateur utilisateur = (Utilisateur) request.getAttribute("utilisateur");
    %>
    
    <div class="container">
        <h1>Modifier un Utilisateur</h1>
        <div class="subtitle">Sunu Bibliotek - Cyberboys</div>
        
        <div class="info-box">
            <p><strong>Numéro de carte:</strong> <%= utilisateur.getNumeroCarte() %></p>
            <p><strong>Date d'inscription:</strong> <%= utilisateur.getDateInscription() %></p>
        </div>
        
        <form action="${pageContext.request.contextPath}/utilisateurs" method="post">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="id" value="<%= utilisateur.getId() %>">
            
            <div class="form-row">
                <div class="form-group">
                    <label for="nom">Nom *</label>
                    <input type="text" id="nom" name="nom" required 
                           value="<%= utilisateur.getNom() %>">
                </div>
                
                <div class="form-group">
                    <label for="prenom">Prénom *</label>
                    <input type="text" id="prenom" name="prenom" required 
                           value="<%= utilisateur.getPrenom() %>">
                </div>
            </div>
            
            <div class="form-group">
                <label for="email">Email *</label>
                <input type="email" id="email" name="email" required 
                       value="<%= utilisateur.getEmail() %>">
            </div>
            
            <div class="form-group">
                <label for="telephone">Téléphone</label>
                <input type="tel" id="telephone" name="telephone" 
                       value="<%= utilisateur.getTelephone() != null ? utilisateur.getTelephone() : "" %>">
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label for="typeUtilisateur">Type d'utilisateur *</label>
                    <select id="typeUtilisateur" name="typeUtilisateur" required>
                        <%
                            TypeUtilisateur currentType = utilisateur.getTypeUtilisateur();
                            for (TypeUtilisateur type : TypeUtilisateur.values()) {
                        %>
                            <option value="<%= type.name() %>" <%= type == currentType ? "selected" : "" %>>
                                <%= type.getLibelle() %>
                            </option>
                        <%
                            }
                        %>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="role">Rôle *</label>
                    <select id="role" name="role" required>
                        <%
                            Role currentRole = utilisateur.getRole();
                            for (Role role : Role.values()) {
                        %>
                            <option value="<%= role.name() %>" <%= role == currentRole ? "selected" : "" %>>
                                <%= role.getLibelle() %>
                            </option>
                        <%
                            }
                        %>
                    </select>
                </div>
            </div>
            
            <div class="form-group">
                <div class="checkbox-group">
                    <input type="checkbox" id="actif" name="actif" 
                           <%= utilisateur.getActif() ? "checked" : "" %>>
                    <label for="actif" style="margin-bottom: 0;">Compte actif</label>
                </div>
            </div>
            
            <div style="margin-top: 30px;">
                <button type="submit" class="btn btn-primary">Enregistrer</button>
                <a href="${pageContext.request.contextPath}/utilisateurs" 
                   class="btn btn-secondary">Annuler</a>
            </div>
        </form>
    </div>
</body>
</html>