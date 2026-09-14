// Modèle 1 : Rapport de Travaux Pratiques (TP) pour l'ECE Paris

#import "theme.typ": *
#import "utils.typ": *
#import "i18n.typ": *

// =============================================================================
// MODÈLE 1 : RAPPORT DE TP / LABORATORY REPORT
// =============================================================================
#let tp(
  title: none,
  tp-num: "[X]",
  promo: "ING[X]",
  major: none,
  majeure: none,
  groupe: none,
  authors: ("André-Marie AMPÈRE", "Alessandro VOLTA"),
  supervisor: none,
  tuteur: none,
  enseignant: none,
  date: auto,
  city: none,
  logo: auto,
  cover-image: auto,
  attestation: auto,
  type-doc: none,
  doc-prefix: none,
  table-of-contents: false,
  toc-depth: 3,
  draft: false,
  show-roles: true,
  show-role: true,
  show-emails: true,
  show-email: true,
  show-supervisor-email: auto,
  equation-numbering: none,
  font: "New Computer Modern",
  font-size: 11pt,
  lang: "fr",
  body
) = {
  let dict = i18n-tp.at(lang, default: i18n-tp.at("fr"))
  
  let actual_show_roles = if show-roles != true { show-roles } else { show-role }
  let actual_show_emails = if show-emails != true { show-emails } else { show-email }
  let actual_show_sup_email = if show-supervisor-email != auto { show-supervisor-email } else { actual_show_emails }
  let actual_title = if title != none { title } else { dict.default_title }
  let actual_type_doc = if type-doc != none { type-doc } else { dict.type_doc }
  let actual_doc_prefix = if doc-prefix != none { doc-prefix } else { dict.doc_prefix }
  let actual_major = if major != none { major } else if majeure != none { majeure } else { none }
  let actual_groupe = if groupe != none { groupe } else { dict.groupe_prefix + " [X]" }
  let actual_supervisor = if supervisor != none { supervisor } else if tuteur != none { tuteur } else if enseignant != none { enseignant } else { none }
  let actual_date = if date == auto {
    if lang == "fr" {
      datetime.today().display("[day]/[month]/[year]")
    } else {
      datetime.today().display("[month]/[day]/[year]")
    }
  } else if date != none {
    date
  } else {
    dict.default_date
  }
  let actual_city = if city != none { city } else { dict.default_city }
  let actual_attestation = if attestation == auto { dict.attestation } else if attestation == none or attestation == false { none } else { attestation }

  let author_list = if type(authors) == array {
    authors.map(a => if type(a) == dictionary { a.at("name", default: "") } else { str(a) }).join(", ")
  } else {
    str(authors)
  }
  set document(
    title: actual_doc_prefix + " " + str(tp-num) + " : " + str(actual_title),
    author: author_list,
  )

  set page(
    paper: "a4",
    margin: (top: 2.5cm, bottom: 2.5cm, left: 2cm, right: 2cm),
    background: if draft {
      rotate(
        -45deg,
        text(
          size: 90pt,
          weight: "bold",
          fill: rgb(180, 180, 180, 120),
        )[#dict.draft_text]
      )
    } else {
      none
    },
    header: context {
      let current_page = counter(page).get().first()
      if current_page > 1 {
        let headings = query(heading.where(level: 1))
        let has_h1_on_page = headings.any(h => h.location().page() == current_page)
        let current_heading = headings.rev().find(h => h.location().page() <= current_page)
        let promo_label = if actual_major != none { promo + " – " + actual_major } else { promo }
        grid(
          columns: (auto, 1fr, auto),
          align: (left + horizon, center + horizon, right + horizon),
          _render-logo(logo, width: 2.5cm),
          if not has_h1_on_page and current_heading != none [
            #text(size: 9pt, fill: rgb("#666666"), style: "italic")[
              #current_heading.body
            ]
          ],
          text(size: 9.5pt, weight: "bold", hyphenate: false)[#promo_label #h(0.4em) #actual_groupe],
        )
      }
    },
    footer: context {
      let i = counter(page).get().first()
      let total = counter(page).final().first()
      if i > 1 {
        align(center, text(size: 10pt)[#i / #total])
      }
    }
  )

  set text(
    font: font,
    size: font-size,
    lang: lang,
  )

  set par(
    justify: true,
    leading: 0.65em,
    first-line-indent: 0pt,
  )

  show link: set text(fill: darkpowderblue)

  if equation-numbering != none {
    set math.equation(numbering: equation-numbering)
  }

  set list(marker: ([#text(fill: ece, size: 0.9em)[•]], [--]))

  show raw.where(block: true): it => block(
    fill: rgb("#F8F9FA"),
    inset: (x: 18pt, y: 14pt),
    radius: 6pt,
    width: 100%,
    stroke: 0.8pt + rgb("#D0D7DE"),
    above: 1.2em,
    below: 1.2em,
    align(left, it),
  )
  show raw.where(block: false): it => box(
    fill: rgb("#F1F3F5"),
    inset: (x: 4pt, y: 0pt),
    outset: (y: 2.5pt),
    radius: 3pt,
    it,
  )
  show figure.where(kind: raw): it => pad(x: -1cm, block(width: 100%, it))

  show outline: it => {
    show link: set text(fill: black)
    it
  }

  set bibliography(style: "ieee")
  show figure: set block(above: 1.5em, below: 1.5em)
  set figure(gap: 0.85em)
  show figure.where(kind: table): set figure(supplement: dict.supp_table)
  show figure.where(kind: raw): set figure(supplement: dict.supp_code)
  show figure.where(kind: image): set figure(supplement: dict.supp_figure)
  show figure.caption: it => [
    #text(weight: "bold")[#it.supplement #context { it.counter.display(it.numbering) }] – #it.body
  ]

  set table(
    stroke: (x, y) => if y == 0 { (bottom: 1.5pt + ece) } else { 0.5pt + rgb("#DDDDDD") },
    fill: (col, row) => if row == 0 { rgb("#EBF5F5") } else if calc.even(row) { rgb("#FAFAFA") } else { none },
    inset: 7pt,
    align: horizon,
  )
  show table.cell.where(y: 0): set text(weight: "bold")

  set heading(numbering: (..nums) => {
    let pos = nums.pos()
    if pos.len() == 1 {
      numbering("I.", pos.last())
    } else if pos.len() == 2 {
      numbering("A.", pos.last())
    } else if pos.len() == 3 {
      numbering("(a)", pos.last())
    }
  })

  show heading.where(level: 1): it => {
    set text(size: 18pt, fill: ece, weight: "bold")
    v(1.5em, weak: true)
    it
    v(0.8em, weak: true)
  }

  show heading.where(level: 2): it => {
    set text(size: 16pt, fill: ece, weight: "bold")
    v(1.3em, weak: true)
    it
    v(0.7em, weak: true)
  }

  show heading.where(level: 3): it => {
    set text(size: 15pt, fill: gamboge, weight: "bold")
    v(1.2em, weak: true)
    it
    v(0.7em, weak: true)
  }

  // --- PAGE DE TITRE ---
  {
    grid(
      columns: (1fr, 1fr),
      align: (left + horizon, right + horizon),
      _render-logo(logo, width: 5.5cm),
      align(right)[
        #text(size: 14pt, weight: "bold")[
          #promo #if actual_major != none [ \ #text(size: 11pt, weight: "regular", fill: rgb("#444444"))[#actual_major] ] \
          #actual_groupe
        ]
      ],
    )

    v(1.5cm)
    line(length: 100%, stroke: 1.5pt + black)
    v(0.4cm)

    align(center)[
      #text(size: 13pt, weight: "bold", fill: rgb("#444444"))[#actual_type_doc]
      #v(0.6cm)
      #text(size: 20pt, weight: "bold", fill: ece)[#actual_doc_prefix #tp-num : #actual_title]
    ]

    v(0.4cm)
    line(length: 100%, stroke: 1.5pt + black)
    v(0.8cm)

    if cover-image != none {
      align(center)[
        #_render-cover(cover-image)
      ]
    }

    v(1fr)

    align(center)[
      #if type(authors) == array [
        #grid(
          columns: (1fr,) * authors.len(),
          gutter: 1.5cm,
          align: center,
          ..authors.map(a => {
            if type(a) == dictionary [
              #text(size: 12pt, weight: "bold")[#a.at("name", default: "")]
              #if actual_show_roles and "role" in a and a.role != none and a.role != "" [ \ #text(size: 9pt, style: "italic", fill: rgb("#666666"))[#a.role] ]
              #if actual_show_emails and "email" in a and a.email != none and a.email != "" [ \ #text(size: 9pt, fill: darkpowderblue)[#link("mailto:" + a.email)[#a.email]] ]
            ] else [
              #text(size: 12pt, weight: "bold")[#a]
            ]
          })
        )
      ] else [
        #text(size: 12pt, weight: "bold")[#authors]
      ]

      #if actual_supervisor != none [
        #v(0.3cm)
        #if type(actual_supervisor) == dictionary [
          #let s_name = actual_supervisor.at("name", default: "")
          #let s_email = actual_supervisor.at("email", default: none)
          #text(size: 11pt, style: "italic")[#dict.supervisor_prefix#s_name]
          #if actual_show_sup_email and s_email != none and s_email != "" [
            \ #text(size: 9pt, fill: darkpowderblue)[#link("mailto:" + s_email)[#s_email]]
          ]
        ] else [
          #text(size: 11pt, style: "italic")[#dict.supervisor_prefix#actual_supervisor]
        ]
      ]

      #v(0.8cm)

      #if actual_attestation != none [
        #text(size: 9.5pt, fill: rgb("#333333"))[#actual_attestation]
        #v(0.3cm)
      ]
      #text(size: 11pt, weight: "bold")[#actual_city#dict.date_connector#actual_date]
    ]
  }

  pagebreak()

  if table-of-contents {
    outline(
      title: dict.toc_title,
      depth: toc-depth,
      indent: 1.5em,
    )
    pagebreak()
  }

  body
}
