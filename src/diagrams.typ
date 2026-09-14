// ECE Paris - Helpers & Composants de Diagrammes pour Rapports Techniques

#import "theme.typ": *

// =============================================================================
// 1. PLANNING DE PROJET & STAGE : DIAGRAMME DE GANTT
// =============================================================================
#let gantt(
  unites: ("S1", "S2", "S3", "S4", "S5", "S6", "S7", "S8"),
  taches: (),
  titre-taches: [*Tâches / Jalons*],
  accent: ece,
) = {
  let nb-u = unites.len()
  let cols = (2.6fr,) + (1fr,) * nb-u

  box(
    stroke: 0.6pt + rgb("#CBD5E1"),
    radius: 4pt,
    clip: true,
    width: 100%,
    table(
      columns: cols,
      align: (col, row) => if col == 0 { left + horizon } else { center + horizon },
      stroke: (x, y) => (
        top: 0.5pt + rgb("#E2E8F0"),
        bottom: if y == 0 { 1.5pt + accent } else { 0.5pt + rgb("#E2E8F0") },
        left: 0.5pt + rgb("#E2E8F0"),
        right: 0.5pt + rgb("#E2E8F0"),
      ),
      fill: (col, row) => if row == 0 { rgb("#F8FAFC") } else if calc.even(row) { rgb("#FCFDFD") } else { white },
      inset: (x: 6pt, y: 7pt),
      table.header(titre-taches, ..unites.map(u => text(weight: "bold", size: 8pt)[#u])),
      ..taches.map(t => {
        let cells = ([#text(weight: "medium", size: 8.5pt)[#t.nom]],)
        for u in range(1, nb-u + 1) {
          if u >= t.debut and u <= t.fin {
            let is-start = u == t.debut
            let is-end = u == t.fin
            let bar-color = t.at("couleur", default: accent)
            cells.push(box(
              fill: bar-color,
              radius: (
                left: if is-start { 3pt } else { 0pt },
                right: if is-end { 3pt } else { 0pt },
              ),
              width: 100%,
              height: 14pt,
            ))
          } else {
            cells.push([])
          }
        }
        cells
      }).flatten()
    )
  )
}
#let diagramme-gantt = gantt

// =============================================================================
// 2. GOUVERNANCE & GESTION D'ÉQUIPE : ORGANIGRAMME
// =============================================================================
#let carte-membre(
  nom,
  role: none,
  affiliation: none,
  responsable: false,
  couleur: ece,
) = {
  box(
    fill: if responsable { rgb("#EBF5F5") } else { white },
    stroke: if responsable { 1.2pt + couleur } else { 0.8pt + rgb("#CBD5E1") },
    radius: 4pt,
    inset: (x: 10pt, y: 7pt),
    width: 100%,
    align(center)[
      #text(weight: "bold", size: 9pt, fill: if responsable { couleur } else { black })[#nom]
      #if role != none [
        #v(1pt)
        #text(size: 7.5pt, style: "italic", fill: rgb("#475569"))[#role]
      ]
      #if affiliation != none [
        #v(1pt)
        #text(size: 7pt, fill: rgb("#94A3B8"))[#affiliation]
      ]
    ]
  )
}

#let orga-equipe(
  responsable: none,
  membres: (),
  colonnes: auto,
) = {
  let nb-membres = membres.len()
  let cols = if colonnes != auto { colonnes } else { (1fr,) * calc.max(1, calc.min(nb-membres, 4)) }
  align(center)[
    #box(width: 95%)[
      #if responsable != none [
        #align(center)[
          #box(width: 50%)[#responsable]
        ]
        #v(2pt)
        #align(center)[#text(fill: ece, size: 12pt)[#sym.arrow.b]]
        #v(2pt)
      ]
      #grid(
        columns: cols,
        gutter: 8pt,
        ..membres
      )
    ]
  ]
}
#let organigramme-equipe = orga-equipe

// =============================================================================
// 3. ÉLECTRONIQUE & HW/SW : BLOCS FONCTIONNELS & CHAÎNES DE TRAITEMENT
// =============================================================================
#let bloc-fonctionnel(
  titre,
  sous-titre: none,
  fill: rgb("#EBF5F5"),
  stroke: ece,
  width: auto,
) = {
  box(
    fill: fill,
    stroke: 1.2pt + stroke,
    radius: 4pt,
    inset: (x: 10pt, y: 8pt),
    width: width,
    align(center)[
      #text(weight: "bold", size: 9.5pt, fill: stroke)[#titre]
      #if sous-titre != none [
        #v(2pt)
        #text(size: 7.5pt, fill: rgb("#555555"))[#sous-titre]
      ]
    ]
  )
}

#let fleche-bus(label: none, couleur: ece) = {
  box(
    inset: (x: 4pt),
    align(center)[
      #if label != none { text(size: 7pt, fill: rgb("#666666"), weight: "bold")[#label \ ] }
      #text(fill: couleur, size: 14pt)[#sym.arrow.r]
    ]
  )
}

#let chaine-blocs(..elements) = {
  align(center)[
    #stack(
      dir: ltr,
      spacing: 6pt,
      ..elements.pos().map(el => {
        if type(el) == str {
          fleche-bus(label: el)
        } else {
          el
        }
      })
    )
  ]
}
#let diagramme-blocs = chaine-blocs

// =============================================================================
// 4. INFORMATIQUE & BDD : SCHÉMAS RELATIONNELS (MCD / MLD)
// =============================================================================
#let table-bdd(
  nom,
  colonnes,
  couleur-entete: darkpowderblue,
) = {
  box(
    stroke: 1.2pt + couleur-entete,
    radius: 4pt,
    clip: true,
    table(
      columns: (auto, auto, auto),
      stroke: 0.5pt + rgb("#E2E8F0"),
      fill: (col, row) => if row == 0 { couleur-entete } else if calc.even(row) { rgb("#F8FAFC") } else { white },
      inset: (x: 8pt, y: 5pt),
      table.header(
        table.cell(colspan: 3, fill: couleur-entete, align(center)[#text(fill: white, weight: "bold", size: 9pt)[#nom]])
      ),
      ..colonnes.map(c => {
        let (col-nom, col-type, col-key) = if c.len() == 3 { c } else { (c.at(0), c.at(1), "") }
        let is-pk = "PK" in col-key
        let is-fk = "FK" in col-key
        (
          align(left)[#text(weight: if is-pk { "bold" } else { "regular" }, size: 8.5pt)[#col-nom]],
          align(center)[#text(fill: rgb("#64748B"), size: 8pt, font: "Courier")[#col-type]],
          align(right)[#if is-pk [ #text(fill: gamboge, weight: "bold", size: 7.5pt)[PK] ] else if is-fk [ #text(fill: ece, weight: "bold", size: 7.5pt)[FK] ] else [ #text(size: 7.5pt, fill: rgb("#94A3B8"))[#col-key] ]],
        )
      }).flatten()
    )
  )
}
#let schema-bdd = table-bdd
