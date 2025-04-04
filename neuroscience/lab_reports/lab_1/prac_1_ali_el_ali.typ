#set page(margin: 2.5cm)
#set text(font: "New Computer Modern", size: 11pt)
#set heading(numbering: none)

#let counter-q = counter("question")
#let counter-part = counter("part")

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
  Membrane Capacitance Properties - Ali El Ali
])

#v(1cm)

#question-answer(
  [
    Following a change in the amplitude of a current injected to a plain bilayer
    membrane:

    Is the slope of the voltage change directly proportional to the current
    amplitude? Should it be?
  ], [
    Plain bilayer membranes work just like capacitors, following the basic
    equation(reference in Lecture 2, slide 64) $I = C "dV"/"dt"$. When we rearrange
    this to $"dV"/"dt" = I/C$, it becomes clear that the slope of voltage change is
    directly proportional to current amplitude as long as capacitance stays the same
    and that the capacitance remains constant. The equation for calculating the
    capacitor current follows the equation $I = C "dV"/"dt"$(which I later found out
    is called the capacitor I-V relationship). But to calculate the voltage change
    proportionality to the current amplitude, the equation needs to be rearranged to $"dV"/"dt" = I/C$.

    Looking at the top graph, you can see that when I applied different currents
    (1-4 nA) to the membrane, the voltage changes were linear with time. The slopes
    increased proportionally with current - the 2 nA current produced a slope twice
    as steep as the 1 nA current, and so on.

    By plotting the bottom graph, I could see the comparison made with the current
    amplitude against the voltage change. The line through the origin point confirms
    that the voltage change is directly proportional to the current amplitude only
    if the capacitance remains constant. An RC circuit has an analogous mechanism
    with how capacitors and voltages change scale based on the current.
  ], is-part: false,
)

#figure(
  image("./images/membrane_capacitance_demo.png", width: 75%), caption: [Demonstration of voltage changes for different current amplitudes and the
    resulting proportional relationship between current amplitude and voltage slope.],
)

#question-answer(
  [How is the slope of the voltage change related to the capacitance?], [
    From the capacitor I-V relationship(Lecture 2, slide 65) when $I = C "dV"/"dt"$ is
    rearranged to $"dV"/"dt" = I/C$ we are then able to observe that the voltage
    change is inversely proportional to capacitance. So when:

    - capacitance increases, the slope of voltage change decreases
    - capacitance decreases, the slope of voltage change increases
  ], is-part: true,
)

#figure(
  image("./images/capacitance_variation.png", width: 75%), caption: [Voltage change slowing as the capacitance increases],
)

#question-answer(
  [Does the value of the resting potential affect the slope of the voltage ramp in
    response to a current pulse?], [No, the value of the resting potential doesn't affect the slope of the voltage
    ramp in response to a current pulse. The slope is determined by the current
    amplitude and membrane capacitance(Lecture 2, slide 67). The only determinant is
    by the capacitor I-V equation: $"dV"/"dt" = I/C$. Which shows that the rate of
    voltage change will remain the same regardless of the starting voltage. See
    figure 1. ],
)

#figure(
  image("./images/resting_potential.png", width: 75%), caption: [Voltage change depends only on current and capacitance. Not on the initial
    voltage level],
)

#question-answer(
  [If you double or halve the stimulus current amplitude, does the steady-state
    level follow in proportion to these changes? Should it?], [According to Ohm's law(Lecture 2, slide 48) $ V = "IR"$ the voltage across a
  resistor is directly proportional to the current flowing through ti when
  resistance remains constant. So for a membrane with leak channels(Lecture 2,
  slide 29) , the steady state voltage follows that kind of relationship. For
  clarity - $ V = $ the steady state voltage $I = $ the stimulus current amplitude $ R = $ membrane
  resistance. This all lines up with the expectation that if you double the
  stimulus current amplitude, the steady-state voltage will also double with the
  assumption that the membrane resistance stays constant. Just to drive the
  intuition home - if you halve the stimulus current, the steady-state voltage
  will also be halved.

  This is expected by how the leak channels have a linear current-voltage
  relationship. And those leak channels maintain a relatively constant
  conductance. This happens regardless of the membrane potential.

  To answer the final part, yes, the steady-state level should follow in
  proportion to the changes in stimulus current amplitude when dealing with leak
  channels. This is what I learned to be `ohmic` behaviour. ],
)

