#let section_title(title, accent) = {
  block(inset: (bottom: 5pt))[
    #text(size: 11.2pt, weight: "bold", fill: accent)[#title]
    #line(length: 100%, stroke: (paint: accent, thickness: 1pt))
  ]
}

#let contact_value(item) = {
  if item.at("link", default: none) != none {
    [
      #link(item.link)[#text(fill: rgb("#334155"))[#item.value]]
    ]
  } else {
    [
      #text(fill: rgb("#334155"))[#item.value]
    ]
  }
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

#let contact_items_block(items: (), contact_labels: (), icon_alt_labels: (), accent: black) = {
  [
    #for item in items [
      #table(
        columns: (4.5%, 95.5%),
        stroke: none,
        inset: (x: 0pt, y: 1.7pt),
        align: left,
        [
          #text(fill: accent)[#image(
            item.icon,
            width: 9pt,
            height: 9pt,
            fit: "contain",
            alt: icon_alt_labels.at(item.alt_key, default: item.alt_key),
          )]
        ],
        [
          #text(weight: "semibold")[#contact_labels.at(item.key_key, default: item.key_key): ]
          #contact_value(item)
        ],
      )
    ]
  ]
}

#let hero_section(
  profile: (),
  profile_role: "",
  personal_info: (),
  skills: (),
  contact_labels: (),
  icon_alt_labels: (),
  profile_title: "Profil",
  accent: black,
) = {
  table(
    columns: (66%, 34%),
    gutter: 14pt,
    stroke: none,
    inset: 0pt,
    [
      #text(size: 28pt, weight: "bold")[#profile.name]
      #linebreak()
      #text(size: 11.4pt, weight: "semibold", fill: accent)[#profile_role]
      #v(6pt)
      #contact_items_block(
        items: personal_info,
        contact_labels: contact_labels,
        icon_alt_labels: icon_alt_labels,
        accent: accent,
      )
      #v(7pt)
      #section_title(profile_title, accent)
      #text(fill: rgb("#334155"))[#profile.summary]
      #v(8pt)
      #stack(
        dir: ltr,
        spacing: 18pt,
        ..skills.map(skill => image(
          skill.icon,
          width: 32pt,
          height: 32pt,
          fit: "contain",
          alt: skill.alt,
        )),
      )
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
  accent: black,
) = {
  [
    #section_title(title, accent)
    #for (index, item) in items.enumerate() [
      #let final_grade = item.at("final_grade", default: none)
      #let expected_grade = item.at("expected_grade", default: none)
      #let latest_grade = item.at("latest_grade", default: none)
      #let has_grade_info = final_grade != none or expected_grade != none or latest_grade != none
      #let show_company = index == 0 or item.company != items.at(index - 1).company

      #table(
        columns: (18fr, 82fr),
        stroke: none,
        gutter: 10pt,
        inset: (x: 0pt, y: 0pt),
        [#text(weight: "semibold", fill: accent)[#item.period]],
        [
          #if show_company [
            #text(weight: "bold")[#item.company]
            #v(0pt)
          ]

          #if has_grade_info [
            #grid(
              columns: (1fr, auto),
              gutter: 8pt,
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

          #if item.bullets.len() > 0 [
            #v(0pt)

            #list(
              tight: true,
              spacing: 4pt,
              ..item.bullets.map(bullet => [#bullet]),
            )
          ]
        ],
      )
    ]
  ]
}

#let hobbies_section(title: "Hobbys", hobbies: (), accent: black) = {
  [
    #section_title(title, accent)
    #for (index, hobby) in hobbies.enumerate() [
      #if index > 0 [
        #h(10pt)
      ]
      #box(
        fill: rgb("#F1F5F9"),
        inset: (x: 8pt, y: 4pt),
        radius: 99pt,
      )[#hobby]
    ]
  ]
}

#let languages_section(title: "Sprachen", languages: (), accent: black) = {
  [
    #section_title(title, accent)
    #for (index, language) in languages.enumerate() [
      #if index > 0 [
        #h(8pt)
      ]
      #box(
        fill: rgb("#F1F5F9"),
        inset: (x: 8pt, y: 4pt),
        radius: 99pt,
      )[
        #text(weight: "semibold")[#language.name]
        #h(6pt)
        #text(size: 8.8pt, fill: accent, weight: "semibold")[#language.level]
      ]
    ]
  ]
}

#let cv_document(
  profile: (),
  profile_role: "",
  personal_info: (),
  skills: (),
  contact_labels: (),
  icon_alt_labels: (),
  profile_title: "Profil",
  timeline_sections: (),
  languages: (),
  section_labels: (),
  grade_labels: (),
  hobbies: (),
  accent: black,
) = {
  [
    #hero_section(
      profile: profile,
      profile_role: profile_role,
      personal_info: personal_info,
      skills: skills,
      contact_labels: contact_labels,
      icon_alt_labels: icon_alt_labels,
      profile_title: profile_title,
      accent: accent,
    )
    #v(10pt)

    #for section in timeline_sections [
      #timeline_section(
        title: section_labels.at(section.title_key, default: section.title_key),
        items: section.items,
        grade_labels: grade_labels,
        accent: accent,
      )
      #v(8pt)
    ]

    #languages_section(
      title: section_labels.languages,
      languages: languages,
      accent: accent,
    )
    #v(8pt)

    #hobbies_section(
      title: section_labels.hobbies,
      hobbies: hobbies,
      accent: accent,
    )
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

