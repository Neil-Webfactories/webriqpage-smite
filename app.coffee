axis         = require 'axis'
rupture      = require 'rupture'
autoprefixer = require 'autoprefixer-stylus'
js_pipeline  = require 'js-pipeline'
css_pipeline = require 'css-pipeline'
cleanUrls    = require  ('clean-urls')
records      = require 'roots-records'
collections  = require 'roots-collections'
excerpt      = require 'html-excerpt'
moment       = require 'moment'
roots_rss_generator =  require 'webriq-roots-rss-generator'

monthNames = [ "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" ]

module.exports =
  ignores: ['readme.md', '**/layout.*', '**/_*', '.gitignore', 'ship.*conf']

  locals:
    postExcerpt: (html, length, ellipsis) ->
      excerpt.text(html, length || 100, ellipsis || '...')
    dateFormat: (date, format) ->
      moment(date).format(format)

  extensions: [
    js_pipeline(files: 'assets/js/*.coffee'),
    css_pipeline(files: 'assets/css/*.styl')
  ] 

  extensions: [
    records(
      characters: { file: "data/characters.json" }
      site: { file: "data/site.json" }
      socials: { file: "data/socials.json" }
    ),
    collections(folder: 'pages', layout: 'page'),
    js_pipeline(files: 'assets/js/*.coffee'),
    css_pipeline(files: 'assets/css/*.styl'),
    roots_rss_generator(
      folder: "pages"
      output: "feed.xml"
      settings:
        site_url: "https://smite.netlify.com"
      )
  ]

  'coffee-script':
    sourcemap: true

  jade:
    pretty: true

  server:
    "clean_urls": true
