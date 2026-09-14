# ⚙️ Référence des Paramètres de Configuration

Cette page détaille l'ensemble des paramètres configurables pour les modèles `#tp` (Rapport de TP), `#projet` (Rapport de Projet) et `#conception` (Document de Conception).

> **Interchangeabilité totale** : Tous les paramètres ci-dessous sont **100 % partagés et interchangeables**. Vous pouvez basculer entre `#show: tp.with(...)`, `#show: projet.with(...)` et `#show: conception.with(...)` sans modifier vos options.

---

## 🤝 Paramètres du moteur commun (`tp`, `projet` & `conception`)

| Paramètre | Type | Valeur par défaut | Description |
| :--- | :--- | :--- | :--- |
| `title` | `str` / `content` | `"[Nom du document]"` | Titre principal affiché sur la page de garde et l'en-tête |
| `promo` | `str` | `"ING[X]"` | Promotion / Année (ex: `"ING5"`, `"ING4"`, `"ING3"`) |
| `major` | `str` / `none` | `none` | Nom de la majeure / filière ECE (alias : `majeure`, ex: `"Systèmes Embarqués"`) |
| `groupe` | `str` / `none` | `none` | Numéro ou nom du groupe (ex: `"Groupe 02"`, `"TD 1"`) |
| `authors` | `array` / `str` | `("A. AMPÈRE", ...)` | Auteurs sous forme de liste de chaînes simples ou de dictionnaires `(name, email, role)` |
| `supervisor` | `str` / `dictionary` / `none` | `none` | Nom et email du tuteur (`"Dr. ..."` ou `(name: "...", email: "...")`, alias : `tuteur`, `enseignant`) |
| `date` | `auto` / `str` | `auto` | Date d'édition (`auto` génère la date du jour dynamique via `datetime.today()`) |
| `city` | `str` / `none` | `none` | Campus / Ville (défaut : `"Paris"` en FR, `"City"` en EN) |
| `lang` | `str` | `"fr"` | Langue du document (`"fr"` pour français, `"en"` pour anglais) |
| `abstract` | `content` / `none` | `none` | Résumé / Avant-propos encadré sur la page de garde (max ~20 lignes) |
| `cover-image` | `auto` / `none` / `image` | `auto` (TP) / `none` (Projet, Conception) | Illustration optionnelle sur la page de titre (`elec.png` par défaut en TP) |
| `tp-num` | `str` / `none` | `"[X]"` (TP) / `none` | Numéro de TP (ex: `"1"`). Pris en compte par `tp`, ignoré proprement par `projet` et `conception` |
| `doc-prefix` | `str` / `none` | `none` | Préfixe du type de document (défaut : `"TP"` en FR, `"LAB"` en EN) |
| `attestation` | `auto` / `str` / `content` / `none` | `auto` | Déclaration sur l'honneur (`auto` = texte officiel adapté au document, `none` ou `false` pour masquer) |
| `table-of-contents` | `bool` | `false` (TP) / `true` (Projet & Conception) | Activer ou désactiver la génération de la table des matières |
| `table-of-figures` | `bool` | `false` | Génération automatique de la liste des figures |
| `table-of-tables` | `bool` | `false` | Génération automatique de la liste des tableaux |
| `same-page-figures-tables` | `bool` | `true` | Regrouper la liste des figures et des tableaux sur la même page si les deux sont activées (alias : `group-figures-tables`) |
| `same-page-toc` | `bool` | `false` | Regrouper le sommaire général, la liste des figures et des tableaux sur la même page si court (alias : `group-outlines`) |
| `toc-depth` | `int` | `3` | Profondeur d'imbrication des titres dans le sommaire |
| `numbering-format` | `str` / `auto` | `auto` (TP : I, A, a) / `"1.1"` (Projet & Conception) | Format de numérotation des sections et sous-sections |
| `draft` | `bool` | `false` | Affiche un filigrane diagonal *"BROUILLON"* (FR) ou *"DRAFT"* (EN) |
| `show-roles` | `bool` | `true` | Afficher ou masquer le rôle/titre sous les auteurs (alias : `show-role`) |
| `show-emails` | `bool` | `true` | Afficher ou masquer les liens e-mail sous les auteurs (alias : `show-email`) |
| `show-supervisor-email` | `auto` / `bool` | `auto` | Afficher ou masquer l'adresse e-mail du tuteur/enseignant (`auto` suit `show-emails`) |
| `equation-numbering` | `str` / `none` | `none` | Format de numérotation des équations mathématiques (ex: `"(1)"`) |
| `font` | `str` / `array` | `"New Computer Modern"` | Famille(s) de polices typographiques du document |
| `font-size` | `length` | `11pt` | Taille de la police du corps de texte |
| `logo` | `auto` / `none` / `image` | `auto` | Logo vectoriel ECE officiel en en-tête et page de garde |

