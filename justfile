# Justfile - Command runner pour ece-reports

default:
    @just --list

# Compiler l'ensemble des templates et exemples
compile:
    typst compile template/main.typ /tmp/template.pdf
    typst compile examples/rapport-tp/rapport-tp.typ /tmp/rapport-tp.pdf
    typst compile examples/rapport-projet/rapport-projet.typ /tmp/rapport-projet.pdf
    typst compile examples/document-conception/document-conception.typ /tmp/document-conception.pdf
    typst compile examples/rapport-stage/rapport-stage.typ /tmp/rapport-stage.pdf
    typst compile examples/organigrammes.typ /tmp/organigrammes.pdf
    typst compile examples/diagrammes-uml.typ /tmp/diagrammes-uml.pdf
    @echo "✅ Tous les documents Typst compilent sans erreur."

# Générer les images de prévisualisation et vignettes (PNG)
preview:
    typst compile --pages 1 --ppi 150 examples/rapport-tp/rapport-tp.typ assets/preview-tp.png
    typst compile --pages 1 --ppi 150 examples/rapport-projet/rapport-projet.typ assets/preview-projet.png
    typst compile --pages 1 --ppi 150 examples/document-conception/document-conception.typ assets/preview-conception.png
    typst compile --pages 1 --ppi 150 examples/rapport-stage/rapport-stage.typ assets/preview-stage.png
    typst compile --pages 1 --ppi 150 template/main.typ thumbnail.png
    @echo "✅ Aperçus et vignettes régénérés avec succès dans assets/ et thumbnail.png."

# Surveiller un fichier en mode live-reload
watch file="template/main.typ":
    typst watch {{file}}

# Nettoyer les fichiers de sortie temporaires
clean:
    rm -f /tmp/template.pdf /tmp/rapport-tp-*.pdf /tmp/rapport-projet-*.pdf /tmp/document-conception-*.pdf /tmp/rapport-stage-*.pdf /tmp/organigrammes.pdf /tmp/diagrammes-uml.pdf /tmp/test_*.png


