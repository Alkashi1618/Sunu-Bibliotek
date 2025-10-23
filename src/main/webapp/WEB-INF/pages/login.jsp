<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
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
            max-width: 1000px;
            width: 100%;
            display: grid;
            grid-template-columns: 1fr 1fr;
        }
        .login-banner {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 60px 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
        }
        .login-banner .logo {
            font-size: 5em;
            margin-bottom: 20px;
        }
        .login-banner h1 {
            font-size: 2.5em;
            margin-bottom: 20px;
        }
        .login-banner p {
            font-size: 1.1em;
            opacity: 0.9;
        }
        .login-form-container {
            padding: 60px 40px;
        }
        .login-form-container h2 {
            color: #333;
            margin-bottom: 10px;
            font-size: 2em;
        }
        .subtitle {
            color: #718096;
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
            border-radius: 8px;
            font-size: 1em;
            transition: border-color 0.3s;
        }
        input:focus {
            outline: none;
            border-color: #667eea;
        }
        .btn {
            width: 100%;
            padding: 15px;
            background: #667eea;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 1.1em;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .btn:hover {
            background: #5568d3;
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.4);
        }
        .alert {
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-weight: 500;
        }
        .alert-error {
            background: #fed7d7;
            color: #742a2a;
            border-left: 4px solid #e53e3e;
        }
        .alert-info {
            background: #bee3f8;
            color: #2c5282;
            border-left: 4px solid #4299e1;
        }
        .demo-credentials {
            background: #f7fafc;
            padding: 20px;
            border-radius: 8px;
            margin-top: 30px;
        }
        .demo-credentials h3 {
            color: #2d3748;
            margin-bottom: 15px;
            font-size: 1.1em;
        }
        .demo-credentials .credential-item {
            background: white;
            padding: 10px;
            border-radius: 6px;
            margin-bottom: 10px;
            border: 1px solid #e2e8f0;
        }
        .demo-credentials .credential-item strong {
            color: #667eea;
        }
        .demo-credentials .credential-item small {
            color: #718096;
            display: block;
            margin-top: 5px;
        }
        @media (max-width: 768px) {
            .login-container {
                grid-template-columns: 1fr;
            }
            .login-banner {
                padding: 40px 20px;
            }
            .login-form-container {
                padding: 40px 20px;
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-banner">
            <div class="logo">📚</div>
            <h1>Sunu Bibliotek</h1>
            <p>Powered by Cyberboys</p>
            <p style="margin-top: 20px; font-size: 0.9em;">
                Système de gestion de bibliothèque moderne
            </p>
        </div>
        
        <div class="login-form-container">
            <h2>Connexion</h2>
            <p class="subtitle">Accédez à votre espace</p>
            
            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    ${error}
                </div>
            </c:if>
            
            <c:if test="${not empty info}">
                <div class="alert alert-info">
                    ${info}
                </div>
            </c:if>
            
            <form action="${pageContext.request.contextPath}/login" method="post">
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" required 
                           placeholder="votre@email.com"
                           value="<c:out value='${email}'/>">
                </div>
                
                <div class="form-group">
                    <label for="motDePasse">Mot de passe</label>
                    <input type="password" id="motDePasse" name="motDePasse" required 
                           placeholder="Votre mot de passe">
                </div>
                
                <button type="submit" class="btn">Se connecter</button>
            </form>
            
            <div class="demo-credentials">
                <h3>Comptes de démonstration</h3>
                <div class="credential-item">
                    <strong>Admin:</strong> admin@bibliotek.sn
                    <small>Mot de passe: admin123</small>
                </div>
                <div class="credential-item">
                    <strong>Bibliothécaire:</strong> biblio@bibliotek.sn
                    <small>Mot de passe: biblio123</small>
                </div>
                <div class="credential-item">
                    <strong>Lecteur:</strong> lecteur@bibliotek.sn
                    <small>Mot de passe: lecteur123</small>
                </div>
            </div>
        </div>
    </div>
</body>
</html>