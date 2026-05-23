#let pill(body) = {
  box(
    fill: rgb("#F1F5F9"),
    inset: (x: 8pt, y: 3pt),
    radius: 99pt,
  )[#body]
}

#let section_title(title, accent) = {
  block(inset: (bottom: 3pt))[
    #text(size: 10.4pt, weight: "bold", fill: accent)[#title]
    #v(-6pt)
    #line(length: 100%, stroke: (paint: accent, thickness: 0.8pt))
    #v(-3pt)
  ]
}

#let cover_letter_contact_value(value, target: none) = {
  if target != none {
    [
      #link(target)[#text(size: 9pt, fill: rgb("#334155"))[#value]]
    ]
  } else {
    [
      #text(size: 9pt, fill: rgb("#334155"))[#value]
    ]
  }
}

#let contact_icon(item, accent, icon_alt_labels) = {
  image(
    item.icon,
    width: 8pt,
    height: 8pt,
    fit: "contain",
    alt: icon_alt_labels.at(item.alt_key, default: item.alt_key),
  )
}

#let contact_text(item) = {
  if item.at("link", default: none) != none {
    link(item.link)[#text(fill: rgb("#334155"))[#item.value]]
  } else {
    text(fill: rgb("#334155"))[#item.value]
  }
}

#let contact_items_block(items: (), contact_labels: (), icon_alt_labels: (), accent: black, contact_mode: "full") = {
  if contact_mode == "compact" {
    // Two-column layout: icon + value only, no labels
    let half = calc.ceil(items.len() / 2)
    let col1 = items.slice(0, half)
    let col2 = items.slice(half)

    let build_cells(col) = {
      let cells = ()
      for item in col {
        cells.push([#text(fill: accent)[#contact_icon(item, accent, icon_alt_labels)]])
        cells.push([#contact_text(item)])
      }
      cells
    }

    table(
      columns: (1fr, 1fr),
      stroke: none,
      gutter: 12pt,
      inset: 0pt,
      align: left,
      table(
        columns: (5%, 95%),
        stroke: none,
        inset: (x: 0pt, y: 3pt),
        column-gutter: 4pt,
        align: left,
        ..build_cells(col1),
      ),
      table(
        columns: (5%, 95%),
        stroke: none,
        inset: (x: 0pt, y: 3pt),
        column-gutter: 4pt,
        align: left,
        ..build_cells(col2),
      ),
    )
  } else {
    // Full mode: icon + label + value
    [
      #for item in items [
        #table(
          columns: (4%, 95.5%),
          stroke: none,
          inset: (x: 0pt, y: 3pt),
          column-gutter: 4pt,
          align: left,
          [
            #text(fill: accent)[#contact_icon(item, accent, icon_alt_labels)]
          ],
          [
            #text(weight: "semibold")[#contact_labels.at(item.key_key, default: item.key_key): ]
            #contact_text(item)
          ],
        )
      ]
    ]
  }
}

#let skill_dots(level: 5, max: 5, accent: black) = {
  let fill_color = accent
  let empty_color = rgb("#CBD5E1")
  box(stack(dir: ltr, spacing: 1pt,
    ..range(max).map(i => {
      if i < level {
        block(width: 4pt, height: 4pt, fill: fill_color, radius: 99pt)
      } else {
        block(width: 4pt, height: 4pt, fill: empty_color, radius: 99pt)
      }
    })
  ))
}

#let hero_section(
  profile: (),
  personal_info: (),
  contact_labels: (),
  icon_alt_labels: (),
  profile_title: "Profil",
  accent: black,
  contact_mode: "full",
) = {
  table(
    columns: (66%, 34%),
    gutter: 8pt,
    stroke: none,
    inset: 0pt,
    [
      #text(size: 26pt, weight: "bold")[#profile.name]
      #v(-20pt)
      #contact_items_block(
        items: personal_info,
        contact_labels: contact_labels,
        icon_alt_labels: icon_alt_labels,
        accent: accent,
        contact_mode: contact_mode,
      )
      #v(6pt)
      // #section_title(profile_title, accent)
      #text(fill: rgb("#334155"))[#profile.summary]
    ],
    [
      #block(fill: rgb("#F8FAFC"), inset: 6pt, radius: 6pt)[
        #image(
          profile.photo_path,
          width: 100%,
          height: 8.7cm,
          fit: "cover",
        )
      ]
    ],
  )
}

