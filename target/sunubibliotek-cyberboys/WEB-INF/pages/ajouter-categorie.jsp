<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ajouter une Catégorie - Sunu Bibliotek</title>
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
            max-width: 700px;
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
        input[type="color"],
        textarea {
            width: 100%;
            padding: 12px;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 1em;
            transition: border-color 0.3s;
            font-family: inherit;
        }
        input:focus, textarea:focus {
            outline: none;
            border-color: #667eea;
        }
        textarea {
            resize: vertical;
            min-height: 100px;
        }
        .color-preview {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        .color-preview input[type="color"] {
            width: 60px;
            height: 50px;
            border: none;
            cursor: pointer;
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
    </style>
</head>
<body>
    <div class="container">
        <h1>Ajouter une Catégorie</h1>
        <div class="subtitle">Sunu Bibliotek - Cyberboys</div>
        
        <form action="${pageContext.request.contextPath}/categories" method="post">
            <input type="hidden" name="action" value="create">
            
            <div class="form-group">
                <label for="nom">Nom de la catégorie *</label>
                <input type="text" id="nom" name="nom" required 
                       placeholder="Ex: Littérature Africaine">
                <div class="help-text">Le nom doit être unique</div>
            </div>
            
            <div class="form-group">
                <label for="code">Code *</label>
                <input type="text" id="code" name="code" required 
                       placeholder="Ex: LIT-AFR" maxlength="20">
                <div class="help-text">Code court pour identifier la catégorie (max 20 caractères)</div>
            </div>
            
            <div class="form-group">
                <label for="description">Description</label>
                <textarea id="description" name="description" 
                          placeholder="Description de la catégorie..."></textarea>
            </div>
            
            <div class="form-group">
                <label for="couleur">Couleur</label>
                <div class="color-preview">
                    <input type="color" id="couleur" name="couleur" value="#667eea">
                    <span>Choisissez une couleur pour identifier visuellement cette catégorie</span>
                </div>
            </div>
            
            <div style="margin-top: 30px;">
                <button type="submit" class="btn btn-primary">Enregistrer</button>
                <a href="${pageContext.request.contextPath}/categories" 
                   class="btn btn-secondary">Annuler</a>
            </div>
        </form>
    </div>
</body>
</html>