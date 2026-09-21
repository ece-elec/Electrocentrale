#import "@preview/electrocentrale:0.1.0": *

#set page(
  paper: "a4",
  flipped: false,
  margin: (x: 2cm, top: 2.2cm, bottom: 2.2cm),
  header: align(right)[
    #text(size: 7.5pt, fill: rgb("#64748B"))[
      ECE Paris — Exemples d'organigrammes de projet et d'entreprise
    ]
  ],
  footer: align(center)[
    #context text(size: 8pt, fill: rgb("#94A3B8"))[#counter(page).display()]
  ],
)

#set text(
  font: ("Arial", "Helvetica"),
  size: 9pt,
  lang: "fr",
)
#set par(justify: true, leading: 0.65em)

#align(center)[
  #v(1cm)
  #text(weight: "bold", size: 18pt, fill: ece)[Exemples d'Organigrammes] \
  #v(4pt)
  #text(size: 11pt, fill: rgb("#475569"))[
    Modèles prêts à l'emploi pour rapports de TP, projets d'ingénierie et stages ECE
  ]
  #v(1.5cm)
]

= 1. Équipe Projet Étudiante (Format classique)

Ce modèle convient aux projets de cycle ingénieur (ING3, ING4, ING5) encadrés par un enseignant-chercheur ou tuteur de majeure, avec deux ou trois élèves-ingénieurs aux rôles complémentaires.

#v(8pt)

#figure(
  orga-equipe(
    responsable: carte-membre(
      "Dr. Jean DUPONT",
      role: "Tuteur & Enseignant-chercheur",
      affiliation: "Département Électronique & Physique",
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
  caption: [Organigramme fonctionnel d'une équipe projet de deux étudiants et un tuteur],
) <fig:orga-etudiant>

#pagebreak()

= 2. Équipe Projet Multi-Branches (3 Pôles Techniques)

Pour les projets d'envergure réunissant plusieurs spécialités, le paramètre `poles:` de `#orga-equipe` permet de structurer les responsabilités en pôles thématiques.

#v(8pt)

#figure(
  orga-equipe(
    responsable: carte-membre(
      "Dr. Jean DUPONT",
      role: "Responsable Pédagogique & Tuteur Projet",
      affiliation: "Majeure Systèmes Embarqués",
      responsable: true,
    ),
    poles: (
      (
        nom: "Pôle Électronique & Routage",
        couleur: ece,
        responsable: carte-membre("André-Marie AMPÈRE", role: "Lead Matériel & KiCad", tag: "LEAD"),
        membres: (
          carte-membre("Nikola T.", role: "Dimensionnement puissance"),
        ),
      ),
      (
        nom: "Pôle Logiciel Embarqué (RTOS)",
        couleur: darkpowderblue,
        responsable: carte-membre("Alessandro VOLTA", role: "Lead Architecture C", tag: "LEAD"),
        membres: (
          carte-membre("Ada L.", role: "Pilotes périphériques I2C/SPI"),
        ),
      ),
      (
        nom: "Pôle Interface & Télémétrie",
        couleur: gamboge,
        responsable: carte-membre("Alan T.", role: "Dashboard Web & LoRa", tag: "LEAD"),
        membres: (
          carte-membre("Margaret H.", role: "Banc de calibration"),
        ),
      ),
    ),
  ),
  caption: [Structure hiérarchique d'un projet d'ingénierie découpé en trois pôles techniques],
) <fig:orga-multibranches>

#pagebreak()

= 3. Organigramme de Stage ou PFE en Entreprise

Ce format valorise le positionnement de l'élève-ingénieur au sein de l'entreprise d'accueil, avec son tuteur industriel, son équipe de travail directe et un pôle partenaire.

#v(8pt)

#figure(
  orga-entreprise(
    direction: "Direction Technique & Innovation — AeroTech Solutions",
    poles: (
      (
        nom: "Pôle Systèmes Embarqués (Équipe d'accueil)",
        couleur: ece,
        responsable: carte-membre(
          "Dr. Sophie LAURENT",
          role: "Tuteur Entreprise & Lead R&D",
          responsable: true,
        ),
        membres: (
          carte-membre(
            "Léon P.",
            role: "Élève-Ingénieur Stagiaire R&D",
            affiliation: "ING5 ECE Paris",
            stagiaire: true,
            email: "leon@aerotech.fr",
          ),
          carte-membre(
            "Thomas D.",
            role: "Ingénieur Linux Embarqué",
            tag: "FIRMWARE",
          ),
          carte-membre(
            "Camille R.",
            role: "Ingénieure Conception & Routage PCB",
            tag: "HARDWARE",
          ),
        ),
      ),
      (
        nom: "Pôle Bancs d'Essais & Qualification",
        couleur: darkpowderblue,
        responsable: carte-membre(
          "Marc DUBOIS",
          role: "Responsable Bancs & Mesures",
        ),
        membres: (
          carte-membre(
            "Sarah B.",
            role: "Ingénieure Qualification CEM & Environnement",
            tag: "TESTS",
          ),
          carte-membre(
            "Julien K.",
            role: "Technicien Supérieur Bancs HIL",
            tag: "LABO",
          ),
        ),
      ),
    ),
  ),
  caption: [Organigramme d'accueil en stage et intégration dans la direction technique],
) <fig:orga-stage>

#set page(
  flipped: true,
  margin: (x: 1cm, top: 0.6cm, bottom: 0.5cm),
  header: none,
)

