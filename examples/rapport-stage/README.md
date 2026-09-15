# Modèle Typst - Rapport de Stage (ECE Paris)

Modèle Typst officiel pour la rédaction des rapports de stage à l'ECE (Cycle Ingénieur).

## 🚀 Utilisation rapide

```bash
# Compiler le rapport de stage (inclut automatiquement la fiche d'évaluation)
typst compile rapport-stage.typ

# Mode live-reload pendant la rédaction
typst watch rapport-stage.typ
```

## 📋 Caractéristiques du modèle `stage`

- **Page de garde officielle** : Reproduction fidèle de la couverture ECE (Élève ingénieur, Entreprise d'accueil, Confidentialité avec cases à cocher, Description de la mission, Signature du maître de stage).
- **Fiche d'évaluation entreprise** : Toujours incluse en dernière page avec le barème officiel (Technique /20, Qualités humaines /20, Total /40 ramené sur /20, Observations, Date, Signature maître de stage et Cachet entreprise).
- **Table des matières automatique** : Activée par défaut avec numérotation hiérarchique `1.1`.
- **Styles de police interchangeables** : `"arial"` (recommandé et par défaut pour le stage), `"latex"`, `"typst-modern"`, `"modern-sans"`, `"editorial"`.
