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

## 🧩 Packages Typst Universe intégrés (Vitrine pédagogique)

Ce modèle démontre la composabilité de Typst avec l'écosystème :
- [`moustaches`](https://typst.app/universe/package/moustaches) : statistiques pédagogiques francophones, dispersion et boîtes à moustaches (`boxplot`).
- [`sourcecraft`](https://typst.app/universe/package/sourcecraft) : génération automatique de diagrammes de classes UML directement à partir de snippets Java / C#.
- [`lilaq`](https://typst.app/universe/package/lilaq) : cartographies 2D, cartes thermiques (`colormesh`) et barres d'échelle (`colorbar`).
