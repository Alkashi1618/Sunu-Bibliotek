<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="sn.ucad.m1.sunubibliotek.Cyberboys.entities.*" %>
<%
    Utilisateur currentUser = (Utilisateur) session.getAttribute("utilisateur");
    String currentPage = request.getRequestURI();
%>

<style>
    .top-header {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        padding: 15px 40px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    }
    .top-header-content {
        max-width: 1400px;
        margin: 0 auto;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    .logo-section {
        display: flex;
        align-items: center;
        gap: 15px;
    }
    .logo-section .logo-icon {
        font-size: 2em;
    }
    .logo-section h1 {
        font-size: 1.5em;
        margin: 0;
    }
    .logo-section small {
        opacity: 0.9;
    }
    .user-section {
        display: flex;
        align-items: center;
        gap: 20px;
    }
    .user-info {
        text-align: right;
    }
    .user-info strong {
        display: block;
        margin-bottom: 3px;
    }
    .user-info small {
        opacity: 0.9;
    }
    .btn-logout {
        padding: 10px 20px;
        background: rgba(255,255,255,0.2);
        color: white;
        border: 2px solid white;
        border-radius: 8px;
        text-decoration: none;
        font-weight: 600;
        transition: all 0.3s;
    }
    .btn-logout:hover {
        background: white;
        color: #667eea;
    }
    .main-nav {
        background: white;
        box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        padding: 0 40px;
        position: sticky;
        top: 0;
        z-index: 100;
    }
    .main-nav-content {
        max-width: 1400px;
        margin: 0 auto;
        display: flex;
        gap: 30px;
    }
    .main-nav a {
        display: inline-block;
        padding: 20px 0;
        color: #4a5568;
        text-decoration: none;
        font-weight: 600;
        border-bottom: 3px solid transparent;
        transition: all 0.3s;
    }
    .main-nav a:hover, .main-nav a.active {
        color: #667eea;
        border-bottom-color: #667eea;
    }
    .flash-messages {
        max-width: 1400px;
        margin: 20px auto;
        padding: 0 40px;
    }
    .alert {
        padding: 15px 20px;
        border-radius: 8px;
        margin-bottom: 15px;
        display: flex;
        align-items: center;
        gap: 10px;
        animation: slideIn 0.3s ease;
    }
    @keyframes slideIn {
        from {
            transform: translateY(-20px);
            opacity: 0;
        }
        to {
            transform: translateY(0);
            opacity: 1;
        }
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
    .alert-warning {
        background: #feebc8;
        color: #744210;
        border-left: 4px solid #ed8936;
    }
    .alert-info {
        background: #bee3f8;
        color: #2c5282;
        border-left: 4px solid #4299e1;
    }
</style>

<!-- Header -->
<div class="top-header">
    <div class="top-header-content">
        <div class="logo-section">
            <div class="logo-icon">📚</div>
            <div>
                <h1>Sunu Bibliotek</h1>
                <small>Powered by Cyberboys</small>
            </div>
        </div>
        <div class="user-section">
            <div class="user-info">
                <strong><%= currentUser.getNomComplet() %></strong>
                <small><%= currentUser.getRole().getLibelle() %> - <%= currentUser.getNumeroCarte() %></small>
            </div>
            <a href="${pageContext.request.contextPath}/logout" class="btn-logout">
                Déconnexion
            </a>
        </div>
    </div>
</div>

<!-- Navigation -->
<div class="main-nav">
    <div class="main-nav-content">
        <a href="${pageContext.request.contextPath}/dashboard" 
           class="<%= currentPage.contains("dashboard") ? "active" : "" %>">
            🏠 Tableau de bord
        </a>
        <a href="${pageContext.request.contextPath}/documents" 
           class="<%= currentPage.contains("documents") ? "active" : "" %>">
            📚 Documents
        </a>
        <a href="${pageContext.request.contextPath}/emprunts" 
           class="<%= currentPage.contains("emprunts") ? "active" : "" %>">
            📖 Emprunts
        </a>
        <a href="${pageContext.request.contextPath}/reservations" 
           class="<%= currentPage.contains("reservations") ? "active" : "" %>">
            📋 Réservations
        </a>
        <% if (currentUser.estBibliothecaire()) { %>
            <a href="${pageContext.request.contextPath}/utilisateurs" 
               class="<%= currentPage.contains("utilisateurs") ? "active" : "" %>">
                👥 Utilisateurs
            </a>
            <a href="${pageContext.request.contextPath}/categories" 
               class="<%= currentPage.contains("categories") ? "active" : "" %>">
                📁 Catégories
            </a>
            <a href="${pageContext.request.contextPath}/statistiques" 
               class="<%= currentPage.contains("statistiques") ? "active" : "" %>">
                📊 Statistiques
            </a>
        <% } %>
    </div>
</div>

<!-- Flash Messages -->
<div class="flash-messages">
    <% if (session.getAttribute("success") != null) { %>
        <div class="alert alert-success">
            ✓ <%= session.getAttribute("success") %>
        </div>
        <% session.removeAttribute("success"); %>
    <% } %>
    
    <% if (session.getAttribute("error") != null) { %>
        <div class="alert alert-error">
            ✗ <%= session.getAttribute("error") %>
        </div>
        <% session.removeAttribute("error"); %>
    <% } %>
    
    <% if (session.getAttribute("warning") != null) { %>
        <div class="alert alert-warning">
            ⚠ <%= session.getAttribute("warning") %>
        </div>
        <% session.removeAttribute("warning"); %>
    <% } %>
    
    <% if (session.getAttribute("info") != null) { %>
        <div class="alert alert-info">
            ℹ <%= session.getAttribute("info") %>
        </div>
        <% session.removeAttribute("info"); %>
    <% } %>
</div>