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

Consider the content at ```/home/me/Documents/words/2015/10/31/asset.ext```

A handler will do this:

* mkdir ```{{config/landing-page-dir}}/2015/10/31```
* create a landing page ```{{config/landing-page-dir}}/2015/10/31/index.html```
* mkdir ```{{config/entries-dir}}```
* create a feed entry ```{{config/entries-dir}}/2015_10_31_asset.ext.html```
