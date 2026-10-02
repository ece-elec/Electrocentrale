#import "@preview/electrocentrale:0.2.0": *
#import "@preview/sourcecraft:0.1.0": source-diagram
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge, shapes

#set page(
  paper: "a4",
  flipped: false,
  margin: (x: 2cm, top: 2.2cm, bottom: 2.2cm),
  header: align(right)[
    #text(size: 7.5pt, fill: rgb("#64748B"))[
      ECE Paris — Exemples de diagrammes UML et Architectures Logicielles
    ]
  ],
  footer: align(center)[
    #context text(size: 8pt, fill: rgb("#94A3B8"))[#counter(page).display()]
  ],
)

#set text(
  font: ("Arial", "Helvetica"),
  size: 9pt,
  lang: "fr",
)
#set par(justify: true, leading: 0.65em)

#align(center)[
  #v(0.8cm)
  #text(weight: "bold", size: 18pt, fill: ece)[Diagrammes UML & Architectures Logicielles] \
  #v(4pt)
  #text(size: 11pt, fill: rgb("#475569"))[
    Modèles modernes exploitant les packages Typst Universe (`sourcecraft` et `fletcher`) pour rapports d'ingénierie ECE
  ]
  #v(1.2cm)
]

= 1. Diagramme de Classes UML Automatisé (`sourcecraft`)

Plutôt que de concevoir et maintenir des boîtes UML manuelles souvent désynchronisées de l'implémentation, le package `@preview/sourcecraft:0.1.0` analyse directement le code source orienté objet (Java ou C\#) et produit le diagramme de classes vectoriel avec relations d'héritage et d'implémentation :

#v(8pt)

#figure(
  source-diagram(
    ```java
    public interface ICapteur {
        boolean init();
        int lireValeurBrute();
    }

    public abstract class CapteurPhysique implements ICapteur {
        protected int identifiant;
        protected boolean estCalibre;
        public abstract float acquerirMesure();
    }

    public class BME280 extends CapteurPhysique {
        private int surEchantillonnage;
        private int tempsAttente;
        public boolean init() { return true; }
        public int lireValeurBrute() { return 0; }
        public float acquerirMesure() { return 21.5f; }
        public float lirePression() { return 1013.25f; }
    }

    public class StationMeteo {
        private CapteurPhysique[] capteurs;
        private String versionFirmware;
        public void lancerAcquisition() {}
    }
    ```.text,
    grammar: "java",
  ),
  caption: [Diagramme de classes UML généré automatiquement depuis le code Java (`sourcecraft`)],
) <fig:uml-classes>

#pagebreak()

= 2. Diagramme de Séquence UML (`fletcher`)

Le diagramme de séquence représente la chronologie des interactions entre composants à travers le temps. Il est formalisé simplement avec `@preview/fletcher:0.5.8` :

#v(8pt)

#figure(
  diagram(
    node-stroke: 0.8pt,
    spacing: (22mm, 8mm),
    
    // Lignes de vie verticales des participants
    edge((0, 0), (0, 7), "--", stroke: 0.6pt + rgb("#94A3B8")),
    edge((1, 0), (1, 7), "--", stroke: 0.6pt + rgb("#94A3B8")),
    edge((2, 0), (2, 7), "--", stroke: 0.6pt + rgb("#94A3B8")),
    edge((3, 0), (3, 7), "--", stroke: 0.6pt + rgb("#94A3B8")),

    // Boîtes des participants
    node((0, 0), [Client Web \ #text(8pt)[Vue.js]], shape: shapes.rect, fill: white),
    node((1, 0), [API Gateway \ #text(8pt)[NestJS]], shape: shapes.rect, fill: white),
    node((2, 0), [Service Auth \ #text(8pt)[Microservice]], shape: shapes.rect, fill: white),
    node((3, 0), [Base SQL \ #text(8pt)[PostgreSQL]], shape: shapes.rect, fill: white),
    
    // Messages
    edge((0, 1), (1, 1), "-|>", [POST /auth/login]),
    edge((1, 2), (2, 2), "-|>", [validate(credentials)]),
    edge((2, 3), (3, 3), "-|>", [SELECT \* FROM users]),
    edge((3, 4), (2, 4), "-->", [UserRecord (hash)]),
    edge((2, 5), (1, 5), "-->", [Token JWT]),
    edge((1, 6), (0, 6), "-->", [200 OK + Cookie]),
  ),
  caption: [Diagramme de séquence du flux d'authentification (`fletcher`)],
) <fig:uml-seq>

#pagebreak()

= 3. Graphe et Arbre d'Appels Logiques (`fletcher`)

Pour l'analyse logicielle et le développement de firmware embarqué (C / STM32 / RTOS), les dépendances d'appels et l'architecture par couches sont formalisées par un graphe orienté standard :

== Architecture logicielle par couches

#v(6pt)

#figure(
  diagram(
    node-stroke: 0.8pt,
    spacing: (16mm, 10mm),
    // Couche Point d'entrée
    node((1, 0), [main()], shape: shapes.rect),
    
    // Couche Ordonnancement & Tâches
    node((0, 1), [SystemClock_Config()], shape: shapes.rect),
    node((1, 1), [App_TaskMeteo()], shape: shapes.rect),
    node((2, 1), [App_TaskRadio()], shape: shapes.rect),
    
    // Couche Pilotes périphériques
    node((1, 2), [BME280_Driver], shape: shapes.rect),
    node((2, 2), [SX1276_LoRa], shape: shapes.rect),
    
    // Couche Matériel / HAL
    node((1, 3), [HAL_I2C], shape: shapes.rect),
    node((2, 3), [HAL_SPI], shape: shapes.rect),
    
    // Arborescence d'appels
    edge((1, 0), (0, 1), "-|>"),
    edge((1, 0), (1, 1), "-|>"),
    edge((1, 0), (2, 1), "-|>"),
    edge((1, 1), (1, 2), "-|>"),
    edge((2, 1), (2, 2), "-|>"),
    edge((1, 2), (1, 3), "-|>"),
    edge((2, 2), (2, 3), "-|>"),
  ),
  caption: [Graphe d'appels et architecture en couches du firmware embarqué (`fletcher`)],
) <fig:callgraph>
