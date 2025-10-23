<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sunu Bibliotek - Cyberboys</title>
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
            position: relative;
            overflow: hidden;
        }
        body::before {
            content: "";
            position: absolute;
            width: 400px;
            height: 400px;
            background: rgba(255,255,255,0.1);
            border-radius: 50%;
            top: -100px;
            left: -100px;
            animation: float 6s ease-in-out infinite;
        }
        body::after {
            content: "";
            position: absolute;
            width: 300px;
            height: 300px;
            background: rgba(255,255,255,0.1);
            border-radius: 50%;
            bottom: -50px;
            right: -50px;
            animation: float 8s ease-in-out infinite;
        }
        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(20px); }
        }
        .container {
            text-align: center;
            background: white;
            border-radius: 30px;
            padding: 60px 50px;
            box-shadow: 0 25px 70px rgba(0,0,0,0.3);
            max-width: 700px;
            position: relative;
            z-index: 1;
            animation: slideUp 0.6s ease;
        }
        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        .logo {
            font-size: 6em;
            margin-bottom: 20px;
            animation: bounce 2s ease infinite;
        }
        @keyframes bounce {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }
        h1 {
            color: #333;
            font-size: 3.5em;
            margin-bottom: 15px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        .subtitle {
            color: #667eea;
            font-weight: bold;
            font-size: 1.4em;
            margin-bottom: 25px;
        }
        p {
            color: #666;
            font-size: 1.2em;
            margin-bottom: 40px;
            line-height: 1.6;
        }
        .btn {
            display: inline-block;
            padding: 20px 50px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-decoration: none;
            border-radius: 50px;
            font-size: 1.3em;
            font-weight: 600;
            transition: all 0.4s ease;
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.4);
            position: relative;
            overflow: hidden;
        }
        .btn::before {
            content: "";
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: rgba(255,255,255,0.2);
            transition: left 0.4s ease;
        }
        .btn:hover::before {
            left: 100%;
        }
        .btn:hover {
            transform: translateY(-5px) scale(1.05);
            box-shadow: 0 15px 40px rgba(102, 126, 234, 0.6);
        }
        .features {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 25px;
            margin-top: 50px;
        }
        .feature {
            padding: 25px;
            background: linear-gradient(135deg, #f7fafc 0%, #e2e8f0 100%);
            border-radius: 15px;
            transition: all 0.3s ease;
        }
        .feature:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }
        .feature-icon {
            font-size: 3em;
            margin-bottom: 15px;
        }
        .feature-text {
            color: #4a5568;
            font-size: 1.1em;
            font-weight: 600;
        }
        .version {
            margin-top: 40px;
            color: #a0aec0;
            font-size: 0.9em;
        }
        @media (max-width: 768px) {
            .container {
                padding: 40px 30px;
            }
            h1 {
                font-size: 2.5em;
            }
            .features {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="logo">📚</div>
        <h1>Sunu Bibliotek</h1>
        <div class="subtitle">Powered by Cyberboys 🚀</div>
        <p>
            Système de gestion de bibliothèque moderne et intuitif.<br>
            Gérez vos livres, revues et dictionnaires en toute simplicité.
        </p>
        
        <a href="${pageContext.request.contextPath}/login" class="btn">
            🔐 Se connecter
        </a>
        
        <div class="features">
            <div class="feature">
                <div class="feature-icon">📖</div>
                <div class="feature-text">Gestion des livres</div>
            </div>
            <div class="feature">
                <div class="feature-icon">📰</div>
                <div class="feature-text">Revues & Magazines</div>
            </div>
            <div class="feature">
                <div class="feature-icon">📕</div>
                <div class="feature-text">Dictionnaires</div>
            </div>
            <div class="feature">
                <div class="feature-icon">👥</div>
                <div class="feature-text">Gestion utilisateurs</div>
            </div>
            <div class="feature">
                <div class="feature-icon">📊</div>
                <div class="feature-text">Statistiques</div>
            </div>
            <div class="feature">
                <div class="feature-icon">🔒</div>
                <div class="feature-text">Sécurisé</div>
            </div>
        </div>
        
        <div class="version">
            Version 1.0 - Développé par Cyberboys Team<br>
            UCAD - Master 1 Informatique
        </div>
    </div>
</body>
</html>