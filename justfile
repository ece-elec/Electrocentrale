# Justfile - Command runner pour ece-reports

default:
    @just --list

# Compiler l'ensemble des templates et exemples
compile:
    typst compile template/main.typ /tmp/template.pdf
    typst compile examples/rapport-tp/rapport-tp-fr.typ /tmp/rapport-tp-fr.pdf
    typst compile examples/rapport-tp/rapport-tp-en.typ /tmp/rapport-tp-en.pdf
    typst compile examples/rapport-projet/rapport-projet-fr.typ /tmp/rapport-projet-fr.pdf
    typst compile examples/rapport-projet/rapport-projet-en.typ /tmp/rapport-projet-en.pdf
    typst compile examples/document-conception/document-conception-fr.typ /tmp/document-conception-fr.pdf
    typst compile examples/document-conception/document-conception-en.typ /tmp/document-conception-en.pdf
    typst compile examples/organigrammes.typ /tmp/organigrammes.pdf
    @echo "✅ Tous les documents Typst compilent sans erreur."

# Générer les images de prévisualisation et vignettes (PNG)
preview:
    typst compile --pages 1 --ppi 150 examples/rapport-tp/rapport-tp-fr.typ assets/preview-tp.png
    typst compile --pages 1 --ppi 150 examples/rapport-projet/rapport-projet-fr.typ assets/preview-projet.png
    typst compile --pages 1 --ppi 150 examples/document-conception/document-conception-fr.typ assets/preview-conception.png
    typst compile --pages 1 --ppi 150 template/main.typ thumbnail.png
    @echo "✅ Aperçus et vignettes régénérés avec succès dans assets/ et thumbnail.png."

# Surveiller un fichier en mode live-reload
watch file="template/main.typ":
    typst watch {{file}}

# Nettoyer les fichiers de sortie temporaires
clean:
    rm -f /tmp/template.pdf /tmp/rapport-tp-*.pdf /tmp/rapport-projet-*.pdf /tmp/document-conception-*.pdf /tmp/organigrammes.pdf /tmp/test_*.png

