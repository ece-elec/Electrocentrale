<h1 align="center">⚡ electrocentrale — Modèles Typst (ECE Paris)</h1>

<p align="center">
  <a href="https://typst.app">
    <img alt="Typst logo" src="https://img.shields.io/badge/Typst-%232f90ba.svg?&logo=Typst&logoColor=white" />
  </a>
  <a href="LICENSE">
    <img alt="License: MIT" src="https://img.shields.io/badge/license-MIT-blue.svg" />
  </a>
</p>

<p align="center">
  <img src="https://raw.githubusercontent.com/ece-elec/ece-reports/main/assets/preview-tp.png" width="23.5%" alt="Aperçu Rapport de TP" />
   
  <img src="https://raw.githubusercontent.com/ece-elec/ece-reports/main/assets/preview-projet.png" width="23.5%" alt="Aperçu Rapport de Projet" />
   
  <img src="https://raw.githubusercontent.com/ece-elec/ece-reports/main/assets/preview-conception.png" width="23.5%" alt="Aperçu Document de Conception" />
   
  <img src="https://raw.githubusercontent.com/ece-elec/ece-reports/main/assets/preview-stage.png" width="23.5%" alt="Aperçu Rapport de Stage" />
</p>

**electrocentrale** propose des modèles **Typst** pour la rédaction de **Rapports de Travaux Pratiques (`tp`)**, **Rapports de Projet (`projet`)**, **Documents de Conception (`conception`)** et **Rapports de Stage (`stage`)** à l'**ECE (École Centrale d'Électronique)**.

---

## 🚀 Démarrage rapide

### Option A : Depuis Typst Universe

```bash
# Initialiser un nouveau rapport
typst init @preview/electrocentrale mon-rapport
cd mon-rapport
typst watch main.typ
```

### Option B : Utilisation locale directe

```bash
git clone https://github.com/ece-elec/ece-reports.git
cd ece-reports

# Tester les exemples complets
typst watch examples/rapport-tp/rapport-tp.typ
typst watch examples/rapport-projet/rapport-projet.typ
typst watch examples/document-conception/document-conception.typ
typst watch examples/rapport-stage/rapport-stage.typ
```

---

## Documentation

La documentation détaillée est structurée en plusieurs guides thématiques :

- [**Guide de démarrage pas à pas (Tutoriel)**](docs/tutoriel.md) : installation de Typst (macOS, Windows, Linux), configuration de VS Code avec Tinymist, collaboration sur typst.app et rédaction d'un premier document pas à pas.
- [**Référence des Paramètres de Configuration**](docs/parametres.md) : options communes, modèles `tp`, `projet`, `conception` et `stage`, maître de stage / encadrant (`supervisor`), styles de polices commutables (`font-presets`), auteurs structurés, mode filigrane `draft`.
- [**Utilitaires & Composants d'Ingénierie**](docs/composants.md) : organigrammes vectoriels (`#orga-equipe`, `#orga-entreprise`), chaînes de blocs (`#chaine-blocs`), algorigrammes (`#algorigramme`), diagrammes UML (`#classe-uml`, `#sequence-uml`), graphes d'appels (`#call-graph`), bases de données (`#table-bdd`), diagrammes de Gantt (`#gantt`), questions `#t()` / `#e()`, encarts `#callout`, tableaux au style ECE (`#table`, `#table-double-entree`), et gestionnaire d'annexes `#show: annexes`.
- [**Exemples complets prêts à l'emploi**](examples/) : rapports complets de TP, projets, documents de conception, rapports de stage et galeries de diagrammes.

---

## Fonctionnalités clés

- **Quatre modèles académiques** : Rapport de TP (`tp`), Rapport de Projet complet (`projet`), Document de Conception matériel & logiciel (`conception`) et Rapport de Stage avec fiche d'évaluation entreprise (`stage`).
- **Composants d'ingénierie vectoriels** : Organigrammes hiérarchiques avec liens orthogonaux, synoptiques matériels `#chaine-blocs`, logigrammes et algorigrammes `#algorigramme`, schémas de BDD `#table-bdd` et diagrammes de Gantt `#gantt`.
- **Styles typographiques** : `latex` (Computer Modern), `typst-modern` (Libertinus), `modern-sans` (Helvetica/Arial) et `editorial` (Charter).
- **Suppléments de figures intelligents** : renvois automatiques *Figure*, *Tableau* (`@tab:...`) et *Code* (`@code:...`).

---

## 🤝 Contributions

Les contributions, signalements de bugs et suggestions sont les bienvenus via [Issues](https://github.com/ece-elec/ece-reports/issues) ou [Pull Requests](https://github.com/ece-elec/ece-reports/pulls).

---

## 📄 Licence

- **Code source & gabarits** : sous licence [MIT](LICENSE).
- **Logos & identité visuelle** : propriété exclusive de l'ECE.
