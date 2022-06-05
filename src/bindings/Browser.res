type classList = {
  add: (. string) => unit,
  remove: (. string) => unit,
}

type rec htmlElement = {
  classList: classList,
}

@val external document: htmlElement = "document"

let querySelector = (element: htmlElement, query: string) => {
  let result: Js.nullable<htmlElement> = %raw(`
    function(element, query) {
      return element.querySelector(query);
    }
  `)(element, query)
  
  result -> Js.Nullable.toOption
}

let setInnerText: (htmlElement, string) => unit = %raw(`
  function(element, text) {
    element.innerText = text;
  }
`)

type event = [#click]

let addEventListener: (htmlElement, event, unit => unit) => unit = %raw(`
  function(element, event, cb) {
    element.addEventListener(event, cb);
  }
`)

let appendChild: (htmlElement, htmlElement) => unit = %raw(`
  function(element, child) {
    element.appendChild(child);
  }
`)

let setAttribute: (htmlElement, string, string) => unit = %raw(`
  function(element, attribute, value) {
    element.setAttribute(attribute, value);
  }
`)

let createElement: string => htmlElement = %raw(`
  function(tag) {
    return document.createElement(tag);
  }
`)

let removeElement: htmlElement => unit = %raw(`
  function(element) {
    element.remove();
  }
`)
