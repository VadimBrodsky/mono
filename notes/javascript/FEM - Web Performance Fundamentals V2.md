Link - https://master.dev/courses/web-perf-v2/
# Importance
## Definition
The **speed** and **efficiency** with which a website loads, renders, and responds to interactions from the visitors.

### What does slow feel like?
- Waiting for the page to load
- Elements jump around
- Delays to click response
- Slow images and videos
- Laggy scrolling and animations

## Why Is it important
- User experience
	- How well your website meets or exceeds user expectations
	- for effective communication, some response is needed within **2 seconds of a request**
	- a wait longer than 2 seconds **breaks concentration** and affects productivity
	- User Expectations
		- **Instant** - 0.01 second
		- **Uninterrupted flow** - 1 second
		- **Frustration** - 10 seconds
	- User behaviour
		- 40% of users abandon a site at 3 seconds
		- 75% of users that experience a slow website will not return
- SEO
	- Helping search engines understand and rank your content
	- Search ranking change that incorporates page experience metrics.
	- Signal that combines **Core Web Vitals** with the existing SEO signals
	- You need to be fast to rank well
- Online advertising
	- 65% performance improvement 
		- reduced bounce rate by 20%
		- 200% time on page improvement
	- save money on user acquisition
- Revenue
	- Walmart - 100ms improvement yields 1% incremental revenue
	- Skilled.co - load time correlates to conversion
	- WPOStats - https://wpostats.com
# Measuring
- How do we measure "fast"?
## Waterfall Charts
- Measures time, in seconds or milliseconds
- Like a candle chart
#### Stages
- Queue and connection time
- request initiation
- waiting for server response
- receiving content
- streaming and parsing data
- potential waiting on the main thread
- completion

#### Colors
- HTML Documents - blue
- Stylesheets - Purple
- JavaScript - yellow
- Images - Green
- Font - Teal 
- Fetch / Other - Grey

#### Uses of Waterfall Charts
- trace resource dependencies
- identify bottlenecks
- understand loading sequence
- optimize web performance by examining the timing and other order of resource downloads
## Legacy Metrics
- Load originally meant that the document is ready
- Then in 2010 client-side rendering and single-page applications happened
- No meaningful connection to the user experience with SPAs
- Specifically Google needed new events to measure objective user perception of site experience
### DOMContentLoaded
- the HTML downloaded
- Deferred scripts have executed
- The structure of the page is done
- But images may not be displayed

```javascript
window.addEventListener("DOMContentLoaded", (e) => {
  console.log("DOMContentLoaded at " + e.timeStamp + 'ms');
})
```
### Load
- The HTML and all known resources have been downloaded and rendered
- Except those that are lazy-loaded
- Fires after `DOMContentLoaded`
- The spinner stops
- The document is ready and update and reporting tasks can begin

```javascript
window.addEventListener("load", (e) => {
  console.log("load at " + e.timeStamp + 'ms');
})
```
## Core web vitals
- How fast your site visibly loads?
	- Largest Contentful Paint (LCP)
- How smooth things load?
	- Cumulative Layout Shift (CLS)
- How quickly users can interact?
	- Interaction to Next Paint (INP)
- Search rankings incorporates the Core Web Vital page experience metrics
- These captured on both desktop and mobile
- Google does mobile-first indexing
### Largest Contentful Paint (LCP)
- How fast your site visibly loads the most important element
- Developers can't influence in negative ways
- **Largest by pixels in the body**
	- `<img>`
	- `<video>`
	- `css:background-image`
	- Text Elements
- Rules
	- Opacity > 0
	- Size < 100%
	- Low entropy images < 0.05
		- entropy - number of bits per visible pixel shown, means the data density of the image
- Can decide the LCP through design - the largest thing
- Stops after the first user interaction
- What is a good score to Google
	- Good: LCP < 2.5 seconds
	- Needs improvement: 2.5 sec < LCP < 4.0 sec
	- Poor: LCP > 4.0 sec

