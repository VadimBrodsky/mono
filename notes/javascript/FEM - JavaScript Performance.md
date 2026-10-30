Link - <https://master.dev/courses/web-performance/>

## Why it matters

- Jakob Nielsen: 0.1 second is about the limit for having the user feel that the system is reacting instantaneously , meaning that no special feedback is necessary except to display the result.
- Jakob Nielsen: 1.0 second is about the limit of the user's flow of thought to stay uninterrupted, even though the user will notice the delay. Normally, no special feedback is necessary during delays of more than 0.1 but less than 1.0 second, but the user does lose the feeling of operating directly on the data.
- Jakob Nielsen: 10 seonds is about the limit for keeping the user's attention focused on the dialogue. For longer delays, users will want to perform other tasks while waiting for the computer to finish, so they should be given feedback indicating when the computer expects to be done. Feedback during the delay is especially important if the response is likely to be highly variable.
- If you want users to feel like your site is faster than your competitors, you need to be 20% faster.
- Our applications are getting bigger.

## Thinking about performance

- Are all of our needs the same?
  - NY Times vs Gmail
  - Initial load vs sustained performance and memory leaks
- There are 3 different kinds of performance
  - **Network** load performance
  - **Parsing** and compilation of JavaScript
  - **Rendering** performance
- RAIL - goals / benchmarks to think about performance by Google
  - **Response** - tap/click to paint in less than 100ms
  - **Animation** - each frame completes in less than 16 ms
  - **Idle** - use idle time to proactively schedule work, comete for work in 50ms chunks.
  - **Load** - satisfy the response goals during full load, get first meaningful paint in 1000 mss
- Its about getting 10% better
- Most screens refresh at 60 fps, which equal to approximately 16 milliseconds between each frame. To maintain smooth animations and avoid janky scrolling or interruptions, new frames need to be rendered within this timeframe. However not all 16 milliseconds are available for application code since the browser and other processes also need time.

## The Importance of Measurement

- Measure, Don't tune for speed until you've measured, and even then don't unless one part of the code overwhelms the rest. - Rob Pike
- Agony metric - how slow the page x how many people visit it
- Do not just blindly applying performance optimizations
- There is a cost to every abstraction - and everything has a trade off.
- What is our performance budget?
- Are we simulating less-than-perfect network conditions.
- Are we testing performance on fancy MacBook Pros or consumer-grade hardware?
- Don't get carried away with measuring, either - its not free.
- Thinking deeply about the architecture and design of your application is better use of your time than micro-benchmarks.
- 3 tiers of performance optimization advice
  - definitely do this
  - maybe do this, but measure before and after
  - Only do this if you find a performance problem that needs solving
- Golden rule of performance:
  - **Doing less stuff takes less time**.
  - **If you can do it later. Do it later**.
  - **Doing stuff twice, is slower than doing it once.**

## JavaScript Performance

- Problem: You literally can't buy faster servers to improve performance of client-side applications.
- Don't get to control the computer on which your code runs on.
- Sometimes parsing and compiling JavaScript is the culprit.
- Performance DevTools
  - Big yellow slug - executing JavaScript
  - Red bars - when CPU is pegged
  - Red triangles - you are doing a bad thing
- JavaScript is a compiled language.
- Most browsers use JIT compilation.
  - There is a compilation step
  - Happens moments before execution
  - Happens on client's machine
  - They are paying the cost and doing the hard work for us.

## Parsing

- The source code is the true intention of the application, but the engine needs to figure out what this means.
- parsing can be slow - as slow as 1MB/s on mobile.
- One way to reduce the parsing time is to have less code to parse.
- Another way is to do as much parsing as you need and as little as you can get away with.
- Parsing happens in 2 phases
  - **Eager** - full parse.
  - **Lazy** - pre-parse, do the minimum now, we'll parse it for real later.
- The basic rules
  - Scan through the top-level scope.
  - Parse all the code you see that's actually doing something.
  - Skip things like function declarations and classes for now.
  - We'll parse them when we need them.
- Parsing can happen twice if we lazy parse then eager parse right away.

```javascript
const a = 1;
const b = 2;
function myFunction() {...} // parsed lazily
myFunction(); // go back and parse again
```

- To eager parse, wrap in in parenthesis
- OptimizeJS attempted to load more stuff eagerly - <https://github.com/nolanlawson/optimize-js>

```javascript
(function add(a, b) {
 return a + b;
});
add(a, b)
```

## ASTs and Initial Execution

- We are gone from a big long string of text to an actual data structure representing our code.
- The baseline compiler takes the AST and starts to execute our code as we wrote it - Ignition in V8.

