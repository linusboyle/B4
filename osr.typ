#import "@preview/marginalia:0.2.3" as marginalia: note, notefigure, wideblock
#import "@preview/hydra:0.6.2": hydra

/* Internal Utilities */

/* This is the logical page */
#let current_page() = counter(page).at(here()).first()

#let current_physical_page() = here().position().page

/* Exported Functions */
#let osr(
  it,
  header : ("DND", "OSR"),
  heading-font : "Noto Serif CJK SC",
  indent : 2em
) = {
  /* Basic Styling for Main Content */
  set page(
    paper: "a4",

    header: context {
      let i = current_page()
      marginalia.header(
        even: (
          align(left, header.first()),
          align(center, hydra(2)),
          align(left, [#i]),
        ),
        odd: (
          align(right, [#i]),
          align(center, hydra(2)),
          align(right, header.at(1)),
        )
      )
    },
    header-ascent: 10mm,
    binding: left,
  )
  
  set par(
    justify: true,
    linebreaks: "optimized",
    spacing: 1em,
    leading: 1em,
    first-line-indent: (
      amount: indent,
      all: true,
    )
  )

  set text(
    font: (
      (name: "Sarasa Term SC", covers: "latin-in-cjk"),
      "Noto Sans CJK SC",
    ),
    weight: "light",
    size: 11pt,
    lang: "zh"
  )

  show heading.where(level: 1) : h => {
    set text(
      font: heading-font,
      weight: "extrabold"
    )
    v(0.3em)
    align(center, h.body)
    v(0.3em)
  }

  show heading.where(level: 2) : h => {
    set text(
      font: heading-font,
      weight: "extrabold"
    )
    v(0.3em)
    align(center, h.body)
    v(0.3em)
  }

  show heading.where(level: 3): h => {
    set text(
      font: heading-font,
      weight: "extrabold"
    )
    set par(
      first-line-indent: 0pt
    )
    v(0.3em)
    align(left, h.body)
    v(0.3em)
  }

  show heading.where(level: 4): h => {
    set text(
      font: heading-font,
      weight: "extrabold"
    )
    set par(
      first-line-indent: 0pt
    )
    v(0.3em)
    align(left, h.body)
    v(0.3em)
  }

  set enum(
    indent: indent
  )
  set list(
    indent: indent,
    marker: ([‣], [•])
  )
  set strong(delta: 240)

  /* Figure Container */
  set figure(numbering: "一")
  set figure.caption(position: top)
  // show figure.caption.where(position: top) : note.with(
  //   alignment: "top",
  //   anchor-numbering: none,
  //   numbering: none,
  //   shift: "avoid",
  //   keep-order: true
  // )

  /* Table Styling */
  show table.cell.where(y: 0): set text(weight: "medium")
  set table(
    align: horizon + left,
    inset: (
      y : 0.4em
    ),
    fill: (_, y) => if calc.odd(y) { rgb("#DCDDDD") },
    stroke: (_, y) => if y == 0 { (top: 1pt, bottom: 0.7pt) }
  )


  marginalia.setup(
    book: true,
    inner: (
      width: 1cm,
    ),
    outer: (
      width: 5cm,
    ),
  )[#it]
}

#let vanilla_page(it) = {
  set page(
    footer: none,
    header: none,
    margin: (
      x: 10%
    )
  )
  [
    #it
  ]
}

#let front_pages(..it) = {
  set page(
    numbering: "I",
    header: none
  )
  for p in it.pos() {
    vanilla_page(p)
  }
  outline()
  set page(
    numbering: "1"
  )
  counter(page).update(1)
}

#let floating_widetable(t, caption : none) = {
  place(
    top + center, 
    float: true, 
    wideblock(
      side: "both",
      figure(
        kind: table,
        caption: caption,
        t
      )
    )
  )
}

#let note = note.with(
  numbering: (..i) => super(numbering("a", ..i)),
  par-style: (
    justify: true,
    first-line-indent: (
      amount: 0em,
      all: true,
    )
  ),
  text-style: (
    weight: "light"
  )
)

#let notefigure = notefigure.with(
  numbering: (..i) => super(numbering("a", ..i)),
  anchor-numbering: none,
  show-caption: (number, caption) => {
    number
    caption.body
  },
  par-style: (
    justify: true,
    first-line-indent: (
      amount: 0em,
      all: true,
    )
  ),
  text-style: (
    weight: "light"
  )
)

#let annotated_note = note.with(
  numbering: none,
)

#let boxed(it) = {
  set text(
    size: 11pt
  )
  pad(0.3em, block(
    it,
    width: 100%,
    stroke: (
      paint: black,
      thickness: 0.8pt,
    ),
    // fill: rgb("#dcdddd43"),
    inset: 1em,
  ))
}
