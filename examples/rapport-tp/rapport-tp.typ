#import "@preview/electrocentrale:0.1.0": *

// Style de police : "latex" | "typst-modern" | "modern-sans" | "editorial"
#let style-police = "latex"

// Modèle de TP (changeable en `projet.with` sans modifier les arguments)
#show: tp.with(
  lang: "fr",
  title: "Filtres Actifs et Traitement du Signal",
  tp-num: "1",
  promo: "ING5",
  major: "Systèmes Embarqués",
  groupe: "Groupe 02",
  authors: (
    (name: "André-Marie AMPÈRE", email: "ampere@ece.fr", role: "Mesures & Câblage"),
    (name: "Alessandro VOLTA", email: "volta@ece.fr", role: "Calculs théoriques"),
  ),
  supervisor: (name: "Dr. Jean DUPONT", email: "jean.dupont@ece.fr"),
  show-roles: true,
  show-emails: true, // Passer à false pour masquer les adresses email
  show-supervisor-email: true, // Passer à false pour masquer l'email du tuteur
  date: auto,  // ou date: "15 octobre 2026" pour une date fixe
  city: "Paris",
  draft: false, // Passer à true pour activer le filigrane "BROUILLON"
  // equation-numbering: "(1)",  // Décommenter pour numéroter les équations
  font: font-presets.at(style-police, default: "New Computer Modern"),
)

= Première partie : Étude théorique et expérimentale
== Analyse fréquentielle du filtre

#t(1)[Déterminer la fonction de transfert théorique du filtre passe-bas actif du 1#super[er] ordre.]

La fonction de transfert théorique s'exprime sous la forme canonique :
$ H(j omega) = (V_("out")) / (V_("in")) = - (R_2 / R_1) 1 / (1 + j (omega / omega_0)) $ <eq:transfert>

Pour les valeurs de composants $R_1 = 10#kohm$, $R_2 = 100#kohm$ et $C = 10#nf$, la fréquence de coupure à $-3#db$ théorique vaut :
$ #fcut = 1 / (2 pi R_2 C) approx 159.15#hz $

Le signal d'entrée appliqué par le GBF est sinusoïdal de tension continue $V_("offset") = 0#vdc$ et d'amplitude $V_("in") = 1#vpp$ ($approx 0.35#vrms$). Le montage sous banc de test est présenté sur la @fig:montage.

#figure(
  logo-ece(width: 5cm),
  caption: [Schéma du montage expérimental],
) <fig:montage>

#callout(title: "Précaution expérimentale", type: "warning")[
  Vérifier l'alimentation symétrique (+15 V / -15 V) de l'amplificateur opérationnel avant la mise sous tension du générateur de fonctions (GBF).
]

#e(1)[Mesure expérimentale du gain et traitement des données.]

Les points de mesure acquis à l'oscilloscope numérique sous banc de test sont consignés dans le @tab:mesures :

#figure(
  table(
    columns: (1.5fr, 2fr, 2fr, 1.5fr),
    align: (col, row) => if col == 0 { center + horizon } else { horizon },
    table.header(
      [Fréquence ($"Hz"$)],
      [$V_("out")$ mesuré ($"V"_("pp")$)],
      [Gain $G$ ($"dB"$)],
      [Écart relatif],
    ),
    [10], [9.95], [-0.04], [0.4 %],
    [50], [9.51], [-0.44], [0.8 %],
    [100], [8.48], [-1.43], [1.2 %],
    [159], [7.07], [-3.01], [0.3 %],
    [500], [3.02], [-10.4], [1.5 %],
    [1 000], [1.57], [-16.1], [0.9 %],
  ),
  caption: [Relevé expérimental de la réponse fréquentielle du filtre actif],
) <tab:mesures>

Le @tab:comparatif met en vis-à-vis les grandeurs caractéristiques calculées, simulées et relevées expérimentalement :

#figure(
  table-double-entree(
    headers: ("Grandeur", "Théorie", "Simulation", "Mesure", "Écart (%)"),
    [Gain statique $G_0$], [20.0 dB], [19.9 dB], [19.8 dB], [1.0 %],
    [Fréquence de coupure $f_c$], [159 Hz], [158 Hz], [155 Hz], [2.5 %],
    [Pente d'atténuation], [-20 dB/déc], [-20 dB/déc], [-19.5 dB/déc], [2.5 %],
    [Déphasage à $f_c$], [-45.0°], [-45.2°], [-46.1°], [2.4 %],
  ),
  caption: [Matrice de comparaison théorique, simulée et expérimentale du filtre],
) <tab:comparatif>

Le script Python ci-dessous permet d'acquérir les points de mesure et de tracer le diagramme de Bode :

```python
import numpy as np
import matplotlib.pyplot as plt

# Fréquences de test (Hz) et calcul de la réponse en fréquence
freqs = np.logspace(1, 5, 50)
gain = -20 * np.log10(np.sqrt(1 + (freqs / 1000)**2))

plt.semilogx(freqs, gain, label="Réponse mesurée (dB)")
plt.xlabel("Fréquence (Hz)")
plt.ylabel("Gain (dB)")
plt.grid(True, which="both")
plt.legend()
```

= Méthodologie et recommandations
== Guide de rédaction

#text(fill: gray)[
  Petits rappels pour une grande réussite :

  Pour chaque question, dire :

  + Formulation du *problème* : ce que l’on cherche à faire ;
  + Présentation de la *solution technique* : comment on le fait (bien souvent, algorigramme commenté, ou diagramme de branchement) ;
  + Présentation et description des *résultats* : Ce que l’on obtient ;
  + *Validation* des résultats et *Réponses à la question* (lien entre 1. et 3.) avec un avis critique.

  #v(0.5em)

  - Toujours mentionner les renvois aux Figures ("Les résultats de la simulation sont présentés sur la Figure 2.1. On y voit…").
  - Pas de code dans les rapports, uniquement des renvois à des annexes si cela est pertinent.
  - Pas de vidéo. Elles ne seront pas regardées et donc pas notées.
  - Lire scrupuleusement l’énoncé. Une mesure à l’oscilloscope n’est pas une capture d’écran du traceur série.
  - Exporter au format .PDF le rapport.
]

#show: annexes

= Tableaux de mesures brutes

Relevés bruts oscilloscope et analyseur de spectre.

= Code source des scripts d'acquisition

Scripts de traitement automatisé (#attention[pas de code dans le corps du rapport]).
