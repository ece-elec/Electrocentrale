# 🛠️ Utilitaires & Composants d'Ingénierie

[📖 Tutoriel](tutoriel.md) · [⚙️ Paramètres de configuration](parametres.md) · [🛠️ Composants d'ingénierie](composants.md)

Le paquet `electrocentrale` inclut un ensemble d'outils, de macros et de composants prêts à l'emploi pour enrichir vos rapports scientifiques et d'ingénierie à l'ECE Paris.

---

## 📑 Récapitulatif rapide

| Fonction / Macro | Syntaxe | Rôle |
| :--- | :--- | :--- |
| `#logo-ece(width: ...)` | `#logo-ece(width: 4cm)` | Insère le logo SVG officiel haute résolution de l'ECE |
| `#t(num)[...]` | `#t(1)[Calculer la fréquence...]` | Question théorique numérotée (ex : **T1.**) |
| `#e(num)[...]` | `#e(1)[Mesurer le signal...]` | Question expérimentale numérotée (ex : **E1.**) |
| `#question("Label")[...]` | `#question("Q1")[...]` | Question avec label personnalisé |
| `#callout(title: ..., type: ...)[...]` | `#callout(title: "Info", type: "info")[...]` | Encart stylisé (`"info"`, `"tip"`, `"warning"`, `"danger"`) |
| `#table(...)` | `#table(columns: ..., ...)` | Tableaux standards Typst (automatiquement stylisés aux couleurs ECE) |
| `#table-double-entree(...)` | `#table-double-entree(headers: (...), ...)` | Tableaux à double entrée (en-tête haut + en-tête de côté) |
| `#gantt(...)` | `#gantt(unites: (...), taches: (...))` | Diagramme de Gantt natif pour plannings projet et stage |
| `#table-bdd(...)` | `#table-bdd("Nom", ((col, type, key), ...))` | Schéma relationnel de base de données avec clés PK/FK |
| `#show: annexes` | `#show: annexes` | Mode Annexes (A, B, A.1...) + préfixage auto des figures/tableaux |
| `#ohm`, `#kohm`, `#uf`, `#nf` | `$R_1 = 10#kohm$` | Notations d'impédances et capacités ($\Omega$, $\text{k}\Omega$, $\mu\text{F}$, $\text{nF}$...) |
| `#hz`, `#khz`, `#mhz` | `$f_0 = 3.39#khz$` | Fréquences normalisées ($\text{Hz}$, $\text{kHz}$, $\text{MHz}$, $\text{GHz}$) |
| `#ma`, `#ua`, `#na` | `$I_1 = 15#ua$` | Courants normalisés ($\text{mA}$, $\mu\text{A}$, $\text{nA}$) |
| `#vpp`, `#vrms`, `#vdc`, `#vac` | `$V_("in") = 2.5#vpp$` | Tensions caractéristiques, millivolt (`#mv`), microvolt (`#uv`) |
| `#db`, `#dbm`, `#degc` | `$G = -20#db$` | Décibels, puissances RF (`#dbm`, `#mw`), température (`#degc`) |
| `#attention[...]` | `#attention[Avertissement]` | Texte d'avertissement en rouge gras |
| `#nb[...]` | `#nb[Remarque]` | Encart **NB :** |
| `#todo[...]` | `#todo[Section à compléter]` | Surlignage TODO jaune pour brouillon |

---

## ❓ Questions théoriques et expérimentales

Des fonctions dédiées permettent de formater distinctement les questions dans les comptes-rendus de TP :

```typst
#t(1)[Calculer la fonction de transfert théorique du filtre passe-bas actif.]

#e(1)[Mesurer à l'oscilloscope la tension de crête à crête en sortie pour $f = 1 "kHz"$.]

#question("Q1")[Question personnalisée non préfixée par T ou E.]
```

---

## 📢 Encarts d'alerte et remarques (`#callout`)

Des boîtes d'information colorées avec bordures arrondies facilitent la mise en avant de points clés :

```typst
#callout(title: "Précaution expérimentale", type: "warning")[
  Vérifier l'alimentation symétrique (+15 V / -15 V) avant la mise sous tension.
]

#callout(title: "Astuce de routage", type: "tip")[
  Placer les condensateurs de découplage au plus près des broches d'alimentation du microcontrôleur.
]

#callout(title: "Note d'information", type: "info")[
  Le protocole I2C requiert des résistances de tirage (*pull-up*) de 4.7 kΩ.
]

#callout(title: "Danger électrique", type: "danger")[
  Ne pas dépasser la tension maximale admissible de 3.3 V sur les broches GPIO.
]
```

Encarts rapides de rédaction :

```typst
#nb[Certains projets d’électronique à l’ECE n’ont pas de cahier des charges imposé.]
#attention[Pas de code source volumineux dans le corps principal du rapport.]
#todo[Compléter les mesures à 100 kHz.]
```

---

## 📊 Tableaux au style ECE (`#table`)

Tous les tableaux standards de Typst créés avec `#table(...)` adoptent **automatiquement** la charte graphique de l'école lorsqu'ils sont utilisés dans un rapport (`tp`, `projet` ou `conception`) :

- **En-tête stylisé :** fond vert pastel doux (`#EBF5F5`), texte en gras automatique sur la première ligne et bordure inférieure en vert canard ECE (`1.5pt`).
- **Alternance zébrée :** fond blanc cassé (`#FAFAFA`) sur les lignes paires pour faciliter la lecture.
- **Grille fine :** bordures intérieures gris clair (`0.5pt`) et marge intérieure aérée (`7pt`).
- **Syntaxe standard :** vous utilisez directement la syntaxe officielle `table(...)` de Typst sans surcouche inutile !

### Exemple : Nomenclature de composants (BOM)

```typst
#figure(
  table(
    columns: (1fr, 2.2fr, 2fr, 0.8fr, 2fr),
    [Réf.], [Composant], [Valeur / Boîtier], [Qté], [Rôle dans le circuit],
    [U1], [TL072CN], [DIP-8 / Double AOP], [1], [Étage amplificateur actif],
    [R1], [Résistance métal], [10 kΩ ±1% (0805)], [2], [Résistance d'entrée et contre-réaction],
    [C1], [Condensateur céramique], [100 nF / 50 V (X7R)], [1], [Pôle de filtrage passe-bas],
  ),
  caption: [Nomenclature des composants du banc de test (BOM)],
) <tab:bom>
```

### Tableaux à double entrée (`#table-double-entree`)

Pour les matrices de compatibilité ou grilles d'évaluation :

```typst
#table-double-entree(
  headers: ([Module], [STM32F4], [ESP32-S3], [RP2040]),
  ([Wi-Fi / Bluetooth], [Non], [Oui], [Non]),
  ([Cœurs & Fréquence], [1x 84 MHz], [2x 240 MHz], [2x 133 MHz]),
  ([Consommation Deep-Sleep], [10 µA], [5 µA], [180 µA]),
)
```

---

## 📅 Composants natifs de gestion de projet

### 1. Planning & Diagramme de Gantt (`#gantt`)

Permet de représenter les phases d'un projet ou stage avec des barres colorées et des jalons :

```typst
#figure(
  gantt(
    unites: ("S1", "S2", "S3", "S4", "S5", "S6", "S7", "S8"),
    taches: (
      (nom: "Étude théorique & Spécifications", debut: 1, fin: 3),
      (nom: "Conception Schématique & Routage PCB", debut: 2, fin: 5, couleur: darkpowderblue),
      (nom: "Développement Firmware (Pilotes I2C/SPI)", debut: 4, fin: 7),
      (nom: "Banc de tests & Validation finale", debut: 6, fin: 8, couleur: gamboge),
    ),
  ),
  caption: [Planning prévisionnel des tâches du projet],
) <fig:gantt>
```

### 2. Schéma relationnel de base de données (`#table-bdd`)

Affiche une table relationnelle avec typage précis des colonnes et mise en évidence des clés primaires (`PK`) et étrangères (`FK`) :

```typst
#table-bdd(
  "TelemetryRecord",
  (
    ("id", "BIGINT", "PK"),
    ("device_id", "UUID", "FK"),
    ("timestamp", "DATETIME", ""),
    ("temperature", "FLOAT", ""),
    ("battery_level", "TINYINT", ""),
  ),
)
```

---

## 🎨 Schémas d'ingénierie & Écosystème Typst Universe

Plutôt que d'imposer des mini-langages de diagrammes limités, `electrocentrale` tire parti des meilleurs paquets vectoriels officiels de **Typst Universe**. Ces paquets fonctionnent nativement en ligne (sur `typst.app`) et en local, sans dépendance externe.

### 1. Organigrammes et hiérarchies d'équipe (`typart`)

Le paquet [`@preview/typart:0.1.1`](https://typst.app/universe/package/typart) permet de construire des organigrammes d'équipe, de projet ou de stage avec connecteurs orthogonaux élégants :

```typst
#import "@preview/typart:0.1.1": hierarchy, tree

// Organigramme d'équipe avec responsable et pôles
#hierarchy(
  [Chef de Projet],
  (
    [Électronique Analogique],
    [Architecture Firmware],
    [Validation & Bancs de Test],
  ),
  box-w: 4.8,
  box-h: 1.4,
  level-gap: 2.0,
  size: 8.5pt,
)
```

Pour les structures multi-niveaux d'entreprise (direction, départements, services) :

```typst
#tree((
  [Direction R&D],
  (
    ([Pôle Embarqué], ([Firmware], [Hardware])),
    ([Pôle Logiciel], ([Cloud], [Web UI])),
    [Qualité & Validation],
  )
))
```

### 2. Synoptiques matériels & Chaînes de blocs fonctionnels (`fletcher`)

Le paquet [`@preview/fletcher:0.5.8`](https://typst.app/universe/package/fletcher) est la référence vectorielle pour modéliser l'interconnexion matérielle, les bus de communication et les pipelines de traitement de signal :

```typst
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge

#figure(
  diagram(
    spacing: (18mm, 0mm),
    node-stroke: 0.8pt + rgb("#007B83"),
    node-corner-radius: 4pt,
    node-fill: white,
    
    node((0, 0), [Générateur BF \ #text(7.5pt, fill: gray)[Stimulus sinusoïdal]]),
    edge((0, 0), (1, 0), "->", [$V_("in")(t)$]),
    node((1, 0), [Filtre Actif \ #text(7.5pt, fill: gray)[AOP + R1, R2, C1]]),
    edge((1, 0), (2, 0), "->", [$V_("out")(t)$]),
    node((2, 0), [Étage ADC \ #text(7.5pt, fill: gray)[12-bit / DMA]]),
    edge((2, 0), (3, 0), "<->", [USB / SCPI]),
    node((3, 0), [Poste PC \ #text(7.5pt, fill: gray)[LabVIEW]]),
  ),
  caption: [Synoptique de la chaîne d'instrumentation et de mesure],
) <fig:synoptique>
```

### 3. Algorigrammes et logigrammes d'exécution (`fletcher`)

Idéal pour documenter le déroulement d'une boucle firmware ou d'un automate d'état conforme aux normes d'ingénierie :

```typst
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge, shapes

#diagram(
  spacing: (0mm, 10mm),
  node-stroke: 0.8pt + rgb("#007B83"),
  node-fill: white,

  // Nœud de départ arrondi
  node((0, 0), [Démarrage du système], corner-radius: 12pt),
  edge((0, 0), (0, 1), "->"),

  // Action de traitement
  node((0, 1), [Initialisation matérielle (GPIO, I2C, SPI)]),
  edge((0, 1), (0, 2), "->"),

  // Condition / Test (Losange)
  node((0, 2), [Capteur prêt ?], shape: shapes.diamond),
  edge((0, 2), (0, 3), "->", [Oui]),
  edge((0, 2), (1, 2), "->", [Non]),

  node((1, 2), [Attente 10 ms], corner-radius: 4pt),
  edge((1, 2), (0, 1), "->", corner: "top-right"),

  // Suite séquentielle
  node((0, 3), [Acquisition et émission radio], corner-radius: 4pt),
  edge((0, 3), (0, 4), "->"),
  node((0, 4), [Mise en veille (Low Power)], corner-radius: 12pt),
)
```

### 4. Diagrammes de classes orientés objet (`sourcecraft`)

Le paquet [`@preview/sourcecraft:0.1.0`](https://typst.app/universe/package/sourcecraft) permet d'écrire des diagrammes de classes UML directement à partir d'une syntaxe proche de Java/C++ :

```typst
#import "@preview/sourcecraft:0.1.0": source-diagram

#source-diagram(```java
public abstract class Capteur {
  protected int id;
  protected byte i2cAddr;
  private boolean isCalibrated;

  public abstract boolean init();
  public abstract float readValue();
  protected void calibrate();
}

public class BME280 extends Capteur {
  private int oversampling;
  public boolean init();
  public float readValue();
}
```)
```

### 5. Diagrammes de séquence UML (`fletcher`)

Pour représenter chronologiquement les échanges de trames réseau ou d'appels inter-composants avec lignes de vie pointillées :

```typst
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge

#diagram(
  spacing: (32mm, 10mm),
  node-stroke: 0.8pt + rgb("#007B83"),
  node-fill: white,
  node-corner-radius: 3pt,

  // En-têtes des participants
  node((0, 0), [Microcontrôleur]),
  node((1, 0), [Capteur I2C]),
  node((2, 0), [Module LoRa]),

  // Lignes de vie verticales
  edge((0, 0), (0, 4), "--", stroke: 0.6pt + rgb("#94A3B8")),
  edge((1, 0), (1, 4), "--", stroke: 0.6pt + rgb("#94A3B8")),
  edge((2, 0), (2, 4), "--", stroke: 0.6pt + rgb("#94A3B8")),

  // Échanges de messages
  edge((0, 1), (1, 1), "->", [Start + ReadReg(0x75)]),
  edge((1, 2), (0, 2), "-->", [ACK + Chip_ID(0x60)]),
  edge((0, 3), (2, 3), "->", [TX_Payload(Trame)]),
)
```

### 6. Métrologie & Visualisation de données scientifiques

Pour vos comptes-rendus expérimentaux :
- **Boîtes à moustaches (Boxplots)** : [`@preview/moustaches:0.1.3`](https://typst.app/universe/package/moustaches) pour comparer la dispersion de mesures expérimentales.
- **Cartographies et matrices thermiques (Heatmaps)** : [`@preview/lilaq:0.4.0`](https://typst.app/universe/package/lilaq) pour visualiser des grilles de capteurs ou matrices de corrélation.

---

## 🔗 Ressources complémentaires

- [📖 Tutoriel pas à pas](tutoriel.md)
- [⚙️ Paramètres des modèles](parametres.md)
- [Fiche Typst Universe de `electrocentrale`](https://typst.app/universe/package/electrocentrale)
