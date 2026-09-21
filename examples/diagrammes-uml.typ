#import "@preview/electrocentrale:0.1.0": *

#set page(
  paper: "a4",
  flipped: false,
  margin: (x: 2cm, top: 2.2cm, bottom: 2.2cm),
  header: align(right)[
    #text(size: 7.5pt, fill: rgb("#64748B"))[
      ECE Paris — Exemples de diagrammes UML et Call Graphs
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
    Modèles vectoriels natifs prêts à l'emploi pour rapports de TP, projets informatiques et embarqués ECE
  ]
  #v(1.2cm)
]

= 1. Diagramme de Classes UML

Le diagramme de classes permet de modéliser la structure statique d'un logiciel orienté objet. Le composant `#classe-uml` gère automatiquement le partitionnement (en-tête, attributs, méthodes) ainsi que les badges de visibilité standard (`+` public, `-` privé, `#` protégé, `~` package).

#v(8pt)

#figure(
  diagramme-classes(
    classe-uml(
      "Capteur",
      stereotype: "abstract",
      abstrait: true,
      attributs: (
        "# id: int",
        "# i2c_addr: uint8_t",
        "- is_calibrated: bool",
      ),
      methodes: (
        "+ init(): bool",
        "+ read_raw(): uint16_t",
        "# calibrate(): void",
      ),
    ),
    relation-uml(type-rel: "heritage", label: "hérite de", direction: "gauche"),
    classe-uml(
      "BME280",
      attributs: (
        "- oversampling: uint8_t",
        "- standby_time: uint8_t",
      ),
      methodes: (
        "+ init(): bool",
        "+ read_temperature(): float",
        "+ read_pressure(): float",
        "+ read_humidity(): float",
      ),
    ),
  ),
  caption: [Diagramme de classes : spécialisation et polymorphisme de capteurs],
)

#pagebreak()

= 2. Diagramme de Séquence UML

Le diagramme de séquence représente la chronologie des interactions entre composants à travers le temps. Il prend en charge les appels synchrones, les messages asynchrones, les retours et les auto-appels (boucles locales).

#v(8pt)

#figure(
  sequence-uml(
    participants: (
      (nom: "Client Web", tag: "Vue.js"),
      (nom: "API Gateway", tag: "NestJS"),
      (nom: "Service Auth", tag: "Microservice"),
      (nom: "Base de Données", tag: "PostgreSQL"),
    ),
    messages: (
      (de: 1, vers: 2, label: "POST /auth/login {user, pwd}", type: "sync"),
      (de: 2, vers: 3, label: "validateCredentials(user, pwd)", type: "sync"),
      (de: 3, vers: 4, label: "SELECT * FROM users WHERE email=?", type: "sync"),
      (de: 4, vers: 3, label: "UserRecord (hash Argon2)", type: "retour"),
      (de: 3, vers: 3, label: "verifyPasswordHash()", type: "sync"),
      (de: 3, vers: 2, label: "TokenPayload (id, role)", type: "retour"),
      (de: 2, vers: 1, label: "200 OK + JWT Cookie", type: "retour"),
    ),
  ),
  caption: [Diagramme de séquence du flux d'authentification sécurisée],
)

#pagebreak()

= 3. Graphe et Arbre d'Appels Logiques (Call Graph)

Pour l'analyse logicielle et l'embarqué (C / C++ / Rust / CMSIS / RTOS), deux représentations sont disponibles : l'arbre d'appels hiérarchique et le graphe d'appels par couches logicielles.

== A. Arbre d'appels hiérarchique (`#arbre-appels`)

#v(6pt)

#figure(
  arbre-appels(
    noeud-appel("main()", tag: "RESET", enfants: (
      noeud-appel("SystemClock_Config()", tag: "RCC"),
      noeud-appel("MX_GPIO_Init()"),
      noeud-appel("App_MainLoop()", tag: "WHILE(1)", enfants: (
        noeud-appel("BME280_AcquireAll()", enfants: (
          noeud-appel("HAL_I2C_Mem_Read()", tag: "HAL"),
        )),
        noeud-appel("FIR_FilterSample()", sous-titre: "DSP"),
        noeud-appel("LoRa_TransmitPacket()", enfants: (
          noeud-appel("SX1276_WriteFIFO()", tag: "SPI"),
          noeud-appel("SX1276_SetTxMode()", tag: "RF"),
        )),
        noeud-appel("PWR_EnterLowPowerStop()", tag: "SLEEP"),
      )),
    )),
  ),
  caption: [Arbre d'appels hiérarchique du firmware STM32],
)

#v(1em)

== B. Graphe d'appels par couches architecturales (`#call-graph`)

#v(6pt)

#figure(
  call-graph(
    couches: (
      (
        nom: "1. Couche Application & Ordonnancement",
        fonctions: (
          (nom: "main()", tag: "ENTRY"),
          (nom: "App_TaskMeteo()", tag: "RTOS 10 Hz"),
          (nom: "App_TaskRadio()", tag: "RTOS 1 Hz"),
        )
      ),
      (
        nom: "2. Couche Services & Métier (Middleware)",
        fonctions: (
          (nom: "BME280_Driver()", tag: "Driver"),
          (nom: "Payload_Packer()", tag: "Binary"),
          (nom: "LoRaWAN_MAC()", tag: "Protocol"),
        )
      ),
      (
        nom: "3. Couche Abstraction Matérielle (HAL / CMSIS)",
        fonctions: (
          (nom: "HAL_I2C_Transfer()", tag: "I2C1"),
          (nom: "HAL_SPI_Transmit()", tag: "SPI2"),
          (nom: "HAL_RTC_SetAlarm()", tag: "RTC"),
          (nom: "HAL_RTC_SetAlarm()", tag: "RTC"),
        )
      ),
    )
  ),
  caption: [Graphe d'appels inter-couches du système embarqué],
)
