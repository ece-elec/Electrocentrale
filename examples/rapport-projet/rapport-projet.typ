#import "@preview/electrocentrale:0.1.0": *

// Style de police : "latex" | "typst-modern" | "modern-sans" | "editorial"
#let style-police = "latex"

// Modèle de Projet (changeable en `tp.with` sans modifier les arguments)
#show: projet.with(
  lang: "en",
  title: "Système Embarqué Autonome",
  promo: "ING5",
  major: "Systèmes Embarqués",
  groupe: "Groupe 02",
  authors: (
    (name: "André-Marie AMPÈRE", email: "ampere@ece.fr", role: "Chef de projet & Électronique"),
    (name: "Alessandro VOLTA", email: "volta@ece.fr", role: "Développement Embarqué"),
  ),
  show-roles: true, // Passer à false pour masquer les rôles/titres sous les auteurs
  show-emails: true, // Passer à false pour masquer les adresses email
  supervisor: (name: "Dr. Jean DUPONT", email: "jean.dupont@ece.fr"),
  show-supervisor-email: true, // Passer à false pour masquer l'email du tuteur
  date: auto,  // ou date: "15 octobre 2026" pour une date fixe
  city: "Paris",
  draft: true, // Passer à true pour activer le filigrane "BROUILLON"
  table-of-figures: true, // Liste automatique des figures et diagrammes
  table-of-tables: true,  // Liste automatique des tableaux
  // equation-numbering: "(1)",  // Décommenter pour numéroter les équations
  abstract: [
    Quel est le contexte et la problématique du projet ? Quels sont les objectifs techniques ?
    Dans quel contexte faites-vous ce projet ? [maximum 20 lignes]
  ],
  font: font-presets.at(style-police, default: "New Computer Modern"),
)

= Objectifs

Quel est l’objectif de ce document ?

Que va y trouver le lecteur ?

= Glossaire

== Termes

Renseigner ici sous forme de tableau les principaux termes techniques et leurs définitions.

#table(
  columns: (1.5fr, 3.5fr),
  table.header([Terme], [Définition]),
  [Exemple de terme], [Définition précise du terme dans le cadre du projet.],
  [Autre terme], [Explication détaillée du fonctionnement ou rôle du terme.],
)

== Acronymes

Renseigner ici sous forme de tableau les principaux acronymes, leurs significations et leurs explications.

#table(
  columns: (1fr, 1.8fr, 2.7fr),
  table.header([Acronyme], [Signification], [Explication]),
  [CAN], [Convertisseur Analogique-Numérique], [Composant permettant d'échantillonner et numériser un signal analogique.],
  [UART], [Universal Asynchronous Receiver-Transmitter], [Protocole de communication série asynchrone.],
)

= L'équipe

== Présentation de l’équipe

L'équipe projet est constituée de deux élèves-ingénieurs de la majeure Systèmes Embarqués, encadrés par un enseignant-chercheur du département Électronique.

== Organisation de l’équipe

La répartition des rôles et l'organigramme fonctionnel sont détaillés sur la @fig:orga :

#figure(
  orga-equipe(
    responsable: carte-membre("Dr. Jean DUPONT", role: "Tuteur & Enseignant-chercheur", affiliation: "Département Électronique & Physique", responsable: true),
    membres: (
      carte-membre("André-Marie AMPÈRE", role: "Chef de projet & Routage PCB", affiliation: "ING5 Systèmes Embarqués", tag: "HARDWARE"),
      carte-membre("Alessandro VOLTA", role: "Développement Firmware C / STM32", affiliation: "ING5 Systèmes Embarqués", tag: "FIRMWARE"),
    ),
  ),
  caption: [Organigramme fonctionnel de l'équipe projet],
) <fig:orga>

== Diagramme de Gantt

Le calendrier prévisionnel des différentes phases de conception, de développement et de validation en laboratoire est illustré sur la @fig:gantt :

#figure(
  gantt(
    unites: ("S1", "S2", "S3", "S4", "S5", "S6", "S7", "S8"),
    taches: (
      (nom: "Étude théorique & Spécifications", debut: 1, fin: 3),
      (nom: "Conception Schématique & Routage PCB", debut: 2, fin: 5, couleur: darkpowderblue),
      (nom: "Développement Firmware (Pilotes I2C/SPI)", debut: 4, fin: 7),
      (nom: "Banc de tests & Validation en laboratoire", debut: 6, fin: 8, couleur: gamboge),
    ),
  ),
  caption: [Planning prévisionnel des tâches du projet (Gantt)],
) <fig:gantt>

