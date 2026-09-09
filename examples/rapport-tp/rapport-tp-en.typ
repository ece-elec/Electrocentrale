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

#show: tp.with(
  lang: "en",
  title: "Active Filters and Signal Processing",
  tp_num: "1",
  promo: "ING5",
  major: "Embedded Systems",
  groupe: "Group 02",
  authors: (
    (name: "André-Marie AMPÈRE", email: "ampere@ece.fr"),
    (name: "Alessandro VOLTA", email: "volta@ece.fr"),
  ),
  supervisor: (name: "Dr. John DOE", email: "john.doe@ece.fr"),
  show_emails: true, // Set to false to hide email links
  show_supervisor_email: true, // Set to false to hide supervisor email
  date: auto,  // or date: "October 15, 2026" for a fixed date
  city: "Paris",
  draft: false, // Set to true to enable "DRAFT" watermark
  // equation_numbering: "(1)",  // Uncomment to number equations
  font: polices-presets.at(style-police, default: "New Computer Modern"),
)

= Part 1: Theoretical Analysis and Measurements
== Frequency response of the active low-pass filter

#t(1)[Determine the theoretical transfer function of the first-order active low-pass filter.]

The theoretical transfer function can be written in canonical form:
$ H(j omega) = (V_("out")) / (V_("in")) = - (R_2 / R_1) 1 / (1 + j (omega / omega_0)) $ <eq:transfer_en>

For component values $R_1 = 10#kohm$, $R_2 = 100#kohm$, and $C = 10#nf$, the theoretical $-3"dB"$ cutoff frequency is:
$ #fcut = 1 / (2 pi R_2 C) approx 159.15" Hz" $

The input sinusoidal test signal from the generator has a DC bias $V_("offset") = 0#vdc$ and an amplitude $V_("in") = 1#vpp$ ($approx 0.35#vrms$). The experimental testbench is shown in @fig:setup.

#figure(
  logo-ece(width: 5cm),
  caption: [Experimental circuit setup],
) <fig:setup>

#callout(title: "Experimental Safety Note", type: "warning")[
  Verify the dual rail power supply (+15 V / -15 V) on the operational amplifier before powering up the function generator.
]

#e(1)[Gain measurement and data processing.]

The following Python script automates data acquisition and plots the Bode response:

```python
import numpy as np
import matplotlib.pyplot as plt

# Frequency array (Hz) and theoretical response
freqs = np.logspace(1, 5, 50)
gain = -20 * np.log10(np.sqrt(1 + (freqs / 1000)**2))

plt.semilogx(freqs, gain, label="Measured Response (dB)")
plt.xlabel("Frequency (Hz)")
plt.ylabel("Gain (dB)")
plt.grid(True, which="both")
plt.legend()
```

= Methodology and Guidelines
== Report writing guide

#text(fill: gray)[
  Some reminders and tips:

  For each question:

  + Formulation of the *problem*: what we want to do;
  + Presentation of the *technical solution*: how the conception is made (most of the time, present and comment an algorigram or a wiring diagram);
  + Presentation and description of the *results*: what we obtain;
  + *Validation* of the results and *Answer to the question* (link between 1. and 3.) with a critical point of view.

  #v(0.5em)

  - Always mention references to Figures ("Results of the simulation are presented on Figure 2.1. We can see…").
  - Never put raw code in the report, only in appendix if necessary.
  - A link to a video is not a result nor answer to a question. They won’t be corrected.
  - Read with attention the wordings. If asked to measure something using an oscilloscope, you must not present a screenshot of the serial monitor.
  - Export the report to .PDF format.
]

#show: appendix.with(lang: "en")

= Raw Measurement Data

Oscilloscope captures and raw spectrum analyzer data points.

= Acquisition Source Code

Automated measurement scripts (#attention[no raw code in the main report body]).
