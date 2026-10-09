# Pour aller plus loin – Démarrer avec Docker

Ces exercices sont facultatifs. Ils ne sont pas contrôlés par `verifier.sh`.

## 1. Un deuxième site, sur un autre port

Lancez un serveur **nginx** à côté d'Apache, sur le port 8081 :

```bash
docker run -d -p 8081:80 --name mon-nginx nginx:alpine
```

Ouvrez le port 8081 dans l'onglet **PORTS**. Deux conteneurs tournent en même temps, chacun isolé de l'autre. Pourquoi ne peut-on pas utiliser `-p 8080:80` une deuxième fois ?

## 2. Un shell interactif dans un conteneur

```bash
docker run -it --rm alpine sh
```

Dans ce shell, tapez `cat /etc/os-release`, puis `exit`. Que signifient `-it` et `--rm` ? Pourquoi le conteneur n'apparaît-il pas dans `docker ps -a` ensuite ?

## 3. Combien pèse une image ?

```bash
docker images
```

Comparez la taille de `httpd:2.4`, `nginx:alpine` et `alpine`. D'où vient la différence ?

## 4. Arrêter n'est pas supprimer

```bash
docker stop mon-site
docker ps
docker ps -a
docker start mon-site
```

Rechargez votre page : votre message est-il toujours là ? Et si vous supprimiez le conteneur avec `docker rm -f mon-site` puis le recréiez ? (Réponse en séance 4.) Pensez à relancer `docker start mon-site` avant `./verifier.sh`.

## 5. Faire le ménage

```bash
docker rm -f mon-nginx
docker container prune
```

Lisez l'avertissement de `prune` avant de confirmer : qu'est-ce qui va être supprimé ?
