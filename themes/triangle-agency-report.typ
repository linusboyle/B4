// 三角机构 · 外勤行动报告
// Triangle Agency field report theme
//
// Design language follows the Triangle Agency core rulebook:
// - crimson + navy on white, pale rose panels
// - heavy Tsanger YuMo display type, triangle motifs
// - thin rules and a red outer margin strip
//
// Fonts: the patched TsangerYuMo family in fonts/tsanger-yumo/
// supplies W01-W05 as real weights. Build with:
//   typst compile --root . --font-path fonts/tsanger-yumo ...
// or install that family system-wide.
//
// Usage:
//   #import "../../themes/triangle-agency-report.typ": *
//   #show: triangle-agency-report.with(
//     subject: "华夫饼",
//     agent: "外勤特工，代号“波哥”",
//   )
//   == 异常体分析
//   ...

#let ta-red = rgb("#CB1C2E")
#let ta-navy = rgb("#231C42")
#let ta-rose = rgb("#FAEAEC")
#let ta-rose-soft = rgb("#FDF4F5")
#let ta-ink = rgb("#211D29")
#let ta-grey = rgb("#77717F")

#let ta-body-font = ("TsangerYuMo", "Noto Sans CJK SC", "Noto Sans")
#let ta-head-font = ("TsangerYuMo", "Noto Sans CJK SC", "Noto Sans")
#let ta-body-weight = "light"
#let ta-head-weight = "bold"

#let ta-triangle(size: 4pt, fill: ta-red) = polygon(
  fill: fill,
  (0pt, size),
  (size / 2, 0pt),
  (size, size),
)

#let ta-meta(lab, val) = block(
  width: 100%,
  above: 3.2mm,
  below: 0pt,
)[
  #text(
    font: ta-body-font,
    size: 6.1pt,
    fill: ta-red,
    tracking: 0.7pt,
  )[#lab]
  #v(0.8mm)
  #text(font: ta-head-font, weight: ta-head-weight, size: 9.4pt, fill: ta-navy)[#val]
]

#let ta-strong(it) = text(font: ta-head-font, weight: ta-head-weight, fill: ta-red, it)
#let ta-emph(it) = text(font: ta-head-font, weight: ta-head-weight, fill: ta-navy, it)

#let ta-h2(it) = block(
  width: 100%,
  above: 0.4em,
  below: 0.72em,
  stroke: (bottom: 0.6pt + ta-red),
  inset: (bottom: 1.6mm),
)[
  #grid(columns: (auto, 1fr), gutter: 2.6mm, align: horizon)[
    #box(baseline: 12%, ta-triangle(size: 6.6pt))
    #text(
      font: ta-head-font,
      weight: ta-head-weight,
      size: 13pt,
      fill: ta-red,
      tracking: 0.4pt,
    )[#it.body]
  ]
]

#let ta-h3(it) = block(
  width: 100%,
  above: 0.9em,
  below: 0.3em,
)[
  #text(font: ta-head-font, weight: ta-head-weight, size: 10.5pt, fill: ta-navy)[#it.body]
]

