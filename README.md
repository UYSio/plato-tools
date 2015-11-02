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

# Handlers

Handlers do two things:

* prepare a *content package* at a *location*.
- *content package*: an index.html and whatever else needed to support it (e.g. images, etc)
- *location*: a path in the output directory which is a function of the asset location.

E.g. if the asset location is ```/home/me/Documents/words/2015/10/31/pumpkin-suffrage.md``` then the *location* is ```{out-dir}/2015/10/31```.
The contents will be ```index.html```, which contains the Markdown-rendered contents of ```pumpkin-suffrage.md```, possibly annotated with ```words``` as a tag or somesuch.