## The Optimizing Compiler

- TurboFan in V8, has these optimizations
  - Speculative optimization
  - Hidden classes for dynamic lookups
  - Function inlining
- Skip some of the rules of JavaScript if the engine observes that the same operation is being repeated constantly.
- User timing API shows up in the User Timing section of the performance tab in chrome dev tools.
  - in dev mode - React is using this out of the box
- V8 flags to get more insight into the compiler
  - Optimizing
    - `node --trace-opt benchmark.js` add tracing
    - `%OptimizeFunctionOnNextCall(add)` flag in source code with `--allow-natives-syntax` to instruct v8 to optimize a function
  - Deoptimizing
    - `node --trace-deopt benchmark.js` adds tracing for the de-optimizations
    - `node --allow-natives-syntax benchmark.js`
    - `%NeverOptimizeFunction(add)` flag in source code
  - D8 is a tool for debugging V8 - <https://v8.dev/docs/d8>

## Speculative Optimization

- We use an interpreter because optimizing compiler is slow to get started
- Also it needs some information before it knows what it can either optimize or skip all together.
- Interpreter starts gathering feedback about what it sees as the function is used.
- The optimizing compiler optimizes for what its seen. If it sees something new,that becomes problematic.

## Deleting, Feeding Objects

- When adding a third dimension to a function that previously had two dimensions - the code may perform half as fast.
- Setting a property to `undefined` assigns the value undefined to that property but keeps it in the object.
- Using the `delete` operator removes the property from the object. These have different performance implications.
  - Sometimes with TurboFan its still fast if the last property is deleted.
  - Crankshaft would slow down if you deleted any properties from an object.
  - TurboFan is optimized to handle deletion of the last property efficiently, though deleting other properties is still slow.
- Performance degrades noticeably when objects in an array have inconsistent property shapes. Iteration and operations can be 20% slower compares to objects with identical shapes. Even when all objects share a common property that's being accessed.

## Monomorphism, Polymorphism, and Megamorphism

- Monomorphism: always receives the same type of object or data. V8 can highly optimize these functions because it knows exactly what to expect every time the function is called, making them the fastest to execute.
- Polymorphism: V8 has seen a few different types and can optimize for those specific cases using a switch-statement-like approach.
- Megamorphism: V8 has seen too many different types and gives up on optimization, reverting to the normal, unoptimized behaviour.

The more consistent things are the better they are at being optimized. This applies to not just objects. This is because JavaScript does not have a type system, but V8 does have an internal type system to track types and optimize code execution.

## Optimizing Objects

Can use the V8 options `%HaveSameMap(a, b)` to check if the 2 objects are Monomorphic.

When 2 objects follow the same modification path and have the same properties added in the same order, they will have the same map in V8.

## Hidden classes

Dynamic lookup: process where the JavaScript engine must determine if a property exists on an object or its prototype chain by reading through the specification and doing work to figure out where the property is located. This process is relatively slow because the engine doesn't initially know where the property is stored.

Hidden Class is a secret type system that V8 maintains behind the scenes to optimize property access. When V8 accesses a property on an object, it remembers the lookup result and the object's shape. For subsequent accesses on object with the same shape, V8 can skip the lookup process and directly access the property at a known memory offset, making property access much faster.

The order in which properties are added to an object determines its Hidden Class path. Objects that have the same properties added in different order will have different Hidden Classes. V8 can only use cached lookups for objects that followed the same path of property additions, so different orders prevent optimization even if the final set of properties is the same.

When a property is deleted from an object, it transitions to a different Hidden Class. This creates a new path in the Hidden Class chain. Deleting different properties or deleting properties from objects with different starting Hidden Classes will result in a different Hidden Class transitions, potentially preventing optimization.

The lattice describes how V8 tracks and evolves its understanding of value's type. It starts as `None` (never seen), moves to specific types like `SignedSmall`, `Number` or `Strign` when first encountered, and can only move forward. If mixed types are seen then the type becomes `Any` at which point V8 can no longer optimize based on type assumptions.

## Scoping and Prototypes

TurboFan is able to optimize your code in substantial ways if you pass it consistent values.

- Initialize you properties at creation.
- Initialize them in the same order.
- Try not to modify them after the fact.
- Maybe just use TypeScript or Flow so you don't have to worry about these things?

When a class is defined inside of a function, it creates a fresh class with a different prototype chain each time the function runs. This means each object points to a different prototype object, resulting in different maps, whereas classes defined outside maintain the same prototype chain.

Create a function that generates objects rather than manually creating objects literals each time. This ensures objects are created the same way every time, allowing them to share the same map and enabling better optimization by the JavaScript engine.

