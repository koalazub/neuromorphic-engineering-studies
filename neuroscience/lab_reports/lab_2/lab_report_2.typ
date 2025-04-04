#set page(margin: 2.5cm)
#set text(font: "JetBrains Mono", size: 11pt)
#set heading(numbering: none)
#show figure.caption: set text(size: 8pt)

#let counter-q = counter("question")
#let counter-part = counter("part")
#let time_constant = $tau_m = "r"_m*"c"_m$
#let sodium = $"Na"^+$
#let potassium = $K^+$

#let question-answer(question, answer, is-part: false) = {
  if not is-part {
    counter-q.step()
    counter-part.update(1)
    context(par(strong(counter-q.display() + ". Question: ")))
  } else {
    counter-part.step()
    context(
      par(
        strong(counter-q.display() + counter-part.display("a") + ". Question: "),
      ),
    )
  }
  question
  context(par(strong("Answer:")))
  answer
}

#align(center, text(17pt, weight: "bold")[
  Lab Report 2 - The #sodium Action Potential Tutorial
  Ali El Ali
])

#v(1cm)

#question-answer(
  ["What underlies the depolarizing ramp at the beginning of the action potential?"], [Leveraging the NEURON library to capture the action potential that marks the
  kickoff of the stimulus. The bottom graph shows the depolarisation of the
  current when more and more Na⁺ ions rush into the channels. The stimulus current
  depolarises the membrane to threshold (shifting from -75mV to -55mV), triggering
  the first few voltage-gated sodium channels to open. This kicks off a
  self-reinforcing cycle that begins with just a trickle of *Na⁺* entering the
  neuron membrane, but rapidly picks up pace. Na⁺ opens additional `Na⁺` channels,
  creating a cascading effect. This flood of Na⁺ drives the membrane potential
  towards the sodium equilibrium potential. The image shows a Plain Bilayer
  Membrane model with *Na/K* pump, displaying both the Membrane Voltage (blue
  line) and Stimulus current (green line) over time, demonstrating this process in
  a simplified way.], is-part: false,
)

#figure(
  image("action_potential.svg", width: 90%), caption: [Membrane action potential of items ],
)

#question-answer(
  [Why is *$I_"Na"$* so `kinky` with two phases?], [*$I^"Na"$* is described as `kinky` because of the non-linear behaviour. The
  pattern of staying active during sustained deplolarisation isn't simple. It
  shows a rapid rise followed by an abrupt fall despite the continued depolarising
  stimulus. If you look at the current trace, it forms a 'kinked' shape rather
  than a flat or gradually changing response.

  The properties of the voltage-gated *Na* channels give it the unique
  characteristic, which simulataneously contain the activation and inactiviation
  gates. These operate at different time scaled. You can see the reference via the
  Hodgkin-Huxley model where:

  > #text(
    size: 8pt,
  )[$V arrow.r "m increases" arrow.r "g"_"Na" text(" increases") arrow.r text("more Na current flows in") arrow.r text("more depolarisation") arrow.r "V" text(" rises rapidly toward reversal potential of ") V_"Na" arrow.r "h" text(" starts to decrease") arrow.r "g"_"Na" text(" shrinks") arrow.r "V" text(" falls")$]

  The automatic inactivation immediately after automatic inactivation creates that `kinky` two-phased
  pattern that makes the sodium current distinctive and crucial for action
  potential generation in neurons.

  To finish, the two-phased nature of the *Na* current, being rapid activation
  followed by inactivation, is vital for action potential generation and the
  refractory period. `Kinky` behaviour ensures that action potentials are brief,
  unidirectional events that propagate along neurons.

  ], is-part: false,
)

#figure(
  image("nia_action_potential.png", width: 60%), caption: [Membrane action potential of items ],
)

