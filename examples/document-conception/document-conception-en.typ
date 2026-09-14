#import "@preview/ece-reports:0.1.0": *

// Font style : "latex" | "typst-modern" | "modern-sans" | "editorial"
#let style-police = "latex"

// ECE Paris Design Document Template
#show: conception.with(
  lang: "en",
  title: "Autonomous Connected Weather Station",
  promo: "ING5",
  major: "Embedded Systems",
  groupe: "Group 03",
  authors: (
    (name: "André-Marie AMPÈRE", email: "ampere@ece.fr", role: "Hardware & PCB Design"),
    (name: "Alessandro VOLTA", email: "volta@ece.fr", role: "Software & Firmware Engineering"),
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
    This project aims to design and prototype an autonomous, ultra-low-power connected weather station. The station continuously samples environmental metrics (ambient temperature, relative humidity, barometric pressure, and wind speed) and broadcasts packetized frames over a long-range wireless transceiver (LoRa) to a central IoT gateway.

    This document compiles all hardware and software architectural specifications, unit and integration test protocols, and experimental validation evidence necessary to maintain, reproduce, or iterate upon this design.
  ],
  font: font-presets.at(style-police, default: "New Computer Modern"),
)

= Glossary

== Terms

@tab:glossary-terms establishes the fundamental technical terms used throughout the system design:

#figure(
  table(
    columns: (1.5fr, 3.5fr),
    table.header([Term], [Definition]),
    [Duty-cycle], [Fraction of time an RF transmitter is actively radiating over a specific window (1% regulatory limit on 868 MHz ISM band).],
    [Watchdog], [Independent hardware timer reset periodically by software to recover from firmware lockups via hardware reset.],
    [I2C Fast Mode], [Two-wire synchronous bus topology clocked at 400 kHz for sensor polling.],
    [Deep Sleep], [Ultra-low-power CPU mode bringing overall quiescent current draw below 5 µA.],
  ),
  caption: [Glossary of technical terms],
) <tab:glossary-terms>

== Acronyms

Standardized acronyms and initialisms are listed in @tab:glossary-acronyms:

#figure(
  table(
    columns: (1fr, 1.8fr, 2.7fr),
    table.header([Acronym], [Expansion], [Technical explanation]),
    [ADC], [Analog-to-Digital Converter], [Peripheral sampling continuous voltage levels with 12-bit precision.],
    [SPI], [Serial Peripheral Interface], [High-speed 4-wire synchronous serial bus communicating with the LoRa transceiver.],
    [LoRa], [Long Range], [Chirp spread spectrum (CSS) radio modulation technique for IoT.],
    [MCU], [Microcontroller Unit], [Embedded computing core executing application firmware.],
    [PCB], [Printed Circuit Board], [Mechanical substrate providing electrical traces between electronic components.],
  ),
  caption: [Table of acronyms],
) <tab:glossary-acronyms>

= Hardware Design

== Hardware Architecture

The electronic hardware is partitioned into four interconnected functional stages. @fig:arch-hw shows the block diagram along with the corresponding electrical interfaces and communication buses:

#figure(
  chaine-blocs(
    bloc("I2C Sensors", sous-titre: "BME280 & Anemometer", tag: "3.3 V"),
    fleche-bus("I2C (400 kHz)"),
    bloc("Microcontroller", sous-titre: "STM32F401RE @ 84 MHz", tag: "MCU"),
    fleche-bus("SPI (10 MHz)"),
    bloc("RF Transceiver", sous-titre: "Semtech SX1276", tag: "868 MHz"),
    fleche-bus("RF 50 Ω"),
    bloc("Antenna", sous-titre: "Dipole 1/4 λ", tag: "+14 dBm"),
  ),
  caption: [Global hardware system block diagram],
) <fig:arch-hw>

== Power and Regulation Module

This subsystem conditions and regulates harvested energy from a monocrystalline solar cell backed by a 3.7 V Li-Ion rechargeable cell.

=== Schematic

Buck-boost DC-DC conversion is achieved via a dedicated converter exhibiting sub-microamp quiescent current ($I_Q < 1 mu upright("A")$) according to design best practices. The main 3.3 V power rail is decoupled using 100 nF X7R ceramic capacitors close to each integrated circuit supply pin.

=== Unit Test

- *Protocol:* Feed the power stage with an adjustable DC bench supply swept from 2.8 V to 4.2 V.
- *Pass Criteria:* Output rail $V_("out")$ must stay strictly within 3.25 V and 3.35 V under a 50 mA nominal load, with peak-to-peak ripple below 20 mV.

=== Test Evidence

Oscilloscope measurements demonstrate rock-solid regulation at 3.31 V under full load, with maximum recorded ripple of 14.2 mV. Overall power efficiency exceeds 91.4 %, validating module compliance.

== Microcontroller and Sensor Subsystem

This module groups the STM32F401RE microcontroller and the BME280 sensor suite.

=== Schematic

The environmental sensor interfaces through the I2C1 bus (pins PB8/SCL and PB9/SDA). Dual 4.7 kΩ pull-up resistors tie both bus lines to the regulated 3.3 V rail.

=== Unit Test

- *Protocol:* Execute a targeted read sequence targeting the chip ID register (`0xD0`).
- *Pass Criteria:* The returned device ID must be strictly equal to `0x60` with zero NACK conditions.

=== Test Evidence

