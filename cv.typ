#import "styles/theme.typ": apply_theme
#import "content/data.typ": accent, photo_path, profile_name, skills
#import "content/cv.__LANG__.typ": hobbies, personal_info, profile_summary, role_key, timeline_sections
#import "content/i18n/__LANG__.typ": contact_labels, grade_labels, icon_alt_labels, role_labels, section_labels
#import "styles/layout.typ": cv_document

#show: apply_theme.with(lang: "__LANG__")

#let accent_color = accent

#cv_document(
  profile: (
    name: profile_name,
    photo_path: photo_path,
    summary: profile_summary,
  ),
  profile_role: role_labels.at(role_key, default: role_key),
  personal_info: personal_info,
  skills: skills,
  contact_labels: contact_labels,
  icon_alt_labels: icon_alt_labels,
  profile_title: section_labels.profile,
  timeline_sections: timeline_sections,
  section_labels: section_labels,
  grade_labels: grade_labels,
  hobbies: hobbies,
  accent: accent_color,
)