#question-answer(
  [Does changing either the length or diameter of the patch alter the action
    potential in any respect? Should it?], [Based on what's been discussed in our materials, the changing of these
    dimensions(length, diameter, etc.) doesn't change the form necessarily, but it
    does affect the propagation based on said dimensions. This is shown in a
    experiments and theories.

    Deriving from the Hodgkin-Huxley model, action potential is based on
    Voltage-dependent activation and inactivation of sodium channels, delayed
    activation of potassium channels, relative conductivity of said channels and the
    concentration gradient of ions. This more concretely describes its importance in
    terms of membrane and the channels rather than dimensions.

    Cable theory examines that while dimensions affect signal propagation, they
    don't change the fundamental action potential mechanism. That is:

    The length constant $lambda = sqrt("rm"/"ri")$ determines the potential passive
    spread, but doesn't affect the action potential generation. And the time
    constant $tau_m = "r"_m*"c"_m$ is independent of shape, length or width. For
    example:

    *Diameter changes:* increases along the length constant $lambda infinity sqrt(d)$ which
    allow signals to spread farther before regeneration is required.

    *Axon thickness:* faster conduction velocities because of how length constants
    increases diameter

    *Cable Theory:* shows that propagation velocity is dependent on both the time
    and length constants

    One final mention is the patch clamp experiment. Where changing the patch size
    could affect the magnitude of the recorded currents. Where in this case the
    larger patches would - by its nature - have more channels and so larger
    currents. The capacitance of the membrane, which scales the surface area. And
    finally the input resistance. Which decreases with increasing membrane area.

    In this case the shape, threshold, and timing characteristics of the action
    potential still remain unchanged(in no absolutes) because of these properties
    are determined by individual channels and ion concentrations.

    So while dimensions affect how signals propagate, they don't fundamentally alter
    the action potential waveform or generation mechanism, which is described in the
    Hodkin-Huxley model. With further evidence on the theories and experiments
    mentioned above. ],
)

#figure(
  image("theory_validation.svg", width: 100%), caption: [Runs of experiments and theories to test how signals propagate and how
    dimensions affect action potentials],
)


#question-answer(
  [What happens to the duration of the action potential if you change the
    temperature? Why?], [Temperature affects the kinetics of the channels that allow the movements of
    ions during action potentials. Below is an explainer on what happens based on
    the temperature:

    *Low temp.:*
    - Ion channel kinetics slow down
    - open/close channels take longer
    - action potential is prolonged

    *High temp.:*
    - ion channels become faster
    - activation/inactivations accelerate
    - the action channel is shorter due to rapid channel state transitions

    Temperature affects the time constants of the membrane and rate constants when
    basing it off the Hodgkin-Huxley model equations that dictate the channel state
    transitions. Membrane-time constant being mentioned as the equation: #time_constant

    The magnitude of difference between high and low temperature is quite large. The
    reduction in action potential duration can be up to 20 times when making
    calculations at 30$degree$C or $10degree$C.

    #figure(image("temperature_affects_ap.svg", width: 90%))
  ],
)
#question-answer(
  [Which is more effective at blocking action potentials, a toxin that selectively
    blocks Na+ channels or the anesthetics (investigated above) that block both Na+
    and K+ channels?], [
    TTX is mentioned as a 'highly specific blocker of many(but not all) of the
    voltage-gated #sodium channel subtypes, including the HH #sodium channel.' This
    is a reference to the fugu puffer fish. I'll discuss the mechanism and then
    follow through on the efficacy of blocking action potentials. Abbreviating
    tetrodotoxin as *TTX*.

    Generally speaking, the *HH* model states that much of the change in membrane
    potential during an action potential can be explained by the #sodium current.

    So to look into the effectiveness of when _a) #sodium channels are blocked by TTX_ and _b) the #sodium and #potassium channels are blocked by aesthetics_

    a. initial depolarisation is unable to occur and so without depolarisation, no
    action potential can be generated. No matter how much stimulation is received,
    the membrane will remain at resting potential.

    b. The depolarisation phase is prevented in much the same way as *TTX*. With the
    repolarisation _also_ being compromised. #sodium and #potassium channels being
    blocked also affected the membranes' ability to restore its equilibrium.

    #figure(image("toxins_effect_on_ap.svg", width: 90%))
  ],
)
