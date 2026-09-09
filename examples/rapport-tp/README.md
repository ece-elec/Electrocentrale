# Modèle Typst - Rapport de Travaux Pratiques (TP)

Modèle Typst bilingue (Français / Anglais) pour la rédaction de rapports de TP à l'ECE Paris.

## 🚀 Utilisation rapide

```bash
# Compiler la version française
typst compile rapport-tp-fr.typ

# Compiler la version anglaise
typst compile rapport-tp-en.typ

# Mode live-reload pendant la rédaction
typst watch rapport-tp-fr.typ
```

## ⚙️ Options principales

- **Langue** : `lang: "fr"` ou `lang: "en"`
- **Police** : `#let style-police = "latex"` (`"latex"`, `"typst-modern"`, `"modern-sans"`, `"editorial"`)
- **Logo** : SVG vectoriel officiel intégré (`#logo-ece()`)
- **Utilitaires** : `#t(1)[...]`, `#e(1)[...]`, `#nb[...]`, `#attention[...]`, `#todo[...]`, `#callout[...]`
