# elm-webpack-starter

## About

A simple Webpack setup for writing [Elm](http://elm-lang.org/) apps:

* Dev server with live reloading, HMR
* Support for CSS/SCSS (with Autoprefixer), image assets
* Bootstrap 3.3+ (Sass version)
* Bundling and minification for deployment
* Basic app scaffold, using `Html.beginnerProgram`
* A snippet of example code to get you started!

Install all dependencies using the handy `reinstall` script:

```shell
npm run reinstall
```

*This does a clean (re)install of all npm and elm packages, plus a global elm install.*

## Serve locally

```shell
npm start
```

* Access app at `http://localhost:8080/`
* Get coding! The entry point file is `src/elm/Main.elm`
* Browser will refresh automatically on any file changes..

## Build & bundle for prod

```shell
npm run build
```

* Files are saved into the `/dist` folder
* To check it, open `dist/index.html`
