#import "@preview/ece-reports:0.1.0": *

// =============================================================================
// OPTIONS DE TYPOGRAPHIE ET POLICE (MODIFIABLE DIRECTEMENT ICI)
// =============================================================================
// Choisissez l'un des styles prédéfinis ci-dessous :
// - "latex"        : Style Scientifique LaTeX classique (New Computer Modern avec sérifs)
// - "typst-modern" : Style Scientifique Typst moderne (Libertinus Serif - élégant et aéré)
// - "modern-sans"  : Style Moderne Sans-Serif / Clean (Helvetica Neue / Arial)
// - "editorial"    : Style Éditorial / Revue scientifique (Charter / PT Serif)
// =============================================================================
#let style-police = "latex" // Changez par : "latex" | "typst-modern" | "modern-sans" | "editorial"

#let polices-presets = (
  "latex": "New Computer Modern",
  "typst-modern": "Libertinus Serif",
  "modern-sans": ("Helvetica Neue", "Arial"),
  "editorial": ("Charter", "PT Serif", "Times New Roman"),
)

#show: projet.with(
  lang: "fr",
  title: "Système Embarqué Autonome",
  promo: "ING5",
  major: "Systèmes Embarqués",
  groupe: "Groupe 02",
  authors: (
    (name: "André-Marie AMPÈRE", email: "ampere@ece.fr", role: "Chef de projet & Électronique"),
    (name: "Alessandro VOLTA", email: "volta@ece.fr", role: "Développement Embarqué"),
  ),
  show_roles: true, // Passer à false pour masquer les rôles/titres sous les auteurs
  show_emails: true, // Passer à false pour masquer les adresses email
  supervisor: (name: "Dr. Jean DUPONT", email: "jean.dupont@ece.fr"),
  show_supervisor_email: true, // Passer à false pour masquer l'email du tuteur
  date: auto,  // ou date: "15 octobre 2026" pour une date fixe
  city: "Paris",
  draft: false, // Passer à true pour activer le filigrane "BROUILLON"
  table_of_figures: false, // Passer à true pour générer la liste des figures
  table_of_tables: false, // Passer à true pour générer la liste des tableaux
  // equation_numbering: "(1)",  // Décommenter pour numéroter les équations
  abstract: [
    Quel est le contexte et la problématique du projet ? Quels sont les objectifs techniques ?
    Dans quel contexte faites-vous ce projet ? [maximum 20 lignes]
  ],
  font: polices-presets.at(style-police, default: "New Computer Modern"),
)

= Objectifs

Quel est l’objectif de ce document ?

Que va y trouver le lecteur ?

= Glossaire

== Termes

Renseigner ici sous forme de tableau les principaux termes techniques et leurs définitions.

#table-termes(
  [Exemple de terme], [Définition précise du terme dans le cadre du projet.],
  [Autre terme], [Explication détaillée du fonctionnement ou rôle du terme.],
)

== Acronymes

Renseigner ici sous forme de tableau les principaux acronymes, leurs significations et leurs explications.

#table-acronymes(
  [CAN], [Convertisseur Analogique-Numérique], [Composant permettant d'échantillonner et numériser un signal analogique.],
  [UART], [Universal Asynchronous Receiver-Transmitter], [Protocole de communication série asynchrone.],
)

= L'équipe

== Présentation de l’équipe

Qui sont les membres qui composent l’équipe ?

Quelles sont leurs compétences et qualités ?

== Organisation de l’équipe

Comment est organisée l’équipe ? Comment est réparti le travail ?

== Diagramme de Gantt

Comment est utilisé le temps alloué au projet ?

= Contexte et problématique

== Contexte

Quel est le contexte économique et ou sociétal du projet ?

Comment est née l’invention / la technologie du projet, comment a-t-elle évolué ?

== Problématique

À quelle problématique répond le projet ?

== Spécifications techniques

Quelles sont les spécifications techniques du projet ?

#nb[Certains projets d’électronique à l’ECE n’en ont pas.]

= Conception

== Architecture fonctionnelle

Quelle est l’architecture fonctionnelle du projet ?

#nb[Les fonctionnalités sont des verbes à l’infinitif suivi de compléments.]

À ce stade, aucun choix technique n’est fait.

== Architecture matérielle

Quel matériel est utilisé et pourquoi ? Comment les différentes briques techniques sont connectées entre elles ?

L'étage analogique et les alimentations sont dimensionnés selon les règles de l'art de l'électronique @horowitz2015art. Le microcontrôleur principal et ses registres de configuration sont référencés d'après la documentation constructeur @stm32f401_datasheet. L'architecture du réseau de capteurs suit les recommandations de l'état de l'art IoT @al2015internet.

#callout(title: "Règle de conception matérielle", type: "tip")[
  Privilégier des composants montés en surface (CMS 0805) et prévoir des points de test (testpoints) sur les bus I2C et SPI pour faciliter le débogage à l'analyseur logique.
]

#figure(
  logo-ece(width: 5.5cm),
  caption: [Synoptique de l'architecture matérielle globale du système],
) <fig:archi>

=== Nomenclature des composants principaux (BOM)

La liste des composants nécessaires est détaillée dans le @tab:bom et le câblage associé dans le @tab:pinout.

