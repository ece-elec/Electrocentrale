// Exemple : rapport de stage de fin d'études ING5 avec la grille de notation entreprise 2026-2027 (preset: "ing5")
// Importe la version locale du paquet ; une fois publiée : #import "@preview/electrocentrale:<version>": *
#import "/lib.typ": *

#show: stage.with(
  preset: "ing5",
  lang: "fr",
  cycle: "Cycle Ingénieur",
  annee-cycle: "3ᵉ année",
  annee-universitaire: "2026-2027",
  title: "Détection d'anomalies sur flux industriels par apprentissage non supervisé",
  student: (firstname: "Camille", lastname: "MARTIN", major: "Data & IA"),
  company: (
    name: "Innovatech Solutions SAS",
    address: "12 rue de l'Innovation, 75015 Paris",
  ),
  confidential: false,
  return-to-supervisor: false,
  mission-description: [
    Concevoir et industrialiser une chaîne de détection d'anomalies sur les données de capteurs des lignes de production.
  ],
  missions: (
    [Auditer les données disponibles et définir les indicateurs de qualité],
    [Prototyper et comparer plusieurs modèles non supervisés],
    [Déployer le modèle retenu et former les équipes d'exploitation],
  ),
  maitre-de-stage: (name: "Dr. Thomas BERNARD", email: "thomas.bernard@innovatech-solutions.fr", phone: "01 40 00 00 00"),
  city: "Paris",
  font: font-presets.at("arial"),
  font-size: 10pt,
)

= L'entreprise et les missions
== Présentation de l'entreprise
Innovatech Solutions SAS conçoit des solutions de supervision pour l'industrie.

= Organisation du travail
== Cahier des charges et planning
Le planning prévisionnel est présenté sous forme de diagramme de Gantt commenté.

= Travail accompli
== Méthodologie
Description de la démarche, des outils et des choix techniques.

= Bilan
Rappel du projet professionnel et perspectives.
