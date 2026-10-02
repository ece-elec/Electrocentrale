#import "@preview/electrocentrale:0.2.0": *
#import "@preview/typart:0.1.1": hierarchy, tree

#set page(
  paper: "a4",
  flipped: false,
  margin: (x: 2cm, top: 2.2cm, bottom: 2.2cm),
  header: align(right)[
    #text(size: 7.5pt, fill: rgb("#64748B"))[
      ECE Paris — Exemples d'organigrammes de projet et d'entreprise (`typart`)
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
  #v(0.6cm)
  #text(weight: "bold", size: 18pt, fill: ece)[Exemples d'Organigrammes avec `typart`] \
  #v(4pt)
  #text(size: 11pt, fill: rgb("#475569"))[
    Modèles hiérarchiques élégants (`hierarchy` et `tree`) pour rapports de projet, TP et stages ECE
  ]
  #v(1cm)
]

= 1. Équipe Projet Étudiante (`hierarchy`)

Ce modèle convient aux projets de cycle ingénieur (ING3, ING4, ING5) encadrés par un enseignant-chercheur ou tuteur de majeure, avec deux élèves-ingénieurs aux rôles complémentaires :

#v(8pt)

#figure(
  align(center)[
    #hierarchy(
      [*Dr. Jean DUPONT* \ #text(8pt)[Tuteur projet & Enseignant-chercheur] \ #text(7pt, fill: rgb("#64748B"))[Département Électronique]],
      (
        [*André-Marie AMPÈRE* \ #text(8pt)[Chef de projet & Hardware] \ #text(7pt, fill: rgb("#64748B"))[ING5 Systèmes Embarqués]],
        [*Alessandro VOLTA* \ #text(8pt)[Développement Firmware C] \ #text(7pt, fill: rgb("#64748B"))[ING5 Systèmes Embarqués]],
      ),
      size: 8.5pt,
      box-w: 4.8,
      box-h: 1.5,
      level-gap: 2.0,
      accent: rgb("#002B49"),
      root-fill: rgb("#EBF5F5"),
      box-fill: rgb("#F8FAFC"),
    )
  ],
  caption: [Organigramme fonctionnel d'une équipe projet de deux étudiants et un tuteur],
) <fig:orga-etudiant>

#v(1.5em)

= 2. Équipe Projet Multi-Pôles (`hierarchy`)

Pour les projets d'envergure réunissant plusieurs spécialités, le widget `#hierarchy` permet de structurer les responsabilités en pôles thématiques avec des couleurs dédiées par pôle :

#v(8pt)

#figure(
  align(center)[
    #hierarchy(
      [*Direction de Projet* \ #text(8pt)[Dr. Jean DUPONT]],
      (
        ([*Pôle Matériel* \ #text(8pt)[A.-M. Ampère (Lead)] \ #text(7.5pt)[N. Tesla (Routage)]], rgb("#EBF5F5")),
        ([*Pôle Firmware* \ #text(8pt)[A. Volta (Lead)] \ #text(7.5pt)[A. Lovelace (RTOS)]], rgb("#F0FDF4")),
        ([*Pôle Télémétrie* \ #text(8pt)[A. Turing (Lead)] \ #text(7.5pt)[M. Hamilton (Cloud)]], rgb("#FEF3C7")),
      ),
      size: 8pt,
      box-w: 4.2,
      box-h: 1.5,
      gap-x: 0.6,
      level-gap: 2.0,
      accent: rgb("#002B49"),
      root-fill: rgb("#E2E8F0"),
    )
  ],
  caption: [Structure hiérarchique d'un projet d'ingénierie découpé en trois pôles techniques],
) <fig:orga-multibranches>

#pagebreak()

= 3. Organigramme Multi-Niveaux d'Entreprise (`tree`)

Pour les rapports de stage ou de PFE en entreprise, le widget `#tree` de `typart` génère automatiquement une arborescence multi-niveaux où la hauteur des boîtes s'adapte au texte :

#v(8pt)

#figure(
  align(center)[
    #tree(
      (
        [*Direction Technique & R&D* \ #text(7.5pt)[AeroTech Solutions]],
        (
          (
            [*Pôle Systèmes Embarqués* \ #text(7.5pt)[Dr. Sophie LAURENT (Tuteur)]],
            (
              ([*Léon P.* \ #text(7.5pt)[Élève-Ingénieur Stagiaire]], rgb("#FEF3C7")),
              [*Thomas D.* \ #text(7.5pt)[Ingénieur Linux]],
              [*Camille R.* \ #text(7.5pt)[Conception PCB]],
            )
          ),
          (
            [*Pôle Bancs d'Essais* \ #text(7.5pt)[Marc DUBOIS (Lead)]],
            (
              [*Sarah B.* \ #text(7.5pt)[Qualification CEM]],
              [*Julien K.* \ #text(7.5pt)[Technicien HIL]],
            )
          ),
        )
      ),
      size: 7.5pt,
      box-w: 3.1,
      box-h: 1.2,
      xstep: 3.3,
      ystep: 2.1,
      accent: rgb("#002B49"),
      root-fill: rgb("#EBF5F5"),
      box-fill: rgb("#F8FAFC"),
    )
  ],
  caption: [Organigramme multi-niveaux d'accueil en stage et intégration dans la direction technique (`typart`)],
) <fig:orga-stage>
