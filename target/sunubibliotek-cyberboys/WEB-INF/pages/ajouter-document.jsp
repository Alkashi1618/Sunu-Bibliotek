<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ajouter un Document - Sunu Bibliotek</title>
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
        input[type="number"],
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
        .dynamic-fields {
            margin-top: 20px;
            padding: 20px;
            background: #f7fafc;
            border-radius: 8px;
        }
        .hidden {
            display: none;
        }
    </style>
    <script>
        function showFields() {
            var type = document.getElementById('type').value;
            
            document.getElementById('livre-fields').classList.add('hidden');
            document.getElementById('revue-fields').classList.add('hidden');
            document.getElementById('dictionnaire-fields').classList.add('hidden');
            
            if (type === 'livre') {
                document.getElementById('livre-fields').classList.remove('hidden');
            } else if (type === 'revue') {
                document.getElementById('revue-fields').classList.remove('hidden');
            } else if (type === 'dictionnaire') {
                document.getElementById('dictionnaire-fields').classList.remove('hidden');
            }
        }
        
        window.onload = function() {
            showFields();
        }
    </script>
</head>
<body>
    <div class="container">
        <h1>➕ Ajouter un Document</h1>
        <div class="subtitle">Sunu Bibliotek - Cyberboys</div>
        
        <form action="${pageContext.request.contextPath}/documents" method="post">
            <input type="hidden" name="action" value="create">
            
            <div class="form-group">
                <label for="type">Type de document *</label>
                <select id="type" name="type" required onchange="showFields()">
                    <option value="">-- Sélectionner --</option>
                    <option value="livre">📖 Livre</option>
                    <option value="revue">📰 Revue</option>
                    <option value="dictionnaire">📕 Dictionnaire</option>
                </select>
            </div>
            
            <div class="form-group">
                <label for="titre">Titre *</label>
                <input type="text" id="titre" name="titre" required 
                       placeholder="Entrez le titre du document">
            </div>
            
            <!-- Champs spécifiques pour Livre -->
            <div id="livre-fields" class="dynamic-fields hidden">
                <div class="form-group">
                    <label for="auteur">Auteur *</label>
                    <input type="text" id="auteur" name="auteur" 
                           placeholder="Nom de l'auteur">
                </div>
                <div class="form-group">
                    <label for="nbrPages">Nombre de pages *</label>
                    <input type="number" id="nbrPages" name="nbrPages" min="1"
                           placeholder="Ex: 250">
                </div>
            </div>
            
            <!-- Champs spécifiques pour Revue -->
            <div id="revue-fields" class="dynamic-fields hidden">
                <div class="form-group">
                    <label for="mois">Mois *</label>
                    <select id="mois" name="mois">
                        <option value="1">Janvier</option>
                        <option value="2">Février</option>
                        <option value="3">Mars</option>
                        <option value="4">Avril</option>
                        <option value="5">Mai</option>
                        <option value="6">Juin</option>
                        <option value="7">Juillet</option>
                        <option value="8">Août</option>
                        <option value="9">Septembre</option>
                        <option value="10">Octobre</option>
                        <option value="11">Novembre</option>
                        <option value="12">Décembre</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="annee">Année *</label>
                    <input type="number" id="annee" name="annee" min="1900" max="2100"
                           placeholder="Ex: 2025">
                </div>
            </div>
            
            <!-- Champs spécifiques pour Dictionnaire -->
            <div id="dictionnaire-fields" class="dynamic-fields hidden">
                <div class="form-group">
                    <label for="langue">Langue *</label>
                    <input type="text" id="langue" name="langue" 
                           placeholder="Ex: Français, Anglais, Wolof...">
                </div>
            </div>
            
            <div style="margin-top: 30px;">
                <button type="submit" class="btn btn-primary">✅ Enregistrer</button>
                <a href="${pageContext.request.contextPath}/documents" 
                   class="btn btn-secondary">❌ Annuler</a>
            </div>
        </form>
    </div>
</body>
</html>