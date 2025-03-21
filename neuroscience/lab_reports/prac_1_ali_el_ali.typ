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
    context(par(strong(counter-q.display() + counter-part.display("a") + ". Question: ")))
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
    Following a change in the amplitude of a current injected to a plain bilayer membrane:

    Is the slope of the voltage change directly proportional to the current amplitude? Should it be?
  ],
  [
    Plain bilayer membranes work just like capacitors, following the basic equation $I = C "dV"/"dt"$. When we rearrange this to $"dV"/"dt" = I/C$, it becomes clear that the slope of voltage change is directly proportional to current amplitude as long as capacitance stays the same and that the capacitance remains constant.
    The equation for calculating the capacitor current follows the equation $I = C "dV"/"dt"$(which I later found out is called the capacitor I-V relationship). But to calculate the voltage change proportionality to the current amplitude, the equation needs to be rearranged to $"dV"/"dt" = I/C$.

    Looking at the top graph, you can see that when I applied different currents (1-4 nA) to the membrane, the voltage changes were linear with time. The slopes increased proportionally with current - the 2 nA current produced a slope twice as steep as the 1 nA current, and so on.

    By plotting the bottom graph, I could see the comparison made with the current amplitude against the voltage change. The line through the origin point confirms that the voltage change is directly proportional to the current amplitude only if the capacitance remains constant.
    Looking back at the RC circuit, you can kind of map out the similarities with how capacitors and voltage changes scale based on the current being pushed through.
  ],
  is-part: false
)

#figure(
  image("./images/membrane_capacitance_demo.png", width: 75%),
  caption: [Demonstration of voltage changes for different current amplitudes and the resulting proportional relationship between current amplitude and voltage slope.]
)

#question-answer(
  [How is the slope of the voltage change related to the capacitance?],
  [
    From the capacitor I-V relationship when $I = C "dV"/"dt"$ is rearranged to $"dV"/"dt" = I/C$ we are then able to observe that the voltage change is inversely proportional to capacitance. So when:

    - capacitance increases, the slope of voltage change decreases
    - capacitance decreases, the slope of voltage change increases
  ],
  is-part: true
)

#figure(
  image("./images/capacitance_variation.png", width: 75%),
  caption: [Voltage change slowing as the capacitance increases]
)
