let round = ref(0)

let mainContainer = Browser.document->Browser.querySelector("main")->Belt.Option.getExn
let nextRoundButton = Browser.document->Browser.querySelector("#nextRound")->Belt.Option.getExn

let createNewTile = () => {
  let newNextTile = Browser.createElement("div")

  Browser.setAttribute(newNextTile, "class", "tile newToNext")
  Browser.setInnerText(newNextTile, `„${Data.titles[round.contents]}“`)
  Browser.appendChild(mainContainer, newNextTile)
}

let setNextRound = () => {
  round.contents = round.contents + 1

  let isLastRound = round.contents === Array.length(Data.titles)

  if isLastRound {
    Browser.setAttribute(nextRoundButton, "disabled", "true")
  }

  mainContainer
  ->Browser.querySelector("main > .prevToDelete")
  ->Belt.Option.forEach(Browser.removeElement(_))

  mainContainer
  ->Browser.querySelector("main > .currentToPrev")
  ->Belt.Option.forEach(Browser.setAttribute(_, "class", "tile prevToDelete"))

  mainContainer
  ->Browser.querySelector("main > .nextToCurrent")
  ->Belt.Option.forEach(Browser.setAttribute(_, "class", "tile currentToPrev"))

  mainContainer
  ->Browser.querySelector("main > .newToNext")
  ->Belt.Option.forEach(Browser.setAttribute(_, "class", "tile nextToCurrent"))

  if !isLastRound {
    createNewTile()
  }
}

createNewTile()
nextRoundButton->Browser.addEventListener(#click, setNextRound)
