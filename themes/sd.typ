#import "@preview/marginalia:0.2.3" as marginalia: note, notefigure, wideblock
#import "@preview/hydra:0.6.2": hydra
#import "@preview/cuti:0.3.0": cn-fakebold
#import "../libs/common.typ" : *
#import "../libs/components.typ" : *


/* Shadowdark */

/* Exported Theme */
#let sd(
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
    
    margin: (
      x: 10%,
      top: 1.2cm,
      bottom: 1.2cm,
    ),
    
    // header-ascent: 5mm,
    // footer-descent: 5mm,
    
    // footer: context {
    //   let i = current_page()
    //   align(center + horizon)[#i]
    // },
    binding: left,
  )
  
  set par(
    justify: true,
    linebreaks: "optimized",
    spacing: 1.6em,
    leading: 1em,
    // first-line-indent: (
    //   amount: indent,
    //   all: true,
    // )
  )
  
  set text(
    font: (
      latin-fallback,
      "京華老宋体-GB印通表字形",
      "Noto Sans CJK SC",
      // "Noto Serif CJK SC"
    ),
    // weight: "light",
    size: 12pt,
    lang: "zh",
  )
  
  show heading.where(level: 1): it => {
    set text(
      font: "Huiwen-ZhengKai",
      weight: "extrabold",
      size: 48pt,
    )
    set page(
      columns: 1,
      footer: none,
    )
    set block(
      stroke: (bottom: 2pt),
      inset: (top: 0.8em, bottom: 0.4em),
      width: 70%,
    )
    // pagebreak(weak: true)
    v(1fr)
    align(center, it)
    v(3fr)
    // place(center + horizon, align(center, it))
    // pagebreak(weak: true)
  }
  
  show heading.where(level: 2): h => {
    set text(
      font: "Huiwen-mincho",
      weight: "bold",
      // size: 12pt,
      fill: white,
      tracking: 0.2em,
    )
    pagebreak(weak: true)
    place(top + center, float: true, scope: "parent", dy: -page.margin.top)[
      // #block(fill: black, width: page.width, inset: (
      //   y: 15pt
      // ))[
      // #text(h, size: 40pt)]
      #grid(
        columns: 1fr,
        gutter: 0pt,
        rows: (0pt, auto),
        
        rect(
          fill: black,
          width: page.width,
          height: 60pt,
        ),
        text(h, size: 36pt, baseline: 18pt),
      )
    ]
  }
  
  show heading.where(level: 3): h => {
    set text(
      font: "FZMingShiTiS",
      weight: "black",
      size: 15pt,
    )
    set par(
      justify: false,
      spacing: 0pt,
    )
    align(left, h.body)
  }
  
  show heading.where(level: 4): h => {
    set text(
      font: "KaiTi",
      weight: "black",
      size: 14pt,
    )
    set par(
      first-line-indent: 0pt,
      leading: 0.4em,
    )
    v(0.2em)
    align(left, cn-fakebold(h))
    v(0.2em)
  }
  
  show heading.where(level: 5): h => {
    set text(
      font: "KaiTi",
      weight: "bold",
    )
    set par(
      first-line-indent: 0pt,
    )
    v(0.2em)
    align(left, h.body)
    v(0.2em)
  }

  set enum(
    // indent: 1em,
  )
  show enum: it => {
    set par(
      first-line-indent: 0pt,
      leading: 0.8em,
      spacing: 1.2em,
    )
    it
  }
  set list(
    // indent: 0em,
    marker: ([‣], [•]),
  )
  // set strong(delta: 180)

  show strong: set text(
    font: (
      // latin-fallback,
      "FZMingShiTiS"
    )
  )
  
  /* Figure Container */
  set figure(numbering: "一")
  // set figure.caption(position: top)
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
  // show table.cell.where(y: 0): cn-fakebold
  set table(
    align: horizon + left,
    inset: (
      y: 0.4em,
    ),
    fill: (_, y) => if calc.odd(y) { rgb("#DCDDDD") },
    stroke: (_, y) => if y == 0 { (top: 1pt, bottom: 0.7pt) },
  )
  
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.where(kind: table): set figure(gap: 0em)
  show figure.where(kind: table): set par(justify: false, leading: 0.8em)
  show figure.where(kind: table): set text(size: 11pt)
  show figure.where(kind: table): set block(breakable: true)
  // show figure.where(kind: table): set block(width: 100%)
  
  // show figure.where(kind: table): t => {
  //   place(bottom, float: true, scope: "parent", t)
  // }
  set colbreak(weak: true)
  
  show figure.caption: it => {
    align(left + horizon)[
      #block(
        width: 100%,
        fill: black,
        inset: 0.3em,
        text(
          fill: white,
          font: "FZMingShiTiS",
          it.body,
        ),
        spacing: 0em,
      )]
  }

  it
  // marginalia.setup(
  //   book: false,
  //   top: 1.5cm,
  //   bottom: 1.5cm,
  //   inner: (
  //     sep: 0pt,
  //     far: 0pt,
  //     width: inner-width,
  //   ),
  //   outer: (
  //     sep: 0pt,
  //     far: 0pt,
  //     width: outer-width,
  //   ),
  // )[#it]
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
  invisible_heading()[
    = 目录
    <目录>
  ]
  outline(depth: 2, title: none)
  counter(page).update(0)
}

#let quote(it) = {
  set text(size: 14pt)
  place(top + center, float: true, scope: "parent", dy: 4em, it)
  pagebreak(weak: true)
}

#let quote_bottom(it) = {
  floating_bottom(it)
}

// #let quote_bottom(it) = context {
//   set par(
//     spacing: 1em
//   )
//   set text(
//     size: 10pt
//   )
//   let quote_size = measure(it)
//   let quote_height = quote_size.height
//   floating_bottom()[
//     #grid(
//       columns: 1,
//       gutter: 0pt,
//       rows: (quote_height + 10pt, 0pt),

//       image("images/Shadowdark/shadowdark-022.png", width: 100%, height: quote_height + 10pt),
//       // it,
//       text(fill: white, it, baseline: -5pt),
//     )
//   ]
// }

#let small_table(it, ..opts) = {
  set text(
    size: 6pt
  )
  place(top + center, float: true, scope: "parent")[
    #figure(it, ..opts)
  ]
}
