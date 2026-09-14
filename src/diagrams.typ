#import "theme.typ": *

// Diagramme de Gantt (planning projet et stage)
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

// Organigramme d'équipe ou de département
#let carte-membre(
  nom,
  role: none,
  service: none,
  affiliation: none,
  tag: none,
  badge: auto,
  email: none,
  responsable: false,
  stagiaire: false,
  couleur: auto,
  width: 100%,
  compact: false,
) = {
  let affil = if service != none { service } else { affiliation }
  let accent = if couleur != auto {
    couleur
  } else if stagiaire {
    gamboge
  } else if responsable {
    ece
  } else {
    darkpowderblue
  }

  let bg = if responsable {
    rgb("#F2F9F9")
  } else if stagiaire {
    rgb("#FFFDF6")
  } else {
    white
  }

  let border-color = if responsable {
    ece
  } else if stagiaire {
    gamboge
  } else {
    rgb("#CBD5E1")
  }

  let pad-y = if compact { 3.5pt } else { 5.5pt }
  let pad-x = if compact { 5pt } else { 8pt }
  let font-name = if compact { 8pt } else { 9pt }
  let font-role = if compact { 6.8pt } else { 7.8pt }
  let font-sub = if compact { 6pt } else { 6.8pt }
  let top-bar = if compact { 2.5pt } else { 3.5pt }

  let show-badge = if badge == false or badge == none {
    false
  } else if badge == true or type(badge) == str {
    true
  } else {
    tag != none or stagiaire or responsable
  }

  box(
    width: width,
    fill: bg,
    stroke: (top: top-bar + accent, rest: 0.8pt + border-color),
    radius: 5pt,
  )[
    #pad(x: pad-x, top: pad-y, bottom: pad-y)[
      #align(center)[
        #if show-badge [
          #let badge-text = if type(badge) == str {
            badge
          } else if tag != none {
            tag
          } else if stagiaire {
            "STAGIAIRE"
          } else {
            "RESPONSABLE"
          }
          #box(
            fill: accent.lighten(80%),
            radius: 3pt,
            inset: (x: 4pt, y: 1.2pt),
          )[
            #text(size: 6pt, weight: "bold", fill: accent)[#badge-text]
          ]
          #v(if compact { 2pt } else { 2.5pt })
        ]
        #text(weight: "bold", size: font-name, fill: if responsable { ece } else { rgb("#0F172A") })[#nom]
        #if role != none [
          #v(1.2pt)
          #text(size: font-role, style: "italic", fill: rgb("#334155"))[#role]
        ]
        #if affil != none [
          #v(1.2pt)
          #text(size: font-sub, fill: rgb("#64748B"))[#affil]
        ]
        #if email != none [
          #v(1.2pt)
          #text(size: font-sub, fill: darkpowderblue)[#link("mailto:" + email)[#email]]
        ]
      ]
    ]
  ]
}