= Contexte et problématique

== Contexte

Quel est le contexte économique et ou sociétal du projet ?

Comment est née l’invention / la technologie du projet, comment a-t-elle évolué ?

== Problématique

À quelle problématique répond le projet ?

== Spécifications techniques

Les exigences fonctionnelles et contraintes opérationnelles du système sont synthétisées dans le @tab:spec :

#figure(
  table(
    columns: (1.2fr, 3fr, 1.5fr, 1.3fr),
    align: (col, row) => if col in (0, 2, 3) { center + horizon } else { left + horizon },
    table.header([Réf.], [Exigence technique], [Valeur cible], [Priorité]),
    [SPEC-01], [Tension d'alimentation nominale], [3.3 V ± 5%], [Critique],
    [SPEC-02], [Consommation moyenne en veille], [< 15 µA], [Haute],
    [SPEC-03], [Cadence d'échantillonnage IMU], [100 Hz], [Critique],
    [SPEC-04], [Portée de communication sans fil], [> 30 m (intérieur)], [Moyenne],
    [SPEC-05], [Autonomie sur batterie Li-Po], [> 72 heures], [Haute],
  ),
  caption: [Spécifications techniques et exigences de performance du système],
) <tab:spec>

= Conception

== Architecture fonctionnelle

La chaîne fonctionnelle globale d'acquisition, de traitement et de communication du système est représentée sur la @fig:chaine-fonc :

#figure(
  chaine-blocs(
    bloc-fonctionnel("Mesurer", sous-titre: "Grandeur physique (accélération)"),
    "Signal analogique",
    bloc-fonctionnel("Conditionner & Échantillonner", sous-titre: "Filtre anti-repliement & ADC"),
    "Données brutes",
    bloc-fonctionnel("Traiter & Calculer", sous-titre: "Filtrage numérique et calibration"),
    "Trames",
    bloc-fonctionnel("Transmettre", sous-titre: "Liaison radiofréquence"),
  ),
  caption: [Synoptique de la chaîne fonctionnelle globale du système],
) <fig:chaine-fonc>

== Architecture matérielle

Quel matériel est utilisé et pourquoi ? Comment les différentes briques techniques sont connectées entre elles ?

L'étage analogique et les alimentations sont dimensionnés selon les règles de l'art de l'électronique @horowitz2015art. Le microcontrôleur principal et ses registres de configuration sont référencés d'après la documentation constructeur @stm32f401_datasheet. L'architecture du réseau de capteurs suit les recommandations de l'état de l'art IoT @al2015internet.

#callout(title: "Règle de conception matérielle", type: "tip")[
  Privilégier des composants montés en surface (CMS 0805) et prévoir des points de test (testpoints) sur les bus I2C et SPI pour faciliter le débogage à l'analyseur logique.
]

#figure(
  chaine-blocs(
    bloc-fonctionnel("Batterie Li-Po", sous-titre: "3.7 V / 1200 mAh"),
    "V_bat",
    bloc-fonctionnel("Régulateur LDO", sous-titre: "3.3 V faible bruit"),
    "3.3 V",
    bloc-fonctionnel("Capteur MPU-6050", sous-titre: "IMU 6 axes"),
    fleche-bus(label: "I2C", bidirectionnelle: true),
    bloc-fonctionnel("STM32F401RE", sous-titre: "MCU ARM Cortex-M4"),
    "SPI",
    bloc-fonctionnel("Module LoRa / RF", sous-titre: "SX1276 (868 MHz)"),
  ),
  caption: [Synoptique de l'architecture matérielle et des bus d'interconnexion],
) <fig:archi>

=== Nomenclature des composants principaux (BOM)

La liste des composants nécessaires est détaillée dans le @tab:bom et le câblage associé dans le @tab:pinout.

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

=== Affectation des broches (Pinout)
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

== Architecture logicielle

L'ordonnancement de la boucle principale de mesure et de transmission radio est synthétisé par l'algorigramme de la @fig:algo :

