# Editeur Atom s'exécutant dans un conteneur via SSH.

Cette installation fonctionne que sous Linux X11.

## Inspiration des plugins de développement:

https://scotch.io/bar-talk/best-of-atom-features-plugins-acting-like-sublime-text

## Inspiration des plugins pour le développement Python:

http://www.marinamele.com/install-and-configure-atom-editor-for-python

## Utilisation

Pour construire l'image, on tape:

```
cd /..../docker_atom/
docker-compose build
docker-compose up -d

ssh -X ubuntu@localhost
ubuntu@localhost's password:
```

Le mot de passe est *ubuntu*

Le paramètre "-X" permet de créer un pont X11 pour l'affichage de Atom sur le
poste hôte bien que Atom s'exécute dans le conteneur.