To calculate the entropy of all the images on the page:
```javascript
console.table(
	[...document.images].map(img => {
		const entry = performance.getEntriesByName(img.currentSrc)[0];
		const bytes = entry?.encodedBodySize * 8;
		const pixels = img.width * img.height;
		return {
			src: img.currentSrc,
			bytes,
			pixels,
			entropy: bytes / pixels,
		}
	})
)
```
### Cumulative Layout Shift (CLS)
- How smooth and predictably elements load into the page
- Are things moving around? Are things re-organizing?
- Is the page predictable and can be interacted with?
- Google uses the 75th percentile of all CLS scores collected from different users, devices and network conditions
- Layout shift occur within the users current viewport and are affected by user scrolling and interaction.
	- if the content shifts or loads while the user is viewing or scrolling the page, it can generate new CLS scores, potentially impacting the website performance metrics.
- Layout Shift Value
	- **impact fraction** x **Distance Fraction**
		- Impact Fraction = impact size / viewport size
			- percentage of viewport impacted by the shift
		- Distance Fraction = distance moved / viewport size
			- how far elements move across the viewport
	- How much across the viewport things move
	- These happen in x and y directions
	- impact size - every pixel that needs to shift
- Depend on the size of the users viewport
- Cumulative - The sum of all layout shift
	- not including shifts from user actions
	- within 500ms of a user action
	- scrolling is not part of it
- What is a good score to Google
	- Good: CLS < 0.1
	- Needs improvement: 0.1 < CLS < 0.25
	- Poor: CLS > 0.25
### Interaction to Next Paint (INP)
- How long between an interaction and next paint
- How quickly users can interact, is it getting in the way
- Depends on the user interactions, what is the slowest one
- What is an interaction
	- Click
	- Drag
	- Touch
	- Keypress
	- But not Scroll
- input delay - if the browser is doing something else
- An INP event measures the total time from user interaction to the next paint, including input delay, event handler execution, JavaScript processing and rendering of the updated frame
- solution yield on the main thread
	- we can paint sooner
	- we can do less
- every time this happens and takes the worst score
- over 100ms a user would notice the delay and we want to the interactions not-noticeable to the users
- there might not be an interaction on the page if the user bounces and no INP score for that user
- don't know the works until its over
- heavily influenced by device capability
- The INP score is based on the worst interaction during the entire page's lifecycle. However if there are many interactions. (dozens or hundreds), there is a caveat: for approximately every 50 interactions, Google ignores the absolute worst and picks the second worst. This is data noise reduction technique to make their measurements more reliable. 
- Spinners are fine - indicators are a response to interaction
- Beacon API is used to capture this data as the page is being destroyed
- what is a good score to Google
	- Good: INP < 200ms
	- Needs Improvement: 200ms < INP < 500ms
	- Poor: INP > 500ms

### First Input Delay (FID)
- Used to be important 2020-2024
- Was replaced by INP
- Measured the first INP - the delay before the browser could respond to the first user interaction, primarily measuring the blocking time when JavaScript was still running, being compiled and the main thread was busy during initial page load.
- Problems with FID
	- It only emphasized blocking time over processing time and did not capture the performance of multiple interactions throughout a page's lifecycle
	- It did not measure the responsiveness of subsequent interactions after the first one, which could still make the site feel slow
- 
## Reading Flame Charts
- A flame chart is a visual representation that shows the execution of browser tasks over time
- typically measured in milliseconds and microsends
- It sues stacked bars where parent tasks appear above child tasks they invoke, with ehe width of each bar indicating execution time.
- Flame charts are important for understanding JavaScript performance and how the browser's main thread executed tasks like parsing HTML, compiling scrips, running JavaScript, and performing layout and paint operations.
- Colors
	- Browser tasks - gray
	- Parse HTML - blue
	- Layout and paint - purple
	- Evaluate and compile scripts - yellow (passthrough)
	- JavaScript execution - tan (working)
	- Extensions - teal
