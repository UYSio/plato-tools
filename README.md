# Misc tools

## Create date folder


    mkdirt.py

E.g. output:

```
$ tree
.
├── 2015
│   └── 11
│       └── 01
│           └── 14
│               └── 56
│                   └── 18
├── etc...
```

## Parse content

    racket main.rkt

Depends on config in user home: ```~/.plato/config.rkt```

# Mime detection

Uses same ```mime.types``` [recently pushed](https://github.com/racket/web-server/pull/8) to the Racket web-server.