#figure(
  algorigramme(
    algo-debut("Démarrage du système"),
    algo-action("Initialisation matérielle", sous-titre: "Horloges, GPIO, I2C1, SPI1"),
    algo-sous-programme("Configuration du capteur IMU", sous-titre: "Plage ±2g, filtre passe-bas interne"),
    algo-es("Lecture des registres accéléromètre", sous-titre: "Trame brute I2C 6 octets"),
    algo-decision("Données valides", non: "Rejet & Sommeil"),
    "OUI",
    algo-action("Calcul de la moyenne glissante", sous-titre: "Filtrage numérique FIR"),
    algo-es("Téléversement de la trame radio", sous-titre: "Paquet LoRa SX1276 (868 MHz)"),
    algo-fin("Mise en veille temporaire (Low Power)"),
  ),
  caption: [Algorigramme de la boucle d'acquisition du firmware embarqué],
) <fig:algo>

== Modélisation de la base de données (Informatique & Télémétrie)

Pour les projets intégrant un volet logiciel ou une passerelle IoT, les données reçues sont persistées dans une base de données relationnelle dont le schéma entité-association est illustré sur la @fig:bdd :

#figure(
  grid(
    columns: (auto, auto),
    gutter: 20pt,
    align: top,
    table-bdd("CAPTEUR", (
      ("id", "INT", "PK"),
      ("nom", "VARCHAR(50)", ""),
      ("adresse_mac", "VARCHAR(17)", "UNIQUE"),
      ("frequence_ech", "INT", ""),
    )),
    table-bdd("RELEVE_TELEMETRIE", (
      ("id", "BIGINT", "PK"),
      ("capteur_id", "INT", "FK"),
      ("timestamp", "DATETIME", ""),
      ("valeur_x", "FLOAT", ""),
      ("valeur_y", "FLOAT", ""),
      ("valeur_z", "FLOAT", ""),
    )),
    
  ),
  caption: [Schéma relationnel des données de télémétrie capteurs (MCD / Tables SQL)],
) <fig:bdd>

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

Le bilan de consommation selon les modes opérationnels est détaillé dans le @tab:modes :

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

== Module 2 : Traitement du signal et conditionnement analogique

Le conditionnement du signal capteur utilise un étage préamplificateur à faible bruit. Le filtre passe-bas anti-repliement passif $R C$ est dimensionné avec $R_("filtre") = 4.7#kohm$ et $C_("filtre") = 10#nf$, fixant la fréquence de coupure théorique à :

$ #fcut = 1 / (2 pi R_("filtre") C_("filtre")) approx 3.39#khz $

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

=== Synthèse de la campagne de tests

La matrice de validation récapitule les résultats obtenus sur l'ensemble des modules dans le @tab:tests :

#figure(
  table(
    columns: (1fr, 2.2fr, 2fr, 2fr, 1.2fr),
    align: (col, row) => if col in (0, 4) { center + horizon } else { left + horizon },
    table.header([ID Test], [Fonctionnalité], [Critère attendu], [Résultat mesuré], [Statut]),
    [TEST-01], [Régulateur Buck 3.3V], [$V_("out") in [3.2, 3.4]" V"$], [3.31 V régulé], [*Validé*],
    [TEST-02], [Liaison I2C capteur IMU], [Réponse ACK @ 100 kHz], [Trame conforme], [*Validé*],
    [TEST-03], [Filtre anti-repliement], [$f_(-3"dB") approx 3.4" kHz"$], [3.38 kHz (-3 dB)], [*Validé*],
    [TEST-04], [Portée radio intérieure], [Taux d'erreur < 1% @ 30 m], [0.3% mesuré], [*Validé*],
  ),
  caption: [Matrice de validation et conformité des tests expérimentaux],
) <tab:tests>

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

Le routage du circuit imprimé et le plan de masse sont présentés sur la @fig:pcb :

#figure(
  logo-ece(width: 5cm),
  caption: [Routage complet du circuit imprimé et plan de masse],
) <fig:pcb>

= Datasheets et caractéristiques des capteurs

Le @tab:datasheet consigne les spécifications électriques de la centrale inertielle :

#figure(
  table(
    columns: (2fr, 2fr, 2fr),
    table.header([Paramètre], [Valeur nominale], [Tolérance]),
    [Tension d'alimentation], [3.3 V], [± 5 %],
    [Courant actif maximal], [40 mA], [± 10 %],
    [Plage de température], [-40 °C à +85 °C], [Nominal],
  ),
  caption: [Spécifications électriques de la centrale inertielle],
) <tab:datasheet>

Documents volumineux, extraits de documentation constructeur et éventuels codes exhaustifs (#attention[pas de code brut dans le corps du rapport]).