- The Main Thread - single thread of work
	- The single thread of work the browser has for handling user events, layout, paint and running JavaScript


## More metrics
### Time to First Byte (TTFB)
- How quickly your hosts responds - focusing on server and network performance and is measured from the moment the first byte is received from the server.
- Steps include: navigation start, potential redirects, service worker processing, local cache check, DNS lookup, TCP connection establishment, and then initiating a request to the server.
- Most operational of all metrics - server and network performance.
- Not SEO affecting metric, but affect other metrics like LCP
- What is a good score to Google
	- Good: TTFB < 800ms
	- Needs improvement: 800ms < TTFB < 1800ms
	- Poor: TTFB > 1800ms

### First Contentful Paint (FCP)
- Like FCP but first one
- FCP is the first time the browser window switches from white to showing content, indicating tot he user that their request or link click is loading and something will happen.
- Not a core web vital - does not impact SEO
- What is a good score to Google
	- Good: FCP < 1.8sec
	- Needs ImprovementL 1.8sec < FCP < 3.0sec
	- Poor: FCP > 3.0sec
- After TTFB at around 800ms, you have one second to parse the HTML and render the first content.
- Relationship to LCP
	- FCP always occurs after TTFB, which is always the first metric.
	- FCP typically occurs after DomContentLoaded - but not always especially in client-side rendered architectures.
	- The exact timing depends on the website's structure and resource loading.
	- In some cases FCP and LCP can occur at nearly the same time, particularly on smaller websites.

## Capturing metrics
- All of the metrics are available programatically
### Performance API
- https://developer.mozilla.org/en-US/docs/Web/API/Performance
- `.now()` - high resolution timestamp relative to start of page, since the start of the page in microseconds
- `.timeOrigin` - when did the page start
- `.getEntries()` - get timings for 
	- page navigation
	- resource requests
	- performance events
	- custom events
- `.mark()`
- `.measure()`

```javascript
Date.now // not good enough, up to the millisecond
performance.now() // fractions of a second relative to the start of the page
performance.timeOrigin // get the start of the page
performance.timeOrigin + performance.now() // kinda equivalent to Date.now but in high percision format
```
### PerformanceObserver API
- https://developer.mozilla.org/en-US/docs/Web/API/PerformanceObserver
- Addressed the problem of the disturbance of observed system by the act of observation
- observer performance entries when idle

```javascript
const performanceObserver = new PerfomanceObserver((list, observer) => {
	list.getEntries().forEach(entry => {
		console.log(`Layout shifted by ${entry.value}`);
	})
});

performanceObserver.observe({
	type: 'layout-shift', 
	buffered: true // informed of events before started observing
});
```

### Web-Vitals.js
- A package from Google to help look at web vitals
- Helpful to diagnose the page

```javascript
import { onLCP, onCLS, onINP } from 'web-vitals';

onLCP(console.log);
onCLS(console.log);
onINP(console.log);
```
## Browser support
- Implemented in browser engines
	- Blink, Webkit, Gecko
- Historically Webkit did not support these events

# Tests and Tools
## Testing Methods
- Where do we measure from?
	- Lab data - on the same machine or close to the host
	- Synthetic data - actually uses the network, using robots or services on the internet
	- Field data - reality, metrics from real users
- Sample size
	- Lab data provides a single performance score from a simulated test, while field data provides multiple data points representing the actual performance of real users
- Lab data vs field data
	- lab data is easier to capture, is a diagnostic
	- field data is more accurate, is experience
- Making lab data better
	- Simulation
		- mobile vs desktop
		- network conditions
		- processing power

## Common Tools
- Lighthouse
	- Default lighthouse report is based on your computer
	- Need to simulate real usage
	- Devtools throttling in lighthouse
	- No IMP score - it does not interact on our behalf
- Device Toolbar
	-  Custom size: Small laptop
		- Resolution 1366 x 768, non retina 1 ppi