// Organigramme d'entreprise, de département ou de projet multi-pôles
#let orga-entreprise(
  direction: "Direction Technique & R&D",
  transverse: none,
  poles: (),
  largeur: 100%,
  gutter: 12pt,
  couleur-liaison: ece,
  largeur-direction: auto,
  largeur-transverse: auto,
) = {
  let nb-poles = poles.len()
  let cols = (1fr,) * calc.max(1, nb-poles)
  let stroke = 1.2pt + couleur-liaison
  let stroke-trans = 1.2pt + couleur-liaison.lighten(25%)

  let dir-w = if largeur-direction != auto {
    largeur-direction
  } else if type(direction) == str {
    auto
  } else {
    215pt
  }

  let trans-w = if largeur-transverse != auto {
    largeur-transverse
  } else {
    175pt
  }

  let dir-node = if type(direction) == str [
    #box(
      fill: rgb("#EBF5F5"),
      stroke: 1.2pt + ece,
      radius: 6pt,
      inset: (x: 16pt, y: 8pt),
    )[
      #text(weight: "bold", size: 10pt, fill: ece)[#direction]
    ]
  ] else [
    #box(width: dir-w)[#direction]
  ]

  let trans-node = if transverse != none [
    #box(width: trans-w)[#transverse]
  ] else {
    none
  }

  let top-section = if trans-node != none [
    #grid(
      columns: (1fr, auto, 1fr),
      align: (horizon + right, horizon + center, horizon + left),
      [],
      dir-node,
      grid(
        columns: (22pt, auto),
        align: (horizon + left, horizon + left),
        line(length: 22pt, stroke: stroke-trans),
        trans-node,
      )
    )
  ] else [
    #align(center)[#dir-node]
  ]

  let connector-section = if nb-poles > 0 [
    #let stem-h = 14pt
    #let drop-h = 12pt
    #let total-h = stem-h + drop-h
    #box(width: 100%, height: total-h)[
      #layout(size => {
        let w = size.width
        let col-w = (w - (nb-poles - 1) * gutter) / nb-poles
        box(width: 100%, height: total-h)[
          #if nb-poles > 1 {
            let x-start = col-w / 2
            let x-end = (nb-poles - 1) * (col-w + gutter) + col-w / 2
            let x-center = w / 2
            place(top + left, line(start: (x-center, 0pt), end: (x-center, stem-h), stroke: stroke))
            place(top + left, line(start: (x-start, stem-h), end: (x-end, stem-h), stroke: stroke))
            for i in range(nb-poles) {
              let x = i * (col-w + gutter) + col-w / 2
              place(top + left, line(start: (x, stem-h), end: (x, total-h), stroke: stroke))
            }
          } else {
            let x-center = w / 2
            place(top + left, line(start: (x-center, 0pt), end: (x-center, total-h), stroke: stroke))
          }
        ]
      })
    ]
  ] else {
    none
  }

  let poles-section = if nb-poles > 0 [
    #grid(
      columns: cols,
      gutter: gutter,
      ..poles.map(p => {
        let p-nom = p.at("nom", default: "")
        let p-resp = p.at("responsable", default: none)
        let p-sous-poles = p.at("sous-poles", default: ())
        let p-membres = p.at("membres", default: ())
        let accent-pole = p.at("couleur", default: darkpowderblue)
        
        box(
          fill: rgb("#F8FAFC"),
          stroke: 0.8pt + rgb("#CBD5E1"),
          radius: 6pt,
          inset: (x: 6pt, y: 7pt),
          width: 100%,
        )[
          #align(center)[
            #text(weight: "bold", size: 8pt, fill: accent-pole)[#p-nom]
            #v(3pt)
            #line(length: 65%, stroke: 0.8pt + accent-pole.lighten(50%))
            #v(5pt)
            
            #if p-resp != none [
              #p-resp
              #if p-membres.len() > 0 or p-sous-poles.len() > 0 [
                #v(4pt)
                #line(start: (0pt, 0pt), end: (0pt, 8pt), stroke: 0.8pt + rgb("#94A3B8"))
                #v(3pt)
              ]
            ]

            #if p-membres.len() > 0 [
              #stack(
                spacing: 5pt,
                ..p-membres
              )
            ]

            #if p-sous-poles.len() > 0 [
              #if p-membres.len() > 0 [ #v(5pt) ]
              #stack(
                spacing: 6pt,
                ..p-sous-poles.map(sp => {
                  let sp-nom = sp.at("nom", default: "")
                  let sp-membres = sp.at("membres", default: ())
                  box(
                    fill: white,
                    stroke: 0.6pt + rgb("#E2E8F0"),
                    radius: 5pt,
                    inset: (x: 5pt, top: 4pt, bottom: 5pt),
                    width: 100%,
                  )[
                    #text(size: 6.8pt, weight: "bold", fill: rgb("#475569"))[#upper(sp-nom)]
                    #v(3pt)
                    #stack(
                      spacing: 4pt,
                      ..sp-membres
                    )
                  ]
                })
              )
            ]
          ]
        ]
      })
    )
  ] else {
    none
  }

  align(center)[
    #box(width: largeur)[
      #stack(
        spacing: 0pt,
        top-section,
        connector-section,
        poles-section,
      )
    ]
  ]
}
#let organigramme-entreprise = orga-entreprise
#let orga-projet = orga-entreprise
#let organigramme-projet = orga-entreprise

