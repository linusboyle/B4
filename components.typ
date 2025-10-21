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

// maybe equivalent to just use auto for width and height?
#let maximum_figure(path) = {
  layout(size => {
    let container_height = size.height
    let container_width = size.width
    let container_ratio = container_width.pt() / container_height.pt()

    let image_size = measure(image(path))
    let image_height = image_size.height
    let image_width = image_size.width
    let image_ratio = image_width.pt() / image_height.pt()

    if (container_ratio >= image_ratio) {
      image(path, height: container_height)
    } else {
      image(path, width: container_width)
    }
  })
}

#let vanilla_page(it, ..extra) = {
  set page(
    footer: none,
    columns: 1,
    header: none,
    margin: auto,
    ..extra
  )
  [
    #it
  ]
}

#let full_page_figure(path) = {
  vanilla_page(
    margin: 0pt,
  )[
    #place(center + horizon,
      maximum_figure(path)
    )
  ]
}