#align(center)[
  #text(weight: "bold", size: 12pt, fill: ece)[4. Grand Organigramme d'Entreprise Multi-Pôles avec Rôle Transverse (Mode Paysage)] \
  #v(1pt)
  #text(size: 7.5pt, fill: rgb("#64748B"))[Direction générale, rôle transverse PMO / Qualité, 4 pôles techniques et 16 collaborateurs en mode compact]
]
#show figure: set block(above: 0.3em, below: 0.3em)

#scale(x: 93%, y: 93%, reflow: true)[
#figure(
  orga-entreprise(
    direction: carte-membre(
      "Dr. Alexandre DE LA TOUR",
      role: "Directeur Technique & R&D (CTO)",
      affiliation: "Comité de Direction — AeroTech Group",
      responsable: true,
      compact: true,
    ),
    transverse: carte-membre(
      "Claire M.",
      role: "PMO & Assurance Qualité",
      affiliation: "Direction Projet",
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
                affiliation: "ING5 ECE Paris",
                stagiaire: true,
                email: "leon@aerotech.fr",
                compact: true,
              ),
              carte-membre(
                "Thomas D.",
                role: "Ingénieur Linux Embarqué",
                tag: "FIRMWARE",
                compact: true,
              ),
            ),
          ),
          (
            nom: "Équipe Électronique & CAO",
            membres: (
              carte-membre(
                "Camille R.",
                role: "Ingénieure Routage PCB",
                tag: "HARDWARE",
                compact: true,
              ),
            ),
          ),
        ),
      ),
      (
        nom: "Pôle Logiciel & Cloud IoT",
        couleur: darkpowderblue,
        responsable: carte-membre(
          "Marc BLANCHARD",
          role: "Responsable Plateforme Cloud",
          compact: true,
        ),
        sous-poles: (
          (
            nom: "Développement Applicatif",
            membres: (
              carte-membre(
                "Alexandre B.",
                role: "Lead Développeur Full-Stack",
                tag: "BACKEND",
                compact: true,
              ),
              carte-membre(
                "Julie L.",
                role: "Développeuse Web & UI/UX",
                tag: "FRONTEND",
                compact: true,
              ),
            ),
          ),
          (
            nom: "Infrastructure",
            membres: (
              carte-membre(
                "Karim T.",
                role: "Ingénieur Cloud DevOps & K8s",
                tag: "DEVOPS",
                compact: true,
              ),
            ),
          ),
        ),
      ),
      (
        nom: "Pôle IA Embarquée & Data",
        couleur: rgb("#0D9488"),
        responsable: carte-membre(
          "Dr. Nicolas ROY",
          role: "Principal AI Scientist",
          compact: true,
        ),
        membres: (
          carte-membre(
            "David P.",
            role: "Ingénieur Deep Learning / TinyML",
            tag: "AI/ML",
            compact: true,
          ),
          carte-membre(
            "Emma S.",
            role: "Data Engineer Edge Computing",
            tag: "DATA",
            compact: true,
          ),
          carte-membre(
            "Adrien M.",
            role: "Alternant M2 Data Science",
            tag: "ALTERNANT",
            compact: true,
          ),
        ),
      ),
      (
        nom: "Pôle Bancs d'Essais & Validation",
        couleur: gamboge,
        responsable: carte-membre(
          "Marc DUBOIS",
          role: "Responsable Bancs & Mesures",
          compact: true,
        ),
        membres: (
          carte-membre(
            "Sarah B.",
            role: "Ingénieure Qualification CEM",
            tag: "QUALIF",
            compact: true,
          ),
          carte-membre(
            "Julien K.",
            role: "Technicien Supérieur Instrumentation",
            tag: "LABO",
            compact: true,
          ),
          carte-membre(
            "Lucas F.",
            role: "Technicien Bancs HIL",
            tag: "TESTS",
            compact: true,
          ),
        ),
      ),
    ),
  ),
  caption: [Organigramme général multi-pôles de la Direction Technique (16 collaborateurs)],
) <fig:orga-complet-paysage>
]
