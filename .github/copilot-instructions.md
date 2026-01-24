# LinkFlow - AI Coding Agent Instructions

## Project Overview
LinkFlow is a Progressive Web App (PWA) that generates WhatsApp links with phone numbers and optional messages. It's designed for Arabic-speaking users with RTL support and includes features like country selection, message templates, history tracking, and offline functionality.

## Architecture
- **Single HTML File**: All code (HTML, CSS, JS) is contained in `index.html`
- **No Build Process**: Pure static files served directly
- **PWA Features**: Service worker (`sw.js`) and manifest (`manifest.json`) for offline use
- **Data Persistence**: Uses `localStorage` for history, templates, and settings
- **External Dependencies**: Tailwind CSS (CDN), Google Fonts, JSZip (for downloads)

## Key Components
- **Main App** (`index.html`): Complete SPA with tabs for Send, History, Templates
- **PWA Files**: `manifest.json`, `sw.js`, `icon.svg`
- **Download Page** (`download.html`): Generates ZIP of app files for offline distribution

## Development Patterns

### Code Organization
- CSS variables for theming (dark/light modes)
- Event-driven JavaScript with global functions
- i18n with hardcoded translation objects
- Glass morphism design with backdrop-filter

### Data Flow
```javascript
// Settings persistence
localStorage.setItem('linkflow_settings', JSON.stringify(settings));

// History management
history.unshift(entry);
localStorage.setItem('linkflow_history', JSON.stringify(history));

// Template storage
templates.push(newTemplate);
localStorage.setItem('linkflow_templates', JSON.stringify(templates));
```

### UI Patterns
- Tab-based navigation with `switchTab()`
- Modal overlays for settings and template creation
- Glass effect with `backdrop-filter: blur()`
- Neon glow effects for branding
- RTL-aware layouts with `dir="rtl"`

### WhatsApp Integration
```javascript
// Generate WhatsApp URL
const fullNumber = selectedCountry.code.replace('+', '') + currentNumber;
let url = `https://wa.me/${fullNumber}`;
if (selectedTemplate) {
    url += `?text=${encodeURIComponent(selectedTemplate)}`;
}
window.open(url, '_blank');
```

## Critical Workflows

### Adding New Features
1. Add HTML structure in appropriate tab panel
2. Implement JavaScript functions (global scope)
3. Add CSS styles using existing patterns
4. Update i18n translations if needed
5. Test PWA functionality

### Modifying Country Data
- Countries array in `index.html` JavaScript section
- Each country: `{ name: 'Country', code: '+XXX', flag: '🇽🇽' }`
- Update `renderCountryList()` for filtering

### Template System
- Templates stored in localStorage as JSON array
- Each template: `{ id, title, message, emoji }`
- CRUD operations: `renderTemplates()`, `saveTemplate()`, `deleteTemplate()`

### History Management
- History entries: `{ id, number, country, template, timestamp, note }`
- Auto-limits to 50 entries
- Resend functionality parses number to detect country

## Deployment
- Serve static files from web server
- No build step required
- PWA works offline after first load
- Download page generates ZIP for distribution

## Common Patterns
- Use `t()` function for translations
- `glass` and `glass-strong` CSS classes for UI elements
- `text-accent` for highlighted text
- `neon-glow` for branded elements
- Event listeners for dynamic interactions

## File Structure
```
LinkFlow/
├── index.html          # Main app (HTML + CSS + JS)
├── manifest.json       # PWA manifest
├── sw.js              # Service worker
├── icon.svg           # App icon
├── download.html      # Download page
├── LICENSE            # Public domain
└── .github/
    └── copilot-instructions.md
```</content>
<parameter name="filePath">/workspaces/LinkFlow/.github/copilot-instructions.md