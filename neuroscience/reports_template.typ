// report template follows the typical question/answer flow. Be sure to fill in the details appropriately and let the LSP reference how things break.

// Test the doc via typst-compile || typst-live and generate into PDF


// examples of templates:
// # let ek = $"EK"$;
// # let eko = $K^+_o$;
// # let eki = $K^+_i$;
// # let ghk = $ "Vm" = ("gK" + "gNa"*"ENa" + "gCI"*"ECI")/ ("gK" + "gNa" + "gCI")$
// 
#set page(margin: 2.5cm)
#set text(font: "JetBrains Mono", size: 11pt)
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
  <put your name here>
])

#v(1cm)

#question-answer(
  [], [], is-part: false,
)

#figure(
  image("src goes here", width: 75%), caption: [],
)


