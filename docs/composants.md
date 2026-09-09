# 🛠️ Utilitaires & Composants d'Ingénierie

Le paquet `ece-reports` inclut un ensemble d'outils et de composants prêts à l'emploi pour enrichir vos rapports scientifiques et d'ingénierie.

---

## 📑 Récapitulatif rapide

| Fonction / Macro | Syntaxe | Rôle |
| :--- | :--- | :--- |
| `#logo-ece(width: ...)` | `#logo-ece(width: 4cm)` | Insère le logo SVG officiel haute résolution de l'ECE |
| `#t(num)[...]` | `#t(1)[Calculer la fréquence...]` | Question théorique numérotée (ex: **T1.**) |
| `#e(num)[...]` | `#e(1)[Mesurer le signal...]` | Question expérimentale numérotée (ex: **E1.**) |
| `#question("Label")[...]` | `#question("Q1")[...]` | Question avec label personnalisé |
| `#callout(title: ..., type: ...)[...]` | `#callout(title: "Info", type: "info")[...]` | Encart stylisé (`"info"`, `"tip"`, `"warning"`, `"danger"`) |
| `#table-composants(...)` | `#table-composants([R1], [Résistance], ...)` | Nomenclature BOM électronique avec en-tête stylisé |
| `#table-brochage(...)` | `#table-brochage([PA5], [SPI_SCK], ...)` | Tableau d'affectation des broches (Pinout microcontrôleur) |
| `#table-termes(...)` | `#table-termes([Terme], [Définition], ...)` | Tableau de glossaire technique |
| `#table-acronymes(...)` | `#table-acronymes([CAN], [Signif.], [Explic.])` | Tableau d'acronymes et abréviations |
| `#show: annexes` | `#show: annexes` | Bascule automatique en mode Annexes (A, B, A.1...) |
| `#ohm`, `#kohm`, `#mohm` | `$R_1 = 10#kohm$` | Notations d'unités électroniques ($\Omega$, $\text{k}\Omega$, $\text{M}\Omega$) |
| `#uf`, `#nf`, `#pf` | `$C_1 = 100#nf$` | Notations de capacités ($\mu\text{F}$, $\text{nF}$, $\text{pF}$) |
| `#vpp`, `#vrms`, `#vdc` | `$V_("in") = 2.5#vpp$` | Tensions crête-à-crête, efficace et continue |
| `#attention[...]` | `#attention[Avertissement]` | Texte d'avertissement en rouge gras |
| `#nb[...]` | `#nb[Remarque]` | Encart **NB :** |
| `#todo[...]` | `#todo[Section à compléter]` | Surlignage TODO jaune |

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

## 🔩 Tableaux d'ingénierie matérielle

### Nomenclature BOM (`#table-composants` / `#table-bom`)

```typst
#figure(
  table-composants(
    [U1], [STM32F401RE], [LQFP-64], [1], [Microcontrôleur principal 84 MHz],
    [U2], [MPU-6050], [QFN-24], [1], [Centrale inertielle 6 axes I2C],
    [C1-C4], [Condensateurs céramiques], [100 nF, 0805], [4], [Découplage alimentations],
    [R1-R2], [Résistances pull-up], [4.7 kΩ, 0805], [2], [Lignes I2C SDA / SCL],
  ),
  caption: [Nomenclature des composants matériels principaux],
) <tab:bom>
```

### Brochage et Pinout (`#table-brochage` / `#table-pinout`)

```typst
#figure(
  table-brochage(
    [PA5], [SPI1_SCK], [Output Alternate], [Horloge maître du bus SPI],
    [PA7], [SPI1_MOSI], [Output Alternate], [Données maître vers esclave],
    [PB6], [I2C1_SCL], [Open Drain], [Horloge capteur I2C],
    [PB7], [I2C1_SDA], [Open Drain], [Données bidirectionnelles I2C],
  ),
  caption: [Brochage et affectation des broches du microcontrôleur],
) <tab:pinout>
```

---

## 📖 Glossaires et Acronymes

```typst
#table-termes(
  [Bode], [Représentation graphique de la réponse en fréquence d'un système linéaire.],
  [Aliasing], [Phénomène de repliement de spectre lors de l'échantillonnage.],
)

#table-acronymes(
  [CAN], [Convertisseur Analogique-Numérique], [Échantillonne et quantifie un signal analogique.],
  [UART], [Universal Asynchronous Receiver-Transmitter], [Liaison série asynchrone point-à-point.],
)
```

---

## 🏷️ Différenciation intelligente des figures et renvois croisés

Le paquet configure automatiquement les étiquettes et suppléments selon le contenu de la figure :

| Type de contenu | Supplément FR | Supplément EN | Exemple de renvoi | Rendu du renvoi |
| :--- | :--- | :--- | :--- | :--- |
| Image / Graphique | `Figure` | `Figure` | `@fig:montage` | *Figure 1* |
| Tableau (`table`) | `Tableau` | `Table` | `@tab:bom` | *Tableau 1* / *Table 1* |
| Code brut (`raw`) | `Code` | `Listing` | `@code:driver` | *Code 1* / *Listing 1* |

---

## 📎 Gestion des Annexes (`#show: annexes`)

Placez simplement la règle `#show: annexes` (ou `#show: appendix.with(lang: "en")`) avant vos sections d'annexes :

```typst
#show: annexes

= Tableaux de mesures brutes
= Code source des scripts d'acquisition
```

La numérotation bascule automatiquement en lettres alphabétiques (**Annexe A**, **Annexe B**, sous-sections **A.1**, **A.2**), et les en-têtes sont mis à jour sans modifier la numérotation des pages.

---

## ⚡ Notations scientifiques & unités électroniques

Pour simplifier l'écriture des formules mathématiques et unités :

```typst
$ R_1 = 10#kohm, quad C_1 = 100#nf, quad f_0 = 1 / (2 pi R_1 C_1) $

$ V_("in") = 3.3#vdc, quad V_("ripple") = 50#vpp $
```

| Raccourci | Rendu | Signification |
| :--- | :--- | :--- |
| `#ohm` | $\Omega$ | Ohm |
| `#kohm` | $\text{k}\Omega$ | Kilo-ohm |
| `#mohm` | $\text{M}\Omega$ | Méga-ohm |
| `#uf` | $\mu\text{F}$ | Microfarad |
| `#nf` | $\text{nF}$ | Nanofarad |
| `#pf` | $\text{pF}$ | Picofarad |
| `#vpp` | $V_{\text{pp}}$ | Tension crête-à-crête (Peak-to-Peak) |
| `#vrms` | $V_{\text{rms}}$ | Tension efficace (RMS) |
| `#vdc` | $V_{\text{dc}}$ | Tension continue (DC) |
| `#fcut` | $f_0$ | Fréquence de coupure |

