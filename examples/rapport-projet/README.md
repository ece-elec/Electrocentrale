# Modèle Typst - Rapport de Projet d'Ingénierie

Modèle Typst bilingue (Français / Anglais) pour la rédaction de rapports de projet à l'ECE Paris.

## 🚀 Utilisation rapide

```bash
# Compiler la version française
typst compile rapport-projet.typ

# Mode live-reload pendant la rédaction
typst watch rapport-projet.typ
```

## ⚙️ Options principales

- **Langue** : `lang: "fr"` ou `lang: "en"`
- **Police** : `#let style-police = "latex"` (`"latex"`, `"typst-modern"`, `"modern-sans"`, `"editorial"`)
- **Table des matières** : `table-of-contents: true`, `toc-depth: 3`
- **Résumé / Abstract** : encart dédié sur la page de titre
- **Utilitaires** : `#table(...)`, `#table-double-entree(...)`, `#nb[...]`, `#attention[...]`, `#todo[...]`