- Network Panel
	- Network throttling
	-  USA Coffee Shop Wifi - 10mbit/s, 4.0mbit/s, 50ms, 1%, 0, off
- Performance Panel
	- Can use WASD to navigate the timeline
	- Set throttling
		- CPU throttling - 6x
		- Hardware concurrency 10
	- Waterfall chart
		- Provides a comprehensive view of page load performance, showing detailed timings of network requests, resource loading, CSS parsing, JS execution and rendering processes at different granularity levels.
		- Render blocking resources, which are high-priority items that prevent the screen from painting, typically CSS files.
		- Network transactions in milliseconds (10-100ms)
	- Frame chart
		- Usually happens at different time scale as compared to the waterfall chart
		- Need to zoom into very small processing time ranges to show detailed task execution
	- CPU throttling
- Memory tab
	- Not easy to get real memory data from users
	- New API: `measureUserAgentSpecificMemory`
		- https://developer.mozilla.org/en-US/docs/Web/API/Performance/measureUserAgentSpecificMemory
	- Biggest performance issues are not memory leaks in JS, its usually resources, images, layout, netowrk, right order.
- Web vitals extension
	- Logs MCP, LCP, ICP
	- https://developer.chrome.com/blog/web-vitals-extension-merged
	- Logs field data from other users who have visited the website
- Chrome User Experience Report (CRUX)
	- Field data
	- Logged in Chrome users
	- Top 1M public websites
	- Anonymous and public
	- 28 day rolling average
	- Google BigQuery
	- SpeedCheck Tool - https://requestmetrics.com/resources/tools/crux/
	- PageSpeed Insights - https://pagespeed.web.dev
- WebPageTest
	- https://www.webpagetest.org
	- more control for field data as compared to PageSpeed Insights

## Real User Monitoring
- RUM - field data like CrUX from all users of the site
- Collect data from real users on the site is owned
- All users, private sites, private details, realtime, custom dashboards and alerts
- Code or library that is installed
- Enterprise RUM
	- Akamai mPulse
	- Dynatrace
	- AppDynamics
	- DataDog
	- Sentry
- Project RUM
	- Request Metrics
	- SpeedCurve
	- RUMVision
	- Pingdom
	- Raygun
- mPulse agent, other RUM services use
	- https://github.com/akamai/boomerang

## Statistics
- Average problems - can hide important details about data distribution, such as wether most users have good or bad experiences, and can be skewed by outliers or extreme values that do not represent typical user experience.
- Percentiles - a measure that represents the value below which a given percentage of observations fall.
	- p50 is meidan - is the middle value when data points are arranged in order. with 50% of the data falling below that point.
	- we care more about p75,p 95, p99 
	- p75 percentile represents the majority of user expreinces.
	- p95 and p99 represent the worst performance scenarios
	- Google uses the p75
	- helping to understand performance variations without being skewed by extreme outliers
	- we don't use p100 as there is noise in the data, some garbage results
- 



# Setting Goals
- How fast is enough - is a subjective user perception
	- depends on the users
	- how valuable it is
	- perceived performance
	- they remember it slower
	- psychology of waiting
		- people want to start
		- bored waits feel slower
		- anxious waits feel slower
		- unexplained waits feel slower
		- uncertain waits feel slower
		- people will wait for value
	- some products are intentionally slow
		- turbotax
		- people want to wait for value
- Who gets to decide
	- not you
	- user experience
		- follow your business metrics - how it measures success
			- bounce rate
			- session time
			- add-to-cart rate
			- cart abandonment rate
			- conversion rate
		- find correlation between business metrics and performance metrics
	- competitors
		- you need to be 20% faster - for the user to nice the difference between you and your competitor
		- Weber's Law (the 20% rule)
			- 20% difference minimum for people to notice it visually
	- SEO pagerank
		- Need to hit LCP, CLS, INP web vitals metrics to rank higher
		- If the content is comparable