#let timeline_section(
  title: "",
  items: (),
  grade_labels: (final: "Final Grade", expected: "Expected Grade", latest: "Latest Grade"),
  timeline_school_label: (),
  timeline_projects_label: (),
  accent: black,
) = {
  [
    #section_title(title, accent)
    #for (index, item) in items.enumerate() [
      #let final_grade = item.at("final_grade", default: none)
      #let expected_grade = item.at("expected_grade", default: none)
      #let latest_grade = item.at("latest_grade", default: none)
      #let school = item.at("school", default: none)
      #let projects = item.at("projects", default: ())
      #let has_grade_info = final_grade != none or expected_grade != none or latest_grade != none
      #let has_projects = projects.len() > 0
      #let has_newer_same_company = index > 0 and item.company == items.at(index - 1).company
      #let show_company = index == 0 or item.company != items.at(index - 1).company

      #let role_content = if has_grade_info [
        #v(-4pt)
        #grid(
          columns: (1fr, auto),
          gutter: 6pt,
          stroke: none,
          inset: 0pt,
          align: (left, top),

          [#text(fill: rgb("#3F3F46"))[#item.role]],

          [
            #align(right)[
              #text(size: 9pt, fill: accent, weight: "semibold")[
                #if final_grade != none [
                  #grade_labels.final: #final_grade
                ]
                #if expected_grade != none [
                  #if final_grade != none [ | ]
                  #grade_labels.expected: #expected_grade
                ]
                #if latest_grade != none [
                  #if final_grade != none or expected_grade != none [ | ]
                  #grade_labels.latest: #latest_grade
                ]
              ]
            ]
          ],
        )
      ] else [
        #text(fill: rgb("#3F3F46"))[#item.role]
      ]

      #let project_section = if has_projects [
        #v(-6pt)
        #text(size: 8.2pt, fill: rgb("#3F3F46"))[#timeline_projects_label]
        #v(-8pt)
        #list(
          tight: true,
          spacing: 5pt,
          ..projects.map(project => [#text(fill: rgb("#3F3F46"))[#project]]),
        )
      ] else [
      ]

      #let show_school_on_older = school != none and has_newer_same_company

      #let company_and_role = if show_company [
        #stack(spacing: 1pt)[
          #text(weight: "bold")[#item.company]
          #if school != none [
            #linebreak()
            #text(size: 8.2pt, fill: rgb("#64748B"))[#timeline_school_label: #school]
          ]
          #linebreak()
          #role_content
        ]
      ] else if show_school_on_older [
        #stack(spacing: 1pt)[
          #text(size: 8.2pt, fill: rgb("#64748B"))[#timeline_school_label: #school]
          #linebreak()
          #role_content
        ]
      ] else [
        #stack(spacing: 1pt)[
          #role_content
        ]
      ]

      #let period_parts = item.period.split(" - ")
      #let period_display = if period_parts.len() == 2 [
        #stack(spacing: 2pt,
          align(left)[#text(weight: "semibold", fill: accent)[#period_parts.at(0)]],
          align(right)[#text(weight: "semibold", fill: accent)[– #period_parts.at(1)]],
        )
      ] else [
        #text(weight: "semibold", fill: accent)[#item.period]
      ]

      #table(
        columns: (2cm, 1fr),
        stroke: none,
        gutter: 6pt,
        inset: (x: 0pt, y: 0pt),
        align: (right, top),
        [#period_display],
        [
          #company_and_role

          #if item.bullets.len() > 0 [
            #v(-4pt)

            #list(
              tight: true,
              spacing: 5pt,
              ..item.bullets.map(bullet => [#bullet]),
            )
            #project_section
          ]
        ],
      )
    ]
  ]
}

#let skills_section(title: "Skills", skills: (), icon_alt_labels: (), accent: black) = {
  [
    #section_title(title, accent)
    #for (index, skill) in skills.enumerate() [
      #if index > 0 [
        #h(6pt)
      ]
      #let level = skill.at("level", default: none)
      #let dots = if level != none { skill_dots(level: level, accent: accent) } else { none }
      #pill[
        #box(image(skill.icon, width: 9pt, height: 9pt, fit: "contain", alt: skill.alt))
        #h(4pt)
        #text(weight: "semibold")[#skill.name]
        #if dots != none [#h(4pt)#dots]
      ]
    ]
  ]
}

#let languages_section(title: "Sprachen", languages: (), accent: black) = {
  [
    #section_title(title, accent)
    #for (index, language) in languages.enumerate() [
      #if index > 0 [
        #h(6pt)
      ]
      #pill[
        #text(weight: "semibold")[#language.name]
        #h(4pt)
        #text(size: 8.8pt, fill: accent, weight: "semibold")[#language.level]
      ]
    ]
  ]
}

