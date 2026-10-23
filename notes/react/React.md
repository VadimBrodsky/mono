### Framework for developing a React App

1. Break the app into components
2. Build a static version of the app
3. Determine in which component each piece of state should live
4. Hard-code initial states
5. Add inverse data flow
6. Add server communication


### Criteria to determine if data should be stateful:

Represent state with as few data points as possible, [Thinking in React](https://facebook.github.io/react/docs/thinking-in-react.html).

1. Is it passed in from a parent via props? If so, it is probably isn't state.
2. Does it change over time? If not, it is probably isn't state.
3. Can you compute it based on any other state or props in your component? If so, it is not state.



### Determine in which component each piece of state should live

For each piece of state:

- Identify every components that renders something based on that state
- Find a common owner component, a single components above all the components that need the sate in the hierarchy
- Either the common owner or another component higher up in the hierarchy should own the state
- If you can't find a component where it make sense to own the state, create a new component to simply for simply holding the state and add it somewhere in the hierarchy above the common owner component.



### ReactDom

```javascript
// render accepts a third, callback argument
ReactDOM.render(reactElement, mountPoint, function cb() {
 // The React app has been rendered / updated
});
```



### JSX

JavaScript Syntax Extension is syntactic sugar around `React.createElement`.

```javascript
const Message = props => (<div>{props.text}</div>);
const reactComponent = (<Message text="Hello world" />);

// transpiles to:
var Message = function Message(props) {
  return React.createElement(
    "div",
    null,
    props.text
  );
};
var reactComponent = React.createElement(Message, { text: "Hello world" });
```

JSX boolean attributes:
```javascript
<input name='Name' disabled={true} />
```

JSX comments:
```javascript
let userLevel = 'admin';
{/*
  Show the admin menu of the userLevel is 'admin'
*/}
{userLevel === 'admin' && <AdminMenu />}
```

JSX spread syntax:
```javascript
const props = { msg: 'Hello', recipient: 'World' };
<Component {...props} />
```

JSX Gotchas:
```javascript
// className instead of class
<div className='box'></div>

// htmlFor instead of for
<label htmlFor='email'>Email</label>
<input name='email' type='email' />

// html entities and emoji
// use UTF8 and Unicode directly in JS
<ul>
  <li>phone: {'\u0260e'}</li>
  <li>star: {'\u2606'}</li>
  <li>dolphin: {'\udD83D\uDC2C'}</li>
</ul>

// need to preprent data- only to native dom attributes
<div className='box' data-dismissible={true} />
<Message dismissible={true} />

// aria attributes are supported, prepended by aria-
<div aria-hidden={true} />
```


### ReactComponent

A `ReactComponent` is a JS object that at a minimum has a `render()` function. Render is expected to return a `ReactElement`. The goal of a `ReactComponent` is:

- To `render()` a `ReactElement` tree
  - a single child element
  - a virtual representation of a DOM component
  - or return a falsy value of `null` or `false`, will render an empty element a `<noscript />` tag, also removes a tag from the page.
- Attach functionality to this section of the page
  - attaching event handlers
  - managing state
  - interacting with children

Creating a `ReactComponent`:

```javascript
import React from 'react';

// React.createClass
const App = React.createClass({
  render: function() {} // require method
});
export default App;
```

```javascript
import React from 'react';

// ES2015 class
class App extends React.Component {
  render() // required method
}
export default App;
```



### Props and State

Props are immutable pieces of data that are passed into child components from parents. Component's state is where data is held, local to a component. Typically when the component's state changes the component needs to be re-rendered. State is private to the component and mutable.

Component props can be thought as arguments while state as instance variables to an object.

Props are the input to the components, any JavaScript object can be passed through props. While the outputs will be used by any event handlers passed into the component.

```javascript
<div>
  <Header headerText="Hello world" />
</div>
```


#### PropTypes

Way to validate the values that are passed in through the props. Need to be added as NPM dependency module `prop-types`:

```javascript
class Map extends React.Component {
  static propTypes = {
    lat: PropTypes.number,
    lng: PropTypes.number,
    zoom: PropTypes.number,
    place: PropTypes.object,
    markers: PropTypes.array,
  };
}
```


#### Default Props

If on initial value is set in the props use the default:

```javascript
class Counter extends React.Component {
  static defaultProps = {
    initialValue: 1,
  }
}

<Counter />
<Counter initialValue={1} />
```


### Context

A prop that is exposed globally, specifying `context` allows to automatically pass down variables from component to component, rather than needing to pass down props at every level. The parent component needs to define `childContextTypes` and `getChildContext`:

```javascript
class Messages extends React.Component {
  static propTypes = {
    users: PropTypes.array.isRequired,
    initialActiveChatIdx: PropTypes.number,
    messages: PropTypes.array.isRequired
  };
  
  static childContextTypes = {
    users: PropTypes.array,
    userMap: PropTypes.object,
  }
  
  getChildContext() {
    return {
      users: this.getUser(),
      userMap: this.getUserMap(),
    };
  }
  
  render() {
    return (
      <div>
        <TheadList />
        <ChatWindow />
      </div>
    );
  }
}
```

The child components get the context types automatically, set to `this.context` object. If `contextTypes` is defined on a component, several of the lifecycle methods will get additional `nextContext` argument. In functional stateless components `context` is passed as the second argument.

```javascript
class ThreadList extends React.Component {
  static contextTypes = {
    users: PropTypes.array,
  };
}

class ChatWindow extends React.Components {
  static contextTypes = {
    userMap: PropTypes.object,
  };
}

class CharMessage extends React.Component {
  static contextTypes = {
    userMap: PropTypes.object,
  };
}
```


### State

Components that hold local-mutable data are stateful components.

Components should have own state when they have UI states which:
1. cannot be fetched from outside or
2. cannot be passed into the component

The only information we should ever put in state are values that are not computed and do not have need to be synced across the app.


#### Stateless Components

Lightweight components that do not need any special handling around the component. Only need the `render()` method, no need to reference `this`.

These components are just functions that do not have a backing instance and do not extend `ReactElement`. They cannot contain state and do not get called with the normal component lifecycle methods. The pattern is to isolate state into a few parent components while using stateless components as much as possible. Passing the arguments down as props from the parent component.


React allows the use of `propTypes` and `defaultProps` on stateless components.

```javascript
const Header = props => (
  <h1>{props.headerText}</h1>
);
```


#### Children Components

Refer to child components in the tree using `this.props.children`.

Can validate children props as a prop type:

```javascript
static propTypes = {
  children: PropTypes.oneOf([
    PropTypes.element,
    PropTypes.array
  ])
}
```

If children is always wrapped in a single element:

```javascript
static propTypes = {
  children: PropTypes.element.isRequired,
}
```

Useful methods when working with children:
- `React.Children.map()` - returns an new array
- `React.Children.forEach()` - does not return an array
- `React.Children.toArray()` - converts the children object to a real array


### Redux

- All of the application's data is in a single data structure called the state which is held in the store.
- App reads the state from the store store, `store.getState()`.
- State is never mutated directly outside of the store.
- Views emit action that describe what happened, `store.dispatch(action)`.
- New state is created by combining the old state and the action by a function called the reducer. Taking current state and an action, returns new state.
- Reducer functions must be pure functions.
