# Tutoriel : Ecrire son premier rapport ECE avec Typst

[📖 Tutoriel](tutoriel.md) · [⚙️ Paramètres de configuration](parametres.md) · [🛠️ Composants d'ingénierie](composants.md)

Ce guide s'adresse aux etudiants qui n'ont jamais utilise Typst. Il couvre l'installation, la configuration de l'editeur et la redaction d'un rapport complet avec le template `ece-reports`.

---

## 1. Installer Typst

### macOS

Brew est le [gestionnaire de paquets](https://brew.sh/) le plus populaire sur MacOS

```bash
brew install typst
```

### Windows

Winget est la méthode officielle d'installation de paquets sur WIndows

```powershell
winget install --id Typst.Typst
```

### Linux

Typst est disponible dans les dépôts officiels de : [Arch](https://archlinux.org/packages/extra/x86_64/typst/) (`pacman -S typst`), [Nix](https://search.nixos.org/packages?query=typst) (`nix-env -iA nixpkgs.typst`), [Alpine](https://pkgs.alpinelinux.org/packages?name=typst) (`apk add typst`), [Void](https://github.com/void-linux/void-packages/tree/master/srcpkgs/typst) (`xbps-install typst`), [Snap](https://snapcraft.io/typst) (`snap install typst`).

Si votre distribution n'est pas listée, il faudra l'installer via Cargo, le gestionnaire de paquets Rust :

```bash
cargo install --locked typst-cli
```

### Vérifier l'installation

```bash
typst --version
```

La commande doit afficher un numero de version (idéalement 0.15.0 ou supérieur).

---

## 2. Editer un rapport

### Installer VS Code

Telecharger et installer VS Code depuis [code.visualstudio.com](https://code.visualstudio.com/).

### Installer l'extension Tinymist

Tinymist est l'extension de reference pour editer du Typst dans VS Code. Elle fournit la coloration syntaxique, l'autocompletion, la verification d'erreurs en temps reel et un apercu PDF integre.

1. Visiter : [marketplace.visualstudio.com/items?itemName=myriad-dreamin.tinymist](https://marketplace.visualstudio.com/items?itemName=myriad-dreamin.tinymist)
2. Cliquer sur "Install" et accepter l'ouverture du lien dans VSCode

### Collaborer en temps réel sur un rapport :

[typst.app](https://typst.app/) est le site Officiel Typst pour collaborer gratuitement en temps réel à la manière d'un Google Docs. Il suffit de créer un compte et de créer un document vierge sur le dashboard et de lui donner un nom.

**TODO : Publier le template sur Typst.app pour import rapide en une ligne**

#### Import du template

Téléchargez la dernière version du template :

```Shell
git clone github.com/leonpwd/ece-reports.git
```

Une fois le document ouvert sur Typst.app, suivez la procédure suivante pour importer le template ECE :

1. File
2. "Upload file"
3. "Pick a Folder"
4. Choisissez le dossier téléchargé depuis Github
5. "Upload 45 files"

Sur `main.typ`, vous pouvez maintenant importer le template avec un chemin relatif vers `lib.typ` :

```typst
#import "ece-reports/lib.typ": *
```

Le reste du fichier s'utilise exactement comme avec `@preview` (voir section 4). Remplacez simplement la ligne d'import.

---

### Collaboration via VS Code (Live Share)

[Live Share](https://marketplace.visualstudio.com/items?itemName=MS-vsliveshare.vsliveshare) est une extension Microsoft qui permet a plusieurs personnes d'editer le meme projet simultanement dans VS Code. Le principal facteur limitant est l'impossibilite pour les invites de voir le rendu en temps reel.

Chaque participant voit les modifications des autres en temps reel. Le host (celui qui partage) doit avoir Tinymist installe pour que l'autocompletion et la verification d'erreurs fonctionnent pour tout le monde.

Note : l'apercu PDF n'est visible que sur la machine du host. Les guests editent le code mais ne voient pas le rendu en direct.

---

## 3. Creer un nouveau rapport

Ouvrir un terminal et executer :

```bash
git clone https://github.com/leonpwd/ece-reports.git mon-rapport
cd mon-rapport
```

Le dossier contient le template et des exemples prets a l'emploi. Copier un exemple comme point de depart :

```bash
cp examples/rapport-tp/rapport-tp.typ main.typ
```

### Ouvrir le dossier dans VS Code

```bash
code mon-rapport
```

Ou bien : VS Code > Fichier > Ouvrir un dossier > selectionner `mon-rapport`.

### Lancer l'apercu en temps reel

Ouvrir `main.typ` dans VS Code, puis :

- `Cmd+Shift+P` (macOS) ou `Ctrl+Shift+P` (Windows/Linux)
- Taper **Tinymist: Preview** et valider

Un panneau s'ouvre avec l'apercu PDF. Chaque modification du fichier met a jour l'apercu automatiquement.

Alternativement, depuis le terminal :

```bash
typst watch main.typ
```

Cela recompile le PDF a chaque sauvegarde.

---

## 4. Comprendre la structure du fichier

Le fichier `main.typ` genere par `typst init` ressemble a ceci :

```typst
#import "@preview/ece-reports:0.1.0": *

#let langue = "fr"
#let style-police = "latex"

#show: tp.with(
  lang: langue,
  title: "Filtres Actifs et Traitement du Signal",
  tp-num: "1",
  promo: "ING5",
  major: "Systemes Embarques",
  groupe: "Groupe 02",
  authors: (
    (name: "Andre-Marie AMPERE", email: "ampere@ece.fr", role: "Electronique analogique"),
    (name: "Alessandro VOLTA", email: "volta@ece.fr", role: "Mesures et banc de test"),
  ),
  supervisor: (name: "Dr. Jean DUPONT", email: "jean.dupont@ece.fr"),
  date: auto,
  abstract: [Resume du rapport.],
  font: font-presets.at(style-police, default: "New Computer Modern"),
)
```

Les points importants :

- `#import` charge le template. Ne pas modifier cette ligne.
- `#show: tp.with(...)` applique le modele "Rapport de TP". Remplacer `tp` par `projet` ou `conception` pour changer de modele.
- Tous les parametres entre parentheses sont optionnels sauf `title`.

---

## 5. Rediger le contenu

Le contenu se place **apres** le bloc `#show: tp.with(...)`.

### Titres

```typst
= Titre de partie
== Sous-partie
=== Sous-sous-partie
```

### Questions de TP

Le template fournit deux fonctions pour les questions :

```typst
#t(1)[Calculer la fonction de transfert du filtre.]

#e(1)[Relever les mesures experimentales.]
```

`#t(n)` genere une question theorique numerotee, `#e(n)` une question experimentale.

### Equations

```typst
$ H(j omega) = - R_2 / R_1 dot 1 / (1 + j omega / omega_0) $ <eq:transfert>
```

Pour referencer l'equation dans le texte : `voir @eq:transfert`.

### Figures

```typst
#figure(
  image("schema.png", width: 80%),
  caption: [Schema du montage],
) <fig:schema>
```

Pour referencer la figure : `voir @fig:schema`.

Placer les images dans le meme dossier que `main.typ` ou dans un sous-dossier `images/`.

### Tableaux

```typst
#figure(
  table(
    columns: 3,
    [Frequence (Hz)], [Gain (dB)], [Phase (deg)],
    [100], [-0.2], [-5.7],
    [1000], [-3.0], [-45],
    [10000], [-20.1], [-84],
  ),
  caption: [Mesures experimentales],
) <tab:mesures>
```

### Encarts / callouts

```typst
#callout(title: "Attention", type: "warning")[
  Verifier l'alimentation avant la mise sous tension.
]
```

Les types disponibles : `"info"`, `"warning"`, `"tip"`, `"danger"`.

### Code source

````typst
```c
void main(void) {
    HAL_Init();
    SystemClock_Config();
}
```
````

### Annexes

A la fin du document :

```typst
#show: annexes

= Annexe A : Code source

Le code complet du projet.
```

---

## 6. Changer de modele

Le template propose trois modeles interchangeables. Tous les parametres sont partages : il suffit de changer le nom de la fonction.

### Rapport de TP

```typst
#show: tp.with(
  title: "Mon TP",
  tp-num: "3",
  ...
)
```

### Rapport de projet

```typst
#show: projet.with(
  title: "Mon Projet",
  ...
)
```

### Document de conception

```typst
#show: conception.with(
  title: "Conception du Systeme",
  ...
)
```

Les modeles `projet` et `conception` activent automatiquement la table des matieres. Le modele `tp` ne l'active pas par defaut (ajoutez `table-of-contents: true` pour la forcer).

---

## 7. Changer le style typographique

Quatre styles de police sont disponibles :

| Valeur             | Rendu                                       |
| :----------------- | :------------------------------------------ |
| `"latex"`        | Style LaTeX classique (New Computer Modern) |
| `"typst-modern"` | Style moderne (Libertinus Serif)            |
| `"modern-sans"`  | Sans-serif contemporain (Helvetica / Arial) |
| `"editorial"`    | Style publication scientifique (Charter)    |

Pour changer :

```typst
#let style-police = "modern-sans"
```

---

## 8. Compiler en PDF

### Depuis VS Code

L'apercu Tinymist genere le PDF automatiquement. Pour exporter manuellement :

- `Cmd+Shift+P` > **Tinymist: Export PDF**

### Depuis le terminal

```bash
# Compilation unique
typst compile main.typ

# Compilation continue (recompile a chaque sauvegarde)
typst watch main.typ
```

Le fichier `main.pdf` est genere dans le meme dossier.

---

## 9. Problemes courants

**"package not found" a la compilation**

Le package se telecharge automatiquement depuis Typst Universe lors de la premiere compilation. Verifier la connexion internet.

**L'apercu Tinymist ne s'affiche pas**

S'assurer que l'extension Tinymist est bien installee et que le fichier ouvert a l'extension `.typ`.

**Les accents s'affichent mal**

Verifier que le fichier est encode en UTF-8. VS Code l'utilise par defaut.

**Je veux utiliser une bibliographie**

Creer un fichier `refs.bib` dans le meme dossier, puis ajouter en fin de document :

```typst
#bibliography("refs.bib", style: "ieee")
```

---

## Ressources

- [Documentation Typst](https://typst.app/docs/) -- référence officielle du langage Typst
- [Typst Universe](https://typst.app/universe/) -- packages et templates communautaires
- [⚙️ Référence des paramètres](parametres.md) -- tableau exhaustif des options des 4 modèles
- [🛠️ Composants d'ingénierie](composants.md) -- schémas vectoriels, diagrammes UML et utilitaires ECE
