#let apply_theme(doc, lang: "de", page_margin: (x: 1.2cm, y: 1.2cm)) = {
  set page(
    paper: "a4",
    margin: page_margin,
    numbering: none,
  )
  set text(
    font: ("Avenir Next", "Avenir", "Arial", "Helvetica", "Apple SD Gothic Neo"),
    size: 10.4pt,
    lang: lang,
  )
  set par(justify: true, leading: 0.62em)
  doc
}
