---
layout: post
title:  "Empire Conf Takeaways Day 2"
description: "My notes and takeaways from the second day of Empire Conf 2017"
date:   2017-10-14 00:00:00 -0400
categories: talks conference notes
---

## The rise of HTTP/2

_Daniela Matos de Carvalho_ [@sericaia](https://twitter.com/sericaia/)

- HTTP 0.9 -> 1.0 -> 1.1. Single connection per request to keep-alive.
- Head of Line (HOL) blocking. Requires strict order.
- Introduced HTTP/2, fathered by SPDY.
  - Streams
  - Resource prioritization (implemented even before HTTP/2)
  - Header compression
  - Push
- Try [Wireshark](https://www.wireshark.org/) to inspect network activity!
- To use HTTP/2 with node: Experimental stage 1, behind feature flag `node --expose-http2 index.js`.
- Check out examples at <https://github.com/sericaia/http2-examples-empireconf>.
- "But I use express/hapi!"
  - Not yet ready but soon it will be similar
  - Should be in hapi 17.
- Use Push.
  - In server request handler we can pre push assets to http2 stream.
  - Push css, images, etc.
  - Then these won't be requested by the page later.
- Browsers won't let you use HTTP/2 without a real TLS connection.
  - Test locally without SSL: open chrome with `--ignore-certificate-errors` flag :)
  - But this won't fully work.
  - Use `{credentials: 'include'}` in service worker request handler.


## A Brief History of Prototypes

_Kat Marchan_ [@maybekatz](https://twitter.com/maybekatz/)

- Prototype-Based Object-Oriented Programming: What is it? What is the history? Why did we do this?
  - In class based languages, overriding behavior requires adding a new class.
  - In prototype based languages, you can clone to reuse parent's code. Known as *delegation*.
  - Even JS class syntax papers over prototypes.
- The very beginning: **Director** programming language (1976). The "Actor Model."
  - Used message passing with `ask`, optional asynchronous event loop, delegation based inheritance.
- **Object(Lisp)** (1985).
  - Used for lisp machine UI. Similar to 2017 JS.
  - This is validating to the semantics we
- **Self** (1987).
  - Built on top of class-based Smalltalk language but with prototypes.
  - Ease of use of a dynamic system but speed to match lower level languages.
  - Biggest influence on modern JS.
- **Lambdamoo** (1990).
  - Prototypes for play.
  - Text-based MUD (multi user dungeon) - online multiplayer text based games.
- **Lua**  (1993).
  - Metatables is like objects
  - Small language used for gaming.
- _**JavaScript**_ (1995).
  - Famously put together in 10 days.
  - Most widely used prototype language in the world 🌏.
  - Prototypes were a great fit for the DOM.
- The Future of JS.
  - **More interactive dev**: hope the need for webpack/babel starts to disappear.
  - **Web components** are natural evolution of the platform.
  - **Keep JS easy**: simple easy to learn languages drive adoption. Immediate results are delightful.


## Why Static Typing Matters (or How to Solve All Your Runtime Errors With This One Neat Trick)

_Eli Perkins_ [@_eliperkins](https://twitter.com/_eliperkins/)

- Static typing -> types are known at compile time.
- Dynamic -> type checking at run time.
- Types are discovered by _annotation_ or _inference_.
- In JS: Flow and Typescript. Roughly equivalent tools.
- Avoid whole classes of errors before our programs run.
  - Type mismatches.
  - Unexpected `null`s.
  - Typos.
- Why do we care?
  - Bugs are suprises: static types reduce surprises.
  - Errors at run time: users pay the cost. At compile time: developers pay the cost.
  - In Objective-C this leads to app crashes.
- Swift - strong static typed language that interops with Obj C.
  - At Venmo: introduced static typing slowly, starting at the network layer.
  - Added high confidence in a critical piece of the stack.
- What's next for static typing in JS?
  - Elm
    - Generates JS with no run time exceptions.
    - Understands your API surface, tells you what semver version bump you need.
  - ReasonML
    - Syntax and toolchain for OCaml that compiles to JS.
    - Pattern matching over union types is cool.
- Check out Dan Grossman, Programming Languages course on coursera: <https://www.coursera.org/learn/programming-languages>.


## Bad Performance is the Root of All Evil

_Dave Thompson_ [@limscoder](https://twitter.com/limscoder/)

- Don't optimize before you measure.
- Not measuring performance is the root of all evil .
- RAIL model (or, LIAR model)
  - **L**oad - initial side load - 1000ms.
  - **I**dle - perform background tasks.
  - **A**nimation - javascript, render, paint - 16ms or 60fps for no jank.
  - **R**esponse - delays in interactions - 100ms (should display indicator when > 500ms).
- Use "Performance" tab in chrome dev tools.
- Simple rules to follow:
  - Optimize network.
    - Reduce file size. img `srcset` attribute. Configure cache headers. Use http2. CDN.
    - Sequential code -> parallel code -> lazy code.
  - Optimize interaction response.
    - Make use of _idle time_ `requestIdleCallback` fallback to `requestAnimationFrame`.
  - Long frames.
    - Use "Bottom Up" in devtools to identify slow JS functions.
- Simulate slowness with network and cpu throttling.
- Understand your webpack and babel configs!
- [Lighthouse](https://github.com/GoogleChrome/lighthouse) audit to help identify and fix common problems.
- Slides: <https://github.com/limscoder/react-present>.


## Programming 101: Learn English

_Vanessa Yuen_ [@vanessayuenn](https://twitter.com/vanessayuenn/)

- All popular programming languages are written in English.
- Today to be a programmer you _have to learn English_.
- Hurdles:
  - Memorizing a bunch of words. What if "function" means nothing to you? Reserved words.
  - Coding in a foreign language is basically like coding in emoji <http://www.emojicode.org>
  - Asking questions when you're lost is even harder in a foreign language. Imposter syndrome ++
  - Stack Overflow explicitly states: "Questions written in non-English should be closed"
  - You have to convince people you can communicate. Fluency != communication skills.
  - Half translated, maybe outdated docs.
- How to do better: Make learning accessible regardless of language.
  - Node - 50% learned Node in their non-native language.
  - Good documentation translation is a bridge between all users.
  - Great example: Angular Chinese docs.
  - **Empathy** & patience.
  - Remember your story is not their story.
- We have a responsibility to level out the playing field. Diversity in language benefits all.


## Architecture as Text: Setup AWS Lambda, API Gateway, SNS, and DynamoDB on Easy Mode

_Angelina Fabbro_ [@hopefulcyborg](https://twitter.com/hopefulcyborg/)

- Leveraging new tools in AWS: Lambda, S3, DynamoDB.
- Not a lot of tools for configuration and deployment.
- AWS console / cli is not a great experience. "Kitchen sink UI."
- Serverless == functions as a service. Amazon abstracts the server altogether.
- Many parts needed to do anything meaningful:
  - Route 53 (DNS)
  - API Gateway (routing)
  - Lambda (your code)
  - DynamoDB (optional sessions)
- Existing infrastructure-as-code tools (terraform, serverless, AWS SAM)
  - Describing every resource is verbose and time consuming.
  - Deep proprietary knowledge required.
  - Difficult to read JSON, no comments.
  - Adds cognitive overhead.
- Move to **architecture as text**, plaintext manifest file
  - Minimal `.arc` file.
  - Describes how to provision all of the parts.
  - `npm i @architect/workflows --save`
- Deploys are fast and boring.
- <https://arc.codes>


-D
