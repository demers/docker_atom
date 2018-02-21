#!/bin/bash
apm install autocomplete-php
#Génère des erreurs sous Linux.
#RUN apm install auto-update-packages
apm install autocomplete-modules
apm install autocomplete-nunjucks
apm install color-picker
apm install config-import-export
apm install custom-title
apm install docblockr
apm install editor-stats
apm install editorconfig
apm install emmet
apm install file-icons
apm install git-plus
apm install highlight-line
apm install highlight-selected
apm install improved-chester-atom-syntax
apm install language-babel
apm install language-nunjucks
apm install linter
apm install linter-eslint
apm install merge-conflicts
apm install monokai
apm install opened-files
apm install pigments
apm install project-manager
apm install project-quick-open
# Incompatible à language-babel
#apm install react
apm install simple-drag-drop-text
apm install sort-lines
apm install tabs-to-spaces
apm install tree-view-autoresize
apm install tree-view-git-status

#Seulement pour les connaisseurs de VIM
#apm install vim-mode-plus

#Ne semble plus exister.
#RUN apm install waka

# Pour le développement Python
# Inspiré de http://www.marinamele.com/install-and-configure-atom-editor-for-python
# Il faut que flake8 soit installé comme suit:
#   pip install flake8
#   pip install flake8-docstrings
apm install linter-flake8

sleep 1
mv -f plugins.bash plugins_atom.bash

