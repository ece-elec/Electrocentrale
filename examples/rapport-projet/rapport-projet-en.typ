#import "@preview/ece-reports:0.1.0": *

// =============================================================================
// TYPOGRAPHY AND FONT OPTIONS (CUSTOMIZE HERE)
// =============================================================================
// Available presets:
// - "latex"        : Classic LaTeX scientific style (New Computer Modern serif)
// - "typst-modern" : Modern Typst scientific style (Libertinus Serif - clean and elegant)
// - "modern-sans"  : Modern Sans-Serif / Tech style (Helvetica Neue / Arial)
// - "editorial"    : Editorial / Journal style (Charter / PT Serif)
// =============================================================================
#let style-police = "latex" // Change to: "latex" | "typst-modern" | "modern-sans" | "editorial"

#let polices-presets = (
  "latex": "New Computer Modern",
  "typst-modern": "Libertinus Serif",
  "modern-sans": ("Helvetica Neue", "Arial"),
  "editorial": ("Charter", "PT Serif", "Times New Roman"),
)

#show: projet.with(
  lang: "fr",
  title: "Autonomous Embedded Node",
  promo: "ING5",
  major: "Embedded Systems",
  groupe: "Group 02",
  authors: (
    (name: "André-Marie AMPÈRE", email: "ampere@ece.fr", role: "Project Lead & Hardware"),
    (name: "Alessandro VOLTA", email: "volta@ece.fr", role: "Firmware Engineer"),
  ),
  show-roles: true, // Set to false to hide roles/titles under author names
  show-emails: true, // Set to false to hide email links
  supervisor: (name: "Dr. John DOE", email: "john.doe@ece.fr"),
  show-supervisor-email: true, // Set to false to hide supervisor email
  date: auto,  // or date: "October 15, 2026" for a fixed date
  city: "Paris",
  draft: true, // Set to true to enable "DRAFT" watermark
  table-of-figures: false, // Set to true to enable list of figures
  table-of-tables: false, // Set to true to enable list of tables
  // equation-numbering: "(1)",  // Uncomment to number equations
  abstract: [
    What is the context and problem statement of the project? What are the technical objectives?
    In what context are you carrying out this project? [maximum 20 lines]
  ],
  font: polices-presets.at(style-police, default: "New Computer Modern"),
)

= Objectives

What is the objective of this document?

What will the reader find here?

= Glossary

== Terms

Provide the main technical terms and their definitions in table format.

#table(
  columns: (1.5fr, 3.5fr),
  table.header([Term], [Definition]),
  [Sample term], [Precise definition of the term within the project context.],
  [Another term], [Detailed explanation of the function or role of the term.],
)

== Acronyms

Provide the main acronyms, their meanings, and explanations in table format.

#table(
  columns: (1fr, 1.8fr, 2.7fr),
  table.header([Acronym], [Meaning], [Explanation]),
  [ADC], [Analog-to-Digital Converter], [Component that converts an analog signal into a digital signal.],
  [UART], [Universal Asynchronous Receiver-Transmitter], [Asynchronous serial communication protocol.],
)

= Team

== Team Presentation

Who are the team members?

What are their skills and strengths?

== Team Organization

How is the team organized? How is work divided?

== Gantt Chart

How is the allocated project time utilized?

= Context and Problem Statement

== Context

What is the economic or societal context of the project?

How did the technology/invention originate and evolve?

== Problem Statement

What problem does the project solve?

== Technical Specifications

Functional requirements and operational constraints are summarized in @tab:spec :

#figure(
  table(
    columns: (1.2fr, 3fr, 1.5fr, 1.3fr),
    align: (col, row) => if col in (0, 2, 3) { center + horizon } else { left + horizon },
    table.header([Ref.], [Technical Requirement], [Target Value], [Priority]),
    [SPEC-01], [Nominal Supply Voltage], [3.3 V ± 5%], [Critical],
    [SPEC-02], [Average Standby Current], [< 15 µA], [High],
    [SPEC-03], [IMU Sampling Rate], [100 Hz], [Critical],
    [SPEC-04], [Wireless Range], [> 30 m (indoor)], [Medium],
    [SPEC-05], [Battery Autonomy (Li-Po)], [> 72 hours], [High],
  ),
  caption: [System technical specifications and performance requirements],
) <tab:spec>

