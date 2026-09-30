# Guide de publication et mise à jour sur Typst Universe

Ce guide décrit la procédure pour publier une nouvelle version du template et package **`electrocentrale`** sur [Typst Universe](https://typst.app/universe/package/electrocentrale) (dépôt officiel [`typst/packages`](https://github.com/typst/packages)).

---

## 1. Prérequis

1. **GitHub CLI (`gh`)** configuré et authentifié :
   ```bash
   gh auth status
   ```
2. **Outil officiel de validation (`typst-package-check`)** :
   ```bash
   cargo install --git https://github.com/typst/package-check.git
   ```

   *(Installé sur la machine dans `~/.cargo/bin/typst-package-check`)*.
3. **Fork du dépôt `typst/packages`** :
   Un fork configuré sur votre compte GitHub (ex. `https://github.com/leonpwd/packages`).

---

## 2. Préparation sur le dépôt source (`Electrocentrale`)

1. **Incrémenter la version** :

   - Mettre à jour `version = "x.y.z"` dans [`typst.toml`](../typst.toml).
   - Mettre à jour la version importée dans [`template/main.typ`](../template/main.typ) :
     ```typst
     #import "@preview/electrocentrale:x.y.z": *
     ```
2. **Régénérer les aperçus (si les gabarits visuels évoluent)** :

   ```bash
   just preview
   ```
3. **Vérifier la conformité avec le linter officiel** :

   ```bash
   just check
   # ou directement : typst-package-check check .
   ```

   > Le retour doit afficher **0 erreur et 0 avertissement**.
   >
4. **Créer le commit et le tag de version sur GitHub** :
   Les images dans le `README.md` doivent pointer vers un commit ou tag figé :

   ```bash
   git add -A
   git commit -m "chore: release vX.Y.Z"
   git tag vX.Y.Z
   git push origin main --tags
   ```

---

## 3. Préparation du package dans `typst/packages`

Le registre Typst Universe n'attend dans `typst/packages` que les fichiers strictement requis au fonctionnement du package et du template (les documentations lourdes et exemples restent sur le dépôt source).

1. **Mettre à jour le fork local de `typst/packages`** :

   ```bash
   cd /chemin/vers/typst-packages   # ex: /tmp/typst-packages
   git checkout main
   git pull upstream main
   git checkout -b update-electrocentrale-X.Y.Z
   ```
2. **Créer le dossier de la nouvelle version** :

   ```bash
   mkdir -p packages/preview/electrocentrale/X.Y.Z
   ```
3. **Copier les 24 fichiers nécessaires** :
   Depuis le dépôt source `Electrocentrale` vers `packages/preview/electrocentrale/X.Y.Z/` :

   - `typst.toml`
   - `LICENSE`
   - `README.md`
   - `thumbnail.png`
   - `lib.typ`
   - Dossier `src/` (tous les fichiers sources Typst)
   - Dossier `template/` (`main.typ`)
   - Dossier `assets/images/` (`elec.png`, `logo-ece.svg`)

   *Fichiers à ne pas copier* : `.git`, `.github`, `.vscode`, `docs/`, `examples/`, `justfile`, `.DS_Store`, `*.pdf`.
4. **Valider localement avec l'outil officiel** :
   Depuis le dossier `packages/` du dépôt `typst/packages` :

   ```bash
   typst-package-check check @preview/electrocentrale:X.Y.Z
   ```

   Et tester la compilation du template :

   ```bash
   typst compile packages/preview/electrocentrale/X.Y.Z/template/main.typ /tmp/test-template.pdf
   ```

---

## 4. Création de la Pull Request sur `typst/packages`

1. **Créer le commit et pousser la branche** :
   Le message de commit **doit impérativement respecter** le format `nom:version` :

   ```bash
   git add packages/preview/electrocentrale/X.Y.Z
   git commit -m "electrocentrale:X.Y.Z"
   git push -u origin update-electrocentrale-X.Y.Z
   ```
2. **Ouvrir la Pull Request** :

   ```bash
   gh pr create --repo typst/packages --base main --title "electrocentrale:X.Y.Z"
   ```
3. **Remplir la checklist pour une mise à jour** :
   Cocher `an update for a package` et lister brièvement les nouveautés :

   ```markdown
   I am submitting
   - [ ] a new package
   - [x] an update for a package

   Description: Update electrocentrale to vX.Y.Z:
   - Brief list of new features, bug fixes, or improvements.
   ```
4. **Suivi des bots CI** :
   Les tests automatiques (`@typst-package-check`, `Lint`, `Test`) doivent tous être au vert.
