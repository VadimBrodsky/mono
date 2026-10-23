## JSON Web Tokens

- An open standard: RFC 7519
- Method of transferring claims or assertions between two parties securely via a JSON payload
- A signed, compact, self-contained package
- Mechanism for stateless authentication

Basic JWT

```javascript
{ // Header
  "alg": "HS256",
  "typ": "JWT",
}
{ // Payload
  "sub": "1234567890",
  "name": "John Snow",
  "admin": true
}
// Signature
HMACSHA256(
  base64UrlEncode(header) + "." +
  base64UrlEncode(payload),
  <secret>
)
```

When hashed generates:

```
eyJhbGciOiJIUzI1NiIs
InR5cCI6IkpXVCJ9.eyJ
zdWIiOiIxMjM0NTY3ODk
wIiwibmFtZSI6IkpvaG4
gRG9lIiwiYWRtaW4iOnR
ydWV9.TJVA95OrM7E2cB
ab30RMHrHDcEfxjoYZge
FONFh7HgQ
```


### JWT Header

- JSON object that describes the token
- At least it should have the token type and signing algorithm
- Signing algorithm is used to verify the token
- Commonly tokens are signed with HS256 (symmetric) or RS256 (asymmetric)


### JWT Payload

- JSON object which contains any claims or assertions about the entity for which it was issued
- The JWT standard descries a set of reserved claims: `iss`, `sub`, `aud`, `exp`, `nbf`, `iat`, `jti`
- The payload can contain any arbitrary claims that are defined at will


### JWT Signature

- JSON object produced by BASE64 URL encoding the header and payload, then run through a hashing algorithm with a secret key
- The signature is used as a means to digitally sign the token so that its validity could be verified later
- If anything in the header or the payload is modified, the token is invalidated


## Traditional Authentication

- User submits the credentials which are checked against a database
- If all is good, a session is created for the user on the server, and a cookie with a `session_id` is sent back to the browser
- The cookie is sent back to the server on all subsequent requests and is verified against the session
- The application constructs the views on the backend, in which the authentication can be checked
- REST APIs are stateless and traditional authentication is stateful


### Downsides of Cookie / Session Authentication

- SPA does not refresh
- Cookies don't flow downstream in a micro services environment
- Can't communicate easily between multiple servers with traditional authentication
- Access control requires database queries
- In traditional authentication, the server does the heavy lifting


## JWT Authentication

- User submits the credentials which are checked against the database
- If everything is good, a token is signed and returned to the client in response
- The token is saved on the client, usually in web storage or in a cookie
- The token is sent as an `Authorization` header on every HTTP request
- When the request is received on the backend, the JWT is verified against the secret that only the server knows
- The payload is checked to route the request based on the JWT's claims, usually with middleware
- If the JWT is valid, the requested resource is returned
- If it's invalid a 401 is returned


### Upsides of JWT Authentication

- The SPA does not rely on the backed to tell it whether the user is authenticated
- The backend receives requests from multiple clients and the backend only cares that the token is valid
- Requests can flow downstream to other servers if necessary
- The client tells the backend what is permissible instead of asking
- No need for user access lookups


## JWT Storage

- Once the JWT received from the server, it needs to be stored in the user's browser
- Storing in memory will lose the session if the page is refreshed
- JWTs are usually stored in browser storage (local storage or session storage) or in HTTP-only cookies
- Token expiry is usually around 1 hour, so if a token is stolen it would get invalidated
- If the user has a token in the browser he is logged in, it it's gone he is logged out


To Authenticate using JWT:


```javascript
function _doAuthentication(endpoint, values) {
  return this.fetch(`${API_URL}/${endpoint}`, { 
    method: 'POST', 
    body: JSON.stringify(values),
    headers: { 'Content-Type': 'application/json' }
  });
}

function login(user, password) {
  return _doAuthentication('users/authenticate', { user, password });
}
```

To Logout:

```javascript
function logout() {
  // Clear user token and profile data from localStorage
  localStorage.removeItem('token');
}
```


## Additional Resouces
- [Token Decoder](https://jwt.io/)
- [Slides](https://frontendmasters.com/assets/resources/ryanchenkie/secure-auth.pdf)