#let hobbies_section(title: "Hobbys", hobbies: (), accent: black) = {
  [
    #section_title(title, accent)
    #for (index, hobby) in hobbies.enumerate() [
      #if index > 0 [
        #h(6pt)
      ]
      #pill[#hobby]
    ]
  ]
}

#let signature_block(
  signature_path: none,
  signature_date: "",
  accent: black,
) = {
  stack(spacing: 4pt,
    image(signature_path, height: 1.5cm, fit: "contain"),
    line(length: 6cm, stroke: (paint: rgb("#CBD5E1"), thickness: 0.6pt)),
    text(size: 8pt, fill: rgb("#64748B"))[#signature_date],
  )
}

#let hero_section_left(
  profile: (),
  personal_info: (),
  contact_labels: (),
  icon_alt_labels: (),
  profile_title: "Profil",
  accent: black,
  contact_mode: "full",
  skills: (),
  languages: (),
  hobbies: (),
  section_labels: (),
  skills_title: "Skills",
  timeline_sections: (),
  timeline_school_label: (),
  timeline_projects_label: (),
  grade_labels: (),
  photo_side: "left",
  show_signature: false,
  signature_path: none,
  signature_date: "",
) = {
  let sidebar = [
    #block(fill: rgb("#F8FAFC"), inset: 6pt, radius: 6pt)[
      #image(
        profile.photo_path,
        width: 100%,
        height: 8.7cm,
        fit: "cover",
      )
    ]
    #v(6pt)
    #skills_section(
      title: skills_title,
      skills: skills,
      icon_alt_labels: icon_alt_labels,
      accent: accent,
    )
    #v(6pt)
    #languages_section(
      title: section_labels.languages,
      languages: languages,
      accent: accent,
    )
    #v(6pt)
    #hobbies_section(
      title: section_labels.hobbies,
      hobbies: hobbies,
      accent: accent,
    )
    #if show_signature [
      #v(1fr)
      #align(if photo_side == "left" { left } else { right })[
        #signature_block(
          signature_path: signature_path,
          signature_date: signature_date,
          accent: accent,
        )
      ]
    ]
  ]

  let main = [
    #text(size: 26pt, weight: "bold")[#profile.name]
    #v(-20pt)
    #contact_items_block(
      items: personal_info,
      contact_labels: contact_labels,
      icon_alt_labels: icon_alt_labels,
      accent: accent,
      contact_mode: contact_mode,
    )
    #v(6pt)
    #text(fill: rgb("#334155"))[#profile.summary]
    #v(6pt)
    #for section in timeline_sections [
      #timeline_section(
          title: section_labels.at(section.title_key, default: section.title_key),
          items: section.items,
          grade_labels: grade_labels,
          timeline_school_label: timeline_school_label,
          timeline_projects_label: timeline_projects_label,
          accent: accent,
        )
        #v(6pt)
      ]
    ]

  if photo_side == "right" {
    table(
      columns: (1fr, 30%),
      gutter: 8pt,
      stroke: none,
      inset: 0pt,
      main,
      sidebar,
    )
  } else {
    table(
      columns: (30%, 1fr),
      gutter: 8pt,
      stroke: none,
      inset: 0pt,
      sidebar,
      main,
    )
  }
}

#let cv_document_left(
  profile: (),
  personal_info: (),
  skills: (),
  contact_labels: (),
  icon_alt_labels: (),
  profile_title: "Profil",
  skills_title: "Skills",
  timeline_sections: (),
  languages: (),
  section_labels: (),
  grade_labels: (),
  timeline_school_label: (),
  timeline_projects_label: (),
  hobbies: (),
  accent: black,
  contact_mode: "compact",
  signature_path: "../assets/signature-placeholder.svg",
  location_date_label: "Location, Date",
  photo_side: "left",
  show_signature: false,
  signature_date: "",
) = {
  [
    #hero_section_left(
      profile: profile,
      personal_info: personal_info,
      contact_labels: contact_labels,
      icon_alt_labels: icon_alt_labels,
      profile_title: profile_title,
      accent: accent,
      contact_mode: contact_mode,
      skills: skills,
      languages: languages,
      hobbies: hobbies,
      section_labels: section_labels,
      skills_title: skills_title,
      timeline_sections: timeline_sections,
      timeline_school_label: timeline_school_label,
      timeline_projects_label: timeline_projects_label,
      grade_labels: grade_labels,
      photo_side: photo_side,
      show_signature: show_signature,
      signature_path: signature_path,
      signature_date: signature_date,
    )
    #v(6pt)
  ]
}


