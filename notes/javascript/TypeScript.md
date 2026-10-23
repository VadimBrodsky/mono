```typescript
// strictNullChecks, makes  null and undefined not assignable to other types
// need to do a typecheck, or check if it exists
const maybeContainer = document.getElementById('app-container')!
if (maybeContainer) {
  maybeContainer.innerText = 'hi';
}



// union types
function trimAndLower(text: string | null | undefined) {
  if (typeof text === 'string') {
    return text.trim().toLocaleLowerCase();
  }
  return text;
}



// Not null operator, assume a thing exists, avoid
const container = document.getElementById('app-container')!



// definite assignment analysis
let foo: number;
console.log(foo); // would warn that foo is undefined



const numbers = [0, 1, 2, [3, 4], 5, [6], 7, 8, [9]];
// type guards
function flatten(array: (number | number[])[]): number[] {
  const flattened: number[] = [];
  for (const element of array) {
    if (Array.isArray(element)) {
      flattened.push(...element);
    } else {
      flattened.push(element);
    }
  }
  return flattened;
}

// generic
function flattenAnything<T>(array: (T | T[])[]): T[] {
  const flattened: T[] = [];
  for (const element of array) {
    if (Array.isArray(element)) {
      flattened.push(...element);
    } else {
      flattened.push(element);
    }
  }
  return flattened;
}

console.log(flattenAnything(numbers));


// type guard function
function isFlat<T>(array: (T | T[])[]): array is T[] {
  return !array.some(Array.isArray)
}

if (isFlat(numbers)){
  numbers;
}



// read only properties
interface User {
  readonly id: number;
  name: string;
}

// type Readonly<T> {
//   readonly [P in keyof T]: T[P];
// }

const user: User = {
  id: 42,
  name: 'John',
};

user.id++;  // will fail because its read only
user.name += ' Smith';


class ClassyUser {
  readonly id: number;
  name: string;

  constructor(id: number, name: string) {
    this.id = id;
    this.name = name;
  }
}

const user2 = new ClassyUser(43, 'Jeff');
user2.id++; // will fails because its ready only
user2.name += ' Goldblum';


const weekdays: ReadonlyArray<string> = ['...'];
weekdays.length = 0;
weekdays.push('oh no you didnt');



// types
// JS primitive types
type Primitive =
  | boolean
  | number
  | string
  | symbol
  | null
  | undefined;

// object type
let obj: object;

obj = true;
obj = 42;
obj = 'foo';
obj = Symbol();
obj = null;
obj = undefined;

obj = {}; // empty object type object
obj = [];
obj = Math.random;

// real objects
let realObj: Object;
realObj.toString();
realObj.hasOwnProperty('foo');

const objEmpty: { [key: string]: any } = {};
obj.hasOwnProperty('foo');  // is not a type error, but does not auto complete
obj['foo ']= "bar";         // need to define type of key to make this work


// never type is unreachable, type result is never
// this is different than void
enum ShirtSize {
  // XS,
  S,
  M,
  L,
  XL
}

function prettyPrintSize(size: ShirtSize) {
  switch (size) {
    case ShirtSize.S: return 'small';
    case ShirtSize.M: return 'medium';
    case ShirtSize.L: return 'large';
    case ShirtSize.XL: return 'extra large';
    default: return assertNever(size);
  }
}

// guards against anything to be passed to it
// helps to deal with forgetting to deal with all cases
function assertNever(value: never): never {
  throw Error(`Unexpected value '${value}'`);
}



// function overload
// types of the overload should be compatible with the types in the implementation

/**
 * Reverses the given string.
 * @param string The string  to reverse.
 */
function reverse(string: string): string;

/**
 * Reverses the given array.
 * @param array The array to reverse.
 */
function reverse(array: any[]): any[];

// generic
function reverse<T>(array: T[]): T[];

function reverse(stringOrArray: string | any[]) {
  return typeof stringOrArray === 'string'
    ? [...stringOrArray].reverse().join('')
    : stringOrArray.slice().reverse();
}

const reversedString = reverse("TypeScript");
const reversedArray = reverse([1,2,3,4,5,6]);



// string enum types
enum MediaTypes {
  JSON = 'application/json'
}

// const enums have runtime manifestation
// preserveConstEnums: false
const enum Ports {
  SSL = 443
}

fetch('https://example.com/api/endpoint', {
  headers: {
    Accept: MediaTypes.JSON
  }
}).then(response => {
  // ..
});



// string literal types
let autoComplete: 'on' | 'off' = 'on';
autoComplete = "off";


// numeric literal types
type NumberBase = 2 | 8 | 10 | 16;
let base: NumberBase;
base = 2;
base = 3; // will fail

type HTTPSuccessStatusCode = 200 | 201 | 202 | 203 | 204 | 205 | 206 | 207 | 208 | 226;


// boolean literal types
// let autoFocus: true | false = true;
let autoFocus: boolean = true;
autoFocus = false;


// enum literal type
enum Protocols {
  HTTP,
  HTTPS,
  FTP
}

type HyperTextProtocol = Protocols.HTTP | Protocols.HTTPS;

let protocol: HyperTextProtocol;
protocol = Protocols.HTTP;
protocol = Protocols.HTTPS;
protocol = Protocols.FTP;  // fails



// discriminating union types
// model alternatives
//
// not restrictive enough
// type Result = {
//   success: boolean;
//   value?: number;
//   error?: string;
// }
type Result<T> =
  | { success: true, value: T }
  | { success: false, error: string };

function tryParse(text: string): Result<number> {
  if (/^-?\d+$/.test(text)) {
    return { success: true, value: parseInt(text, 10) };
  }
  return { success: false, error: 'Invalid number format' };
}

const result = tryParse("42");

if (result.success) {
  result.success; // this can only one type
  result.error;   // this fails, error does not exist
} else {
  result;
}


interface Cash { kind: 'cash'; }
interface PayPal { kind: 'paypal'; email: string }
interface CreditCard { kind: 'creditcard', cardNumber: string, securityCode: string; }
type PaymentMethod = Cash | PayPal | CreditCard;

function stringifyPaymentMethod(method: PaymentMethod): string {
  switch(method.kind) {
    case "cash":
      return "Cash";
    case "paypal":
      return `PayPal ${method.email}`; // email exists because of the type
    case "creditcard":
      return "CreditCard";
  }
}



// lookup types
interface Todo {
  id: number;
  text: string;
  completed: boolean;
}

const todo: Todo = { id: 1, text: 'Buy Milk', completed: false };

// keyof gets the keys from the interface Todo
function prop(obj: Todo, key: keyof Todo) {
  return obj[key];
}

// generic prop function
// K must be any of the keys T defines
function genericProp<T, K extends keyof T>(obj: T, key: K): T[K] {
  return obj[key];
}

// type lookups
type TodoId = Todo['id'];
type TodoTextOrCompleted = Todo['text' | 'completed'];

const id = prop(todo, 'id');
const text = genericProp(todo, 'text');
const completed = prop(todo, 'completed');


// mapped types

// partial type
// makes all types optional
interface Point {
  x: number;
  y: number;
}

// type Partial<T> = {
//   [P in keyof T]?: T[P];
// }
let point: Partial<Point>;
point = {};


// custom mapped type
type Nullable<T> = {
  [P in keyof T]: T[P] | null;
};
let pointMaybe: Nullable<Point>;
pointMaybe = { x: 0, y: 0 };
pointMaybe = { x: null, y: null };

// combine maps
// hover over the type to see what it resolves to
type PartialNullAblePoint = Partial<Nullable<Point>>;

type Stringify<T> = {
  [P in keyof T]: string;
}


// React Stateless Component
const App: React.SFC<{ message: string }> = ({ message }) => (
  <div>{message}</div>
)


// React State full Component
type AppProps = { message: string }
type AppState = { count: number }

class App extends React.Component<AppProps, AppState> {
  constructor(props) {
    super(props);
    this.state = { count: 0 };
  }

  render() {
    return (
      <div>{this.props.message} {this.props.state}</div>
    );
  }
}
```