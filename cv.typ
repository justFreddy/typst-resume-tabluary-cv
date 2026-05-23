#import "styles/theme.typ": apply_theme
#import "content/data.typ": accent, contact_mode, layout, photo_path, pill_stretch, profile_name, show_signature, signature_date, signature_path, skills
#import "content/cv.__LANG__.typ": hobbies, languages, personal_info, profile_summary, timeline_sections
#import "content/i18n/__LANG__.typ": contact_labels, grade_labels, icon_alt_labels, section_labels, timeline_labels
#import "styles/layout.typ": cv_document

#show: apply_theme.with(lang: "__LANG__")

#let accent_color = accent

#cv_document(
  profile: (
    name: profile_name,
    photo_path: photo_path,
    summary: profile_summary,
  ),
  personal_info: personal_info,
  skills: skills,
  contact_labels: contact_labels,
  icon_alt_labels: icon_alt_labels,
  profile_title: section_labels.profile,
  skills_title: section_labels.skills,
  timeline_sections: timeline_sections,
  languages: languages,
  section_labels: section_labels,
  grade_labels: grade_labels,
  timeline_school_label: timeline_labels.school,
  timeline_projects_label: timeline_labels.projects,
  hobbies: hobbies,
  accent: accent_color,
  contact_mode: contact_mode,
  layout: layout,
  signature_path: signature_path,
  show_signature: show_signature,
  signature_date: signature_date,
  location_date_label: section_labels.location_date,
  pill_stretch: pill_stretch,
)

