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
| `#ohm`, `#kohm`, `#uf`, `#nf`    | `$R_1 = 10#kohm$` | Notations d'impédances et capacités ($\Omega$, $\text{k}\Omega$, $\mu\text{F}$, $\text{nF}$...) |
| `#hz`, `#khz`, `#mhz`              | `$f_0 = 3.39#khz$` | Fréquences normalisées ($\text{Hz}$, $\text{kHz}$, $\text{MHz}$, $\text{GHz}$)                 |
| `#ma`, `#ua`, `#na`                | `$I_1 = 15#ua$` | Courants normalisés ($\text{mA}$, $\mu\text{A}$, $\text{nA}$)                                        |
| `#vpp`, `#vrms`, `#vdc`, `#vac`  | `$V_("in") = 2.5#vpp$`                                                                                                        | Tensions caractéristiques, millivolt (`#mv`), microvolt (`#uv`)                                 |
| `#db`, `#dbm`, `#degc`             | `$G = -20#db$`                                                                                                                | Décibels, puissances RF (`#dbm`, `#mw`), température (`#degc`)                               |
| `#orga-equipe(...)`                | `#orga-equipe(responsable: ..., membres: (...))`                                                                               | Organigramme d'équipe projet avec connecteur arborescent vectoriel                            |
| `#orga-entreprise(...)`            | `#orga-entreprise(direction: ..., poles: (...))`                                                                             | Organigramme d'entreprise/stage hiérarchique multi-pôles                                      |
| `#gantt(...)`                      | `#gantt(unites: (...), taches: (...))`                                                                                        | Diagramme de Gantt pour plannings projet et stage                                             |
| `#chaine-blocs(...)`               | `#chaine-blocs(bloc-fonctionnel(...), ...)`                                                                                   | Chaîne de blocs fonctionnels et flux de signaux                                               |
| `#table-bdd(...)`                  | `#table-bdd("Nom", ((col, type, key), ...))`                                                                                 | Schéma relationnel de base de données avec clés PK/FK                                         |
| `#algorigramme(...)`               | `#algorigramme(algo-debut(...), ...)`                                                                                         | Algorigramme et logigramme séquentiel                                                         |
| `#attention[...]`                  | `#attention[Avertissement]`                                                                                                   | Texte d'avertissement en rouge gras                                                           |
| `#nb[...]`                         | `#nb[Remarque]`                                                                                                               | Encart **NB :**                                                                               |
| `#todo[...]`                       | `#todo[Section à compléter]`                                                                                                  | Surlignage TODO jaune                                                                         |

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

---

## 📊 Diagrammes d'ingénierie & Organigrammes

Le paquet intègre des générateurs de diagrammes 100 % vectoriels en Typst natif (sans dépendances externes ni compilation lourde).

### 1. Organigramme d'équipe projet (`#orga-equipe`)

Conçu pour illustrer la structure hiérarchique d'un projet étudiant (tuteur / chef de projet et membres de l'équipe) reliés par un connecteur arborescent vectoriel continu et des cartes stylisées avec bandeaux de couleur et badges pilules.

```typst
#figure(
  orga-equipe(
    responsable: carte-membre(
      "Dr. Jean DUPONT",
      role: "Tuteur & Enseignant-chercheur",
      affiliation: "Département Électronique",
      responsable: true,
    ),
    membres: (
      carte-membre(
        "André-Marie AMPÈRE",
        role: "Chef de projet & Routage PCB",
        affiliation: "ING5 Systèmes Embarqués",
        tag: "HARDWARE",
      ),
      carte-membre(
        "Alessandro VOLTA",
        role: "Développement Firmware C / STM32",
        affiliation: "ING5 Systèmes Embarqués",
        tag: "FIRMWARE",
      ),
    ),
  ),
  caption: [Organigramme fonctionnel de l'équipe projet],
) <fig:orga>
```

**Options de `#carte-membre` :**
- `nom` : Nom complet (texte ou contenu).
- `role` : Rôle ou fonction dans le projet ou le service.
- `affiliation` / `service` : Majeure, département, ou laboratoire.
- `tag` : Badge textuel en pilule (ex: `"HARDWARE"`, `"FIRMWARE"`, `"LEAD"`). Facultatif.
- `badge` : Contrôle précis de la pilule (`auto` par défaut, `false` ou `none` pour masquer la pilule, ou texte personnalisé `"CHEF"`).
- `email` : Adresse e-mail cliquable sous forme de lien.
- `responsable` : Si `true`, applique l'accent vert canard ECE.
- `stagiaire` : Si `true`, applique l'accent jaune/or et la mise en valeur.
- `couleur` : Couleur d'accentuation personnalisée (par défaut : `auto`).
- `compact` : Si `true`, réduit le padding et la taille de police (idéal pour les grands organigrammes denses).