## Function Inlining

The code you write is sometimes not the code that is being executed. Use the `--trace-turbo-inlining` flag to see v8 inlining traces.

Function inlining is an optimization where the JavaScript engine automatically rewrites code to replace function calls with the actual function body when it detects a function is being called repeatedly. This eliminates the overhead of function lookups and parameter passing.

```shell
node --trace-turbo-inlining benchmark.js
```

## JavaScript Performance Takeaways

- The easiest way to reduce parse, compile and execution times is to ship less code.
- Use the User Timing API to figure out where the biggest amount of hurt is.
- Consider using a type system so that aligns with V8 expectations.

## Web Page Rendering Life Cycle

DOM: tree-like structure that represents a webpage, starting with the document and including elements like the HTML tag, head and body. Its created by parsing the HTML text received from the server into a structured representation of the page.

### The Render Tree

The render tree has a one-to-one mapping with the visible objects on the page.

Created by combining the DOM with the CSS Object Model (CSSOM). It contains only the visible objects on the page with their computed styles, having a one-to-one mapping with visible elements. Unlike the DOM, it excludes non-visible elements like the head tag or elements with `display:none`, but includes pseudo-elements defined in CSS.

- Not hidden object.
- Yes to pseudo elements, `:after`, `:before`

There might be multiple rules that apply to a single element. We need to figure out all out there.

### Style calculation

The browser figures out all of the styles that will be applied to a given element.

- Figuring out which rules apply to which elements.
- Figuring out how what the end result of an element with multiple rules is.

The process the browser looks at all styles and elements to determine which rules apply to each element, and when multiple rules define the same property, which one wins based on the specificity and order. It results in figuring out which rules apply and resolving conflicts between competing rules.

### Styling Elements

Selector Matching: this is the process of figuring out what styles apply to an element.

- The more complicated you get, the longer this takes.
- Class names are super simple.
- Stick to simple class names whenever possible. Consider using BEM.
- Browser read selectors from left to right, the less selectors you use the faster this is going to be.

Calculating Render Styles: selector matching tries to figure out what selectors apply to an element.

- When multiple selectors apply to an element.
- The browser needs to figure out who wins.
- The easiest way to make this faster is not to do it.
- Stick to simple class names whenever possible, consider using BEM.

Style invalidation: it doesn't matter as much in newer browsers.

- Reduce the amount of unused CSS that you are shipping.
- The less styles you have the less there is to check.
- Reduce the number of styles that effect a given element.

### Layout - aka Reflow

Look at the elements and figure out where they go on the page.

Reflows are very expensive in terms of performance, and is one of the main causes of slow DOM scripts, especially on devices with low processing power, such as phones. In many cases, they are equivalent to laying out the entire page again. -- Opera

Whenever the geometry of an element changes, the browser has to reflow the page.

- A reflow is a blocking operation, everything else stops.
- It consumes a decent amount of CPU.
- It will definitely be noticeable by the user if it happens often.

A reflow of an element causes a reflow of its parents and children.

What causes a reflow:

- Resizing a window
- Changing the font
- Content changes
- Adding or removing a stylesheet
- Adding or removing classes
- Adding or removing elements
- Changing orientation
- Calculating size or position
- Changing size or position

Generally, a reflow is followed by a repaint, which is also expensive.

How can you avoid reflows?

- Change classes at the lowest levels of the DOM tree.
- Avoid repeatedly modifying inline styles.
- Trade smoothness for speed if you are doing an animation in JavaScript.
- Avoid table layouts.
- Batch DOM manipulations.
- Debounce window resize events.

When you request the size or position of an element (using `offsetWidth`, `getBoundingClientRect`), the browser must ensure it has the most current layout information to return accurate values. If there are any pending style or DOM changes, the browser is forced to immediately perform reflow to calculate the current geometry before it can answer your query. This is sometimes called a "forced synchronous layout" and can be expensive if done repeatedly in a loop.

### Paint

We know what things should look like and where they should go. Draw some pixel to the screen.

### Composite Layers

You might end up painting on multiple layers, but you will eventually need to combine them.

## JavaScript and the Rendering Pipeline

JavaScript gives you the ability to change all of this after the initial load, which means you might have to do all of the above again.

- Change the class of an object.
- Change the inline styles on an object.
- Add or remove elements from the page.

Render pipeline: JavaScript changes styles -> Style recalculation (computed styles) -> Layout calculation (geometry) -> Paint -> Composite (send to GPU)

The computed styles could have changed, we better recalculate those and rebuild the render tree.

The layout step can be skipped when only visual properties that don't affect the geometry are changed, such as background color or opacity. These changes don't require recalculating the position or size of elements on the page.