#let cv_document(
  profile: (),
  personal_info: (),
  skills: (),
  contact_labels: (),
  icon_alt_labels: (),
  profile_title: "Profil",
  skills_title: "Skills",
  timeline_sections: (),
  languages: (),
  section_labels: (),
  grade_labels: (),
  timeline_school_label: (),
  timeline_projects_label: (),
  hobbies: (),
  accent: black,
  contact_mode: "compact",
  signature_path: "../assets/signature-placeholder.svg",
  location_date_label: "Location, Date",
  layout: "default",
  show_signature: false,
  signature_date: "",
) = {
  if layout == "left" or layout == "right" [
    #cv_document_left(
      profile: profile,
      personal_info: personal_info,
      skills: skills,
      contact_labels: contact_labels,
      icon_alt_labels: icon_alt_labels,
      profile_title: profile_title,
      skills_title: skills_title,
      timeline_sections: timeline_sections,
      languages: languages,
      section_labels: section_labels,
      grade_labels: grade_labels,
      timeline_school_label: timeline_school_label,
      timeline_projects_label: timeline_projects_label,
      hobbies: hobbies,
      accent: accent,
      contact_mode: contact_mode,
      photo_side: layout,
      show_signature: show_signature,
      signature_path: signature_path,
      signature_date: signature_date,
    )
  ] else [
    #hero_section(
        profile: profile,
        personal_info: personal_info,
        contact_labels: contact_labels,
        icon_alt_labels: icon_alt_labels,
        profile_title: profile_title,
        accent: accent,
        contact_mode: contact_mode,
      )
      #v(6pt)

      #for section in timeline_sections [
        #timeline_section(
          title: section_labels.at(section.title_key, default: section.title_key),
          items: section.items,
          grade_labels: grade_labels,
          timeline_school_label: timeline_school_label,
          timeline_projects_label: timeline_projects_label,
          accent: accent,
        )
        #v(6pt)
      ]

      #skills_section(
        title: skills_title,
        skills: skills,
        icon_alt_labels: icon_alt_labels,
        accent: accent,
      )
      #v(6pt)

      #languages_section(
        title: section_labels.languages,
        languages: languages,
        accent: accent,
      )
      #v(6pt)

      #hobbies_section(
        title: section_labels.hobbies,
        hobbies: hobbies,
        accent: accent,
      )
      #if show_signature [
        #v(12pt)
        #signature_block(
          signature_path: signature_path,
          signature_date: signature_date,
          accent: accent,
        )
      ]
  ]
}

#let cover_letter_document(
  sender_name: "",
  recipient: (),
  paragraphs: (),
  closing: "",
  date_line: "",
  labels: (),
  accent: black,
) = {
  [
    #text(weight: "semibold", size: 10pt)[#sender_name]
    #if recipient.sender_address != none [
      #linebreak()
      #text(size: 9pt, fill: rgb("#334155"))[#recipient.sender_address]
    ]
    #if recipient.sender_email != none [
      #linebreak()
      #cover_letter_contact_value(
        recipient.sender_email,
        target: recipient.sender_email_link,
      )
    ]
    #if recipient.sender_phone != none [
      #linebreak()
      #cover_letter_contact_value(
        recipient.sender_phone,
        target: recipient.sender_phone_link,
      )
    ]

    #v(14pt)
    #text(weight: "semibold", size: 10pt)[#recipient.company]
    #if recipient.name != none and recipient.name != "" [
      #linebreak()
      #text(fill: rgb("#334155"), size: 9pt)[#recipient.name]
    ]
    #for line in recipient.address_lines [
      #linebreak()
      #text(fill: rgb("#334155"), size: 9pt)[#line]
    ]

    #v(14pt)
    #if date_line != "" [
      #align(right)[#text(fill: accent, weight: "semibold", size: 9pt)[#date_line]]
      #v(12pt)
    ]

    #if recipient.subject != none and recipient.subject != "" [
      #text(weight: "bold", fill: accent, size: 10pt)[#recipient.subject]
    ]

    #v(12pt)

    #for (idx, paragraph) in paragraphs.enumerate() [
      #if idx > 0 [
        #v(6pt)
      ]
      #paragraph
    ]

    #v(12pt)
    #text()[#closing]
    #v(18pt)
    #text(weight: "semibold")[#sender_name]
  ]
}
