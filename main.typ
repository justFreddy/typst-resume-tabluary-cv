#import "styles/theme.typ": apply_theme
#import "content/data.typ": accent, photo_path, profile_name, skills, sender_street, sender_postal_code, sender_city, shared_contact_info
#import "content/cv.__LANG__.typ": hobbies, languages, personal_info, profile_summary, role_key, timeline_sections
#import "content/cl.__LANG__.typ": cover_letter_body, cover_letter_closing, cover_letter_date, cover_letter_recipient, cover_letter_subject
#import "content/i18n/__LANG__.typ": contact_labels, cover_letter_labels, grade_labels, icon_alt_labels, role_labels, section_labels, timeline_labels
#import "styles/layout.typ": cover_letter_document, cv_document

#show: apply_theme.with(lang: "__LANG__")

#let accent_color = accent

#let formatted_sender_address = sender_street + "\n" + sender_postal_code + " " + sender_city

#let recipient_with_sender = (
  ..cover_letter_recipient,
  sender_address: formatted_sender_address,
  sender_email: shared_contact_info.email.value,
  sender_email_link: shared_contact_info.email.link,
  sender_phone: shared_contact_info.phone.value,
  sender_phone_link: shared_contact_info.phone.link,
  subject: cover_letter_subject,
)

#cover_letter_document(
  sender_name: profile_name,
  recipient: recipient_with_sender,
  paragraphs: cover_letter_body,
  closing: cover_letter_closing,
  date_line: cover_letter_date,
  labels: cover_letter_labels,
  accent: accent_color,
)
#pagebreak()
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
  languages: languages,
  section_labels: section_labels,
  grade_labels: grade_labels,
  timeline_school_label: timeline_labels.school,
  timeline_continued_label: timeline_labels.continued,
  hobbies: hobbies,
  accent: accent_color,
)