= Design

== Functional Architecture

What is the functional architecture of the project?

#note[Functions should be infinitive verbs followed by direct objects.]

At this stage, no technical implementation choices are made yet.

== Hardware Architecture

What hardware is used and why? How are the different technical building blocks interconnected?

Analog signal conditioning and power subsystems are designed according to standard electronics literature @horowitz2015art. The main microcontroller and peripherals are configured following the manufacturer reference manual @stm32f401_datasheet. The IoT wireless communication stack follows modern protocols outlined in @al2015internet.

#callout(title: "Hardware Design Guideline", type: "tip")[
  Prefer surface mount components (SMD 0805) and place dedicated testpoints on I2C and SPI traces for logic analyzer troubleshooting.
]

#figure(
  logo-ece(width: 5.5cm),
  caption: [Overall hardware architecture block diagram],
) <fig:archi_en>

=== Bill of Materials (BOM)

The complete component bill is listed in @tab:bom and the microcontroller pin connections in @tab:pinout.

#figure(
  table(
    columns: (1fr, 2.2fr, 2fr, 0.8fr, 2fr),
    align: (col, row) => if col in (0, 3) { center + horizon } else { left + horizon },
    table.header([Ref.], [Part Name], [Value / Package], [Qty], [Description]),
    [U1], [STM32F401RE], [LQFP-64], [1], [Main 84 MHz MCU],
    [U2], [MPU-6050], [QFN-24], [1], [6-axis I2C IMU sensor],
    [C1-C4], [Ceramic Capacitors], [100 nF, 0805], [4], [Power decoupling],
    [R1-R2], [Pull-up Resistors], [4.7 kΩ, 0805], [2], [I2C SDA / SCL lines],
  ),
  caption: [Hardware Bill of Materials (BOM)],
) <tab:bom>

=== Pinout Assignment

#figure(
  table(
    columns: (1.2fr, 1.5fr, 1.3fr, 3fr),
    align: (col, row) => if col in (0, 1, 2) { center + horizon } else { left + horizon },
    table.header([Pin], [Signal], [I/O Mode], [Function]),
    [PA5], [SPI1_SCK], [Output Alternate], [SPI Master Clock],
    [PA7], [SPI1_MOSI], [Output Alternate], [Master Out Slave In],
    [PB6], [I2C1_SCL], [Open Drain], [I2C Sensor Clock],
    [PB7], [I2C1_SDA], [Open Drain], [I2C Bidirectional Data],
  ),
  caption: [Microcontroller pinout and peripheral mapping],
) <tab:pinout>

== Software Architecture

How does the embedded software operate?

#note[Present a flowchart or state machine diagram of your firmware.]

The I2C communication driver implementation is shown in @code:i2c :

#figure(
  ```c
  #include <stdint.h>
  #include <stdbool.h>

  /**
   * @brief Read sensor register over I2C bus.
   */
  int8_t sensor_read_register(uint8_t dev_addr, uint8_t reg_addr, uint8_t *data, uint16_t len) {
      if (data == NULL || len == 0) {
          return -1; // Invalid parameter
      }
      i2c_start();
      if (!i2c_write_byte(dev_addr << 1)) return -2;
      if (!i2c_write_byte(reg_addr))      return -3;
      i2c_restart();
      if (!i2c_write_byte((dev_addr << 1) | 0x01)) return -4;
      for (uint16_t i = 0; i < len; i++) {
          data[i] = i2c_read_byte(i == (len - 1)); // ACK / NACK
      }
      i2c_stop();
      return 0; // Success
  }
  ```,
  caption: [I2C bus sensor read driver],
) <code:i2c>

= Development

Present here how the different blocks of the project were developed (theoretical calculations, technical choices, key fabrication concepts).

== Power Consumption Sizing

The average current consumption $I_("avg")$ over period $T$ with duty-cycle $alpha$ is:

$ I_("avg") = alpha dot I_("active") + (1 - alpha) dot I_("sleep") $ <eq:power_en>

The battery lifespan $T_("autonomy")$ for a capacity $C_("bat")$ (in $"mAh"$) is given by:

