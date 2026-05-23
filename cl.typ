#import "styles/theme.typ": apply_theme
#import "content/data.typ": accent, profile_name, sender_street, sender_postal_code, sender_city, shared_contact_info, show_signature, signature_path, signature_date
#import "content/cl.__LANG__.typ": cover_letter_body, cover_letter_closing, cover_letter_date, cover_letter_recipient, cover_letter_subject
#import "content/i18n/__LANG__.typ": cover_letter_labels
#import "styles/layout.typ": cover_letter_document

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
  show_signature: show_signature,
  signature_path: signature_path,
  signature_date: signature_date,
)





