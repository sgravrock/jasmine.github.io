---
question: How can I get Jasmine to fail specs that don't have any assertions?
---

By default, Jasmine doesn't require specs to contain any assertions. You can
enable that behavior by setting the `failSpecWithNoExpectations` option:

* If you're using the standalone distribution, add
  `failSpecWithNoExpectations: true` to the `config` object in 
  `lib/jasmine-<VERSION>/boot.js`.
* If you're using the `jasmine` NPM package, add
  `"failSpecWithNoExpectations": true` to your config file (usually `spec/support/jasmine.json`).
* If you're using a third party tool that wraps jasmine-core, check that tool's
  documentation for how to pass configuration options.