$ T_("autonomie") = (C_("bat") dot eta) / I_("avg") $ <eq:autonomy_en>

where $eta = 0.85$ represents the Buck DC/DC regulator efficiency.

The power consumption breakdown across operating modes is summarized in @tab:modes :

#figure(
  table-double-entree(
    headers: ("Module / Mode", "Sleep", "Eco", "Active", "Boost"),
    [MCU (STM32)], [15 µA], [2 mA], [15 mA], [40 mA],
    [IMU Sensor], [5 µA], [100 µA], [3.8 mA], [3.8 mA],
    [RF Link], [1 µA], [Inactive], [18 mA], [25 mA],
    [Estimated Total], [21 µA], [2.1 mA], [36.8 mA], [68.8 mA],
  ),
  caption: [Energy consumption matrix across operational modes],
) <tab:modes>

== Module 2: Signal Conditioning and Analog Filtering

Sensor analog conditioning relies on a low-noise preamplifier stage. The passive $R C$ anti-aliasing low-pass filter is designed with $R_("filter") = 4.7#kohm$ and $C_("filter") = 10#nf$, yielding a theoretical cutoff frequency of:

$ #fcut = 1 / (2 pi R_("filter") C_("filter")) approx 3.39#khz $

The regulated microcontroller power rail provides $V_("dd") = 3.3#vdc$ with a peak-to-peak voltage ripple $V_("ripple") < 20#vpp$.

== Module 3: Wireless Transmission Interface

= Tests and Validation

Show the technical performance of the system and validate the development module by module, then globally (integration).

Each test result should be described as follows:

- what was performed;
- what was expected and success criteria;
- what was obtained;
- conclusion: validation or non-validation of module operation.

=== Test Campaign Summary

The verification matrix summarizes the test results across all modules in @tab:tests :

#figure(
  table(
    columns: (1fr, 2.2fr, 2fr, 2fr, 1.2fr),
    align: (col, row) => if col in (0, 4) { center + horizon } else { left + horizon },
    table.header([Test ID], [Feature], [Expected Criteria], [Measured Result], [Status]),
    [TEST-01], [3.3V Buck Regulator], [$V_("out") in [3.2, 3.4]" V"$], [3.31 V regulated], [*Passed*],
    [TEST-02], [IMU Sensor I2C Link], [ACK response @ 100 kHz], [Frame verified], [*Passed*],
    [TEST-03], [Anti-aliasing Filter], [$f_(-3"dB") approx 3.4" kHz"$], [3.38 kHz (-3 dB)], [*Passed*],
    [TEST-04], [Indoor Radio Range], [Packet error rate < 1% @ 30 m], [0.3% measured], [*Passed*],
  ),
  caption: [Experimental test verification and compliance matrix],
) <tab:tests>

== Module 1
== Module 2
== Module 3

= Conclusion & Review

== Progress Status

Where does the project stand? Have the objectives been met?

What modules remain to be finalized or improved?

== Technical Solution Relevance

What are the technical limitations of the developed solution?

What are future perspectives or improvements?

== Teamwork Review

What did you learn individually? Which skills will you highlight in your next internship interview?

How could the team have organized better? Propose an action plan for the next project.

#pagebreak()
#bibliography("refs.bib", title: "References & Sources")

#show: appendix.with(lang: "en")

= Complete Hardware Schematics

The complete PCB routing and ground plane layout are shown in @fig:pcb :

#figure(
  logo-ece(width: 5cm),
  caption: [Complete PCB routing and ground plane layout],
) <fig:pcb>

= Datasheets and Sensor Specifications

@tab:datasheet summarizes the electrical ratings for the inertial measurement unit:

#figure(
  table(
    columns: (2fr, 2fr, 2fr),
    table.header([Parameter], [Nominal Value], [Tolerance]),
    [Supply voltage], [3.3 V], [± 5 %],
    [Max active current], [40 mA], [± 10 %],
    [Operating temperature], [-40 °C to +85 °C], [Nominal],
  ),
  caption: [Electrical specifications for the inertial measurement unit],
) <tab:datasheet>

Extensive documentation, sensor register maps and raw source code (#attention[no raw code in the main report body]).
