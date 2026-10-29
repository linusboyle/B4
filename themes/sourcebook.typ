#import "@preview/marginalia:0.2.3" as marginalia: note, notefigure, wideblock
#import "@preview/hydra:0.6.2": hydra
#import "@preview/cuti:0.3.0": cn-fakebold
#import "../libs/common.typ" : *
#import "../libs/components.typ" : *


/* 常规资料书籍 */

/* Exported Theme */
#let sourcebook(
  it,
  header : [],
  latin-fallback-font: "IBM Plex Sans",
  heading-font : "Noto Serif CJK SC",
  indent : 2em,
  inner-width: 8mm,
  outer-width: 8mm,
  paper: "a5"
) = {
  let latin-fallback = (name: latin-fallback-font, covers: "latin-in-cjk")

  /* Basic Styling for Main Content */
  set page(
    paper: paper,
    numbering: "1",

    columns: 2,

    header-ascent: 5mm,
    footer-descent: 5mm,

    header: context {
      marginalia.header(
        even: (
          [],
          align(center, hydra(2)),
          [],
        ),
        odd: (
          [],
          align(center, hydra(2)),
          [],
        )
      )
    },
    footer: context {
      let i = current_page()
      marginalia.header(
          [],
          align(center, header),
          align(center, [#i]),
      )
    },
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
      latin-fallback,
      "京華老宋体-GB印通表字形",
      "Noto Sans CJK SC",
      // "Noto Serif CJK SC"
    ),
    // weight: "light",
    size: 9pt,
    lang: "zh"
  )

  show heading.where(level: 1) : h => {
    set text(
      font: heading-font,
      weight: "extrabold",
      size: 18pt
    )
    set block(
      stroke: (top: 2pt),
      inset: (top: 0.8em, bottom: 1em),
      // width: 100%,
    )
    pagebreak(weak: true)
    h
    // place(top + left, float: true, scope: "parent", h)
  }

  show heading.where(level: 2) : h => {
    set text(
      font: heading-font,
      weight: "extrabold",
      size: 14pt
    )
    set par(
      first-line-indent: 0pt
    )
    v(0.3em)
    align(left, h.body)
    v(0.3em)
  }

  show heading.where(level: 3): h => {
    set text(
      font: "KaiTi",
      weight: "black",
      size: 14pt
    )
    set par(
      first-line-indent: 0pt,
    )
    v(0.3em)
    align(center, cn-fakebold(h.body))
    v(0.3em)
  }

  show heading.where(level: 4): h => {
    set text(
      font: "FZMingShiTiS",
      weight: "black",
      size: 11pt,
    )
    set par(
      first-line-indent: 0pt,
      leading: 0.4em
    )    
    v(0.2em)
    align(left, h)
    v(0.2em)
  }

  show heading.where(level: 5): h => {
    set text(
      font: "KaiTi",
      weight: "bold",
    )
    set par(
      first-line-indent: 0pt
    )
    v(0.2em)
    align(left, h.body)
    v(0.2em)
  }

  set enum(
    indent: 1em
  )
  show enum: it => {
    set par(
      first-line-indent: 0pt,
      leading: 0.8em,
      spacing: 1.2em
    )
    it
  }
  set list(
    indent: 1em,
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
  // show emph: it => {
  //   set text(
  //     font: (
  //       latin-fallback,
  //       "Huiwen-Mincho",
  //     ),
  //     // fill: rgb("#6f6d6d")
  //   )
  //   // cn-fakebold(it)
  //   it
  // }

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
    book: false,
    top: 1.5cm,
    bottom: 1.5cm,
    inner: (
      sep: 0pt,
      far: 0pt,
      width: inner-width,
    ),
    outer: (
      sep: 0pt,
      far: 0pt,
      width: outer-width,
    ),
  )[#it]
}

#let front_pages(..it) = {
  set page(
    numbering: "I",
    header: none,
    footer: none,
    margin: (
      y: 5%
    )
  )
  for p in it.pos() {
    vanilla_page(p)
  }
  set text(
    size: 8pt
  )
  outline(depth: 2)
  counter(page).update(0)
}