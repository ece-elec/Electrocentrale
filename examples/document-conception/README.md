# Modèle Typst - Document de Conception (ECE Paris)

Modèle Typst bilingue (Français / Anglais) pour la rédaction de documents de conception matérielle et logicielle à l'ECE Paris, conforme au modèle institutionnel officiel.

## 🚀 Utilisation rapide

```bash
# Compiler le document
typst compile document-conception.typ

# Mode live-reload pendant la rédaction
typst watch document-conception.typ
```

## ⚙️ Structure et particularités

- **Page de titre** : Encart `AVANT-PROPOS` (ou `FOREWORD`), attestation d'intégrité spécifique à l'équipe de projet (`"commun à l'équipe de projet"`).
- **Architecture matérielle** : Intégration de `#chaine-blocs(...)` et `#bloc(...)`.
- **Architecture logicielle** : Intégration de `#algorigramme(...)`, `#algo-debut(...)`, `#algo-decision(...)`, etc.
- **Protocoles et preuves de test** : Sections dédiées aux tests unitaires et d'intégration avec critères de réussite.
- **Matrice d'exigences** : Tableau de traçabilité des exigences fonctionnelles.
- **Bibliographie IEEE** : Style IEEE conforme au guide institutionnel avec renvois numérotés.
- **Annexes** : Séparation stricte du code source et des documents volumineux via `#show: annexes`.
