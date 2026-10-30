/* Count: A5, two-column table reference. */

#let page-margin-x = 8mm
#let page-margin-top = 12mm
#let page-margin-bottom = 12mm
#let page-gutter = 5mm

// Verse / recipe block: soft background, thin frame, unbreakable.
#let poem(body) = block(
  width: 100%,
  fill: luma(243),
  stroke: 0.7pt + luma(110),
  radius: 4pt,
  inset: (x: 0.8em, y: 0.65em),
  above: 1em,
  below: 1em,
  breakable: false,
  {
    set text(font: ("LXGW WenKai", "KaiTi"), size: 10.5pt)
    set par(justify: false, leading: 1.2em, spacing: 0.5em)
    body
  },
)

#let count-body(
  body,
) = {
  set page(
    paper: "a5",
    margin: (
      x: page-margin-x,
      top: page-margin-top,
      bottom: page-margin-bottom,
    ),
    columns: 2,
    numbering: (..nums) => {
      let n = nums.pos().first()
      if n == 1 { none } else { str(n - 1) }
    },
    number-align: center,
    binding: left,
  )

  set columns(gutter: page-gutter)

  set text(
    font: ("Noto Sans CJK SC", "Noto Serif"),
    size: 11pt,
    lang: "zh",
    region: "cn",
  )

  set par(
    justify: true,
    leading: 1em,
    spacing: 1em,
  )

  set list(indent: 0em, body-indent: 0.3em, spacing: 1.1em)
  set list(marker: ([‣], [・]))
  // show list: set par(justify: false)

  show strong: set text(font: ("TsangerYuMo", "Noto Sans"), weight: 240)
  show emph: set text(font: ("LXGW WenKai", "KaiTi"))

  show heading: set text(
    font: ("Noto Sans CJK SC", "Noto Sans"),
    weight: "bold",
  )

  show heading.where(level: 2): it => {
    v(1.3em, weak: true)
    block(
      width: 100%,
      above: 0.3em,
      below: 0.7em,
      sticky: true,
      stroke: (bottom: 0.6pt),
      inset: (bottom: 0.28em),
      text(size: 14pt, it.body),
    )
  }

  show heading.where(level: 3): it => {
    v(1.1em, weak: true)
    block(
      width: 80%,
      above: 0.3em,
      below: 0.7em,
      sticky: true,
      stroke: (bottom: 0.5pt),
      inset: (bottom: 0.22em),
      text(size: 12.5pt, it.body),
    )
  }

  show heading.where(level: 4): it => block(
    above: 0.7em,
    below: 0.35em,
    sticky: true,
    text(size: 10pt, it.body),
  )

  // Tables: compact, unbreakable, single header rule.
  set table(
    stroke: (x, y) => if y == 0 { (bottom: 0.7pt) } else { none },
    fill: (_, y) => if calc.odd(y) { luma(235) },
    inset: (x: 0.35em, y: 0.32em),
    align: left + top,
  )

  show figure.where(kind: table): set text(size: 10pt)
  show figure.where(kind: table): set par(
    justify: false,
    leading: 0.72em,
    spacing: 0.6em,
  )
  show figure.where(kind: table): set block(breakable: false)
  show figure.where(kind: table): set figure(gap: 0.4em)
  show table.cell.where(y: 0): set text(
    font: ("Noto Sans CJK SC", "Noto Sans"),
    weight: "bold",
  )

  body
}
