# Modèle Typst - Rapport de Travaux Pratiques (TP)

Modèle Typst bilingue (Français / Anglais) pour la rédaction de rapports de TP à l'ECE Paris.

## 🚀 Utilisation rapide

```bash
# Compiler la version française
typst compile rapport-tp.typ

# Mode live-reload pendant la rédaction
typst watch rapport-tp.typ
```

## ⚙️ Options principales

- **Langue** : `lang: "fr"` ou `lang: "en"`
- **Police** : `#let style-police = "latex"` (`"latex"`, `"typst-modern"`, `"modern-sans"`, `"editorial"`)
- **Logo** : SVG vectoriel officiel intégré (`#logo-ece()`)
- **Utilitaires** : `#t(1)[...]`, `#e(1)[...]`, `#nb[...]`, `#attention[...]`, `#todo[...]`, `#callout[...]`
