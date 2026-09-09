# 🛠️ Utilitaires & Composants d'Ingénierie

Le paquet `ece-reports` inclut un ensemble d'outils et de composants prêts à l'emploi pour enrichir vos rapports scientifiques et d'ingénierie.

---

## 📑 Récapitulatif rapide

| Fonction / Macro                         | Syntaxe                                                                                                                         | Rôle                                                                                                |
| :--------------------------------------- | :------------------------------------------------------------------------------------------------------------------------------ | :--------------------------------------------------------------------------------------------------- |
| `#logo-ece(width: ...)`                | `#logo-ece(width: 4cm)`                                                                                                       | Insère le logo SVG officiel haute résolution de l'ECE                                              |
| `#t(num)[...]`                         | `#t(1)[Calculer la fréquence...]`                                                                                            | Question théorique numérotée (ex:**T1.**)                                                   |
| `#e(num)[...]`                         | `#e(1)[Mesurer le signal...]`                                                                                                 | Question expérimentale numérotée (ex:**E1.**)                                               |
| `#question("Label")[...]`              | `#question("Q1")[...]`                                                                                                        | Question avec label personnalisé                                                                    |
| `#callout(title: ..., type: ...)[...]` | `#callout(title: "Info", type: "info")[...]`                                                                                  | Encart stylisé (`"info"`, `"tip"`, `"warning"`, `"danger"`)                                 |
| `#table(...)`                          | `#table(columns: ..., ...)`                                                                                                   | Tableaux standards Typst (automatiquement stylisés aux couleurs ECE)                                |
| `#table-double-entree(...)`            | `#table-double-entree(headers: (...), ...)`                                                                                   | Tableaux à double entrée (en-tête haut + en-tête de côté)                                      |
| `#show: annexes`                       | `#show: annexes`                                                                                                              | Mode Annexes (A, B, A.1...) + préfixage auto des figures/tableaux (`Figure A.1`, `Tableau A.1`) |
| `#ohm`, `#kohm`, `#uf`, `#nf`    | `$R_1 = 10#kohm$` | Notations d'impédances et capacités ($\Omega$, $\text{k}\Omega$, $\mu\text{F}$, $\text{nF}$...) |                                                                                                      |
| `#hz`, `#khz`, `#mhz`              | `$f_0 = 3.39#khz$` | Fréquences normalisées ($\text{Hz}$, $\text{kHz}$, $\text{MHz}$, $\text{GHz}$)                 |                                                                                                      |
| `#ma`, `#ua`, `#na`                | `$I_1 = 15#ua$` | Courants normalisés ($\text{mA}$, $\mu\text{A}$, $\text{nA}$)                                        |                                                                                                      |
| `#vpp`, `#vrms`, `#vdc`, `#vac`  | `$V_("in") = 2.5#vpp$`                                                                                                        | Tensions caractéristiques, millivolt (`#mv`), microvolt (`#uv`)                                 |
| `#db`, `#dbm`, `#degc`             | `$G = -20#db$`                                                                                                                | Décibels, puissances RF (`#dbm`, `#mw`), température (`#degc`)                               |
| `#attention[...]`                      | `#attention[Avertissement]`                                                                                                   | Texte d'avertissement en rouge gras                                                                  |
| `#nb[...]`                             | `#nb[Remarque]`                                                                                                               | Encart**NB :**                                                                                 |
| `#todo[...]`                           | `#todo[Section à compléter]`                                                                                                | Surlignage TODO jaune                                                                                |

---

## ❓ Questions théoriques et expérimentales

Des fonctions dédiées permettent de formater distinctement les questions de TP :

```typst
#t(1)[Calculer la fonction de transfert théorique du filtre passe-bas actif.]

#e(1)[Mesurer à l'oscilloscope la tension de crête à crête en sortie pour $f = 1"kHz"$.]

#question("Q1")[Question personnalisée.]
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
  Le protocole I2C utilise des résistances de pull-up de 4.7 kΩ.
]

#callout(title: "Danger électrique", type: "danger")[
  Ne pas dépasser la tension maximale admissible de 3.3V sur les broches GPIO.
]
```

Encarts rapides :

```typst
#nb[Certains projets d’électronique à l’ECE n’ont pas de cahier des charges imposé.]
#attention[Pas de code source volumineux dans le corps principal du rapport.]
#todo[Compléter les mesures à 100 kHz.]
```

