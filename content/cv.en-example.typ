#import "data.typ": shared_contact_info
#import "data.typ": sender_street, sender_postal_code, sender_city

#let profile_summary = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."

#let personal_info = (
  (
    key_key: "phone",
    value: shared_contact_info.phone.value,
    icon: shared_contact_info.phone.icon,
    alt_key: shared_contact_info.phone.alt_key,
    link: shared_contact_info.phone.link,
  ),
  (
    key_key: "email",
    value: shared_contact_info.email.value,
    icon: shared_contact_info.email.icon,
    alt_key: shared_contact_info.email.alt_key,
    link: shared_contact_info.email.link,
  ),
  (
    key_key: "location",
    value: sender_street + ", " + sender_postal_code + " " + sender_city,
    icon: shared_contact_info.location.icon,
    alt_key: shared_contact_info.location.alt_key,
  ),
  (
    key_key: "birth_date",
    value: shared_contact_info.birth_date.value,
    icon: shared_contact_info.birth_date.icon,
    alt_key: shared_contact_info.birth_date.alt_key,
  ),
  (
    key_key: "linkedin",
    value: shared_contact_info.linkedin.value,
    icon: shared_contact_info.linkedin.icon,
    alt_key: shared_contact_info.linkedin.alt_key,
    link: shared_contact_info.linkedin.link,
  ),
  (
    key_key: "github",
    value: shared_contact_info.github.value,
    icon: shared_contact_info.github.icon,
    alt_key: shared_contact_info.github.alt_key,
    link: shared_contact_info.github.link,
  ),
)

#let timeline_sections = (
  (
    title_key: "career_and_education",
    items: (
      (
        period: "03/2023 - present",
        role: "Senior Software Developer",
        company: "Lorem Ipsum Inc., Berlin",
        bullets: (
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
          "Sed do eiusmod tempor incididunt ut labore et dolore magna.",
          "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.",
        ),
      ),
      (
        period: "08/2020 - 02/2023",
        role: "Software Developer",
        company: "Dolor Sit Amet GmbH, Hamburg",
        bullets: (
          "Consectetur adipiscing elit, sed do eiusmod tempor incididunt.",
          "Ut labore et dolore magna aliqua, ut enim ad minim veniam.",
        ),
      ),
      (
        period: "10/2018 - 07/2020",
        role: "Apprenticeship in Application Development",
        company: "Dolor Sit Amet GmbH, Hamburg",
        school: "Vocational School for IT and Technology, Hamburg",
        bullets: (
          "Hands-on work in web and backend projects.",
          "Vocational training focused on software development and systems engineering.",
        ),
      ),
      (
        period: "09/2014 - 06/2018",
        role: "Computer Science B.Sc.",
        company: "Technical University of Berlin",
        final_grade: "1.8",
        bullets: (
          "Specialization in distributed systems and cloud computing.",
          "Thesis on microservice architectures.",
        ),
      ),
    ),
  ),
)

#let role_key = "software_developer"

#let languages = (
  (
    name: "German",
    level: "Native",
  ),
  (
    name: "English",
    level: "Fluent",
  ),
)

#let hobbies = (
  "Lorem ipsum",
  "Dolor sit amet",
  "Consectetur adipiscing",
)

