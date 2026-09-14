#import "@preview/ece-reports:0.1.0": *

// Style de police : "latex" | "typst-modern" | "modern-sans" | "editorial"
#let style-police = "latex"

// Modèle de Document de Conception ECE Paris
#show: conception.with(
  lang: "fr",
  title: "Station Météo Autonome Connectée",
  promo: "ING5",
  major: "Systèmes Embarqués",
  groupe: "Groupe 03",
  authors: (
    (name: "André-Marie AMPÈRE", email: "ampere@ece.fr", role: "Conception matérielle & PCB"),
    (name: "Alessandro VOLTA", email: "volta@ece.fr", role: "Conception logicielle & Firmware"),
  ),
  show-roles: true,
  show-emails: true,
  supervisor: (name: "Dr. Jean DUPONT", email: "jean.dupont@ece.fr"),
  show-supervisor-email: true,
  date: auto,
  city: "Paris",
  draft: false,
  table-of-figures: true,
  table-of-tables: true,
  abstract: [
    Ce projet vise à concevoir et prototyper une station météorologique autonome communicante à très basse consommation énergétique. La station mesure en continu les grandeurs environnementales (température, humidité, pression atmosphérique et vitesse du vent) et transmet ces données via une liaison radioélectrique longue portée (LoRa) vers une passerelle centrale.

    Ce document rassemble l'ensemble des spécifications d'architecture matérielle et logicielle, les protocoles de tests unitaires et d'intégration, ainsi que les preuves de validation expérimentale nécessaires pour reprendre ou faire évoluer le projet.
  ],
  font: font-presets.at(style-police, default: "New Computer Modern"),
)

= Glossaire

== Termes

Le @tab:glossaire-termes définit les notions techniques fondamentales employées tout au long de la conception du système :

#figure(
  table(
    columns: (1.5fr, 3.5fr),
    table.header([Terme], [Définition]),
    [Duty-cycle], [Fraction du temps pendant laquelle un émetteur RF est actif sur une période donnée (limitation légale à 1 % en bande 868 MHz).],
    [Watchdog], [Minuteur matériel réinitialisé périodiquement par le processeur pour forcer un redémarrage en cas de blocage logiciel.],
    [I2C Fast Mode], [Mode de communication synchrone bifilaire cadencé à 400 kHz pour l'acquisition des capteurs.],
    [Deep Sleep], [Mode de veille profonde du microcontrôleur réduisant la consommation électrique sous le seuil de 5 µA.],
  ),
  caption: [Glossaire des termes techniques],
) <tab:glossaire-termes>

== Acronymes

Les abréviations et acronymes normés du projet sont détaillés dans le @tab:glossaire-acronymes :

#figure(
  table(
    columns: (1fr, 1.8fr, 2.7fr),
    table.header([Acronyme], [Signification], [Explication technique]),
    [CAN / ADC], [Convertisseur Analogique-Numérique], [Périphérique échantillonnant les signaux continus sur 12 bits.],
    [SPI], [Serial Peripheral Interface], [Bus série synchrone quatre fils utilisé pour le transceiver LoRa.],
    [LoRa], [Long Range], [Technique de modulation radio à étalement de spectre (CSS).],
    [MPU], [Microprocessor / Microcontroller Unit], [Cœur de traitement du système embarqué.],
    [PCB], [Printed Circuit Board], [Circuit imprimé supportant et reliant les composants.],
  ),
  caption: [Tableau des acronymes],
) <tab:glossaire-acronymes>

= Conception matérielle

== Architecture matérielle

L'architecture matérielle est subdivisée en quatre blocs fonctionnels interconnectés. La @fig:arch-hw illustre le synoptique matériel et la nature des liaisons électriques et protocoles de bus :

#figure(
  chaine-blocs(
    bloc("Capteurs I2C", sous-titre: "BME280 & Vitesse", tag: "3.3 V"),
    fleche-bus("I2C (400 kHz)"),
    bloc("Microcontrôleur", sous-titre: "STM32F401RE @ 84 MHz", tag: "MCU"),
    fleche-bus("SPI (10 MHz)"),
    bloc("Transceiver Radio", sous-titre: "Semtech SX1276", tag: "868 MHz"),
    fleche-bus("RF 50 Ω"),
    bloc("Antenne", sous-titre: "Dipôle 1/4 λ", tag: "+14 dBm"),
  ),
  caption: [Synoptique de l'architecture matérielle globale],
) <fig:arch-hw>