// Organigramme d'équipe projet
#let orga-equipe(
  responsable: none,
  poles: (),
  membres: (),
  largeur: 95%,
  gutter: 14pt,
  colonnes: auto,
  couleur-liaison: ece,
  largeur-responsable: auto,
) = {
  if poles.len() > 0 {
    orga-entreprise(
      direction: responsable,
      poles: poles,
      largeur: largeur,
      gutter: gutter,
      couleur-liaison: couleur-liaison,
      largeur-direction: largeur-responsable,
    )
  } else {
    let nb = membres.len()
    let cols-spec = if colonnes != auto {
      if type(colonnes) == int {
        (1fr,) * colonnes
      } else {
        colonnes
      }
    } else {
      (1fr,) * calc.max(1, calc.min(nb, 4))
    }
    let nb-cols = if type(cols-spec) == array { cols-spec.len() } else { 1 }
    let stroke = 1.2pt + couleur-liaison
    let resp-w = if largeur-responsable != auto {
      largeur-responsable
    } else {
      220pt
    }

    let resp-node = if responsable != none [
      #align(center)[
        #box(width: resp-w)[#responsable]
      ]
    ] else {
      none
    }

    let conn-node = if responsable != none and nb > 0 [
      #let stem-h = 14pt
      #let drop-h = 12pt
      #let total-h = stem-h + drop-h
      #box(width: 100%, height: total-h)[
        #layout(size => {
          let w = size.width
          let col-w = (w - (nb-cols - 1) * gutter) / nb-cols
          box(width: 100%, height: total-h)[
            #if nb-cols > 1 {
              let x-start = col-w / 2
              let x-end = (nb-cols - 1) * (col-w + gutter) + col-w / 2
              let x-center = w / 2
              place(top + left, line(start: (x-center, 0pt), end: (x-center, stem-h), stroke: stroke))
              place(top + left, line(start: (x-start, stem-h), end: (x-end, stem-h), stroke: stroke))
              for i in range(nb-cols) {
                let x = i * (col-w + gutter) + col-w / 2
                place(top + left, line(start: (x, stem-h), end: (x, total-h), stroke: stroke))
              }
            } else {
              let x-center = w / 2
              place(top + left, line(start: (x-center, 0pt), end: (x-center, total-h), stroke: stroke))
            }
          ]
        })
      ]
    ] else {
      none
    }

    let membres-section = if nb > 0 [
      #grid(
        columns: cols-spec,
        gutter: gutter,
        ..membres
      )
    ] else {
      none
    }

    align(center)[
      #box(width: largeur)[
        #stack(
          spacing: 0pt,
          resp-node,
          conn-node,
          membres-section,
        )
      ]
    ]
  }
}
#let organigramme-equipe = orga-equipe

// Chaîne de blocs fonctionnels (électronique et HW/SW)
#let bloc-fonctionnel(
  titre,
  sous-titre: none,
  tag: none,
  fill: rgb("#F8FAFC"),
  stroke: ece,
  couleur: none,
  width: 100%,
  hauteur: 48pt,
  min-height: auto,
  compact: false,
) = {
  let c = if couleur != none { couleur } else { stroke }
  let h = if min-height != auto { min-height } else { hauteur }
  box(
    fill: fill,
    stroke: 1.2pt + c,
    radius: 4pt,
    inset: (x: if compact { 3.5pt } else { 4.5pt }, y: 4pt),
    width: width,
    height: if h != none and h != auto and h != 0pt { h } else { auto },
    align(center + horizon)[
      #set par(justify: false, leading: 2.2pt)
      #set text(hyphenate: false)
      #if tag != none [
        #box(
          fill: rgb("#F1F5F9"),
          stroke: 0.5pt + rgb("#CBD5E1"),
          radius: 2.5pt,
          inset: (x: 3.5pt, y: 1pt),
          text(size: 5.5pt, weight: "bold", fill: rgb("#475569"))[#tag]
        )
        #v(2pt)
      ]
      #text(weight: "bold", size: if compact { 7pt } else { 7.5pt }, fill: c)[#titre]
      #if sous-titre != none [
        #v(2pt)
        #text(size: if compact { 5.8pt } else { 6.2pt }, fill: rgb("#64748B"), weight: "regular")[#sous-titre]
      ]
    ]
  )
}
#let bloc = bloc-fonctionnel