---

## 📊 Tableaux au style ECE (`#table`)

Tous les tableaux standards de Typst créés avec `#table(...)` adoptent **automatiquement** la charte graphique de l'école lorsqu'ils sont utilisés dans un rapport (`tp` ou `projet`) :

- **En-tête stylisé :** fond vert pastel doux (`#EBF5F5`), texte en gras automatique sur la première ligne et bordure inférieure en vert canard ECE (`1.5pt`).
- **Alternance zébrée :** fond blanc cassé (`#FAFAFA`) sur les lignes paires pour faciliter la lecture.
- **Grille fine :** bordures intérieures gris clair (`0.5pt`) et marge intérieure aérée (`7pt`).
- **Aucune fonction personnalisée requise :** vous utilisez directement la syntaxe officielle de Typst !

### 1. Nomenclature BOM (Bill of Materials)

```typst
#figure(
  table(
    columns: (1fr, 2.2fr, 2fr, 0.8fr, 2fr),
    align: (col, row) => if col in (0, 3) { center + horizon } else { left + horizon },
    table.header([Réf.], [Désignation], [Valeur / Boîtier], [Qté], [Remarques]),
    [U1], [STM32F401RE], [LQFP-64], [1], [Microcontrôleur principal 84 MHz],
    [U2], [MPU-6050], [QFN-24], [1], [Centrale inertielle 6 axes I2C],
    [C1-C4], [Condensateurs céramiques], [100 nF, 0805], [4], [Découplage alimentations],
    [R1-R2], [Résistances pull-up], [4.7 kΩ, 0805], [2], [Lignes I2C SDA / SCL],
  ),
  caption: [Nomenclature des composants matériels principaux],
) <tab:bom>
```

### 2. Brochage et Pinout

```typst
#figure(
  table(
    columns: (1.2fr, 1.5fr, 1.3fr, 3fr),
    align: (col, row) => if col in (0, 1, 2) { center + horizon } else { left + horizon },
    table.header([Broche], [Signal], [Mode I/O], [Description]),
    [PA5], [SPI1_SCK], [Output Alternate], [Horloge maître du bus SPI],
    [PA7], [SPI1_MOSI], [Output Alternate], [Données maître vers esclave],
    [PB6], [I2C1_SCL], [Open Drain], [Horloge capteur I2C],
    [PB7], [I2C1_SDA], [Open Drain], [Données bidirectionnelles I2C],
  ),
  caption: [Brochage et affectation des broches du microcontrôleur],
) <tab:pinout>
```

### 3. Relevés de mesures expérimentales

```typst
#figure(
  table(
    columns: (1.5fr, 2fr, 2fr, 1.5fr),
    align: (col, row) => if col == 0 { center + horizon } else { horizon },
    table.header([Fréquence ($"Hz"$)], [$V_("out")$ ($"V"_("pp")$)], [Gain $G$ ($"dB"$)], [Écart]),
    [10], [9.95], [-0.04], [0.4 %],
    [100], [8.48], [-1.43], [1.2 %],
    [1 000], [1.57], [-16.1], [0.9 %],
  ),
  caption: [Relevé expérimental de la réponse en fréquence],
) <tab:mesures>
```

### 4. Tableaux à double entrée / En-tête de côté (`#table-double-entree`)

Pour créer des matrices, bilans énergétiques ou tableaux de correspondance avec **à la fois un en-tête horizontal (en haut) et un en-tête vertical (de côté)**, utilisez `#table-double-entree` (alias : `#tableau-double-entree`, `#table-matrice`, `#tableau-matrice`) :

- La ligne d'en-tête (haut) et la première colonne (gauche) reçoivent toutes deux le fond pastel ECE (`#EBF5F5`) et une police en gras.
- Une double ligne en vert canard ECE sépare distinctement les deux en-têtes (en bas et à droite) des cellules intérieures.

```typst
#figure(
  table-double-entree(
    headers: ("Module / Bloc", "Veille", "Éco", "Actif", "Boost"),
    [Microcontrôleur], [15 µA], [2 mA], [15 mA], [40 mA],
    [Capteur IMU], [5 µA], [100 µA], [3.8 mA], [3.8 mA],
    [Émetteur RF], [1 µA], [Inactif], [18 mA], [25 mA],
    [Total estimé], [21 µA], [2.1 mA], [36.8 mA], [68.8 mA],
  ),
  caption: [Matrice de consommation énergétique selon les modes de fonctionnement],
) <tab:modes>
```