== Module Alimentation et Régulation

Ce module assure la conversion et la régulation d'énergie à partir d'une cellule photovoltaïque et d'une batterie Li-Ion 3,7 V.

=== Schéma

La conversion buck-boost est confiée à un régulateur à découpage à très faible courant de repos ($I_Q < 1 mu upright("A")$) conformément aux préconisations constructeur. Le rail de tension principal est stabilisé à 3,3 V avec un découplage capacitif céramique X7R de 100 nF par circuit intégré.

=== Test unitaire

- *Protocole :* Alimenter le module avec une tension d'entrée variable de 2,8 V à 4,2 V à l'aide d'une alimentation stabilisée de laboratoire.
- *Critères de réussite :* La tension de sortie $V_("out")$ doit demeurer comprise entre 3,25 V et 3,35 V pour une charge nominale de 50 mA, avec une ondulation résiduelle crête à crête inférieure à 20 mV.

=== Preuves de test

Les mesures relevées à l'oscilloscope numérique confirment une régulation effective à $3.31 upright(" V")$ sous 50 mA, avec un ripple maximal mesuré à $14.2 upright(" mV")$. Le rendement global s'établit à 91,4 %. Le fonctionnement du module d'alimentation est donc pleinement validé.

== Module Microcontrôleur et Capteurs

Ce module rassemble le microcontrôleur STM32F401RE et le capteur combiné BME280.

=== Schéma

Le capteur communique via le contrôleur I2C1 (broches PB8/SCL et PB9/SDA). Deux résistances de tirage (_pull-up_) de 4,7 kΩ sont implantées sur les lignes de données conformément aux spécifications du bus.

=== Test unitaire

- *Protocole :* Exécuter une séquence de lecture du registre d'identification (`0xD0`) du capteur par le microcontrôleur.
- *Critères de réussite :* L'identifiant renvoyé doit être strictement égal à `0x60`, et aucune condition d'acquittement négatif (NACK) ne doit être observée.

=== Preuves de test

La capture au moyen d'un analyseur logique confirme la trame d'initialisation : l'envoi de l'adresse `0x76` suivi du registre d'ID génère la réponse attendue `0x60` avec un temps d'acquittement conforme de 1,2 µs. Le module capteurs est ainsi validé unitairement.

= Conception logicielle

== Architecture logicielle

L'architecture logicielle repose sur une machine à états finis cadencée par interruptions temporelles afin d'optimiser l'autonomie sur batterie. Le diagramme de déroulement global de l'application est présenté sur la @fig:algo-global :

#figure(
  algorigramme(
    algo-debut("Reset / Réveil RTC"),
    algo-action("Configuration GPIO, I2C et SPI", sous-titre: "Phase d'amorçage"),
    algo-es("Acquisition capteurs environnementaux", sous-titre: "BME280 & Vitesse du vent"),
    algo-decision("Trame valide", non: "Erreur & Reset I2C"),
    "OUI",
    algo-action("Encodage du payload binaire", sous-titre: "Compression et calcul CRC"),
    algo-es("Émission radio via SX1276", sous-titre: "Modulation LoRa 868 MHz"),
    algo-action("Programmation du timer RTC Wakeup"),
    algo-fin("Entrée en mode Stop / Standby"),
  ),
  caption: [Algorigramme général du logiciel embarqué],
) <fig:algo-global>

== Module Pilote Radio LoRa

Ce module encapsule la couche physique et la gestion du transceiver Semtech SX1276.

=== Algorigramme

L'algorithme de transmission radio initialise les registres de modulation, configure la fréquence centrale à 868,1 MHz, la bande passante à 125 kHz et le facteur d'étalement à SF7. Une fois la charge utile chargée dans le tampon FIFO, la machine d'état attend l'interruption matérielle `DIO0` signalant la fin de transmission (`TxDone`).

=== Test unitaire

- *Protocole :* Émettre en boucle un paquet de test connu (chaîne de 16 octets) vers un récepteur de contrôle relié à un terminal série.
- *Critères de réussite :* 100 % des paquets reçus sans corruption CRC avec un RSSI supérieur à -90 dBm à une distance de 50 mètres.

=== Preuves de test

Sur une série continue de 200 paquets émis, le récepteur a enregistré 200 réceptions valides avec un taux d'erreur binaire (BER) nul et un niveau de réception moyen de -74 dBm. Le module radio satisfait l'intégralité des critères requis.