- Understanding users
	- Who are these users?
	- Mobile - 62.03%
	- Desktop - 35.84%
	- Tablets - 2.13%
	- 60 Mbps down, 11 Mbps up, 27 ms latency
	- What devices, OS, browsers, screen sizes, bandwidth, device cost, countries, the users are using.

# Improving Web Performance
- Focus on the easiest fixes for your worst metric from real user data.
- You should not try to do everything.
- Sometimes its fast enough.
- The secret of performance - Do fewer things.

## Improving TTFB
- How quickly your host responds to the request.
- Part of FCP which is part of LCP
- Check your RUM data or CrUX data for your P75 and compare it against Google's targets.
- Tactics
	- Infra changes
	- Compress HTTP Responses - reduce the size of plain text HTML, CSS, JavaScript
		- Gzip and Brotli
		- Request Header `Accept-Encoding: gzip, deflate, br`
		- Response Header `Content-Encoding`
		- Might not be worth it on super small files
		- Brotli is less effective on small file sizes than Gzip
	- Efficient Protocols
		- HTTP/1.1
			- chatty network traffic, request and response
			- a lot of request setup and teardown is happening
		- HTTP/2
			- one TCP connection open, all request data is sent over it
			- request multiplexing
			- lower overhead to make requests
			- requires TLS / HTTPS
		- HTTP/3
			- like HTTP/2 but over QUIC (UDP)
			- everything happens over a single connection
			- requires TLS / HTTPS
		- UDP
			- Does not confirm responses
			- Streaming the data out
			- If part is missing, the client will ask for it again
			- More faulty
		- TCP
			- request and responses are guaranteed
			- responses acknowledge the requests with `ack` on every packet
			- redundant step of communication
			- reduces connection setup and handshake requests to a single request
		- Header
			- `Alt-Svc` - tells that the server can do H3 and what port
	- Host capacity
		- Right-size your host for your workload
		- How much CPU, Memory and Network throughput pressure exists on the host
	- Host proximity
		- Put your hosts close to your users
		- Regional networks, then hops to other regional network
		- Real time network projections - https://wondernetwork.com
		- Its the speed limit
		- CDN - puts the copy of your content in a regional network
		- https://bunny.net
		- `Cdn-Cache` header indicates a HIT or MISS

## Improving FCP
- How fast your site visibly loads something
- Check your RUM or CrUX p75 data and compare it to Google's requirements
- Tactics
	- Remove Sequence Chains
		- Collapse the dependencies
		- CSS and Fonts are Render Blocking - they prevent the page from rendering until complete
		- CSS files that have `@import` of other CSS files
		- CSS `@font-face` rule that loads fonts
		- Ordered by discovery not by dependency
		- Prepackage the assets together using a bundler like Webpack, Rollup, Vite
		- 
	- Preloading Resources
		- Start critical path resources as soon as possible
		- Link Pre-connect - establishes the connection
			- `<link rel="preconnect" href="..." />`
		- Link Pre-load - fetch something earlier than the browser knows about
			- `<link as="font" crossorigin rel="preload" href="..." />`
			- Can preload: style, script, image, font, fetch
			- Font and fetch require `crossorigin` header for CORS headers to work
		- Often its a good idea to host the Google fonts locally and serve them with the rest of the bundle
	- Lazy load Resources
		- remove resources that aren't on the critical path
		- look at the flame chart to see if a script file task is blocking FCP
		- JavaScript is Parser Blocking - it prevents parsing content, rendering and main execution.
		- if JavaScript is not critical it can be `defer`ed
		- Script defer
			- `<script defer src="...">` - downloads lazy, but executes before `DOMContentLoaded`.
			- `<script async src="...">` - downloads lazy, but executes blocking, don't know when. Race condition can happen between CSS and JS. Does not maintain ordering.
		- Defer vs Async
			- Almost never want `async`
			- Multiple deferred scripts will execute in order they appear
		- Script modules
			- `<script src="..." type="module">`
			- Always deferred
		- Script placement
			- It probably doesn't matter anymore
			- used to be a solution before script defer was added
			- forces the order you start fetching scripts instead of letting the browser do it
			- Still listen on `DOMContentLoaded` event on script execution

