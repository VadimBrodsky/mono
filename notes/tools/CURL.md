Useful to send HTTP requests via the command line:

## Flags
- `-v` verbose: more details about the request and response process
- `-i` or `-include`: includes the HTTP response headers in the output
- `-X`: custom method for the request
- `-L`: follow redirects
## Examples

```
curl -v http://localhost:4000
```

```curl
curl -X POST http://localhost:4000/post
```

```curl
curl -i -H "Range bytes=100-199" --output - http://localhost:4000/static/img/logo.png
```