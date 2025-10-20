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
        }
        .container {
            text-align: center;
            background: white;
            border-radius: 20px;
            padding: 60px 40px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            max-width: 600px;
        }
        h1 {
            color: #333;
            font-size: 3em;
            margin-bottom: 20px;
        }
        .logo {
            font-size: 5em;
            margin-bottom: 20px;
        }
        p {
            color: #666;
            font-size: 1.2em;
            margin-bottom: 40px;
            line-height: 1.6;
        }
        .subtitle {
            color: #667eea;
            font-weight: bold;
            font-size: 1.3em;
            margin-bottom: 30px;
        }
        .btn {
            display: inline-block;
            padding: 18px 40px;
            background: #667eea;
            color: white;
            text-decoration: none;
            border-radius: 10px;
            font-size: 1.2em;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }
        .btn:hover {
            background: #5568d3;
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.6);
        }
        .features {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 20px;
            margin-top: 40px;
        }
        .feature {
            padding: 20px;
            background: #f7fafc;
            border-radius: 10px;
        }
        .feature-icon {
            font-size: 2.5em;
            margin-bottom: 10px;
        }
        .feature-text {
            color: #4a5568;
            font-size: 0.9em;
            font-weight: 600;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="logo">📚</div>
        <h1>Sunu Bibliotek</h1>
        <div class="subtitle">Powered by Cyberboys 🚀</div>
        <p>
            Système de gestion de bibliothèque moderne<br>
            Gérez vos livres, revues et dictionnaires facilement
        </p>
        
        <a href="${pageContext.request.contextPath}/documents" class="btn">
            🚀 Accéder à la bibliothèque
        </a>
        
        <div class="features">
            <div class="feature">
                <div class="feature-icon">📖</div>
                <div class="feature-text">Livres</div>
            </div>
            <div class="feature">
                <div class="feature-icon">📰</div>
                <div class="feature-text">Revues</div>
            </div>
            <div class="feature">
                <div class="feature-icon">📕</div>
                <div class="feature-text">Dictionnaires</div>
            </div>
        </div>
    </div>
</body>
</html>