#figure(
  table-composants(
    [U1], [STM32F401RE], [LQFP-64], [1], [Microcontrôleur principal 84 MHz],
    [U2], [MPU-6050], [QFN-24], [1], [Centrale inertielle 6 axes I2C],
    [C1-C4], [Condensateurs céramiques], [100 nF, 0805], [4], [Découplage alimentations],
    [R1-R2], [Résistances pull-up], [4.7 kΩ, 0805], [2], [Lignes I2C SDA / SCL],
  ),
  caption: [Nomenclature des composants matériels principaux],
) <tab:bom>

=== Affectation des broches (Pinout)

#figure(
  table-brochage(
    [PA5], [SPI1_SCK], [Output Alternate], [Horloge maître du bus SPI],
    [PA7], [SPI1_MOSI], [Output Alternate], [Données maître vers esclave],
    [PB6], [I2C1_SCL], [Open Drain], [Horloge capteur I2C],
    [PB7], [I2C1_SDA], [Open Drain], [Données bidirectionnelles I2C],
  ),
  caption: [Brochage et affectation des broches du microcontrôleur],
) <tab:pinout>

== Architecture logicielle

Comment fonctionne le programme embarqué ?

#nb[Présenter un algorigramme ou la machine à états de votre code.]

L'implémentation logicielle du pilote I2C pour l'acquisition de données est présentée sur le @code:i2c :

#figure(
  ```c
  #include <stdint.h>
  #include <stdbool.h>

  /**
   * @brief Lecture d'un registre sur le capteur via bus I2C.
   */
  int8_t sensor_read_register(uint8_t dev_addr, uint8_t reg_addr, uint8_t *data, uint16_t len) {
      if (data == NULL || len == 0) {
          return -1; // Paramètre invalide
      }
      i2c_start();
      if (!i2c_write_byte(dev_addr << 1)) return -2;
      if (!i2c_write_byte(reg_addr))      return -3;
      i2c_restart();
      if (!i2c_write_byte((dev_addr << 1) | 0x01)) return -4;
      for (uint16_t i = 0; i < len; i++) {
          data[i] = i2c_read_byte(i == (len - 1)); // ACK / NACK
      }
      i2c_stop();
      return 0; // Succès
  }
  ```,
  caption: [Extrait du pilote de communication I2C],
) <code:i2c>

= Développement

L’idée est de présenter ici comment ont été développés les différents blocs du projet. Cela peut rassembler des calculs théoriques, des choix techniques, etc. et surtout bien expliquer le concept clef derrière sa fabrication. Le lecteur doit être capable de comprendre les enjeux techniques et de développer le module en question à l’aide de ces sous-sections.

== Dimensionnement énergétique du nœud autonome

La consommation moyenne $I_("moy")$ du système sur une période $T$ avec un cycle d'activité (duty-cycle) $alpha$ est modélisée par :

$ I_("moy") = alpha dot I_("actif") + (1 - alpha) dot I_("sommeil") $ <eq:conso>

L'autonomie estimée $T_("autonomie")$ sur batterie de capacité $C_("bat")$ (en $"mAh"$) est alors donnée par :

$ T_("autonomie") = (C_("bat") dot eta) / I_("moy") $ <eq:autonomie>

où $eta = 0.85$ représente le rendement du régulateur abaisseur (Buck DC/DC).

== Module 2 : Traitement du signal et conditionnement analogique

Le conditionnement du signal capteur utilise un étage préamplificateur à faible bruit. Le filtre passe-bas anti-repliement passif $R C$ est dimensionné avec $R_("filtre") = 4.7#kohm$ et $C_("filtre") = 10#nf$, fixant la fréquence de coupure théorique à :

$ #fcut = 1 / (2 pi R_("filtre") C_("filtre")) approx 3.39" kHz" $

L'alimentation stabilisée du microcontrôleur délivre $V_("dd") = 3.3#vdc$ avec une ondulation résiduelle crête-à-crête $V_("ondulation") < 20#vpp$.

== Module 3 : Interface de transmission radio

= Tests et validation

Une section au moins aussi importante que celle sur le développement.

Il est question ici de montrer les performances techniques du système et de valider le développement module par module puis au global (intégration) en accord avec la partie IV.

Chaque résultat (bien souvent des courbes) doit être décrit comme suit :

- ce qui a été fait ;
- ce que l’on est censé obtenir et critère de réussite du test ;
- ce que l’on obtient ;
- conclusion : validation ou non du bon fonctionnement du module.

== Module 1
== Module 2
== Module 3

= Bilan

== État d’avancement

Où en est le projet ? A-t-on atteint les objectifs ?

Quels modules restent à finaliser (ou à perfectionner pour être en accord avec les spécifications techniques) ?

== Pertinence de la solution technique

Quelles sont les limites techniques de la solution développée ?

Quelles sont les possibilités d’évolution ou de poursuite ?

== Bilan sur le travail d’équipe

Qu’avez-vous appris individuellement ? Quelles compétences vont pouvoir être mises en avant lors de votre prochaine recherche de stage ?

Comment l’équipe aurait pu mieux s’organiser ? Proposer un plan d’action pour le prochain projet.

#pagebreak()
#bibliography("refs.bib", title: "Bibliographie & Sources")

#show: annexes

= Schémas électroniques complets

Schéma structurel Altium / KiCad et routage PCB.

= Datasheets et caractéristiques des capteurs

Documents volumineux, extraits de documentation constructeur et éventuels codes exhaustifs (#attention[pas de code brut dans le corps du rapport]).