## Reflow Solution

Separate reading from writing.

Batch all reads together first, then perform all writes together. Instead of alternating between reading and writing properties. Read all the values you need from the DOM, then make all the style updates. This reduces the number of reflows from many to just one.

```javascript
// bad pattern
boxes.forEach(element => {
  const width = element.offsetWidth; // causes a reflow
  element.style.width = width * 2;   // causes a reflow
})
```

If a garbage collection is appearing in a performance profile indicates that the browser needed to pause execution to reclaim memory, which can negatively impact performance and contribute to frame drops.

## Layout Thrashing

Forced synchronous layout - a set of things that you do to cause the browser to stop what it's dong and calculate style and layout.

Layout Thrashing occurs when JavaScript violently writes, then reads, from the DOM, multiple times causing document reflows. -- Winston Page

```javascript
const height = element.offsetHeight;
```

The browser wants to provide the most up-to-date information. If anything has changed since the last measurement, the browser must recalculate the layout to ensure it gives accurate information about the current state of the DOM, rather than outdated information from the last render.

In a loop with pattern of check-change-check-change, the browser is forced to recalculate style and layout repeatedly on each iteration, which can cause the rendering to blow through the 16 milliseconds frame budget and create significant performance issues.

Batch all DOM reads first to calculate the next position for all elements, then perform all DOM writes to apply the CSS transformations. This approach prevents layout thrashing by avoiding interleaving reads and writes.

## FastDOM

<https://github.com/wilsonpage/fastdom>

Has 2 important methods, `fasstdom.measure` and `fastdom.mutate`, correspond to read and write operations. It collects all measure function calls, then schedules all mutate operations together in a single request animation frame, preventing multiple separate animation frames from being triggered.

When using React, make sure its run in Production mode.

## Painting, Layers and Profiling

Anytime you change something other than `opacity` or a CSS transform you are going to trigger a paint.

Every layout will cause a paint, but not every paint is because of layout change. Changing colours do not cause a reflow.

Paint as much as you need and as little as you can get away with.

### Threads

1. The UI thread: Chrome itself, the tab bar etc
2. The Renderer thread: we usually call this the main thread. This is where all JavaScript, parsing HTML and CSS style calculations, layout and painting happens. There are one of these per tab. CPU intensive.
3. The Compositor Thread: draws bitmaps to the screen via the GPU. GPU intensive.

### The Compositor Thread

- When we paint, we create bitmaps for the elements, put them onto layers, and prepare shaders for animations if necessary.
- After painting the bitmaps are shared with a thread on the GPU to do the actual compositing.
- The GPU process works with OpenGL
- Offloading to the GPU compositor thread is usually a performance benefit.

### Managing Layers

The browser creates layers to offload work to the Compositor Thread, which is less busy than the main thread. This allows elements to be moved or animated without repainting. For example, a sticky header on its own layer can float above the page while the rest of the content slides underneath it, avoiding expensive repaints.

On retina screens, moving elements to their own layer doesn't noticeably affect font smoothing because of the higher pixel density. On non-retina screens, moving elements to their own layer can cause a loss of pixel aliasing, making fonts look less smooth.

Things the compositor thread is really good at:

- Drawing the same bitmaps over and over in different places
- Scaling and rotating bitmaps
- Making bitmaps transparent
- Applying filters
- Mining Bitcoin

Disclaimer: Compositing is kind of a hack (not part of the W3C spec)

Layers are an optimization that the browser does for you under the hood, you don't have a direct control over it. But its possible to suggest things to be on their own layers.

What kind of stuff get its own layer?

- The root object of the page
- Objects that have specific CSS positions
- Objects with CSS transforms
- Objects that have overflows - that can scroll
- compositing reasons - <http://bit.ly/paint-layers>

If an element does not qualify for its own layer, it will be placed on the same layer as the last element that did get its own layer by traversing up to its parent. If no element qualified for a layer, it will join the root object's layer, creating one flat page.

### will-change

You can give the browser hints using the `will-change` property. Used to suggest to the browser than an element should become its own layer. You specify which property you think is going to change, such as `transform`.

Promoting an object to its own layer takes a non-zero amount of time, anticipating changing.

```css
.sidebar {
  will-change: transform;
  transform: translateZ(0); // Old hack, less used today
}
```

Using layers is a trade-off - Managing layers takes a certain amount of work on behalf of the browser. Each layer needs to be kept in the shared memory between the main and composite threads.

```css
.sidebar { transition: transform 0.5s; }
.sidebar:hover { will-change: transform; }
sidebar.open { transform: translate(400px); }
```

