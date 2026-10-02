# 📖 Tutoriel : Rédiger son premier rapport ECE avec Typst

[📖 Tutoriel](tutoriel.md) · [⚙️ Paramètres de configuration](parametres.md) · [🛠️ Composants d'ingénierie](composants.md)

Ce guide s'adresse aux étudiants et enseignants de l'ECE Paris, qu'ils découvrent Typst pour la première fois ou qu'ils souhaitent migrer un projet existant. Il présente les deux environnements de travail possibles (**l'application Web officielle collaborative** ou **l'environnement local VS Code**) et détaille pas à pas la rédaction d'un rapport avec le modèle `electrocentrale`.

---

## 1. Choisir son environnement de travail

Deux approches s'offrent à vous selon vos préférences de travail :

```
┌────────────────────────────────────────────────────────┐
│               Comment souhaitez-vous rédiger ?         │
└────────────────────────────────────────────────────────┘
            │                                  │
            ▼                                  ▼
 ┌──────────────────────┐          ┌──────────────────────┐
 │  Option A (En ligne) │          │  Option B (En local) │
 │     typst.app        │          │   VS Code + CLI      │
 ├──────────────────────┤          ├──────────────────────┤
 │ • Zéro installation  │          │ • Fonctionne offline │
 │ • Collab en direct   │          │ • Outils Git locaux  │
 │ • Recommandé débutant│          │ • Éditeur avancé     │
 └──────────────────────┘          └──────────────────────┘
```

---

### Option A (Recommandée) : Directement sur l'application Web Typst (`typst.app`)

[typst.app](https://typst.app/) est la plateforme web officielle de Typst pour rédiger, visualiser et **collaborer gratuitement en temps réel** à la manière d'un Google Docs ou d'un Overleaf moderne.

Le modèle `electrocentrale` étant officiellement publié sur **Typst Universe**, son initialisation en ligne ne nécessite aucune installation de compilateur.

#### Étape 1 : Démarrer le projet
1. Rendez-vous sur la page officielle du modèle : **[Typst Universe — electrocentrale](https://typst.app/universe/package/electrocentrale)**.
2. Cliquez sur le bouton **"Start from template"** (ou "Open in app").
3. Connectez-vous ou créez gratuitement votre compte Typst.
4. Votre projet est immédiatement créé avec un fichier `main.typ` préconfiguré, incluant les logos vectoriels et le squelette de rapport.

*(Alternative : si vous avez déjà un document vierge dans l'application Web, insérez simplement en haut du fichier la ligne `#import "@preview/electrocentrale:0.2.0": *`)*.

#### Étape 2 : Collaborer en temps réel avec son binôme / son équipe
1. Dans l'éditeur en ligne, cliquez sur le bouton **Share** (en haut à droite).
2. Saisissez l'adresse e-mail de vos coéquipiers de binôme ou de projet, ou activez un lien de partage avec droits d'édition.
3. Vous pouvez désormais rédiger à plusieurs simultanément, voir les curseurs en direct de vos collègues et observer le rendu PDF se mettre à jour instantanément à chaque frappe.

#### Étape 3 : Exporter le PDF final
- Cliquez simplement sur le bouton **Export** (ou l'icône de téléchargement en haut de l'éditeur) pour récupérer le PDF prêt à être déposé sur la plateforme pédagogique de l'école (Campus / Moodle).

---

### Option B : En local avec VS Code & Tinymist

Pour les utilisateurs préférant travailler hors-ligne, gérer leurs versions avec Git ou utiliser leur propre éditeur de code, l'écosystème local Typst est particulièrement léger et rapide.

#### 1. Installer le compilateur Typst

- **macOS** (via [Homebrew](https://brew.sh/)) :
  ```bash
  brew install typst
  ```
- **Windows** (via le gestionnaire officiel [Winget](https://learn.microsoft.com/fr-fr/windows/package-manager/winget/)) :
  ```powershell
  winget install --id Typst.Typst
  ```
- **Linux** :
  - Arch Linux : `pacman -S typst`
  - Nix : `nix-env -iA nixpkgs.typst`
  - Alpine : `apk add typst`
  - Snap : `snap install typst`
  - Autres distributions (via Cargo) : `cargo install --locked typst-cli`

Vérifiez l'installation dans votre terminal :
```bash
typst --version
```

#### 2. Installer VS Code et l'extension Tinymist
1. Téléchargez et installez **VS Code** depuis [code.visualstudio.com](https://code.visualstudio.com/).
2. Ouvrez l'onglet Extensions (`Ctrl+Shift+X` ou `Cmd+Shift+X`), recherchez **Tinymist Typst** (de *Myriad-Dreamin*) et cliquez sur **Install**.
3. Tinymist offre l'autocomplétion, la coloration syntaxique, la détection d'erreurs en temps réel et un visualiseur PDF synchronisé avec défilement bi-directionnel.

#### 3. Initialiser un nouveau rapport en local

Ouvrez un terminal et exécutez la commande d'initialisation officielle :

```bash
typst init @preview/electrocentrale:0.2.0 mon-rapport
cd mon-rapport
code .
```

Typst télécharge automatiquement le package officiel et crée votre fichier `main.typ` configuré.

*(Si vous souhaitez cloner l'ensemble des exemples complets et des galeries, vous pouvez aussi cloner le dépôt complet : `git clone https://github.com/ece-elec/Electrocentrale.git`)*.

#### 4. Lancer l'aperçu en direct dans VS Code
- Ouvrez le fichier `main.typ`.
- Cliquez sur l'icône d'aperçu en haut à droite de l'éditeur (ou faites `Cmd+Shift+P` / `Ctrl+Shift+P` > **Tinymist: Show Preview**).
- Le visualiseur interactif s'ouvre à côté du code. Chaque enregistrement recompile le document en quelques dizaines de millisecondes.

*(Collaboration en local : Vous pouvez utiliser l'extension officielle Microsoft **Live Share** pour inviter vos collaborateurs dans votre session VS Code)*.

---

## 2. Comprendre la structure du document (`main.typ`)

Le fichier `main.typ` généré est structuré de façon claire et modulaire :

```typst
#import "@preview/electrocentrale:0.2.0": *

// 1. Configuration globale
#let langue = "fr" // "fr" ou "en"
#let style-police = "latex" // "arial" | "latex" | "typst-modern" | "modern-sans" | "editorial"

// 2. Application du modèle (tp, projet, conception ou stage)
#show: tp.with(
  lang: langue,
  title: "Filtres Actifs et Traitement du Signal",
  tp-num: "1",
  promo: "ING5",
  major: "Systèmes Embarqués",
  groupe: "Groupe 02",
  authors: (
    (name: "André-Marie AMPÈRE", email: "ampere@ece.fr", role: "Électronique analogique"),
    (name: "Alessandro VOLTA", email: "volta@ece.fr", role: "Mesures et banc de test"),
  ),
  supervisor: (name: "Dr. Jean DUPONT", email: "jean.dupont@ece.fr"),
  date: auto,
  font: font-presets.at(style-police, default: "New Computer Modern"),
)

// 3. Corps du document rédigé ci-dessous
= Première partie : Étude théorique et expérimentale
...
```

**Points clés à retenir :**
- La ligne `#import "@preview/electrocentrale:0.2.0": *` charge l'ensemble des fonctionnalités du modèle.
- La règle `#show: tp.with(...)` applique le modèle choisi.
- Tous les paramètres (`promo`, `major`, `supervisor`, `authors`, etc.) sont partagés entre tous les modèles.

---

## 3. Rédiger le contenu technique

Le contenu se rédige directement après le bloc `#show: ...`.

### Titres et hiérarchie
Typst utilise une syntaxe très épurée inspirée du Markdown :
```typst
= Première partie : Titre principal
== Analyse théorique (Sous-section)
=== Détail du calcul (Sous-sous-section)
```

### Questions de Travaux Pratiques (`#t` et `#e`)
Pour respecter les conventions des comptes-rendus de TP à l'ECE :
```typst
#t(1)[Calculer la fonction de transfert théorique $H(j omega)$ du filtre.]

#e(1)[Mesurer à l'oscilloscope l'amplitude de sortie pour $f = 1 "kHz"$.]
```
`#t(n)` génère automatiquement un en-tête théorique (ex: **T1.**) et `#e(n)` un en-tête expérimental (ex: **E1.**).

### Formules et notations physiques
Les équations mathématiques se placent entre symboles `$`. Une formule seule sur sa ligne est automatiquement centrée et peut recevoir un label de référence `<...>` :

```typst
$ H(j omega) = - (R_2 / R_1) 1 / (1 + j (omega / omega_0)) $ <eq:transfert>

En appliquant les valeurs numériques dans l'équation @eq:transfert, on obtient...
```

Le template fournit également des macros pour les unités usuelles du génie électrique :
```typst
Soit une résistance $R_1 = 10#kohm$, une capacité $C_1 = 100#nf$ et une fréquence $f_0 = 3.39#khz$.
```

### Tableaux au style ECE
Tous les tableaux `table(...)` adoptent automatiquement la charte graphique de l'école (en-tête vert ECE, zébrures douces, bordures nettes) :

```typst
#figure(
  table(
    columns: (1fr, 1fr, 1.2fr),
    [Fréquence], [Gain mesuré (dB)], [Phase (°)],
    [100 Hz], [-0.2 dB], [-5°],
    [1 kHz], [-3.0 dB], [-45°],
    [10 kHz], [-20.1 dB], [-85°],
  ),
  caption: [Relevé fréquentiel du filtre actif],
) <tab:mesures>
```

### Encarts et avertissements (`#callout`)
Mettez en avant des consignes de sécurité, remarques ou astuces :

```typst
#callout(title: "Précaution expérimentale", type: "warning")[
  Vérifier l'alimentation symétrique (+15 V / -15 V) de l'AOP avant la mise sous tension.
]

#callout(title: "Astuce de mesure", type: "tip")[
  Utiliser une sonde atténuatrice 10x pour limiter la charge capacitive sur le circuit.
]
```
Encarts rapides disponibles : `#nb[...]` (remarque), `#attention[...]` (danger/avertissement), `#todo[...]` (point à compléter).

### Intégration de diagrammes et schémas vectoriels
Typst dispose d'un écosystème de paquets spécialisés très performants, immédiatement utilisables dans la Web App comme en local :

- **Organigrammes et hiérarchies d'équipe** : paquet [`@preview/typart:0.1.1`](https://typst.app/universe/package/typart)
  ```typst
  #import "@preview/typart:0.1.1": hierarchy
  #hierarchy([Chef de projet], ([Électronique], [Firmware], [Tests & Mesures]))
  ```
- **Synoptiques fonctionnels, logigrammes et algorigrammes** : paquet [`@preview/fletcher:0.5.8`](https://typst.app/universe/package/fletcher)
  ```typst
  #import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge
  #diagram(
    node((0, 0), [Générateur BF], stroke: 0.8pt + rgb("#007B83"), corner-radius: 4pt),
    edge((0, 0), (1, 0), "->", [Signal]),
    node((1, 0), [Filtre Actif], stroke: 0.8pt + rgb("#007B83"), corner-radius: 4pt),
  )
  ```
- **Plannings de Gantt et bases de données** : intégrés nativement dans `electrocentrale` via `#gantt(...)` et `#table-bdd(...)`.

*(Pour des exemples complets et détaillés de chaque type de diagramme, consultez le guide [🛠️ Composants d'ingénierie](composants.md))*.

### Code source et annexes
Pour afficher des extraits de code avec coloration syntaxique :
````typst
```c
void SystemClock_Config(void) {
    RCC_OscInitTypeDef RCC_OscInitStruct = {0};
    RCC_OscInitStruct.OscillatorType = RCC_OSCILLATORTYPE_HSE;
    HAL_RCC_OscConfig(&RCC_OscInitStruct);
}
```
````

Pour isoler les codes longs, listings complets et fiches techniques en fin de document :
```typst
#show: annexes

= Annexe A : Code source du microcontrôleur
= Annexe B : Schéma d'implantation PCB
```

---

## 4. Changer de modèle

Tous les modèles d'ingénierie partagent les mêmes arguments. Pour basculer d'un rapport de TP à un projet ou un document de conception, il suffit de modifier la fonction appelée :

| Type de document | Fonction | Particularités automatiques |
| :--- | :--- | :--- |
| **Rapport de TP** | `#show: tp.with(...)` | En-têtes TP, pagination simple, table des matières optionnelle |
| **Rapport de Projet** | `#show: projet.with(...)` | Sommaire complet automatique, abstract, couverture projet |
| **Document de Conception** | `#show: conception.with(...)` | Avant-propos, matrice de conception, style technique |
| **Rapport de Stage** | `#show: stage.with(...)` | Fiche d'évaluation officielle ECE, missions, police Arial imposée |

---

## 5. Personnaliser le style typographique

Le paramètre `font-presets` permet de sélectionner instantanément une identité visuelle adaptée :

```typst
#let style-police = "latex" // Choisissez parmi : "latex", "typst-modern", "modern-sans", "editorial", "arial"

#show: tp.with(
  font: font-presets.at(style-police, default: "New Computer Modern"),
  ...
)
```

- `"latex"` : New Computer Modern (style académique scientifique classique, par défaut).
- `"typst-modern"` : Libertinus Serif (moderne, clair et aéré).
- `"modern-sans"` : Helvetica / Arial (style rapport technique épuré sans empattements).
- `"editorial"` : Charter / PT Serif (style publication de revue).
- `"arial"` : Police officielle requise pour les rapports de stage.

---

## 6. Foire aux Questions & Dépannage

**Q : L'importation du package échoue ("package not found").**  
Typst télécharge automatiquement le package officiel lors de la première compilation. Vérifiez votre connexion Internet. Si vous travaillez en local, assurez-vous d'utiliser une version récente de Typst (`typst --version` $\ge$ 0.12.0).

**Q : Comment insérer des images et photos de banc d'essai ?**  
Placez vos images dans votre projet (par exemple dans un dossier `images/`) et utilisez `#figure(image("images/photo.png", width: 80%), caption: [...]) <fig:photo>`. Dans l'application Web, faites simplement glisser vos fichiers images dans l'explorateur de gauche.

**Q : Comment gérer la bibliographie ?**  
Créez un fichier `bibliographie.bib` au format BibTeX dans le projet, puis ajoutez à la fin de votre document :
```typst
#bibliography("bibliographie.bib", title: "Références bibliographiques", style: "ieee")
```
Vous pouvez ensuite citer des références dans le texte avec `@cle_bibtex`.

---

## Ressources et liens utiles

- [Fiche officielle sur Typst Universe](https://typst.app/universe/package/electrocentrale) — page du package `electrocentrale`
- [Documentation officielle Typst](https://typst.app/docs/) — référence du langage et des fonctions standard
- [Typst Universe](https://typst.app/universe/) — catalogue de tous les packages officiels
- [⚙️ Paramètres de configuration](parametres.md) — tableau exhaustif des options de personnalisation
- [🛠️ Composants d'ingénierie](composants.md) — composants graphiques, mesures et schémas
- [📦 Guide de publication](publication.md) — procédure pour contribuer et mettre à jour le package