#let fleche-bus(
  ..args,
  label: none,
  couleur: ece,
  bidirectionnelle: false,
  width: auto,
  pill: false,
  min-width: 32pt,
) = [
  #metadata("fleche-bus")
  #{
    let l = if args.pos().len() > 0 { args.pos().at(0) } else { label }
    let has-label = l != none and l != ""
    let arrow-head-w = 4.8pt
    let arrow-head-h = 5pt

    let label-content = if has-label {
      if pill [
        #box(
          inset: (x: 4pt, y: 1.2pt),
          radius: 3pt,
          fill: rgb("#F1F5F9"),
          stroke: 0.5pt + rgb("#CBD5E1"),
          text(size: 6pt, weight: "bold", fill: rgb("#334155"))[#l]
        )
      ] else [
        #text(size: 6.5pt, weight: "bold", fill: rgb("#475569"))[#l]
      ]
    } else {
      none
    }

    align(center + horizon)[
      #set par(justify: false)
      #context {
        let label-w = if has-label { measure(label-content).width + 8pt } else { 0pt }
        let total-w = if width != auto {
          width
        } else {
          calc.max(min-width, label-w)
        }

        box(width: total-w)[
          #stack(
            spacing: 2.5pt,
            if has-label {
              align(center)[#label-content]
            },
            box(width: 100%, height: 8pt)[
              #let line-start = if bidirectionnelle { arrow-head-w - 1.5pt } else { 0pt }
              #let line-end = 100% - 1.5pt
              #place(horizon)[#line(start: (line-start, 0pt), end: (line-end, 0pt), stroke: 1.2pt + couleur)]
              #if bidirectionnelle [
                #place(left + horizon)[
                  #polygon(
                    fill: couleur,
                    (arrow-head-w, 0pt),
                    (0pt, arrow-head-h / 2),
                    (arrow-head-w, arrow-head-h),
                  )
                ]
              ]
              #place(right + horizon)[
                #polygon(
                  fill: couleur,
                  (0pt, 0pt),
                  (arrow-head-w, arrow-head-h / 2),
                  (0pt, arrow-head-h),
                )
              ]
            ]
          )
        ]
      }
    ]
  }
]

#let is-bus-arrow(el) = type(el) == str or (type(el) == content and "fleche-bus" in repr(el))

#let chaine-blocs(..elements, largeur-fleche: auto, pill: false) = {
  let raw = elements.pos()
  let cols = ()
  let cells = ()
  let i = 0
  while i < raw.len() {
    let el = raw.at(i)
    if type(el) == str {
      cols.push(auto)
      cells.push(fleche-bus(label: el, width: largeur-fleche, pill: pill))
      i += 1
    } else if type(el) == content and "fleche-bus" in repr(el) {
      cols.push(auto)
      cells.push(el)
      i += 1
    } else {
      cols.push(1fr)
      cells.push(el)
      if i + 1 < raw.len() and not is-bus-arrow(raw.at(i + 1)) {
        cols.push(auto)
        cells.push(fleche-bus(width: largeur-fleche, pill: pill))
      }
      i += 1
    }
  }

  box(width: 100%)[
    #grid(
      columns: cols,
      align: horizon + center,
      column-gutter: 0pt,
      ..cells
    )
  ]
}
#let diagramme-blocs = chaine-blocs

// Schéma relationnel de base de données
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

