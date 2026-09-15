#import "@preview/ece-reports:0.1.0": *

// Choix de la typographie : "arial" (recommandé pour le rapport de stage) | "latex" | "typst-modern" | "modern-sans" | "editorial"
#let style-police = "arial"

#show: stage.with(
  lang: "fr",
  title: "Virtualisation et Sécurisation d'une Plateforme Embarquée en Réseau Industriel",
  student: (
    firstname: "Camille",
    lastname: "MARTIN",
    major: "Systèmes Embarqués",
  ),
  cycle: "Cycle Ingénieur",
  annee-cycle: "2e année",
  annee-universitaire: "2025-2026",
  company: (
    name: "Innovatech Solutions SAS",
    address: "12 rue de l'Innovation, 75015 Paris",
  ),
  confidential: false,
  return-to-supervisor: false,
  mission-description: [
    L’objectif du stage est de démontrer le bon fonctionnement d’un logiciel de virtualisation en prenant en compte à la fois les contraintes du réseau d’entreprise et les exigences de performance de la plateforme cible.
  ],
  missions: (
    [Qualifier et déployer l'environnement de virtualisation sous Linux],
    [Évaluer les limites de performance et la portabilité des services],
    [Automatiser les procédures de déploiement et de tests d'intégration],
    [Présenter les démonstrateurs techniques aux équipes d'ingénierie],
  ),
  maitre-de-stage: (
    name: "Dr. Thomas BERNARD",
    email: "thomas.bernard@innovatech-solutions.fr",
    phone: "01 40 00 00 00",
  ),
  signature-maitre-de-stage: none, // ou image("chemin/vers/signature.png", width: 4cm)
  city: "Paris",
  font: font-presets.at(style-police, default: "Arial"),
  font-size: 10pt,
)

= Introduction et contexte d'entreprise
== L'entreprise d'accueil : Innovatech Solutions

Innovatech Solutions SAS est une entreprise spécialisée dans le conseil en technologies avancées, l'ingénierie des systèmes connectés et la cybersécurité industrielle.

== Contexte technique du stage

La virtualisation des environnements applicatifs est un enjeu clé pour garantir la reproductibilité, l'isolation des dépendances logicielles et la facilité de déploiement sur différentes cibles matérielles.

#callout(title: "Contrainte de réseau d'entreprise", type: "info")[
  L'environnement industriel impose des règles strictes de sécurité (proxy authentifié, filtrage réseau, politique de chiffrement) qui nécessitent une configuration spécifique des outils de conteneurisation et de virtualisation.
]

= Missions réalisées
== Installation et configuration de la solution de virtualisation

La première phase a consisté à qualifier l'installation du logiciel de virtualisation sous un poste Linux configuré aux standards de l'entreprise.

#figure(
  table(
    columns: (1fr, 2fr, 1.2fr),
    [Composant], [Description], [Statut],
    [Noyau Linux], [Distribution LTS durcie avec modules de sécurité], [Validé],
    [Moteur de virtualisation], [Hyperviseur / Container engine], [Opérationnel],
    [Accès Réseau], [Traversée proxy & certificats d'entreprise], [Configuré],
  ),
  caption: [Matrice de qualification de l'environnement hôte],
) <tab:qualif>

== Déploiement et validation de l'HMI

La solution a ensuite été mise à l'épreuve avec un démonstrateur d'Interface Homme-Machine (HMI) issue de la gamme de produits de l'entreprise. Les tests ont permis de mesurer les performances graphiques et la réactivité du système.

= Bilan du stage et compétences développées
== Compétences techniques

Ce stage a permis de consolider des compétences en administration système Linux, en réseaux industriels et en méthodologies de déploiement logiciel.

== Compétences humaines et relationnelles

L'intégration au sein des équipes de développement a nécessité rigueur, autonomie et communication lors des présentations et démonstrations techniques.