> **Astuce - Pleine largeur dans un document à deux colonnes :** Si votre document utilise une mise en page à deux colonnes (`#show: columns.with(2)`), étendez un tableau sur les deux colonnes via `#figure(placement: top, scope: "parent")[ #table(...) ]`.

---

## 🏷️ Différenciation intelligente des figures et renvois croisés

Le paquet configure automatiquement les étiquettes et suppléments selon le contenu de la figure :

| Type de contenu     | Supplément FR | Supplément EN | Exemple de renvoi | Rendu du renvoi             |
| :------------------ | :------------- | :------------- | :---------------- | :-------------------------- |
| Image / Graphique   | `Figure`     | `Figure`     | `@fig:montage`  | *Figure 1*                |
| Tableau (`table`) | `Tableau`    | `Table`      | `@tab:bom`      | *Tableau 1* / *Table 1* |
| Code brut (`raw`) | `Code`       | `Listing`    | `@code:driver`  | *Code 1* / *Listing 1*  |

---

## 📎 Gestion des Annexes (`#show: annexes`)

Placez simplement la règle `#show: annexes` (ou `#show: appendix.with(lang: "en")`) avant vos sections d'annexes :

```typst
#show: annexes

= Tableaux de mesures brutes
= Code source des scripts d'acquisition
```

La numérotation bascule automatiquement en lettres alphabétiques (**Annexe A**, **Annexe B**, sous-sections **A.1**, **A.2**). De plus, les **figures**, **tableaux**, **extraits de code** et **équations** sont automatiquement préfixés par la lettre de l'annexe correspondante (**Figure A.1**, **Tableau B.1**, équation **(A.1)**), et leurs compteurs respectifs sont réinitialisés à chaque annexe.

---

## ⚡ Notations scientifiques & unités d'ingénierie

Pour simplifier l'écriture des formules mathématiques et unités sans erreurs de casse ou d'italique :

```typst
$ R_1 = 10#kohm, quad C_1 = 100#nf, quad f_0 = 3.39#khz $

$ V_("dd") = 3.3#vdc, quad I_("actif") = 15#ma, quad I_("veille") = 15#ua $

$ G = -20#db, quad P_("rf") = 10#dbm, quad T = 25#degc $
```

| Raccourci                               | Rendu                                                                       | Signification                         |
| :-------------------------------------- | :-------------------------------------------------------------------------- | :------------------------------------ |
| `#ohm`, `#kohm`, `#mohm`          | $\Omega$, $\text{k}\Omega$, $\text{M}\Omega$                          | Résistances et impédances           |
| `#uf`, `#nf`, `#pf`               | $\mu\text{F}$, $\text{nF}$, $\text{pF}$                               | Capacités                            |
| `#hz`, `#khz`, `#mhz`, `#ghz`   | $\text{Hz}$, $\text{kHz}$, $\text{MHz}$, $\text{GHz}$               | Fréquences                           |
| `#ma`, `#ua`, `#na`               | $\text{mA}$, $\mu\text{A}$, $\text{nA}$                               | Courants                              |
| `#vpp`, `#vrms`, `#vdc`, `#vac` | $V_{\text{pp}}$, $V_{\text{rms}}$, $V_{\text{dc}}$, $V_{\text{ac}}$ | Tensions caractéristiques            |
| `#mv`, `#uv`                        | $\text{mV}$, $\mu\text{V}$                                              | Millivolt, Microvolt                  |
| `#ms`, `#us`, `#ns`, `#ps`      | $\text{ms}$, $\mu\text{s}$, $\text{ns}$, $\text{ps}$                | Durées et constantes de temps        |
| `#mw`, `#uw`                        | $\text{mW}$, $\mu\text{W}$                                              | Puissances                            |
| `#db`, `#dbm`                       | $\text{dB}$, $\text{dBm}$                                               | Gains, atténuations et puissances RF |
| `#degc`, `#celsius`                 | $^\circ\text{C}$                                                          | Degrés Celsius                       |
| `#fcut`                               | $f_0$                                                                     | Fréquence de coupure                 |
