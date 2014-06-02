module.exports = ->
  options =
    watch :
      options :
        livereload: 35729
      coffee:
        files : ['src/coffee/**/*.coffee']
        tasks : ['percolator:main']
      <% if (hasSVG) { %>
      svg:
        files: ['svg/**/*']
        tasks: ['svg2json', 'copy:svgImages']
      <% } %>
    copy :
      js:
        files:[expand:true, flatten: true, filter: 'isFile', cwd:'bower_components', src:['**/*.min.js'], dest:'public/javascripts/vendor/']
      <% if (hasSVG) { %>
      svgImages:
        files:[expand:true, flatten: true, filter: 'isFile', cwd:'svg/images', src:['**/*'], dest:'public/images/']
      <% } %>

    percolator:
      main  :
        source: './src/coffee'
        output:'./public/javascripts/main.js'
        main: 'main.coffee'
        compile: true
        options:'--bare'

    connect :
      server:
        options:
          port:8888
          base:"public"

    <% if (hasSVG) { %>
    svg2json :
      compile:
        files:
          'public/json/svg.json' : ['svg/**/*.svg']
    <% } %>

  @loadNpmTasks 'grunt-coffee-percolator-v2'
  @loadNpmTasks 'grunt-contrib-watch'
  @loadNpmTasks 'grunt-contrib-copy'
  @loadNpmTasks 'grunt-contrib-connect'
  @loadNpmTasks 'grunt-open'
  @loadNpmTasks 'grunt-contrib-livereload'
  <% if (hasSVG) { %>
  @loadNpmTasks 'grunt-svg2json'
  <% } %>

  @initConfig options

  defaultOptions = ['percolator:main','copy', 'connect:server', 'watch']
  buildOptions = ['percolator:main','copy', <% if (hasSVG) { %> 'svg2json' <% } %>]

  @registerTask 'serve', defaultOptions
  @registerTask 'build', buildOptions
