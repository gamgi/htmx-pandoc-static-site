HTMX powered static site generator with Pandoc
----------------------------------------------

A [make](https://www.gnu.org/software/make/) based static site generator that uses [Pandoc](https://pandoc.org/) to convert markdown to HTML, and [HTMX](https://htmx.org/) to turn it into a static single-page app.

➡ [View demo site](https://gamgi.github.io/htmx-pandoc-static-site)  
➡ [How it works](https://github.com/gamgi/htmx-pandoc-static-site#how-it-works)  

![HTMX powered static site generator with Pandoc](https://github.com/gamgi/htmx-pandoc-static-site/blob/main/screenshot.png?raw=true)


## Quick start

### Building (Nix)

If you have [nix](https://nixos.wiki/wiki/Flakes) with flakes enabled, you can enter the dev environment and build the site with:

```bash
nix develop --command make all
```

### Building (Docker)

NOTE: Tested on arm64 only.

If you don't have nix, but have [GNU make](https://www.gnu.org/software/make/) and [docker](https://www.docker.com/) installed, you use a poor-man's dev environment to build the site:

```bash
make develop make all
````

## How it works

The site is static, i.e. it requires no "HTMX aware" server.

Pandoc renders the markdown files twice: the full page as [standalone](https://pandoc.org/MANUAL.html#option--standalone) into `foo.html` and the page content into `foo.html.part`.

The site navigation contains htmx-boosted links of the form
```html
<a href="/foo.html"
   hx-get="/foo.html.part"
   hx-target="#part"
   hx-push-url="/foo.html">
   Foo
</a>
```

When the user clicks on a link, three things happen:
1. The browser fetches the partial page `foo.html.part` file from the server,
2. and puts its contents into the DOM element with id `#part`,
3. and updates the browser URL to `foo.html`.

If the user refreshes the browser, the browser will fetch the full page `foo.html`. Same applies for users who have javascript disabled.


## Developing

* `nix develop` - enter dev environment (nix)
* `make develop bash` - enter dev environment (docker)
* `make <target>`
  * `all` - build site
  * `clean` - clean up build artifacts
  * `serve` - serve built site


## Notes

* Template adapted from [default pandoc html tempate](https://github.com/jgm/pandoc-templates/blob/master/default.html5)
* It's based on make, what did you expect? ಠ_ಠ
