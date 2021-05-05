---
question: How can I configure a spy to return a rejected promise without triggering an unhandled promise rejection error?
---

Consider this spec:

```
it('might cause an unhandled promise rejection', async function() {
  const foo = jasmine.createSpy('foo')
    .and.returnValue(Promise.reject(new Error('nope')));
  await expectAsync(doSomething(foo)).toBeRejected();
});
```

The spec creates a rejected promise. If everything works correctly, it'll be
handled, ultimately by the async matcher. But if `doSomething` fails to call
`foo` or fails to pass the rejection along, the browser or Node will trigger an
unhandled promise rejection event. Jasmine will treat that as a failure of the
suite or spec that is running at the time of the event.

The fix is to create the rejected promise only when the spy is actually called:

```
it('does not cause an unhandled promise rejection', async function() {
  const foo = jasmine.createSpy('foo')
    .and.callFake(() => Promise.reject(new Error('nope')));
  await expectAsync(doSomething(foo)).toBeRejected();
});
```
