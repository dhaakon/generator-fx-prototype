module.exports = (grunt) ->
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


  grunt.loadNpmTasks 'grunt-coffee-percolator-v2'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-open'
  grunt.loadNpmTasks 'grunt-contrib-livereload'

  grunt.initConfig options

  defaultOptions = ['percolator:main','copy', 'open', 'connect:server', 'watch']
  buildOptions = ['percolator:main','copy']

  grunt.registerTask 'serve', defaultOptions
  grunt.registerTask 'build', buildOptions