= Intégration

L'étape d'intégration valide la coopération simultanée de tous les modules matériels et logiciels en conditions représentatives.

== Protocole de test d'intégration

1. Placer le système complet sous alimentation autonome par batterie.
2. Déclencher un cycle continu de 24 heures d'acquisition et de transmission espacé de 60 secondes.
3. Mesurer simultanément la consommation électrique moyenne à la source via un analyseur de puissance.
4. Vérifier l'intégrité de la base de données de réception sur la passerelle.

== Preuves de test d'intégration

Le @tab:resultats-integration récapitule les indicateurs enregistrés lors du banc d'essai d'intégration continue :

#figure(
  table(
    columns: (2.5fr, 1.5fr, 1.5fr, 2fr),
    table.header([Indicateur], [Spécification], [Mesure obtenue], [Conformité]),
    [Consommation en veille], [$< 15 mu upright("A")$], [$7.8 mu upright("A")$], [Conforme (marge +48%)],
    [Pic d'émission LoRa], [$< 120 upright("mA")$], [$98.4 upright("mA")$], [Conforme],
    [Taux de livraison paquets], [$> 98 %$], [$99.65 %$], [Conforme (1 435 / 1 440)],
    [Autonomie estimée], [$> 12 upright(" mois")$], [$15.2 upright(" mois")$], [Conforme],
  ),
  caption: [Bilan des mesures d'intégration sur 24 heures],
) <tab:resultats-integration>

L'ensemble des exigences de couplage matériel-logiciel est validé avec succès.

= État d’avancement

La matrice de couverture des exigences techniques et fonctionnelles est formalisée dans le @tab:matrice-exigences :

#figure(
  table(
    columns: (1fr, 2.5fr, 1.2fr, 2fr),
    table.header([ID], [Exigence fonctionnelle], [Statut], [Module responsable]),
    [EX-01], [Mesure de la température ($-20$ à $+60$ °C)], [Validé], [Matériel / BME280],
    [EX-02], [Mesure de la pression barométrique], [Validé], [Matériel / BME280],
    [EX-03], [Transmission longue portée ($> 500 upright(" m")$)], [Validé], [Logiciel & Radio SX1276],
    [EX-04], [Autonomie sur batterie supérieure à 1 an], [Validé], [Alimentation & Gestion basse conso],
    [EX-05], [Mise à jour du firmware à distance (FOTA)], [En cours], [Bootloader UART / OTA],
  ),
  caption: [Matrice de traçabilité et couverture des exigences],
) <tab:matrice-exigences>

== Modules restants à finaliser

Le cœur fonctionnel du produit est opérationnel. Seul le mécanisme de mise à jour distante du micrologiciel (_Firmware Over-The-Air_, EX-05) demeure au stade de maquettage logiciel et fera l'objet du prochain jalon de développement.

= Bibliographie

Cette section doit contenir tous les documents utilisés et sites internet consultés pour développer le projet. La syntaxe à utiliser (le standard bibliographique IEEE) est détaillée dans le document « Comment rédiger un rapport » @toolbox.

Lorsqu’ils sont référencés dans le corps de texte du rapport, un renvoi numéroté doit apparaître, conformément au standard bibliographique IEEE @ieee-reference-guide.

Pour automatiser ce traitement, vous pouvez vous aider du gestionnaire de ressources bibliographiques Zotero @zotero.

#v(0.8em)
#bibliography("refs.bib", style: "ieee", title: none)

#show: annexes

= Schémas électriques et routage PCB

Le schéma de câblage complet et l'implantation du circuit imprimé double face sont archivés sous les fichiers CAO Altium Designer version 23.

= Extraits de code source

Conformément aux recommandations académiques, les extraits de code source sont exclus du corps principal du document et consignés dans les annexes :

```c
/* Routine de mise en veille RTC et réveil périodique */
void System_Enter_LowPower_Sleep(uint32_t seconds) {
    HAL_RTCEx_SetWakeUpTimer_IT(&hrtc, seconds, RTC_WAKEUPCLOCK_CK_SPRE_16BITS);
    HAL_SuspendTick();
    HAL_PWR_EnterSTOPMode(PWR_LOWPOWERREGULATOR_ON, PWR_STOPENTRY_WFI);
    HAL_ResumeTick();
    SystemClock_Config();
}
```
