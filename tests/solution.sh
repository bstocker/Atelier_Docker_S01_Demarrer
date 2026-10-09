#!/usr/bin/env bash
# Déroulé complet de l'atelier, utilisé par l'intégration continue pour vérifier
# que l'atelier fonctionne toujours (images disponibles, commandes valides).
set -euo pipefail
docker run hello-world
docker run -d -p 8080:80 --name mon-site httpd:2.4
sleep 3
curl -s http://localhost:8080
docker exec mon-site sh -c 'echo "<h1>Bonjour, je suis CI et ceci est mon premier conteneur</h1>" > /usr/local/apache2/htdocs/index.html'
docker stop mon-site
docker start mon-site
sleep 2
curl -s http://localhost:8080
