---
question: How can I use Jasmine on my TypeScript project?
---

There are two common ways to use Jasmine and TypeScript together. The first is
to use `@babel/register` to compile TypeScript files to JavaScript on the fly
as they're imported. See
[Testing a React app with Jasmine NPM](/tutorials/react_with_npm) for an
example. This approach is easy to set up and provides the fastest possible
edit-compile-run tests cycle, at the expense of 
