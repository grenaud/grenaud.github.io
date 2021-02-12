---
layout: post
title:  "Empire Conf Takeaways Day 1"
description: "My notes and takeaways from the first day of Empire Conf 2017"
date:   2017-10-12 00:00:00 -0400
categories: talks conference notes
---

## Bauhaus in the Browser

_Justin McDowell_ [@revoltpuppy](https://twitter.com/revoltpuppy/)

- Inspired by Bauhaus movement in 1920s Germany.
- Recent browser specs give us the tools to apply the principles of bauhaus on the web.
- Viewport units - `vh`, `vw`, consistent text size and placement for any viewport.
  - Check out [Stop thinking in Pixels by Keith Grant](https://www.youtube.com/watch?v=XanhwddQ-PM).
- Perspective transforms - `perspective` - modify distance from 3D plane.
- Grid - flexible layouts using `grid` - keep proportional with viewport units.
  - Check out [Grid by Example by Rachel Andrew](https://gridbyexample.com/).
- Shapes - `shape-outside` - flow text around arbitrary shapes.
- Blending modes - `mix-blend-mode`, `background-blend-mode`, - blend overlapping layers together.
  - Check out [Practical Blend Modes by Una Kravets](https://vimeo.com/183578252).


## Developing for Localization

_Katie Kurkoski_ [@KatieK2](https://twitter.com/KatieK2/)

<https://katiek2.github.io/localization-links-2017>

- Localized content / dynamic content reveals unexpected edge cases in layout and text changes.
- These are CSS techniques to allow flexible layout to handle different languages and user generated content.
- Different languages take up a different amount of space so don't assume size of text boxes.
  - Spanish and German tend to be longer than English.
  - Japanese and Hebrew tend to be much shorter.
- Don't put copy in images. Cannot be translated by the browser -- use HTML instead.
- Avoid `text-transform` because it changes content in unexpected ways.
  - Uppercase German `SS`, Dutch `IJ`, are handled differently by different browsers.
- Quote marks in different languages `"`, `<<`. Use css pseudo class, e.g. `q:lang(de)`.
- Tricky side padding and width on headlines with unpredictable length.
  - `orphans` and `widows` in CSS to declare minimum number of hanging words.
- Groups of boxes using flexbox and `margin: auto` - vertical alignment is trivial, browser support is great!


## Let's Go on a Data Bender

_Mike Vattuone_ [@mvattuone](https://twitter.com/mvattuone/)

- Databending is the process of manipulating data in unintended ways to achieve unpredictable results.
- Why? "The excitement of witnessing events too momentous for the medium assigned to record them" - Brian Eno.
- Incorrect Editing - editing files with a different format.
- Reinterpretation - converting data using an unintended process.
- Forced Errors - intentionally exploiting bugs to generate unexpected output (MISSINGNO pokemon).
- Use Audacity audio effects on images.
- AudioShop cli tool to script this.
- For realtime, use javascript!
  - Convert image (or video) to audio buffer, apply audio transforms with WebAudio API, use canvas to display.
  - [Tuna.js](https://github.com/Theodeus/tuna) for the audio effects.
  - Demo on github pages (awesome!): [link]
- Experiment and play is the first step to finding the practical applications.
- Be creative and do things differently.


## From Barely Ready to Total Betty: How JS Picked Out My Outfit

_Justin Falcone_ [@modernserf](https://twitter.com/modernserf/)

- Recommendation algorithms are "just" databases.
- Collect -> Focus pattern.
  - Database queries and regex are ways to extract bits of data from large collections.
- It's not "Big Data" but "Big Meaning"
  - Sculpting possibility space - narrow down infinite possibilities.
- Forming outfits comes down to defining relationships between items `article`, `formality`.
  - Graph database fits this system.
- ML approach - training data is all known good outfits - but this probably doesn't exist.
- "Expert Systems" is an alternative approach to this problem.
  - "Rules of Fashion" (abridged)
    - Pants & shoes must coordinate tones
    - Shirts & pants must not be same color
    - All clothes must fit same formality level
- We typically approach these problems in a human, imperative way "if this then that", sequence of steps. Usually turns into nested loops.
- Solve this by encoding meaning in the relationships, the algorithm does not change.
- Declarative approach lets us see the problem all at once.
- "Decentering the algorithm" - data could do so much on our behalf.
  - Example: HTML and CSS.
  - Invert the dependency between meaning and computation.


## Network Not Included

_Carmen Bourlon_ [@carmalou](https://twitter.com/carmalou/)

- Using offline apps to improve accessibility. Network connection is now essential for daily life.
- Inconsistent internet access vs lack of access.
- A lot of people's only consistent internet access is via smartphone.
- How do we address this need
  - Take apps offline:
    - Use Electron
    - Watch for connection with event listeners.
    - Bundle database into the app.
  - Make hybrid mobile apps:
    - Check for network connectivity and make use of local storage.
    - Be mindful of users' mobile data caps and smartphone hard drive space.
  - Downloadable documentation:
    - Use electron for docs, or PDF.
  - At minimum, consider how to handle loss of connection.


## Vue.js in Practice: Hybridizing Objects and Functions

_Betsy Haibel_ [@betsythemuffin](https://twitter.com/betsythemuffin/)

- Patterns useful for managing large Vue.js apps, but will apply to anything else.
- "Reactive Programming" is just like Microsoft Excel.
  - When data changes, fields that observe that data also change.
- Computed properties automatically updates when its dependencies change.
- This is two-way data binding(!).
  - It is not evil.
  - Naïve implementation causes problems with unexpected state changes.
- Needs an observability strategy: `vuex` Vue-style global state management.
- Use partial application to share computed property logic.
- Vuex store is just a dumb Vue instance.
  - Then we can extend the Vue object with our props and computed props.
- We shouldn't feel obligation to purity of technique.
- Vue has opinions, but Vue will get out of your way if you decide on a different approach.


-D