---

## 🎨 Styles typographiques et polices (`font-presets`)

Le paquet intègre des styles typographiques prédéfinis accessibles via le dictionnaire `font-presets` :

```typst
#let style-police = "latex" // "latex" | "typst-modern" | "modern-sans" | "editorial"

#show: tp.with(
  font: font-presets.at(style-police, default: "New Computer Modern"),
  ...
)
```

| Preset | Famille de polices | Rendu |
| :--- | :--- | :--- |
| `"latex"` | *New Computer Modern* | Style scientifique LaTeX classique avec sérifs |
| `"typst-modern"` | *Libertinus Serif* | Style moderne, aéré et élégant |
| `"modern-sans"` | *Helvetica Neue / Arial* | Style clean et contemporain sans empattement |
| `"editorial"` | *Charter / PT Serif* | Style revue scientifique / publication |

---

## 👥 Format structuré des auteurs

Le paramètre `authors` accepte soit des chaînes simples, soit des dictionnaires détaillés :

```typst
authors: (
  (
    name: "André-Marie AMPÈRE",
    email: "ampere@ece.fr",
    role: "Chef de projet & Électronique",
  ),
  (
    name: "Alessandro VOLTA",
    email: "volta@ece.fr",
    role: "Développement Embarqué",
  ),
)
```
Les adresses e-mail sont automatiquement rendues sous forme de liens `mailto:` cliquables.

Vous pouvez masquer globalement les rôles ou les e-mails tout en conservant les dictionnaires d'auteurs via les options :
- `show-roles: false` (ou `show-role: false`) pour masquer la ligne du rôle (ex: *"Chef de projet & Électronique"*).
- `show-emails: false` (ou `show-email: false`) pour masquer la ligne d'adresse e-mail.
- Ou individuellement en omettant le champ `role` ou en lui assignant `none`.

---

## 🎓 Tuteur ou enseignant encadrant (`supervisor`)

Le paramètre `supervisor` (avec les alias `tuteur` et `enseignant`) permet de mentionner l'enseignant ou le tuteur industriel sur la page de garde sous la mention *"Sous la direction de : "* (FR) ou *"Supervised by: "* (EN).

Il accepte deux formats :

### 1. Format simple (chaîne de caractères)

```typst
supervisor: "Dr. Jean DUPONT"
// ou
tuteur: "Dr. Jean DUPONT"
```

### 2. Format structuré (dictionnaire avec e-mail)

```typst
supervisor: (
  name: "Dr. Jean DUPONT",
  email: "jean.dupont@ece.fr",
)
```

L'adresse e-mail est automatiquement convertie en lien `mailto:` cliquable.

### Contrôle de l'affichage de l'e-mail du tuteur

Vous pouvez piloter précisément la visibilité de l'e-mail de l'encadrant via `show-supervisor-email` :
- `show-supervisor-email: auto` (défaut) : suit automatiquement la valeur globale de `show-emails`.
- `show-supervisor-email: false` : masque l'e-mail du tuteur même si `show-emails: true`.
- `show-supervisor-email: true` : affiche l'e-mail du tuteur même si les e-mails des étudiants sont masqués.