Logic analyzer captures verify the transaction: polling address `0x76` followed by register offset `0xD0` returns `0x60` with an acknowledgment time of 1.2 µs. The sensor module is successfully validated.

= Software Design

== Software Architecture

The embedded firmware runs an interrupt-driven finite state machine (FSM) optimized for sleep intervals. @fig:algo-global depicts the top-level execution flowchart:

#figure(
  algorigramme(
    algo-debut("Reset / RTC Wakeup"),
    algo-action("Configure GPIO, I2C, SPI", sous-titre: "Boot sequence"),
    algo-es("Sample Environmental Sensors", sous-titre: "BME280 & Wind speed"),
    algo-decision("Valid Frame", non: "Error & I2C Reset"),
    "YES",
    algo-action("Encode Binary Payload", sous-titre: "Packing and CRC computation"),
    algo-es("Transmit Packet via SX1276", sous-titre: "LoRa 868 MHz modulation"),
    algo-action("Arm RTC Wakeup Timer"),
    algo-fin("Enter Stop / Standby Mode"),
  ),
  caption: [Top-level embedded software flowchart],
) <fig:algo-global>

== LoRa Radio Driver Module

This software component abstracts the physical layer and state machine of the Semtech SX1276 transceiver.

=== Flowchart

The driver configures carrier frequency (868.1 MHz), bandwidth (125 kHz), and spreading factor (SF7). Once loaded into the FIFO buffer, the microcontroller enters sleep while awaiting the `DIO0` (`TxDone`) hardware interrupt.

=== Unit Test

- *Protocol:* Repeatedly transmit a standardized 16-byte telemetry payload to a monitoring receiver station.
- *Pass Criteria:* 100% packet delivery without CRC mismatches and RSSI above -90 dBm at 50 meters line-of-sight.

=== Test Evidence

Across 200 consecutive transmissions, the receiver logged 200 valid frames with zero bit errors and an average RSSI of -74 dBm, fully confirming transceiver compliance.

= Integration

System integration verifies concurrent interoperation across all hardware and software modules under realistic environmental conditions.

== Integration Test Protocol

1. Power the assembled prototype entirely from the internal Li-Ion battery.
2. Run a continuous 24-hour acquisition loop on a 60-second broadcast cadence.
3. Concurrently log power consumption using a high-precision current monitor.
4. Verify packet reception integrity at the remote IoT gateway.

== Integration Test Evidence

@tab:integration-results summarizes metrics obtained during the continuous integration benchmark:

#figure(
  table(
    columns: (2.5fr, 1.5fr, 1.5fr, 2fr),
    table.header([Metric], [Target Spec], [Measured Value], [Status]),
    [Sleep Mode Current], [$< 15 mu upright("A")$], [$7.8 mu upright("A")$], [Pass (+48% margin)],
    [LoRa TX Peak Current], [$< 120 upright("mA")$], [$98.4 upright("mA")$], [Pass],
    [Packet Delivery Ratio], [$> 98 %$], [$99.65 %$], [Pass (1,435 / 1,440)],
    [Estimated Battery Life], [$> 12 upright(" months")$], [$15.2 upright(" months")$], [Pass],
  ),
  caption: [24-hour integration bench results],
) <tab:integration-results>

All hardware-software coupling requirements are met.

= Project Status

The engineering requirement traceability matrix is detailed in @tab:req-matrix:

#figure(
  table(
    columns: (1fr, 2.5fr, 1.2fr, 2fr),
    table.header([ID], [Functional Requirement], [Status], [Module Owner]),
    [FR-01], [Temperature sensing ($-20$ to $+60$ °C)], [Verified], [Hardware / BME280],
    [FR-02], [Barometric pressure monitoring], [Verified], [Hardware / BME280],
    [FR-03], [Long-range radio transmission ($> 500 upright(" m")$)], [Verified], [Software & SX1276],
    [FR-04], [Multi-season autonomous battery runtime], [Verified], [Power & Sleep management],
    [FR-05], [Firmware Over-The-Air (FOTA) updates], [In progress], [Bootloader / OTA module],
  ),
  caption: [Requirement traceability matrix],
) <tab:req-matrix>

== Remaining Items

The primary system core is fully operational. Firmware Over-The-Air updates (FR-05) remain in prototyping stage and are scheduled for the next development sprint.

= References

This section lists all documentation, datasheets, and online references consulted during project design. Citation syntax adheres to the IEEE bibliographic standard as outlined in the ECE Report Toolbox @toolbox.

Numbered in-text callouts appear according to the IEEE standard @ieee-reference-guide.

Bibliographic entries were managed and exported using Zotero @zotero.

#v(0.8em)
#bibliography("refs.bib", style: "ieee", title: none)

#show: annexes

= Schematic and PCB Layout

Full schematics and double-sided board layouts are maintained within the Altium Designer version 23 design repository.

= Source Code Listings

As per engineering report standards, detailed source code is excluded from the main body and supplied in the appendices:

```c
/* Low-power RTC wakeup timer configuration */
void System_Enter_LowPower_Sleep(uint32_t seconds) {
    HAL_RTCEx_SetWakeUpTimer_IT(&hrtc, seconds, RTC_WAKEUPCLOCK_CK_SPRE_16BITS);
    HAL_SuspendTick();
    HAL_PWR_EnterSTOPMode(PWR_LOWPOWERREGULATOR_ON, PWR_STOPENTRY_WFI);
    HAL_ResumeTick();
    SystemClock_Config();
}
```
