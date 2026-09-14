#import "@preview/ece-reports:0.1.0": *

// Configuration générale
#let langue = "fr" // "fr" ou "en"
#let style-police = "latex" // "latex" | "typst-modern" | "modern-sans" | "editorial"

// Choix du modèle : changez simplement `tp.with` en `projet.with` selon votre rendu.
// Tous les paramètres sont 100% interchangeables entre les modèles.
#show: tp.with(
  lang: langue,
  title: "Filtres Actifs et Traitement du Signal",
  tp-num: "1", // utilisé par le modèle tp, ignoré automatiquement par projet
  promo: "ING5",
  major: "Systèmes Embarqués", // ou none
  groupe: "Groupe 02",
  authors: (
    (name: "André-Marie AMPÈRE", email: "ampere@ece.fr", role: "Électronique analogique"),
    (name: "Alessandro VOLTA", email: "volta@ece.fr", role: "Mesures et banc de test"),
  ),
  supervisor: (name: "Dr. Jean DUPONT", email: "jean.dupont@ece.fr"), // ou "Dr. Jean DUPONT" ou none
  show-roles: true, // masquer les rôles en passant à false
  show-emails: true, // masquer les adresses email en passant à false
  show-supervisor-email: true, // masquer l'email de l'encadrant en passant à false
  date: auto,  // ou date: "15 octobre 2026" pour une date fixe
  city: "Paris",
  draft: false, // passer à true pour activer le filigrane "BROUILLON"
  abstract: [Contexte, problématique et objectifs techniques du travail réalisé.],
  // equation-numbering: "(1)",  // décommenter pour numéroter les équations
  font: font-presets.at(style-police, default: "New Computer Modern"),
)

= Première partie : Étude théorique et expérimentale
== Analyse fréquentielle

#t(1)[Calculer la fonction de transfert théorique du filtre passe-bas actif.]

La fonction de transfert théorique s'exprime par :
$ H(j omega) = - (R_2 / R_1) 1 / (1 + j (omega / omega_0)) $ <eq:transfert>

Avec $R_1 = 10#kohm$, $R_2 = 100#kohm$, et $C_1 = 100#nf$. Le banc de test est présenté sur la @fig:logo.

#figure(
  logo-ece(width: 5cm),
  caption: [Logo vectoriel ECE],
) <fig:logo>

#callout(title: "Précaution expérimentale", type: "warning")[
  Vérifier l'alimentation symétrique (+15 V / -15 V) de l'amplificateur opérationnel avant la mise sous tension.
]

#e(1)[Mesure expérimentale du gain et traitement des données.]

Les signaux observés à l'oscilloscope sont illustrés sur la @fig:mesures.

#figure(
  logo-ece(width: 5cm),
  caption: [Résultats expérimentaux],
) <fig:mesures>

= Méthodologie et recommandations
== Guide de rédaction

#text(fill: gray)[
  Pour chaque question, expliciter :
  + Le problème
  + La solution technique
  + Les résultats obtenus
  + La validation critique
]

#show: annexes

= Annexes

Documents volumineux, relevés de mesures brutes ou code source (#attention[pas de code brut dans le corps du rapport]).