## Improving LCP
- How fast your site visibly loads the most important element
- Usually a resource, image or video
- 3 Parts of LCP
	- Resource Delay
	- Resource Duration
	- Render Delay
- Can have multiple LCP events, if a bigger element arrives
- Tactics
	- More lazy loading
		- remove resources that aren't on the critical path
		- lazy loading of images and iframes
			- `<img src="..." alt="..." loading="lazy" />`
			- `<iframe src="..." loading="lazy" />`
		- Below the fold images should always be lazy loaded.
		- Above the fold images that are not core content can also be lazy loaded to optimize page performance
		- Prioritize loading of the LCP image first, and lazy load other images that are less critical to the initial page view
	- Eager loading
		- Start critical path resources as soon as possible
		- Link preload
			- `<link rel="preload" as="image" href="..." />`
			- fetchPriority attribute - https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement/fetchPriority
				- `<img src="..." alt="..." fetchPriority="high" />`
	- Optimizing images
		- send as few bytes as possible
		- text compression does not really work on images
		- image format
			- used to be a jpg vs png discussion
			- webp and avif support is good now
			- tools
				- https://tinypng.com
				- https://jakearchibald.github.io/svgomg/
				- https://github.com/jimp-dev/jimp
		- responsive images
			- same class of image can be rendered at different sizes
			- serving different image sizes based on device screen size and pixel density which helps reduce unnecessary data transfer and improves performance across different devices
			- The `source` element allows you to specify different images based on media queries like screen width. You can use `srcset` attribute to define rules for which image to load at different viewport sizes, and the browser will automatically choose the most appropriate image based on the available space.
			- Using the `picture` and `source` tags

```html
<picture>
  <source media="(max-width: 720px)" srcset="..." />
  <source media="(min-width: 721px)" srcset="..." />
  <img src="..." alt="..." fetchPolicy="high" />
</picture>
```

## Improving Returning Experience
- Server caching - implemented with a CDN
- Browser Response Caching
	- caching headers
		- `ETag`
		- `Last-Modified`
		- `Cache-Control`
		- `Expires`

## Improving CLS
- How smooth and predictably elements load into the page
- By optimizing LCP causes CLS issues
- Tactic: Layout Size Hints
	- specifying height and width of the image, how big the image is
	- its about the aspect ratio
	- No px in the units
	- `<img src="..." alt=".." width="500" height="500" />`
- Late rendered content size
	- Promo banner for example
	- This is a style decision
	- Can set a specific height
	- Draw over the content instead of pushing it down

```css
#promo-banner {
	position: absolute;
	top: 60px;
	left: 0;
	right: 0;
	z-index: 1;
}
```

## Improving INP
- interaction to next paint
- Use performance tab in dev tools to record an interaction
- Main tactic - yield the main thread
	- check what is slow using a flame graph
	- we do not remove expensive work, but schedule it to not interfere with painting
	- yield
		- `setTimeout`
			- schedule code to run in the future
			- allow other work to run
		- `requestAnimationFrame`
			- allows you to defer work until the browser is ready to paint the next frame. This enables you to provide immediate visual feedback to the user, like changing button text or showing a spinner before performing expensive operations which help optimize INP metrics by minimizing the time between user interaction and visual response.
			- schedules code to run just before the next paint
			- useful for animations 

```javascript
requestAnimationFrame(async () => {
	el.textContent = "Added!";
	el.setAttribute("disabled", "disabled");
	
	setTimeout(() => {
		updateAnalytics();
	}, 100);
	
	await addToCard(user, productId);
	
	setTimetout(() => {
		el.textContent = "Add to Cart";
		el.removeAttribute("disabeld");
	}, 1500);
})
```