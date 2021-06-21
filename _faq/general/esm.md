---
question: Can Jasmine test code that's in ES modules?
---

<div class="warning">Note: This FAQ deals with a rapidly changing area and
may become out of date. It was last updated in June 2021.</div>

Yes. The exact process depends on how you're using Jasmine:

* If you're using the standalone distribution or any other in-browser setup
  where you control the HTML tags, just use `<script type="module">`.
* If you're using the jasmine NPM package, you can load specs and helpers
  as ES modules by giving them names ending in `.mjs`. Opt-in support for
  loading `.js` files as ES modules is planned for version 3.8.
* jasmine-browser-runner will also load scripts as ES modules 
  if their names end in `.mjs`.
