# Tabluary Career Kit

`tabluary-career-kit` is a multilingual Typst template for a modern CV and cover letter. It currently includes German and English, and it is structured so you can extend it with additional languages later. It uses a clean table-based layout, sans-serif fonts, reusable styling, and language-specific content files.

## What's Included

- CV entrypoint in `cv.typ`
- Cover letter entrypoint in `cl.typ`
- Shared layout and theme logic in `styles/`
- Centralized personal data in `content/data.typ`
- German and English content files in `content/`
- Placeholder icons, logos, and photo assets in `assets/`

## Getting Started

1. Copy the example content files to their personal counterparts:

```bash
cp content/cv.de-example.typ content/cv.de.typ
cp content/cv.en-example.typ content/cv.en.typ
cp content/cl.de-example.typ content/cl.de.typ
cp content/cl.en-example.typ content/cl.en.typ
cp content/data.typ.example content/data.typ
```

2. Update the personal information in the copied files
3. Replace placeholder logos in `assets/logos/` with actual skill/company logos
4. Replace `assets/photo-placeholder.svg` with your photo
5. Compile with `./compile.sh`

## Prerequisites

Before compiling, install [Typst](https://typst.app/).

Verify installation:

```bash
typst --version
```

## Features

- Professional, modern layout with a clear table structure
- Two layout modes: a two-column sidebar layout and a classic single-column layout
- Configurable photo position (left or right sidebar)
- Non-serif fonts for a clean, modern appearance
- Centralized accent color configuration in `content/data.typ`
- Shared contact metadata, including birth date and icon paths
- Separate CV and cover letter documents
- Compile CV only, cover letter only, or both together
- Language support via `cv.{lang}.typ` and `cl.{lang}.typ`
- German and English labels for section titles, grades, contact items, and roles, with an easy path to add more languages

## Project Structure

- `cv.typ` - CV entrypoint
- `cl.typ` - Cover letter entrypoint
- `compile.sh` - Build script with language selection and output mode selection
- `content/data.typ` - Shared data such as accent color, layout, contact mode, profile name, photo, logos, and contact base data
- `content/data.typ.example` - Example shared data file to copy and customize
- `content/cv.{lang}.typ` - CV content for each language (`lang`: `de`, `en`)
- `content/cl.{lang}.typ` - Cover letter content for each language (`lang`: `de`, `en`)
- `content/i18n/{lang}.typ` - Language labels for section titles, grades, contact labels, icons, and cover letter labels
- `styles/theme.typ` - Page and typography defaults
- `styles/layout.typ` - Reusable layout functions for the CV and cover letter
- `assets/` - Icons, logos, and photos
  - **Important**: The logos in `assets/logos/` are placeholders. Replace them with actual company/skill logos.
  - The photo in `assets/photo-placeholder.svg` is a placeholder. Replace it with a real photo.
  - `assets/icons/birth-date.svg` is the dedicated icon for the birth date contact item.

## Usage

### Compile the default document

The default document is controlled by `COMPILE_MODE` in `.env`.

```bash
./compile.sh
```

### Compile a specific document

```bash
./compile.sh -v -l de   # CV only
./compile.sh -c -l de   # Cover letter only
./compile.sh -s -l de   # CV + cover letter as separate PDFs
./compile.sh -j -l de   # CV + cover letter in one PDF
```

### Custom Output Path

```bash
./compile.sh -v -l de -o out/my-cv.pdf
./compile.sh -c -l en -o out/my-cover-letter.pdf
./compile.sh -j -l en -o out/application.pdf
```

### Full Help

```bash
./compile.sh -h
```

## Configuration

### Default Language and Mode

Set the defaults in `.env`:

```dotenv
COMPILE_LANGUAGE=en
COMPILE_MODE=cv
```

### Accent Color

Change the accent color in `content/data.typ`:

```typ
#let accent = rgb("#0B7285")
```

### Layout

Set the CV layout in `content/data.typ`:

```typ
#let layout = "left"
```

Available values:
- `"left"` — two-column sidebar layout, photo on the left
- `"right"` — two-column sidebar layout, photo on the right
- `"default"` — classic single-column layout

In the sidebar layouts (`"left"` / `"right"`), the sidebar contains the photo, skills, languages, and hobbies. The main column contains the name, contact data, summary, and timeline.

### Contact Mode

Control how contact items are displayed in `content/data.typ`:

```typ
#let contact_mode = "compact"
```

Available values:
- `"compact"` — icon and value only, displayed in two columns
- `"full"` — icon, label, and value, displayed in a single column

### Profile Data

Update shared personal information in `content/data.typ`:
- `profile_name` - Your full name
- `photo_path` - Path to your photo
- `skills` - Programming languages and frameworks
- `shared_contact_info` - Base contact data and icon paths, including `birth_date`

Update CV content in `content/cv.{lang}.typ`:
- `profile_summary` - Your professional summary
- `personal_info` - Contact details shown in the CV
- `timeline_sections` - Timeline entries (keep newest first)
- `role_key` - Role label key from `content/i18n/{lang}.typ`
- `languages` - Spoken languages and proficiency levels
- `hobbies` - Personal interests

Update cover letter content in `content/cl.{lang}.typ`:
- `cover_letter_recipient` - Recipient name, company, and address lines
- `cover_letter_subject` - Subject line
- `cover_letter_date` - Date line
- `cover_letter_body` - Letter body paragraphs
- `cover_letter_closing` - Closing phrase

### Timeline Entries

Each timeline entry supports the following fields:

```typ
(
  period: "08/2020 - 02/2023",
  role: "Software Developer",
  company: "Company Name",
  bullets: (
    "Achievement or responsibility.",
  ),
  // Optional fields:
  school: "School name",         // shown below company name
  projects: ("Project description."),
  final_grade: "1.8",
  expected_grade: "1.8",
  latest_grade: "1.8",
)
```

### Section Labels

Update labels in `content/i18n/{lang}.typ`:
- `section_labels` - Section titles
- `grade_labels` - Grade terminology (final, expected, latest)
- `contact_labels` - Contact method names
- `role_labels` - Professional role titles
- `cover_letter_labels` - Cover letter labels

## Package Name

The Typst package metadata uses the name `tabluary-career-kit`.

If you want a short project alias in your own notes, `Tabluary Career Kit` is the recommended display name.

## Notes

1. **Logos are placeholders**: The SVG files in `assets/logos/` are generic placeholders. Replace them with actual brand logos for each skill/company.

2. **Photo placeholder**: The `assets/photo-placeholder.svg` file contains placeholder text. Replace it with an actual high-resolution portrait photo.

3. **Personal files**: Keep your copied `content/cv.{lang}.typ`, `content/cl.{lang}.typ`, and `content/data.typ` files private.

4. **Timeline order**: Always keep timeline entries newest first.

## License

MIT License
