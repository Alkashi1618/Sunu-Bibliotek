<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion - Sunu Bibliotek</title>
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
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }
        
        .login-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            overflow: hidden;
            max-width: 900px;
            width: 100%;
            display: flex;
        }
        
        .login-left {
            flex: 1;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 60px 40px;
            color: white;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        
        .login-left h1 {
            font-size: 2.5em;
            margin-bottom: 20px;
        }
        
        .login-left .subtitle {
            font-size: 1.2em;
            opacity: 0.9;
            margin-bottom: 30px;
        }
        
        .features {
            margin-top: 40px;
        }
        
        .feature-item {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
            font-size: 1.1em;
        }
        
        .feature-item span {
            font-size: 1.5em;
            margin-right: 15px;
        }
        
        .login-right {
            flex: 1;
            padding: 60px 40px;
        }
        
        .login-right h2 {
            color: #333;
            margin-bottom: 10px;
            font-size: 2em;
        }
        
        .login-subtitle {
            color: #666;
            margin-bottom: 40px;
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
        
        input[type="email"],
        input[type="password"] {
            width: 100%;
            padding: 15px;
            border: 2px solid #e2e8f0;
            border-radius: 10px;
            font-size: 1em;
            transition: all 0.3s;
        }
        
        input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }
        
        .btn-login {
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 1.1em;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.4);
        }
        
        .alert {
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
        }
        
        .alert-error {
            background: #fee;
            color: #c33;
            border: 1px solid #fcc;
        }
        
        .alert-error::before {
            content: "⚠️";
            margin-right: 10px;
            font-size: 1.2em;
        }
        
        .demo-credentials {
            background: #f7fafc;
            padding: 20px;
            border-radius: 10px;
            margin-top: 30px;
            font-size: 0.9em;
        }
        
        .demo-credentials h4 {
            color: #667eea;
            margin-bottom: 15px;
        }
        
        .demo-item {
            display: flex;
            justify-content: space-between;
            padding: 8px 0;
            border-bottom: 1px solid #e2e8f0;
        }
        
        .demo-item:last-child {
            border-bottom: none;
        }
        
        .demo-role {
            font-weight: 600;
            color: #333;
        }
        
        .demo-email {
            color: #666;
            font-family: monospace;
        }
        
        @media (max-width: 768px) {
            .login-container {
                flex-direction: column;
            }
            
            .login-left {
                padding: 40px 30px;
            }
            
            .login-right {
                padding: 40px 30px;
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <!-- Partie gauche - Présentation -->
        <div class="login-left">
            <div>
                <div style="font-size: 4em; margin-bottom: 20px;">📚</div>
                <h1>Sunu Bibliotek</h1>
                <p class="subtitle">Système de gestion de bibliothèque moderne</p>
                
                <div class="features">
                    <div class="feature-item">
                        <span>📖</span>
                        <span>Gestion des documents</span>
                    </div>
                    <div class="feature-item">
                        <span>🔄</span>
                        <span>Suivi des emprunts</span>
                    </div>
                    <div class="feature-item">
                        <span>👥</span>
                        <span>Multi-utilisateurs</span>
                    </div>
                    <div class="feature-item">
                        <span>📊</span>
                        <span>Statistiques en temps réel</span>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Partie droite - Formulaire -->
        <div class="login-right">
            <h2>Connexion</h2>
            <p class="login-subtitle">Connectez-vous pour accéder à votre espace</p>
            
            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    ${error}
                </div>
            </c:if>
            
            <form action="${pageContext.request.contextPath}/auth" method="post">
                <input type="hidden" name="action" value="login">
                
                <div class="form-group">
                    <label for="email"> Email</label>
                    <input type="email" id="email" name="email" required 
                           placeholder="votre.email@exemple.com"
                           value="admin@bibliotek.sn">
                </div>
                
                <div class="form-group">
                    <label for="motDePasse">🔒 Mot de passe</label>
                    <input type="password" id="motDePasse" name="motDePasse" required 
                           placeholder="••••••••"
                           value="admin123">
                </div>
                
                <button type="submit" class="btn-login">
                     Se connecter
                </button>
            </form>
            
            <!-- Identifiants de démo -->
            <div class="demo-credentials">
                <h4>🔑 Comptes de démonstration</h4>
                <div class="demo-item">
                    <span class="demo-role"> Admin</span>
                    <span class="demo-email">admin@bibliotek.sn</span>
                </div>
                <div class="demo-item">
                    <span class="demo-role"> Bibliothécaire</span>
                    <span class="demo-email">biblio@bibliotek.sn</span>
                </div>
                <div class="demo-item">
                    <span class="demo-role"> Lecteur</span>
                    <span class="demo-email">lecteur@bibliotek.sn</span>
                </div>
                <p style="margin-top: 10px; color: #999; font-size: 0.85em;">
                    Mot de passe pour tous : <strong>admin123</strong>
                </p>
            </div>
        </div>
    </div>
</body>
</html>