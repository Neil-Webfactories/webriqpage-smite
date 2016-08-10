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
      socials: { file: "data/socials.json" }
      site: { file: "data/site.json" }
    ),
    roots_rss_generator(
      folder: "pages"
      output: "./public/feed.xml"
      maxcount: 5
      settings:
        title: "New title"
        feed_url: "https://smite.netlify.com/feed.xml"
        description: "This is new description"
    ),
    collections(folder: 'pages', layout: 'page'),
    js_pipeline(files: 'assets/js/*.coffee'),
    css_pipeline(files: 'assets/css/*.styl')
  ]

  'coffee-script':
    sourcemap: true

  jade:
    pretty: true

  server:
    "clean_urls": true
