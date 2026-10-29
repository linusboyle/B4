#import "@preview/marginalia:0.2.3" as marginalia: note, notefigure, wideblock
#import "@preview/hydra:0.6.2": hydra
#import "@preview/cuti:0.3.0": cn-fakebold
#import "../libs/common.typ" : *

/* TSR老模组 */

/* Exported Theme */
#let tsr(
  it,
  header : [],
  latin-fallback-font: "Jetbrains Mono",
  heading-font : "Noto Serif CJK SC",
  indent : 2em,
  inner-width: 1cm,
  outer-width: 5cm,
  paper: "a4"
) = {
  let latin-fallback = (name: latin-fallback-font, covers: "latin-in-cjk")
  /* Basic Styling for Main Content */
  set page(
    paper: paper,

    header: context {
      let i = current_page()
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
    header-ascent: 10mm,
    footer: context {
      let i = current_page()
      marginalia.header(
        even: (
          align(left, [#i]),
          align(center, header),
          [],
        ),
        odd: (
          [],
          align(center, header),
          align(right, [#i]),
        )
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
      "Noto Sans CJK SC",
    ),
    weight: "light",
    size: 11pt,
    lang: "zh"
  )

  show heading.where(level: 1) : h => {
    set text(
      font: heading-font,
      weight: "extrabold",
      size: 18pt
    )
    pagebreak()
    align(center, h.body)
    v(0.3em)
  }

  show heading.where(level: 2) : h => {
    set text(
      font: heading-font,
      weight: "extrabold",
      size: 16pt
    )
    v(0.3em)
    align(center, h.body)
    v(0.3em)
  }

  show heading.where(level: 3): h => {
    set text(
      font: heading-font,
      weight: "bold",
      size: 12pt
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
    book: true,
    inner: (
      width: inner-width,
    ),
    outer: (
      width: outer-width,
    ),
  )[#it]
}

#let vanilla_page(it, ..extra) = {
  set page(
    footer: none,
    header: none,
    margin: (
      x: auto
    ),
    ..extra
  )
  [
    #it
  ]
}

#let front_pages(..it) = {
  set page(
    numbering: "I",
    header: none,
    footer: none
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

#let floating_widefigure(t, caption : none) = {
  place(
    bottom + center, 
    float: true, 
    wideblock(
      side: "both",
      figure(
        caption: caption,
        t
      )
    )
  )
}

#let note = note.with(
  numbering: (..i) => super(baseline: -1em, numbering("1", ..i)),
  anchor-numbering: (..i) => super(baseline: -1em, numbering("1", ..i)),
  par-style: (
    justify: true,
    first-line-indent: (
      amount: 0em,
      all: true,
    )
  ),
  text-style: (
    weight: "light"
  ),
  keep-order: true,
)

#let notefigure = notefigure.with(
  numbering: none,
  anchor-numbering: none,
  counter: none,
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
  anchor-numbering: none
)

#let thickline() = {
    line(
      stroke: (
        paint: black,
        thickness: 1pt,
      ),
      length: 100%
    )
}

#let stat(it) = {
  show regex("AC|HD|hp|豁免|移动|攻击次数|伤害|士气|阵营|力量|智力|睿知|敏捷|体质|魅力|法术|TT|NA"): strong.with(delta: 220)
  stack(
    dir: ttb,
    spacing: 0.4em,
    thickline(),
    it,
    thickline(),
  )
}

#let sidestat(it) = {
  note(
    // numbering: (..i) => numbering("1", ..i),
    // anchor-numbering: (..i) => super(baseline: -1em, numbering("1", ..i)),
    stat(it)
  )
}