#let triangle-agency-report(
  // 报告主标题
  title: "外勤行动报告",
  // 英文副标题
  subtitle: "FIELD OPERATIONS REPORT",
  // 任务类型 / 小标签
  kind: "异常体回收",
  // 异常体代号
  subject: none,
  // 报告人
  agent: none,
  // 档案编号
  report-no: "TA-FR-07-B",
  // 日期：datetime 或字符串
  date: datetime.today(),
  date-format: "[year].[month repr:numerical padding:zero].[day padding:zero]",
  // 密级
  clearance: "内部 · 三级",
  // 归档状态
  status: "已归档",
  // 可选：嘉奖合计，例如 "+7"
  reward-total: none,
  // 是否在正文后保留手写备注区
  notes: true,
  // 正文
  body,
) = {
  let date-text = if type(date) == datetime {
    date.display(date-format)
  } else {
    date
  }

  let author-name = if type(agent) == str { agent } else { "三角机构" }

  set document(title: title, author: author-name)

  set page(
    paper: "a4",
    margin: (left: 26mm, right: 23mm, top: 16mm, bottom: 31mm),
    fill: white,
    header: none,
    footer: context {
      let i = counter(page).at(here()).first()
      set text(font: ta-body-font, weight: "regular", size: 6.5pt, fill: ta-grey, lang: "zh")
      block(
        width: 100%,
        stroke: (top: 0.6pt + ta-red),
        inset: (top: 2.2mm),
      )[
        #grid(
          columns: (1fr, 1fr),
          gutter: 12mm,
          align: bottom,
          [
            #text(fill: ta-red, font: ta-body-font, size: 6pt, tracking: 0.6pt)[报告人签名 / SIGNATURE]
            #v(5.5mm)
            #line(length: 100%, stroke: 0.5pt + ta-red.transparentize(45%))
          ],
          [
            #text(fill: ta-red, font: ta-body-font, size: 6pt, tracking: 0.6pt)[主管审阅 / REVIEW]
            #v(5.5mm)
            #line(length: 100%, stroke: 0.5pt + ta-red.transparentize(45%))
          ],
        )
        #v(2.2mm)
        #grid(
          columns: (1fr, auto),
          align: horizon + left,
          [
            #text(fill: ta-red, font: ta-head-font, weight: ta-head-weight, size: 6.8pt, tracking: 0.6pt)[三角机构 · 外勤档案]
            #h(2mm)
            #text[本报告仅供机构内部传阅 / INTERNAL USE ONLY]
          ],
          [
            #text(fill: ta-red, font: ta-head-font, weight: ta-head-weight, size: 8.5pt)[#numbering("01", i)]
          ],
        )
      ]
    },
  )

  // Page furniture -------------------------------------------------------
  set page(background: {
    // right crimson strip
    place(
      top + right,
      rect(width: 9mm, height: 100%, fill: ta-red),
    )
    // vertical running head
    place(
      top + right,
      dx: 0mm,
      dy: 0mm,
      box(width: 9mm, height: 100%, align(center + horizon, rotate(-90deg, text(
        fill: white,
        font: ta-body-font,
        size: 6.4pt,
        tracking: 1.8pt,
      )[外勤报告  /  FIELD REPORT]))),
    )
    // white triangle at the foot of the strip
    place(
      bottom + right,
      dx: 1.8mm,
      dy: -12mm,
      ta-triangle(size: 5.4pt, fill: white),
    )
    // left margin rule
    place(
      top + left,
      dx: 13mm,
      dy: 15mm,
      rect(width: 0.7pt, height: 267mm, fill: ta-red),
    )
    // left margin marker
    place(
      top + left,
      dx: 8.6mm,
      dy: 15mm,
      polygon(fill: ta-red, (0pt, 0pt), (0pt, 6.4pt), (5.2pt, 3.2pt)),
    )
    // faint oversized triangle, lower right
    place(
      bottom + right,
      dx: -14mm,
      dy: 18mm,
      polygon(
        fill: none,
        stroke: 0.5pt + ta-red.transparentize(88%),
        (0pt, 0pt),
        (42mm, 0pt),
        (42mm, -42mm),
      ),
    )
  })

  set text(
    font: ta-body-font,
    weight: ta-body-weight,
    size: 10.2pt,
    fill: ta-ink,
    lang: "zh",
    hyphenate: false,
  )
  set par(
    leading: 0.72em,
    spacing: 0.9em,
    justify: true,
    linebreaks: "optimized",
    first-line-indent: 0pt,
  )
  set strong(delta: 200)
  show strong: ta-strong
  show emph: ta-emph
  set underline(offset: 2pt, stroke: 0.9pt + ta-red)
  set list(
    indent: 0.8em,
    body-indent: 0.55em,
    spacing: 0.5em,
    marker: box(baseline: 18%, ta-triangle(size: 4.2pt)),
  )
  show list: set par(justify: false, spacing: 0.35em)

  // Layout ---------------------------------------------------------------
  [
    #grid(
      columns: (1fr, auto),
      align: horizon,
      grid(
        columns: (auto, auto, auto),
        gutter: 2mm,
        align: horizon,
        box(baseline: 18%, ta-triangle(size: 7pt)),
        text(
          font: ta-head-font,
          weight: ta-head-weight,
          size: 9.2pt,
          fill: ta-navy,
          tracking: 1.1pt,
        )[TRIANGLE AGENCY],
        text(font: ta-body-font, size: 7.4pt, fill: ta-red)[· 三角机构],
      ),
      text(
        font: ta-body-font,
        size: 6.6pt,
        fill: ta-grey,
        tracking: 0.8pt,
      )[INTERNAL FILE  ·  内部档案],
    )

    #v(3.5mm)
    #line(length: 100%, stroke: 0.5pt + ta-red.transparentize(55%))
    #v(5mm)

    // Title --------------------------------------------------------------
    #grid(
      columns: (1fr, 31mm),
      gutter: 6mm,
      align: horizon,
      [
        #text(
          font: ta-body-font,
          size: 7pt,
          fill: ta-red,
          tracking: 1.6pt,
        )[#kind  /  INCIDENT REPORT]
        #v(2.6mm)
        #text(font: ta-head-font, weight: ta-head-weight, size: 28pt, fill: ta-navy)[#title]
        #v(1.2mm)
        #text(
          font: ta-body-font,
          size: 7.2pt,
          fill: ta-red,
          tracking: 1.9pt,
        )[#subtitle]
      ],
      box(width: 31mm, height: 25mm, {
        place(top + left, polygon(
          fill: ta-red,
          (0pt, 25mm),
          (31mm, 25mm),
          (15.5mm, 0pt),
        ))
        place(
          top + left,
          dx: 0mm,
          dy: 18.5mm,
          box(width: 31mm, align(center, text(
            fill: white,
            font: ta-body-font,
            size: 6.4pt,
            tracking: 0.9pt,
          )[FORM 07-B])),
        )
      }),
    )

    #v(4.5mm)

    #if subject != none [
      #block(
        width: 100%,
        fill: ta-rose,
        stroke: (left: 2.4pt + ta-red),
        inset: (x: 4mm, y: 2.4mm),
      )[
        #grid(
          columns: (auto, 1fr),
          gutter: 3mm,
          align: horizon,
          text(
            font: ta-body-font,
            size: 6.4pt,
            fill: ta-red,
            tracking: 0.8pt,
          )[异常体代号 / SUBJECT],
          text(font: ta-head-font, weight: ta-head-weight, size: 12pt, fill: ta-navy)[#subject],
        )
      ]
      #v(4mm)
    ]

    // Metadata + body ----------------------------------------------------
    #grid(
      columns: (37mm, 1fr),
      gutter: 8mm,
      align: top,
      block(
        width: 100%,
        fill: ta-rose-soft,
        stroke: 0.8pt + ta-red,
        radius: 2.2mm,
        inset: (x: 4mm, y: 4mm),
      )[
        #text(
          font: ta-body-font,
          size: 6.3pt,
          fill: ta-red,
          tracking: 1.2pt,
        )[档案信息 / FILE INFO]
        #v(1.2mm)
        #line(length: 100%, stroke: 0.6pt + ta-red)

        #if agent != none [
          #ta-meta([报告人 / AGENT], agent)
        ]
        #ta-meta([档案编号 / FILE], report-no)
        #ta-meta([提交日期 / DATE], date-text)
        #ta-meta([密级 / CLEARANCE], clearance)
        #ta-meta([状态 / STATUS], status)

        #if reward-total != none [
          #v(4mm)
          #block(
            width: 100%,
            fill: ta-red,
            inset: (x: 3mm, y: 2.4mm),
          )[
            #grid(
              columns: (1fr, auto),
              align: horizon,
              text(fill: white, font: ta-body-font, size: 6.2pt, tracking: 0.5pt)[嘉奖合计 / TOTAL],
              text(fill: white, font: ta-head-font, weight: ta-head-weight, size: 14pt)[#reward-total],
            )
          ]
        ]

        #v(5mm)
        #align(center)[
          #rotate(
            -7deg,
            block(
              stroke: 1.4pt + ta-red,
              inset: (x: 4.5mm, y: 2.4mm),
            )[
              #text(
                fill: ta-red,
                font: ta-head-font,
                weight: ta-head-weight,
                size: 13pt,
                tracking: 2.2pt,
              )[#status]
              #line(length: 100%, stroke: 0.5pt + ta-red)
              #text(
                fill: ta-red,
                font: ta-body-font,
                size: 5.8pt,
                tracking: 0.9pt,
              )[TRIANGLE AGENCY · FILED]
            ],
          )
        ]
      ],
      // Body
      [
        #show heading.where(level: 2): ta-h2
        #show heading.where(level: 3): ta-h3
        #body
      ],
    )

    #if notes [
      #v(5mm)
      #block(
        width: 100%,
        fill: ta-rose-soft,
        stroke: 0.8pt + ta-red,
        radius: 2mm,
        inset: (x: 4mm, y: 3mm),
      )[
        #grid(
          columns: (auto, 1fr),
          gutter: 3mm,
          align: horizon,
          text(
            fill: ta-red,
            font: ta-body-font,
            size: 6.3pt,
            tracking: 0.8pt,
          )[备注 / NOTES],
          line(length: 100%, stroke: 0.5pt + ta-red.transparentize(65%)),
        )
        #v(6.5mm)
        #line(length: 100%, stroke: 0.5pt + ta-red.transparentize(78%))
        #v(6.5mm)
        #line(length: 100%, stroke: 0.5pt + ta-red.transparentize(78%))
        #v(6.5mm)
        #line(length: 100%, stroke: 0.5pt + ta-red.transparentize(78%))
      ]
    ]
  ]
}
