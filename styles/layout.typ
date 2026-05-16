#let section_title(title, accent) = {
  block(inset: (bottom: 3pt))[
    #text(size: 10.4pt, weight: "bold", fill: accent)[#title]
    #line(length: 100%, stroke: (paint: accent, thickness: 0.8pt))
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
        columns: (4%, 95.5%),
        stroke: none,
        inset: (x: 0pt, y: 0.6pt),
        align: left,
        [
          #text(fill: accent)[#image(
            item.icon,
            width: 8pt,
            height: 8pt,
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
    gutter: 8pt,
    stroke: none,
    inset: 0pt,
    [
      #text(size: 26pt, weight: "bold")[#profile.name]
      #linebreak()
      #text(size: 10.8pt, weight: "semibold", fill: accent)[#profile_role]
      #v(4pt)
      #contact_items_block(
        items: personal_info,
        contact_labels: contact_labels,
        icon_alt_labels: icon_alt_labels,
        accent: accent,
      )
      #v(6pt)
      #section_title(profile_title, accent)
      #text(fill: rgb("#334155"))[#profile.summary]
      #v(6pt)
      #stack(
        dir: ltr,
        spacing: 12pt,
        ..skills.map(skill => image(
          skill.icon,
          width: 26pt,
          height: 26pt,
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
  timeline_school_label: "Berufsschule",
  timeline_continued_label: "Übernommen",
  accent: black,
) = {
  [
    #section_title(title, accent)
    #for (index, item) in items.enumerate() [
      #let final_grade = item.at("final_grade", default: none)
      #let expected_grade = item.at("expected_grade", default: none)
      #let latest_grade = item.at("latest_grade", default: none)
      #let school = item.at("school", default: none)
      #let has_grade_info = final_grade != none or expected_grade != none or latest_grade != none
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
        #role_content
      ]

      #table(
        columns: (18fr, 82fr),
        stroke: none,
        gutter: 6pt,
        inset: (x: 0pt, y: 0pt),
        [#text(weight: "semibold", fill: accent)[#item.period]],
        [
          #company_and_role

          #if item.bullets.len() > 0 [
            #v(-4pt)

            #list(
              tight: true,
              spacing: 5pt,
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
        #h(6pt)
      ]
      #box(
        fill: rgb("#F1F5F9"),
        inset: (x: 8pt, y: 3pt),
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
        #h(6pt)
      ]
      #box(
        fill: rgb("#F1F5F9"),
        inset: (x: 8pt, y: 3pt),
        radius: 99pt,
      )[
        #text(weight: "semibold")[#language.name]
        #h(4pt)
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
  timeline_school_label: "Berufsschule",
  timeline_continued_label: "Übernommen",
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
    #v(6pt)

    #for section in timeline_sections [
      #timeline_section(
        title: section_labels.at(section.title_key, default: section.title_key),
        items: section.items,
        grade_labels: grade_labels,
        timeline_school_label: timeline_school_label,
        timeline_continued_label: timeline_continued_label,
        accent: accent,
      )
      #v(6pt)
    ]

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
