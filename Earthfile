VERSION 0.8

FROM haxe:4.3.4-alpine3.20
WORKDIR /hxminetest

# Let Haxelib discover our library (for self-referencing)
RUN haxelib dev hxminetest .

# Install Haxe dependencies
RUN apk add --no-cache git
COPY haxelib.json .
RUN haxelib install haxelib.json --always

setup-deno:

    ENV DENO_FUTURE 1
    RUN apk add --no-cache deno

    COPY scripts/deps.ts scripts/deps.ts
    COPY deno.json deno.lock .
    RUN deno cache scripts/deps.ts

lint:

    RUN haxelib install formatter
    COPY hxformat.json .
    COPY examples examples
    COPY src src
    RUN haxelib run formatter --check -s examples -s src

build-examples:

    FROM +setup-deno

    COPY extraParams.hxml .
    COPY examples examples
    COPY scripts scripts
    COPY src src
    RUN deno run --allow-run=haxe --allow-read=examples scripts/build-examples.ts

build-docs-dump-types:

    FROM +setup-deno

    RUN mkdir docs && mkdir docs/reference
    COPY scripts scripts
    COPY src src
    RUN deno run --allow-run --allow-read=docs --allow-write=docs scripts/generate-class-reference.ts

    # This artifact does not have to be local to build the final HTML version,
    # but we can use it for hot-reloading a dev server on a host machine (vitepress dev docs)
    SAVE ARTIFACT docs/reference/generation/classes.xml AS LOCAL docs/reference/generation/classes.xml

build-docs-static-html:

    FROM +setup-deno

    # TODO: Figure out how to make Rollup use the musl binary
    RUN apk add --no-cache gcompat

    WORKDIR docs
    COPY docs/deno.json docs/package.json .
    RUN deno install

    # Build Vitepress site
    COPY docs .
    COPY +build-docs-dump-types/classes.xml reference/generation/classes.xml
    RUN deno run -A npm:vitepress build .
    SAVE ARTIFACT .vitepress/dist AS LOCAL docs/.vitepress/dist

build-docs:
    BUILD +build-docs-dump-types
    BUILD +build-docs-static-html
