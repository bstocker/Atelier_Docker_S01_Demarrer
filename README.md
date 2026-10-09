# Atelier Docker – Démarrer : GitHub, Codespaces et votre premier conteneur

> **Module :** Atelier virtualisation et conteneurs (TRDE 513) · **Séance 1** · **Durée : 45 min environ**
> **Cours associé :** séance 1 sur 360Learning (à suivre en parallèle : chaque étape y est expliquée)

## Objectifs

À la fin de cet atelier, je suis capable de :

- lancer un environnement de travail Docker en ligne avec GitHub Codespaces ;
- démarrer un conteneur à partir d'une image publique ;
- publier un service web avec l'option `-p` et l'ouvrir dans mon navigateur ;
- observer et modifier un conteneur (`ps`, `logs`, `exec`).

## Prérequis

- Un navigateur web récent (Chrome, Firefox, Edge…)
- Une adresse e-mail valide pour créer un compte GitHub

Vous n'avez **rien à installer** : Codespaces fournit un environnement Linux en ligne, avec Docker déjà installé.

---

## Étape 1 – Créer un compte GitHub
  
> Si vous avez déjà un compte GitHub, passez directement à l'étape 2.  
  
1. Rendez-vous sur [https://github.com](https://github.com).
2. Cliquez sur **Sign up** et suivez les instructions.
3. Validez votre adresse e-mail.
  
---

## Étape 2 – Créer votre copie de l'atelier et lancer un Codespace

1. En haut de cette page, cliquez sur le bouton vert **Use this template** → **Create a new repository**.
2. Laissez votre compte comme **Owner**, gardez le nom proposé, choisissez **Private** si vous le souhaitez, puis cliquez sur **Create repository**.
3. Sur la page de **votre** repository, cliquez sur **Code** → onglet **Codespaces** → **Create codespace on main**.

Patientez quelques instants : un éditeur VS Code s'ouvre dans votre navigateur. Le terminal se trouve en bas de l'écran (sinon : menu **☰** → **Terminal** → **New Terminal**).

Vérifiez que Docker répond :

```bash
docker --version
```

> ⚠️ Travaillez toujours depuis **votre** repository, pas depuis le modèle d'origine.

---

## Étape 3 – Votre tout premier conteneur

```bash
docker run hello-world
```

Docker ne trouve pas l'image `hello-world` sur votre machine : il la **télécharge** depuis le registre Docker Hub, **crée** un conteneur, l'**exécute**, puis le conteneur s'arrête une fois son message affiché.

Lisez le message affiché : il résume les étapes que Docker vient de réaliser.

---

## Étape 4 – Lancer un serveur web

```bash
docker run -d -p 8080:80 --name mon-site httpd:2.4
```

| Élément            | Signification                                                                 |
|--------------------|-------------------------------------------------------------------------------|
| `docker run`       | Crée et démarre un nouveau conteneur                                          |
| `-d`               | Mode *détaché* : le conteneur tourne en arrière-plan                          |
| `-p 8080:80`       | Redirige le port 8080 du Codespace vers le port 80 du conteneur               |
| `--name mon-site`  | Donne un nom au conteneur, pour le retrouver facilement                       |
| `httpd:2.4`        | L'image à utiliser : le serveur web Apache officiel, version 2.4, depuis Docker Hub |

Vérifiez que le conteneur tourne :

```bash
docker ps
```

Vous devez voir une ligne `mon-site` avec le statut `Up` et la colonne `PORTS` qui indique `0.0.0.0:8080->80/tcp`.

---

## Étape 5 – Ouvrir votre site

1. Ouvrez l'onglet **PORTS** (à côté de l'onglet **TERMINAL**).
2. Sur la ligne du port **8080**, cliquez sur l'icône 🌐 (**Open in Browser**).

Vous devez voir la page **« It works! »**.

Vous pouvez aussi interroger le site depuis le terminal :

```bash
curl http://localhost:8080
```

Regardez maintenant le journal du serveur : chaque visite y apparaît.

```bash
docker logs mon-site
```

---

## Étape 6 – Entrer dans le conteneur

Un conteneur est un environnement isolé, mais vous pouvez y exécuter des commandes avec `docker exec`.

Affichez la page servie par Apache :

```bash
docker exec mon-site cat /usr/local/apache2/htdocs/index.html
```

Remplacez-la par votre propre page (mettez votre prénom à la place de `<prenom>`) :

```bash
docker exec mon-site sh -c 'echo "<h1>Bonjour, je suis <prenom> et ceci est mon premier conteneur</h1>" > /usr/local/apache2/htdocs/index.html'
```

Rechargez la page dans votre navigateur : votre message s'affiche.

| Élément               | Signification                                                    |
|-----------------------|------------------------------------------------------------------|
| `docker exec`         | Exécute une commande dans un conteneur **déjà démarré**          |
| `mon-site`            | Le conteneur visé                                                |
| `sh -c '...'`         | Lance un shell qui exécute la commande entre apostrophes         |

---

## ✅ Vérifier votre travail

Votre conteneur `mon-site` doit être **démarré** avec votre page personnalisée. Lancez :

```bash
./verifier.sh
```

Le script contrôle chaque étape. Si tout est `[OK]`, il affiche un **code de validation** : saisissez-le dans le quiz de la séance 1 sur **360Learning**.

---

## À retenir

- Une **image** est un modèle en lecture seule ; un **conteneur** est une instance démarrée de cette image.
- `docker run` = téléchargement de l'image si besoin + création + démarrage du conteneur.
- `-d` lance en arrière-plan, `-p hôte:conteneur` publie un port, `--name` nomme le conteneur.
- `docker ps`, `docker logs`, `docker exec` permettent d'observer et d'agir sur un conteneur.
- `docker exec` agit dans un conteneur existant ; modifier un conteneur ne modifie jamais son image.

## Pour aller plus loin

Exercices facultatifs dans le dossier [`bonus/`](bonus/README.md).

---

> ⚠️ Pensez à **arrêter votre Codespace** quand vous avez terminé (bouton **Code** → onglet **Codespaces** → **…** → **Stop codespace**) afin de ne pas consommer inutilement votre quota d'heures gratuites.
