module.exports = ->
  options =
    watch :
      options :
        livereload: 35729
      files : ['src/coffee/**/*.coffee']
      tasks : ['percolator:main']

    copy :
      js:
        files:[ expand:true, flatten: true, filter: 'isFile', cwd:'bower_components', src:['**/*.min.js'], dest:'public/javascripts/vendor/' ]

    connect :
      server:
        options:
          port:8888
          base:"public"

    percolator:
      main  :
        source: './src/coffee'
        output:'./public/javascripts/main.js'
        main: 'main.coffee'
        compile: true
        options:'--bare'

    open:
      all:
        path: 'http://localhost:<%= connect.server.options.port %>'


  @loadNpmTasks 'grunt-coffee-percolator-v2'
  @loadNpmTasks 'grunt-contrib-watch'
  @loadNpmTasks 'grunt-contrib-copy'
  @loadNpmTasks 'grunt-contrib-connect'
  @loadNpmTasks 'grunt-open'
  @loadNpmTasks 'grunt-contrib-livereload'

  @initConfig options

  defaultOptions = ['percolator:main','copy', 'open', 'connect:server', 'watch']
  buildOptions = ['percolator:main','copy']

  @registerTask 'serve', defaultOptions
  @registerTask 'build', buildOptions
