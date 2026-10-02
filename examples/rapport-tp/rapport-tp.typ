#import "@preview/electrocentrale:0.2.0": *
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge, shapes
#import "@preview/moustaches:0.1.2": stat, caracteristiques
#import "@preview/sourcecraft:0.1.0": source-diagram
#import "@preview/lilaq:0.2.0" as lq

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
  show-emails: true,
  show-supervisor-email: true,
  date: auto,
  city: "Paris",
  draft: false,
  font: font-presets.at(style-police, default: "New Computer Modern"),
)

= Première partie : Chaîne d'acquisition et architecture matérielle

== Synoptique fonctionnel du banc de test

La chaîne de mesure est articulée autour d'un filtre actif passe-bas analogique du 1#super[er] ordre, excité par un générateur de fonctions (GBF) et échantillonné par un étage d'acquisition piloté par un microcontrôleur STM32. Le synoptique matériel est présenté sur la @fig:synoptique.

#figure(
  diagram(
    node-stroke: 0.8pt,
    node((0, 0), [Générateur BF \ #text(8pt)[Signal test]]),
    edge("-|>", [$V_("in")$]),
    node((1, 0), [Filtre Actif \ #text(8pt)[AOP + RC]]),
    edge("-|>", [$V_("out")$]),
    node((2, 0), [Étage ADC \ #text(8pt)[STM32 DMA]]),
    edge("<|-|>", [USB]),
    node((3, 0), [Poste Hôte \ #text(8pt)[Acquisition]]),
  ),
  caption: [Synoptique de la chaîne d'instrumentation et de mesure du filtre actif (`fletcher`)],
) <fig:synoptique>

#callout(title: "Précaution expérimentale", type: "warning")[
  Vérifier l'alimentation symétrique (+15 V / -15 V) de l'amplificateur opérationnel avant la mise sous tension du générateur de fonctions (GBF).
]

== Nomenclature des composants (BOM)

Le dimensionnement des composants de l'étage de filtrage analogique est consigné dans le @tab:bom :

#figure(
  table(
    columns: (1fr, 2.5fr, 1.8fr, 0.8fr, 2fr),
    align: (col, row) => if col in (0, 3) { center + horizon } else { left + horizon },
    table.header([Réf.], [Désignation], [Valeur nominale], [Qté], [Tolérance]),
    [U1], [TL081CP (AOP JFET)], [Boîtier DIP-8], [1], [Gain produit-bande 3 MHz],
    [R1], [Résistance d'entrée], [10 kΩ (0.25 W)], [1], [±1 % (film métallique)],
    [R2], [Résistance de contre-réaction], [100 kΩ (0.25 W)], [1], [±1 % (film métallique)],
    [C1], [Condensateur polyester], [10 nF / 63 V], [1], [±5 % (classe MKT)],
  ),
  caption: [Nomenclature des composants du filtre actif du premier ordre],
) <tab:bom>

#pagebreak()

== Schéma électronique du montage (Image source Web)

Le schéma électronique du filtre actif passe-bas du premier ordre est présenté sur la @fig:schema-filtre. Il est constitué d'un amplificateur opérationnel monté en configuration inverseur, avec une résistance d'entrée $R_1$ et un dipôle de contre-réaction $R_2 parallel C_1$ :

#figure(
  image("filtre-actif.svg", width: 7.2cm),
  caption: [Schéma électronique vectoriel du filtre actif passe-bas inverseur (source : Wikimedia Commons)],
) <fig:schema-filtre>

#pagebreak()

= Deuxième partie : Persistance des mesures et schéma de base de données

== Modélisation relationnelle (`table-bdd`)

Pour assurer la traçabilité des campagnes de qualification en laboratoire, les points acquis sont enregistrés dans une base de données relationnelle locale (SQLite). Le modèle conceptuel de données est modélisé sur la @fig:bdd à l'aide du composant `#table-bdd` natif d'electrocentrale :

#figure(
  grid(
    columns: (auto, auto),
    gutter: 18pt,
    align: top,
    table-bdd("CAMPAGNE_TEST", (
      ("id", "INT", "PK"),
      ("date_mesure", "DATETIME", ""),
      ("operateur", "VARCHAR(60)", ""),
      ("temp_ambiante", "FLOAT", ""),
      ("statut", "VARCHAR(20)", ""),
    )),
    table-bdd("POINT_MESURE", (
      ("id", "BIGINT", "PK"),
      ("campagne_id", "INT", "FK"),
      ("freq_hz", "FLOAT", ""),
      ("vin_vpp", "FLOAT", ""),
      ("vout_vpp", "FLOAT", ""),
      ("gain_db", "FLOAT", ""),
    )),
  ),
  caption: [Schéma relationnel de persistance des points de mesure (Tables SQL)],
) <fig:bdd>

#pagebreak()

= Troisième partie : Algorithme et pilote logiciel d'acquisition

== Algorigramme du cycle d'acquisition (`fletcher`)

Le déroulement du cycle de mesure automatisé est formalisé par l'algorigramme de la @fig:algo, généré via le package vectoriel `@preview/fletcher:0.5.8` :

#figure(
  diagram(
    node-stroke: 0.8pt,
    node((0, 0), [Démarrage acquisition], shape: shapes.pill),
    edge("-|>"),
    node((0, 1), [Configuration ADC et DMA], shape: shapes.rect),
    edge("-|>"),
    node((0, 2), [Attente Trigger GBF], shape: shapes.parallelogram),
    edge("-|>"),
    node((0, 3), [Buffer plein ?], shape: shapes.diamond),
    edge("-|>", [Oui]),
    edge((0, 3), (1, 3), "-|>", [Non]),
    edge((1, 3), (1, 1), (0, 1), "-|>"),
    node((0, 4), [Calcul du Gain et de la tension], shape: shapes.rect),
    edge("-|>"),
    node((0, 5), [Transmission USB], shape: shapes.parallelogram),
    edge("-|>"),
    node((0, 6), [Fin acquisition], shape: shapes.pill),
  ),
  caption: [Algorigramme du cycle d'acquisition généré avec Fletcher],
) <fig:algo>

#pagebreak()

== Traitement de la trame de numérisation (Bloc de code C)

Le microcontrôleur lit en continu le convertisseur analogique-numérique (ADC) par DMA et transmet la moyenne glissante vers la station hôte. L'implémentation du pilote logiciel est détaillée sur le @code:driver :

#figure(
  ```c
  #include <stdint.h>
  #include <stdbool.h>

  #define SAMPLES_COUNT 64
  #define VREF_MV       3300

  /**
   * @brief Calcule la tension crête-à-crête à partir des échantillons DMA.
   */
  float process_vpp_measurement(const uint16_t *adc_buffer, uint16_t len) {
      if (adc_buffer == NULL || len == 0) return 0.0f;

      uint16_t min_raw = 0xFFFF;
      uint16_t max_raw = 0;

      for (uint16_t i = 0; i < len; i++) {
          if (adc_buffer[i] < min_raw) min_raw = adc_buffer[i];
          if (adc_buffer[i] > max_raw) max_raw = adc_buffer[i];
      }

      float v_min = ((float)min_raw * VREF_MV) / 4095.0f;
      float v_max = ((float)max_raw * VREF_MV) / 4095.0f;
      return (v_max - v_min) / 1000.0f; // Retour en Volts
  }
  ```,
  caption: [Pilote de traitement numérique du signal et calcul du $V_("pp")$ mesuré],
) <code:driver>

#pagebreak()

= Quatrième partie : Étude théorique et réponse fréquentielle

== Analyse analytique

#t(1)[Déterminer la fonction de transfert théorique du filtre passe-bas actif du 1#super[er] ordre.]

La fonction de transfert théorique s'exprime sous la forme canonique :
$ H(j omega) = (V_("out")) / (V_("in")) = - (R_2 / R_1) 1 / (1 + j (omega / omega_0)) $ <eq:transfert>

Pour les valeurs de composants $R_1 = 10 "k"Omega$, $R_2 = 100 "k"Omega$ et $C = 10 "nF"$, la fréquence de coupure à $-3 "dB"$ théorique vaut :
$ f_c = 1 / (2 pi R_2 C) approx 159.15 "Hz" $

Le signal d'entrée appliqué par le GBF est sinusoïdal de tension continue 0 V et d'amplitude 1 Vpp.

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

#pagebreak()

= Cinquième partie : Visualisations avancées via modules externes (Typst Universe)

#callout(title: "Architecture modulaire de Typst", type: "info")[
  Le template `electrocentrale` fournit le socle officiel ECE : charte graphique, page de garde, blocs d'ingénierie, tableaux BDD et blocs de code.
  Pour toutes les représentations de pointe (statistiques d'évaluation, UML orienté objet, tracés scientifiques 2D), la philosophie Typst repose sur l'écosystème *Typst Universe* : importer des bibliothèques dédiées en une ligne, sans complexifier le gabarit de base.
]

== 1. Statistiques et dispersion de fabrication avec `moustaches`

#t(2)[Analyser l'impact de la tolérance à 5% des composants sur la dispersion de la fréquence de coupure réelle.]

Pour évaluer la répétabilité du circuit en production, 75 filtres ont été mesurés sur banc automatisé. Le package `moustaches` génère en une commande le tableau des effectifs, les fréquences et la boîte à moustaches :

#figure(
  stat(
    nom-donnee: [$f_c$ mesurée (Hz)],
    nom-effectifs: [Filtres],
    valeurs: (152, 154, 156, 158, 160, 162, 164, 166),
    effectifs: (3, 7, 14, 23, 16, 8, 3, 1),
    qualitatif: false,
    totaux: true,
    diagramme: "bar box",
  ),
  caption: [Distribution statistique et boîte à moustaches de la fréquence de coupure],
) <fig:stats>

#pagebreak()

== 2. Architecture logicielle orientée objet avec `sourcecraft`

#e(2)[Concevoir l'architecture orientée objet du firmware de pilotage des instruments de mesure.]

Plutôt que de concevoir des diagrammes UML manuels ou de bricoler des boîtes vectorielles souvent désynchronisées du code, le package `@preview/sourcecraft:0.1.0` parse directement les fichiers source Java ou C\# et trace le diagramme de classes vectoriel avec relations d'héritage, d'implémentation et d'agrégation :

#figure(
  source-diagram(
    ```java
    public interface IInstrument {
        boolean connecter(String busAdresse);
        void reinitialiser();
    }

    public abstract class InstrumentMesure implements IInstrument {
        protected String identifiant;
        protected boolean estActif;
        public abstract byte[] acquerirTrame();
    }

    public class OscilloscopeNumerique extends InstrumentMesure {
        private double echelleTension;
        private double baseTemps;
        public byte[] acquerirTrame() { return new byte[0]; }
        public double mesurerVpp(int voie) { return 0.0; }
    }

    public class BancAutomatique {
        private InstrumentMesure[] instruments;
        private String operateur;
        public void lancerSequenceTest() {}
    }
    ```.text,
    grammar: "java",
  ),
  caption: [Diagramme de classes UML généré automatiquement par SourceCraft depuis le code source Java],
) <fig:uml-auto>

#pagebreak()

== 3. Cartographie thermique 2D de dissipation avec `lilaq`

#t(3)[Mesurer la carte thermique de dissipation de puissance de l'étage amplificateur en régime continu.]

Le tracé de matrices 2D et heatmaps vectorielles s'effectue via le package scientifique `@preview/lilaq:0.2.0` (`colormesh` et `colorbar`), offrant un rendu fluide de qualité publication directement dans le document :

#figure(
  align(center)[
    #let x-coords = lq.linspace(0, 10, num: 15)
    #let y-coords = lq.linspace(0, 8, num: 12)
    #let z-data = (
      (12, 14, 15, 18, 20, 22, 25, 27, 26, 24, 21, 18, 16, 14, 12),
      (13, 16, 18, 22, 26, 30, 34, 35, 33, 29, 25, 21, 18, 15, 13),
      (15, 18, 22, 28, 35, 42, 48, 49, 45, 38, 30, 24, 20, 17, 14),
      (16, 20, 25, 34, 45, 58, 65, 66, 60, 48, 36, 28, 22, 18, 15),
      (16, 20, 25, 35, 48, 62, 70, 72, 65, 50, 38, 29, 22, 18, 15),
      (15, 19, 23, 32, 42, 55, 62, 63, 57, 45, 34, 26, 21, 17, 14),
      (14, 17, 20, 25, 32, 40, 45, 46, 42, 35, 28, 23, 19, 16, 13),
      (13, 15, 17, 20, 24, 28, 31, 32, 30, 26, 22, 19, 16, 14, 12),
      (12, 14, 15, 17, 19, 21, 23, 24, 23, 21, 18, 16, 14, 13, 11),
      (11, 12, 13, 14, 15, 16, 17, 17, 17, 16, 15, 14, 13, 12, 11),
      (10, 11, 12, 12, 13, 14, 14, 14, 14, 13, 13, 12, 12, 11, 10),
      (10, 10, 11, 11, 11, 12, 12, 12, 12, 11, 11, 11, 10, 10, 10),
    )
    #let cm = lq.colormesh(x-coords, y-coords, z-data)
    #stack(
      dir: ltr,
      spacing: 1em,
      lq.diagram(
        title: [Dissipation thermique (°C) à la surface du PCB],
        xlabel: [Position $X$ (mm)],
        ylabel: [Position $Y$ (mm)],
        cm,
      ),
      lq.colorbar(cm),
    )
  ],
  caption: [Carte thermique 2D de dissipation acquise par caméra infrarouge],
) <fig:thermique>

#pagebreak()

= Méthodologie et recommandations
== Guide de rédaction

#text(fill: rgb("#334155"))[
  Petits rappels pour une grande réussite :

  Pour chaque question, dire :

  + Formulation du *problème* : ce que l’on cherche à faire ;
  + Présentation de la *solution technique* : comment on le fait (schéma bloc @fig:synoptique, schéma BDD @fig:bdd ou pilote @code:driver) ;
  + Présentation et description des *résultats* : ce que l’on obtient (relevé @tab:mesures, statistiques @fig:stats, heatmap @fig:thermique) ;
  + *Validation* des résultats et *Réponses à la question* avec un esprit critique d'ingénieur.

  #v(0.5em)

  - Toujours mentionner les renvois aux Figures et Tableaux.
  - Privilégier les packages de l'écosystème Typst Universe pour les représentations spécialisées (`sourcecraft` pour l'UML, `moustaches` pour les statistiques, `lilaq` pour les graphiques avancés).
  - Exporter au format .PDF le rapport.
]

#show: annexes

= Tableaux de mesures brutes

Relevés bruts oscilloscope et analyseur de spectre.

= Code source des scripts d'acquisition

Scripts de traitement automatisé et communication SCPI.

