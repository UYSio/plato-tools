# Start

    git clone --recursive https://github.com/UYSio/plato-tools.git
    make hoedown

This last command cleans hoedown, updates it, then compiles it.

## Parse content

    make run 

Depends on config in user home: ```~/.plato/config.rkt```

If you have no config, prep one with:

    make prep

# Mime detection

Uses same ```mime.types``` [recently pushed](https://github.com/racket/web-server/pull/8) to the Racket web-server.

# Handlers

Consider the content at ```/home/me/Documents/words/2015/10/31/asset.ext```

A handler will do this:

* mkdir ```{{config/output-root}}/pages/2015/10/31```
* create a landing page ```{{config/output-root}}/pages/2015/10/31/index.html```
* mkdir ```{{config/output-entries}}```
* create a feed entry ```{{config/output-entries}}/2015_10_31_asset.ext.html```

"pages" is currently hard-coded, and relative to {{config/output-root}}.