---

### 2. Organigramme d'entreprise ou de stage (`#orga-entreprise`)

Indispensable pour les rapports de stage (ING4, PFE/ING5) et projets avec partenaire industriel. Il modélise la Direction générale au sommet, les rôles transverses (PMO, Qualité, Adjoint), puis les Pôles / Départements en colonnes avec leurs sous-équipes et collaborateurs.

```typst
#figure(
  orga-entreprise(
    direction: carte-membre(
      "Dr. Alexandre DE LA TOUR",
      role: "Directeur Technique & R&D (CTO)",
      responsable: true,
      compact: true,
    ),
    transverse: carte-membre(
      "Claire M.",
      role: "PMO & Qualité",
      tag: "TRANSVERSE",
      couleur: rgb("#7C3AED"),
      compact: true,
    ),
    poles: (
      (
        nom: "Pôle Systèmes Embarqués",
        couleur: ece,
        responsable: carte-membre(
          "Dr. Sophie LAURENT",
          role: "Tuteur Entreprise & Lead R&D",
          responsable: true,
          compact: true,
        ),
        sous-poles: (
          (
            nom: "Équipe Firmware & Capteurs",
            membres: (
              carte-membre(
                "Léon P.",
                role: "Stagiaire R&D Firmware",
                stagiaire: true,
                compact: true,
              ),
              carte-membre("Thomas D.", role: "Ingénieur Linux", tag: "FIRMWARE", compact: true),
            ),
          ),
          (
            nom: "Équipe Électronique & CAO",
            membres: (
              carte-membre("Camille R.", role: "Ingénieure PCB", tag: "HARDWARE", compact: true),
            ),
          ),
        ),
      ),
      (
        nom: "Pôle Logiciel & Cloud IoT",
        couleur: darkpowderblue,
        responsable: carte-membre("Marc B.", role: "Lead Cloud", compact: true),
        membres: (
          carte-membre("Alexandre B.", role: "Dev Full-Stack", tag: "BACKEND", compact: true),
          carte-membre("Julie L.", role: "Dev Web / UI", tag: "FRONTEND", compact: true),
        ),
      ),
      (
        nom: "Pôle Bancs d'Essais & Validation",
        couleur: gamboge,
        responsable: carte-membre("Marc D.", role: "Resp. Bancs", compact: true),
        membres: (
          carte-membre("Sarah B.", role: "Ingénieure CEM", tag: "QUALIF", compact: true),
          carte-membre("Julien K.", role: "Technicien Mesures", tag: "LABO", compact: true),
        ),
      ),
    ),
  ),
  caption: [Structure organisationnelle multi-branches de l'entreprise d'accueil],
) <fig:orga-entreprise>
```

> **Astuce - Équipe projet multi-pôles :** Vous pouvez également passer le paramètre `poles: (...)` directement à `#orga-equipe(responsable: ..., poles: (...))` pour structurer une grande équipe projet étudiante en plusieurs sous-groupes thématiques.

---

### 3. Planning & Diagramme de Gantt (`#gantt`)

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

---

### 4. Chaîne de blocs fonctionnels (`#chaine-blocs`)

Idéal pour modéliser le synoptique d'un système matériel ou logiciel, avec des blocs rectangulaires et des bus de liaison :

```typst
#figure(
  chaine-blocs(
    bloc-fonctionnel("Mesurer", sous-titre: "Capteurs IMU"),
    "I2C (400 kHz)",
    bloc-fonctionnel("Traiter", sous-titre: "STM32F4 / FreeRTOS"),
    "UART (115200 bps)",
    bloc-fonctionnel("Transmettre", sous-titre: "Module LoRa"),
  ),
  caption: [Synoptique fonctionnel de la chaîne de mesure],
) <fig:chaine>
```

---

### 5. Schéma de base de données relationnelle (`#table-bdd`)

Affiche une table de base de données avec typage des attributs et mise en évidence des clés primaires (`PK`) et étrangères (`FK`) :

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

### 6. Algorigrammes & Logigrammes (`#algorigramme`)

Permet de structurer des organigrammes de traitement séquentiel (initialisation, action, prise de décision conditionnelle, fin) :

```typst
#algorigramme(
  algo-debut("Mise sous tension du système"),
  "Démarrage bootloader",
  algo-action("Initialisation des horloges & bus I2C"),
  "Vérification communication",
  algo-decision("Capteur IMU détecté"),
  "Oui",
  algo-action("Lancement de la tâche FreeRTOS"),
  "Prêt",
  algo-fin("Boucle principale active"),
)
```