// Algorigrammes et logigrammes
#let fleche-algo(
  ..args,
  label: none,
  longueur: 22pt,
  couleur: rgb("#64748B"),
  pill: false,
) = {
  let l = if args.pos().len() > 0 { args.pos().at(0) } else { label }
  let has-label = l != none and l != ""
  let is-oui = l in ("OUI", "Oui", "oui", "YES", "Yes", "yes", "VRAI", "True")
  let is-non = l in ("NON", "Non", "non", "NO", "No", "no", "FAUX", "False")
  let badge-color = if is-oui { rgb("#15803D") } else if is-non { warning-red } else { rgb("#475569") }
  let badge-bg = if is-oui { rgb("#F0FDF4") } else if is-non { rgb("#FEF2F2") } else { rgb("#F1F5F9") }
  let badge-border = if is-oui { rgb("#86EFAC") } else if is-non { rgb("#FECACA") } else { rgb("#CBD5E1") }

  let vw = 5.2pt
  let vh = 4.8pt

  box(width: 80pt, height: longueur)[
    #place(center + top)[
      #line(start: (0pt, 0pt), end: (0pt, longueur - 1.5pt), stroke: 1.2pt + couleur)
    ]
    #place(center + bottom)[
      #polygon(
        fill: couleur,
        (0pt, 0pt),
        (vw, 0pt),
        (vw / 2, vh),
      )
    ]
    #if has-label [
      #place(center + horizon, dx: 18pt)[
        #if pill [
          #box(
            inset: (x: 4.5pt, y: 1.5pt),
            radius: 3pt,
            fill: badge-bg,
            stroke: 0.6pt + badge-border,
            text(size: 6.2pt, weight: "bold", fill: badge-color)[#l]
          )
        ] else [
          #text(size: 7.2pt, weight: "bold", fill: badge-color)[#l]
        ]
      ]
    ]
  ]
}

#let algo-debut(texte, sous-titre: none, couleur: ece) = box(
  fill: rgb("#EBF5F5"),
  stroke: 1.2pt + couleur,
  radius: 20pt,
  inset: (x: 16pt, y: 6.5pt),
  [
    #set par(justify: false, leading: 2.2pt)
    #set text(hyphenate: false)
    #align(center)[
      #text(weight: "bold", size: 8.5pt, fill: couleur)[#texte]
      #if sous-titre != none [
        #v(2pt)
        #text(size: 7pt, fill: rgb("#555555"))[#sous-titre]
      ]
    ]
  ]
)

#let algo-fin(texte, sous-titre: none, couleur: warning-red) = box(
  fill: rgb("#FEF2F2"),
  stroke: 1.2pt + couleur,
  radius: 20pt,
  inset: (x: 16pt, y: 6.5pt),
  [
    #set par(justify: false, leading: 2.2pt)
    #set text(hyphenate: false)
    #align(center)[
      #text(weight: "bold", size: 8.5pt, fill: couleur)[#texte]
      #if sous-titre != none [
        #v(2pt)
        #text(size: 7pt, fill: rgb("#555555"))[#sous-titre]
      ]
    ]
  ]
)

#let algo-action(texte, sous-titre: none, width: 140pt, couleur: rgb("#64748B"), fill: white) = box(
  width: width,
  fill: fill,
  stroke: 1pt + couleur,
  radius: 3.5pt,
  inset: (x: 8pt, y: 6.5pt),
  [
    #set par(justify: false, leading: 2.2pt)
    #set text(hyphenate: false)
    #align(center)[
      #text(weight: "medium", size: 8.5pt, fill: rgb("#1E293B"))[#texte]
      #if sous-titre != none [
        #v(2pt)
        #text(size: 7pt, fill: rgb("#64748B"))[#sous-titre]
      ]
    ]
  ]
)

#let algo-es(texte, sous-titre: none, width: 154pt, height: 32pt, couleur: darkpowderblue) = {
  let slant = 10pt
  box(
    width: width,
    height: if sous-titre != none { height + 10pt } else { height },
    [
      #set par(justify: false, leading: 2.2pt)
      #set text(hyphenate: false)
      #align(center + horizon)[
        #place(top + left)[
          #layout(size => {
            let w = size.width
            let h = size.height
            polygon(
              fill: rgb("#F0F7FF"),
              stroke: 1.1pt + couleur,
              (slant, 0pt),
              (w, 0pt),
              (w - slant, h),
              (0pt, h),
            )
          })
        ]
        #box(width: width - slant * 2)[
          #align(center)[
            #text(weight: "semibold", size: 8.2pt, fill: couleur)[#texte]
            #if sous-titre != none [
              #v(1.5pt)
              #text(size: 6.8pt, fill: rgb("#64748B"))[#sous-titre]
            ]
          ]
        ]
      ]
    ]
  )
}
#let algo-io = algo-es