#question-answer(
  [If you reduce or increase the membrane capacitance, what happens to tau? What
    happens to the steady state level of the voltage?], [tau(the membrane time constant) is affected by membrance capacitance. The
    membrane time constant is defined as $ tau$ = $"RC"$. With $R = $ membrane
    resistance and $C = $ membrane capacitance. This relationship shows that:
    - when membrane capacitance increases, tau increases proportionally
    - when membrane capacitance decreases, tau decreases proportionally
    (Lecture 3a, slide 44) This points to how changes in capacitance directly
    affects how quickly the membrane potential reaches its steady state. But not the
    final voltage level it reaches. Within a membrane with leak channels, doubling
    or halving the current will proportionally change the steady-state voltage
    level. But changing the capacitance won't affect the steady-state value. ],
)

#figure(
  image("./images/capacitance_tau.png", width: 75%), caption: [plot showing that curves all reach the same steady-state level at different
    rates. Higher capacitance is slower(larger tau), while lower capacitance would
    result in faster approaches(higher tau)],
)

#question-answer(
  [At what point in the action potential does the capacitive current cross zero? At
    what point in the action potential the capacitive current is at its peak?], [
    The capactive current crosses zero when the action potential hits its peak. This
    is the moment the rate of change of the voltage is zero. The capactive current
    reaches its peak during the fasted rising phase of the action potential. It hits
    its maximum when the action potential is changing at its most rapid. This is
    that upward tick of the action potential. The amplitude of the current is
    largest during the initial rapid depolarisation - that is a change within the
    cell where there is a shift in electric charge distribution.
  ],
)

#question-answer(
  [What value of $K^+_o$ will cause $"EK"$ to be exactly zero and why?], [The equilibrium potential($"EK"$) will be zero when the extracellular potassium
    concentration $K+o$ equals the intracellular potassium concentration $K+i$. This
    comes from the Nernst equation:
    $ "EK" = ("RT"/"zF") × ln(K^+_o/K^+_i) $

    When the potassium concentrations are identical on both sides of the membrane,
    there is no concentration gradient driving the movement of $K^+$ ions and so no
    electrical potentials is needed to counteract the diffusion forces. ],
)

#question-answer(
  [For the same values of $K^+_o$ and $K^+_i$, will EK be different in a mammal
    than in these simulations?], [The equilibrium potential would be approx. 80.9mV. See working out below: ], is-part: true,
)

#figure(image("images/potassium_ions_working.png", width: 75%))

#question-answer(
  [For the same values of $K^+_o$ and $K^+_i$, will EK be different in a mammal
    than in these simulations?], [Yes, $"EK"$ is different in a mammal compared to room temperature(Lecture 2,
    slide 50). Mammalian body temperates are at 37#sym.degree\C, with the
    coefficient changes from 58mV to roughly 61mV. Applying the same working out as
    above, see the below working: ], is-part: true,
)

#figure(
  image("images/potassium_ion_mammalian.png", width: 75%), caption: [A mammals' equilibrium potential is 85.0mV, which is higher than at room
    temperature(80.1mV)],
)

#figure(image("images/potassium_equilibrium.png", width: 75%))

#let ek = $"EK"$;
#let eko = $K^+_o$;
#let eki = $K^+_i$;
#let ghk = $ "Vm" = ("gK" + "gNa"*"ENa" + "gCI"*"ECI")/ ("gK" + "gNa" + "gCI")$

#question-answer(
  [What determines the "resting potential" and how does it depend on ion
    concentrations?], [Resting membrane potential is determined by the relative conductances of the
    membrane to different ions and their #ek. When a membrane is permeable to
    multiple ions, the resting potential follows the Goldman-Hodgkin-Katz (GHK)
    equation: #ghk

    The ion concentrations affect the resting potential in two ways:
    - directly determining the #ek for each ion
    - changes in ion concentrations can affect the conductances of ion channels

    So if #eko increases, #ek becomes less negative and that shifts teh resting
    potential towards positivity. ],
)

#question-answer(
  [Why is the resting potential so insensitive to the Na concentration when K+ is
    50 times more permeant than Na+?], [ The resting potential is relatively insensitive to sodium concentration changes
    due to a few reasons:
    - When referencing the $"GHK"$ equation's contribution is weighted by its relative
      conductance/permeability.
    - When $K^+$ is 50 times more permeable than $"Na"^+$, the weight of #ek determining $"Vm"$ is
      50 times greater than the weight of $"ENa"$
    - Which points to significant changes in $"Na"^+$ concentrations having minimal
      effect on $"Vm"$ because $"ENa"$ has such a small weight in the equation as a
      whole. The experimental results by Hodgkin and Huxley(Lecture 2 slide 39)
      demonstrated that changing extraceullar $K^+$ concentrations had a significant
      effect on membrane potential, yet $"Na"^+$ concentration has a negligible
      impact. ],
)
