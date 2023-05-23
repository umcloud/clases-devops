[![Go Report Card](https://goreportcard.com/badge/github.com/c0r0nel/api_jwt)](https://goreportcard.com/report/github.com/c0r0nel/api_jwt)

## API_JWT

## Purpose

This is a small API written in golang that implements JSON Web Token through several external libraries.

- https://github.com/go-chi/chi
- https://github.com/go-chi/jwtauth
- https://github.com/mattn/go-sqlite3

## Usage

Create the sqlite3 database elsewere:
```
$ sqlite3 ~/db/users.db < users.sql
```

Before running the server, you need to get all the dependencies needed, this might take some minutes. Be patience.
```
$ go get ./...
```

Finally you can build the server and run it doing:

```
$ go build api_jwt.go
$ ./api_jwt -p 3001 -db=~/db/users.db
```

For testing purpose, you can try to access the API root first:

```
$ curl -v http://localhost:3001/
```
Accessing the restricted endpoint /admin needs that you get authenticated first:
```
$ curl -v http://testuser:supersecret@localhost:3001/auth
```
This will give you a JSON Web Token that will last 3 minutes.
Finally, to use the token do:
```
$ curl -H"Authorization: BEARER YOUeXtrEmlY.LongJSONWEbToken" -v http://localhost:3001/admin
```

## Building a Docker image

To run api_jwt as a docker container you can build the image using the Dockerfile provided.
Build it with:
```
$ docker build -t api_jwt .
```
and then just run it:
```
docker run -v ~/db:/db --rm -p 3001:3001 api_jwt -p=3001 -db=/db/users.db
```

Enjoy!! :)