#let algo-decision(
  question,
  non: none,
  label-non: auto,
  width: 140pt,
  height: 44pt,
  couleur: rgb("#D97706"),
  pill: false,
) = {
  let q = if type(question) == str and not question.ends-with("?") { question + " ?" } else { question }
  box(
    width: width,
    height: height,
    [
      #set par(justify: false, leading: 2.2pt)
      #set text(hyphenate: false)
      #place(top + left)[
        #polygon(
          fill: rgb("#FFFBEB"),
          stroke: 1.2pt + couleur,
          (width / 2, 0pt),
          (width, height / 2),
          (width / 2, height),
          (0pt, height / 2),
        )
      ]
      #place(center + horizon)[
        #box(width: width * 0.74)[
          #align(center)[#text(weight: "bold", size: 7.8pt, fill: rgb("#B45309"))[#q]]
        ]
      ]
      #if non != none [
        #place(left + horizon, dx: width)[
          #box(height: height)[
            #context {
              let lbl = if label-non != auto {
                label-non
              } else if text.lang == "en" {
                "NO"
              } else {
                "NON"
              }
              let arrow-l = 42pt
              let arrow-hw = 4.8pt
              let arrow-hh = 5pt

              grid(
                columns: (arrow-l, auto),
                align: horizon,
                column-gutter: 4pt,
                box(width: arrow-l, height: height)[
                  #place(center + horizon, dy: -9pt)[
                    #if pill [
                      #box(
                        fill: rgb("#FEF2F2"),
                        inset: (x: 4pt, y: 1.2pt),
                        radius: 2.5pt,
                        stroke: 0.5pt + rgb("#FECACA")
                      )[
                        #text(size: 6pt, weight: "bold", fill: warning-red)[#lbl]
                      ]
                    ] else [
                      #text(size: 7.2pt, weight: "bold", fill: warning-red)[#lbl]
                    ]
                  ]
                  #place(center + horizon)[
                    #line(start: (0pt, 0pt), end: (100% - 1.5pt, 0pt), stroke: 1.2pt + rgb("#64748B"))
                    #place(right + horizon)[
                      #polygon(
                        fill: rgb("#64748B"),
                        (0pt, 0pt),
                        (arrow-hw, arrow-hh / 2),
                        (0pt, arrow-hh),
                      )
                    ]
                  ]
                ],
                if type(non) == str [
                  #box(
                    fill: rgb("#FEF2F2"),
                    stroke: 1.1pt + warning-red,
                    radius: 3.5pt,
                    inset: (x: 8pt, y: 6pt),
                    [
                      #set par(justify: false)
                      #set text(hyphenate: false)
                      #text(size: 7.8pt, weight: "semibold", fill: warning-red)[#non]
                    ]
                  )
                ] else {
                  non
                }
              )
            }
          ]
        ]
      ]
    ]
  )
}

#let algo-sous-programme(texte, sous-titre: none, width: 140pt, couleur: ece) = box(
  width: width,
  fill: rgb("#F8FAFC"),
  stroke: 1pt + couleur,
  radius: 3.5pt,
  clip: true,
  [
    #set par(justify: false, leading: 2.2pt)
    #set text(hyphenate: false)
    #place(left + top)[#line(start: (6pt, 0pt), end: (6pt, 100%), stroke: 1pt + couleur)]
    #place(right + top)[#line(start: (-6pt, 0pt), end: (-6pt, 100%), stroke: 1pt + couleur)]
    #box(width: 100%, inset: (x: 12pt, y: 6.5pt), align(center)[
      #text(weight: "bold", size: 8.5pt, fill: couleur)[#texte]
      #if sous-titre != none [
        #v(2pt)
        #text(size: 7pt, fill: rgb("#64748B"))[#sous-titre]
      ]
    ])
  ]
)
#let algo-sous-routine = algo-sous-programme

