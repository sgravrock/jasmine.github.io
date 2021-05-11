---
question: Why is Jasmine written in ES5 with a funny hand-rolled module system? Why not use Babel or TypeScript?
---

Partly because Jasmine is much older than most of those technologies. Webpack
was first released six years after development of Jasmine started. So was
Babel's predecessor 6to5. 
Jasmine
predates all of the standardized JavaScript module systems. Its development
started six years before the first releases of Webpack and Babel's predecessor 
6to5. 

TODO rewrite below here

Jasmine needs to run on browsers that don't support newer JavaScript features.
Currently that means that the compiled code can't rely on a variety of newer
syntax and library features such as arrow functions, `async/`await`, `Promise`,
`Symbol`, `Map`, and `Set`. It also can't include polyfills that add any of
those features. If Jasmine included polyfills, the polyfills could cause specs
for code that depends on the polyfilled features to incorrectly pass when run
on an older browser.

So why doesn't Jasmine use Babel? Three reasons. The first is that Jasmine is
much older than even Babel's predecessor 6to5. Jasmine development started six
years before Babel development, and even Jasmine's last major rewrite predates
Babel. Since then, there hasn't bene an obvious payoff that would justify the
cost of converting Jasmine to use Babel. The other reason is that Jasmine fits
in an odd space that breaks some of the assumptions made by Babel and Webpack:
It's both an application and a library, and even when it's acting as an
application it can't safely modify the JavaScript runtime environment. We've
yet to figure out how to configure Babel and Webpack (or any other bundler) in
a way that guarantees that no polyfills will be introduced. The third reason is
that we hope the problem will go away in the future when we're able to drop
support for Internet Explorer and a couple of very old Safari versions. The
remaining browsers all support a much more modern JavaScript dialect.

TypeScript offers significant advantages over any version of JavaScript. But
the conversion would likely take a great deal of time and effort. It might
happen in the future, but so far there have always been other things to spend
the time on that provide more benefit to users.
