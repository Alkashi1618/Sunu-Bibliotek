<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="sn.ucad.m1.sunubibliotek.Cyberboys.entities.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Détails Utilisateur - Sunu Bibliotek</title>
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
        .profile-header {
            display: flex;
            align-items: center;
            gap: 30px;
            margin-bottom: 40px;
            padding: 30px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 12px;
            color: white;
        }
        .profile-avatar {
            width: 120px;
            height: 120px;
            background: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3em;
            color: #667eea;
        }
        .profile-info h2 {
            margin-bottom: 10px;
            font-size: 1.8em;
        }
        .profile-info p {
            opacity: 0.9;
            margin: 5px 0;
        }
        .info-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 25px;
            margin-bottom: 30px;
        }
        .info-item {
            background: #f7fafc;
            padding: 20px;
            border-radius: 8px;
            border-left: 4px solid #667eea;
        }
        .info-label {
            font-size: 0.9em;
            color: #718096;
            margin-bottom: 5px;
        }
        .info-value {
            font-size: 1.1em;
            color: #2d3748;
            font-weight: 600;
        }
        .badge {
            display: inline-block;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 0.9em;
            font-weight: 600;
        }
        .badge-etudiant {
            background: #bee3f8;
            color: #2c5282;
        }
        .badge-enseignant {
            background: #c6f6d5;
            color: #22543d;
        }
        .badge-personnel {
            background: #fbd38d;
            color: #744210;
        }
        .badge-externe {
            background: #fed7d7;
            color: #742a2a;
        }
        .badge-admin {
            background: #fc8181;
            color: #742a2a;
        }
        .badge-bibliothecaire {
            background: #9ae6b4;
            color: #22543d;
        }
        .badge-lecteur {
            background: #90cdf4;
            color: #2c5282;
        }
        .status-actif {
            color: #38a169;
            font-weight: bold;
        }
        .status-inactif {
            color: #e53e3e;
            font-weight: bold;
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
            margin-right: 10px;
        }
        .btn-primary {
            background: #667eea;
            color: white;
        }
        .btn-primary:hover {
            background: #5568d3;
        }
        .btn-secondary {
            background: #cbd5e0;
            color: #2d3748;
        }
        .btn-secondary:hover {
            background: #a0aec0;
        }
        .section-title {
            font-size: 1.3em;
            color: #2d3748;
            margin: 30px 0 20px 0;
            padding-bottom: 10px;
            border-bottom: 2px solid #e2e8f0;
        }
        .empty-message {
            text-align: center;
            padding: 40px;
            color: #a0aec0;
            background: #f7fafc;
            border-radius: 8px;
        }
    </style>
</head>
<body>
    <%
        Utilisateur utilisateur = (Utilisateur) request.getAttribute("utilisateur");
        TypeUtilisateur type = utilisateur.getTypeUtilisateur();
        Role role = utilisateur.getRole();
        
        String typeBadgeClass = "";
        switch(type) {
            case ETUDIANT: typeBadgeClass = "badge-etudiant"; break;
            case ENSEIGNANT: typeBadgeClass = "badge-enseignant"; break;
            case PERSONNEL: typeBadgeClass = "badge-personnel"; break;
            case EXTERNE: typeBadgeClass = "badge-externe"; break;
        }
        
        String roleBadgeClass = "";
        switch(role) {
            case ADMIN: roleBadgeClass = "badge-admin"; break;
            case BIBLIOTHECAIRE: roleBadgeClass = "badge-bibliothecaire"; break;
            case LECTEUR: roleBadgeClass = "badge-lecteur"; break;
        }
    %>
    
    <div class="container">
        <h1>Profil Utilisateur</h1>
        <div class="subtitle">Sunu Bibliotek - Cyberboys</div>
        
        <div class="profile-header">
            <div class="profile-avatar">
                👤
            </div>
            <div class="profile-info">
                <h2><%= utilisateur.getNomComplet() %></h2>
                <p><strong>Numéro de carte:</strong> <%= utilisateur.getNumeroCarte() %></p>
                <p>
                    <span class="badge <%= typeBadgeClass %>"><%= type.getLibelle() %></span>
                    <span class="badge <%= roleBadgeClass %>"><%= role.getLibelle() %></span>
                </p>
            </div>
        </div>
        
        <div class="info-grid">
            <div class="info-item">
                <div class="info-label">Email</div>
                <div class="info-value"><%= utilisateur.getEmail() %></div>
            </div>
            
            <div class="info-item">
                <div class="info-label">Téléphone</div>
                <div class="info-value">
                    <%= utilisateur.getTelephone() != null ? utilisateur.getTelephone() : "Non renseigné" %>
                </div>
            </div>
            
            <div class="info-item">
                <div class="info-label">Date d'inscription</div>
                <div class="info-value"><%= utilisateur.getDateInscription() %></div>
            </div>
            
            <div class="info-item">
                <div class="info-label">Statut du compte</div>
                <div class="info-value">
                    <%
                        if (utilisateur.getActif()) {
                    %>
                        <span class="status-actif">✓ Actif</span>
                    <%
                        } else {
                    %>
                        <span class="status-inactif">✗ Inactif</span>
                    <%
                        }
                    %>
                </div>
            </div>
        </div>
        
        <div class="section-title">Historique des Emprunts</div>
        <div class="empty-message">
            <p>📚 Aucun emprunt pour le moment</p>
            <p style="font-size: 0.9em; margin-top: 10px;">
                L'historique des emprunts sera disponible après l'implémentation du module emprunts
            </p>
        </div>
        
        <div style="margin-top: 40px;">
            <a href="${pageContext.request.contextPath}/utilisateurs?action=edit&id=<%= utilisateur.getId() %>" 
               class="btn btn-primary">Modifier</a>
            <a href="${pageContext.request.contextPath}/utilisateurs" 
               class="btn btn-secondary">Retour à la liste</a>
        </div>
    </div>
</body>
</html>