#let algo-branche(
  condition,
  oui: (),
  non: (),
  label-oui: auto,
  label-non: auto,
  largeur-noeud: 120pt,
  pill: false,
) = {
  let w = largeur-noeud
  let g = 24pt
  let arm = (w + g) / 2
  let total-w = w * 2 + g
  let oui-items = if type(oui) == array { oui } else { (oui,) }
  let non-items = if type(non) == array { non } else { (non,) }

  box(width: total-w)[
    #align(center)[
      #algo-decision(condition, width: w, pill: pill)
      
      #context {
        let lbl-oui = if label-oui != auto { label-oui } else if text.lang == "en" { "YES" } else { "OUI" }
        let lbl-non = if label-non != auto { label-non } else if text.lang == "en" { "NO" } else { "NON" }
        let vw = 5.2pt
        let vh = 4.8pt
        box(width: total-w, height: 22pt)[
          #place(center + top)[#line(start: (0pt, 0pt), end: (0pt, 9pt), stroke: 1.2pt + rgb("#64748B"))]
          #place(center + top, dy: 9pt)[#line(start: (-arm, 0pt), end: (arm, 0pt), stroke: 1.2pt + rgb("#64748B"))]
          #place(center + top, dx: -arm, dy: 9pt)[
            #line(start: (0pt, 0pt), end: (0pt, 13pt - 1.5pt), stroke: 1.2pt + rgb("#64748B"))
            #place(center + bottom)[#polygon(fill: rgb("#64748B"), (0pt, 0pt), (vw, 0pt), (vw / 2, vh))]
          ]
          #place(center + top, dx: arm, dy: 9pt)[
            #line(start: (0pt, 0pt), end: (0pt, 13pt - 1.5pt), stroke: 1.2pt + rgb("#64748B"))
            #place(center + bottom)[#polygon(fill: rgb("#64748B"), (0pt, 0pt), (vw, 0pt), (vw / 2, vh))]
          ]
          #place(center + top, dx: -arm / 2, dy: 0pt)[
            #if pill [
              #box(fill: rgb("#F0FDF4"), inset: (x: 4pt, y: 1.2pt), radius: 2.5pt, stroke: 0.5pt + rgb("#86EFAC"))[
                #text(size: 6pt, weight: "bold", fill: rgb("#15803D"))[#lbl-oui]
              ]
            ] else [
              #text(size: 7.2pt, weight: "bold", fill: rgb("#15803D"))[#lbl-oui]
            ]
          ]
          #place(center + top, dx: arm / 2, dy: 0pt)[
            #if pill [
              #box(fill: rgb("#FEF2F2"), inset: (x: 4pt, y: 1.2pt), radius: 2.5pt, stroke: 0.5pt + rgb("#FECACA"))[
                #text(size: 6pt, weight: "bold", fill: warning-red)[#lbl-non]
              ]
            ] else [
              #text(size: 7.2pt, weight: "bold", fill: warning-red)[#lbl-non]
            ]
          ]
        ]
      }

      #grid(
        columns: (w, w),
        column-gutter: g,
        align: top + center,
        stack(
          spacing: 0pt,
          ..oui-items.map(el => if type(el) == str { fleche-algo(label: el, pill: pill) } else { el })
        ),
        stack(
          spacing: 0pt,
          ..non-items.map(el => if type(el) == str { fleche-algo(label: el, pill: pill) } else { el })
        )
      )
    ]
  ]
}

#let algorigramme(..etapes, pill: false) = {
  let raw = etapes.pos()
  let items = ()
  let i = 0
  while i < raw.len() {
    let current = raw.at(i)
    if type(current) == str {
      items.push(fleche-algo(label: if current != "" { current } else { none }, pill: pill))
      i += 1
    } else {
      items.push(current)
      if i + 1 < raw.len() {
        let next-el = raw.at(i + 1)
        if type(next-el) != str {
          items.push(fleche-algo(pill: pill))
        }
      }
      i += 1
    }
  }

  align(center)[
    #stack(
      dir: ttb,
      spacing: 0pt,
      ..items
    )
  ]
}