The `will-change` property is most useful when an element wasn't on its own layer before but will need to be on one very shortly. For example when a user hovers over an element that will be transform on a click, you can add the `will-change` on hover so the browser promotes it to its own layer before the actual transformation happens, making the transition smoother.

The `will-change` is tricky because while its a CSS property, you will typically access it using JavaScript.

Use CSS for elements that will permanently or semi-permanently need their own layer, such as sidebars or sticky bottom elements. Use JavaScript for elements that only temporarily need their own layer during an animation, then should be returned to normal.

```javascript
// add will-change
element.addEventListener('mouseenter', () => {
  element.style.willChange = 'transform';
});

// cleanup will-change
element.addEventListener('transitionend', () => {
  element.style.willChange = 'auto';
})
```

If it's something that the user is interacting with constantly, add it to the CSS. Otherwise do it with JavaScript.

Clean up after: Remove `will-change` when it's not going to change anymore. If you don't remove the `will-change` after the animation, the element will remain on its own layer indefinitely. This can accumulate many layers over time, which negatively impacts performance and memory usage.

## Latency and Bandwidth

Networks, CPUs and disks all hate you. On the client, you pay for what you send in ways you can't easily see. -- Alex Russell

- Bandwidth: is how much stuff you can fit through the tube per second.
- Latency: is how long it takes to get to the other end of the tube.

### TCP focuses on reliability

- TCP: Transmission Control Protocol
- We keep checking in with the server to make sure that everything is going well.
- Packets are delivered in the correct order.
- Packets are delivered without errors.
- Client acknowledges each packet.
- Unreliable connections are handled well.
- Will not overload the network.
- <https://www.cloudping.info>

TCP starts by sending a small amount of data and then starts sending more and more as we find things are being successful.

This is why things feel so much worse on a slow internet connection.

Pro tip: The initial windows size is 14kb. So if you can get files under 14kb then it means you can get everything through the first window.

## Caching

Caching only affects the "safe" HTTP methods: `GET`, `OPTIONS`, `HEAD`.

Cache-Control headers:

- `no-store`: browser gets a new version every time.
- `no-cache`: can store a copy, but you can't use it without checking with the server.
- `max-age`: not bother if whatever asses it has is less than a certain number of seconds old.
- `s-maxage`: for CDN only, tell the CDN to keep it forever, but don't tell the browser to do it.
- `immutable`

Cache possibilities:

- Cache missing: there is no local copy in the cache.
- Stale: do a conditional `GET`. The browser has a copy but it's old and no longer valid. Go get a new version.
- Valid: We have a thing in cache and its good, don't even bother talking to the server.

### Caching for CDNs

- The CDN respects the `max-age` header just like browsers. But this opens up a new set of issues.
- We want CSS and JavaScript to be cached by the browser.
- We should like the CDN to cache the CDN it serves up. But we don't want the browser to.

### Service Workers

Service Worker installs itself into the browser like an app and intercepts network requests. Instead of the browser asking the internet directly for resources, it asks the Service Work first. This allows programmatic control over network requests and caching behavior using JavaScript.

Cache-control headers are suggestions to the browser that the browser may or may not respect. With a Service Worker, you write JavaScript code that gives complete control over caching behavior, allowing you to explicitly decide what goes in the cache, when to check the cache, and when to fetch from the network.

The 'cache-first-, network-fallback' strategy involves the Service Worker first checking the cache for a requested resource. If the resource is found in the cache, it returns that version. If the resource is not in the cache, the Service Worker then makes a network request to fetch it from the server.

## Lazy Loading

Doing stuff later is a way to not do stuff now. So, it's faster.

Sending less JavaScript to the browsers yields in less code that has to go through the network, less code arrives at the browser, and less code needs to be parsed, all of which results in faster performance.

Users may only need specific features during their session. Lazy-loading allows sending only the code needed for their current task, rather than sending all features upfront, reducing initial load time and parsing costs.

Code splitting reduces the initial bundle size, which means less code travels over the network, less code needs to be parsed by the JavaScript engine, and faster initial load. Additional code can be loaded on-demand as users navigate to features that require it.

Code should be lazy loaded if it's not immediately needed for the initial user interaction. The goal is to get users to an interactive state as quickly as possible, then load additional features on demand when users actually need them.

## HTTP/2

Measure, measure, measure - for asset strategy.

HTTP/2 support multiplexing and allows server to push assets to the client before they are requested.

With HTTP/1, browsers can only open a limited number of connections, around 6-8 at a time, so combining files reduced the number of requests needed. With HTTP/2 multiplexing capability multiple files can be sent concurrently over the same connection making smaller separate files more efficient.
