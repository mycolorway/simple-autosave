module.exports = (grunt) ->

  grunt.initConfig

    pkg: grunt.file.readJSON 'package.json'

    coffee:
      src:
        options:
          bare: true
        files:
          'lib/autosave.js': 'src/autosave.coffee'
      spec:
        files:
          'spec/autosave-spec.js': 'spec/autosave-spec.coffee'

    umd:
      all:
        src: 'lib/autosave.js'
        template: 'umd.hbs'
        amdModuleId: 'simple-autosave'
        objectToExport: 'autosave'
        globalAlias: 'autosave'
        deps:
          'default': ['$', 'SimpleModule', 'simpleUrl']
          amd: ['jquery', 'simple-module', 'simple-url']
          cjs: ['jquery', 'simple-module', 'simple-url']
          global:
            items: ['jQuery', 'SimpleModule', 'simple.url']
            prefix: ''

    watch:
      styles:
        files: ['styles/*.scss']
        tasks: ['sass']
      spec:
        files: ['spec/**/*.coffee']
        tasks: ['coffee:spec']
      src:
        files: ['src/**/*.coffee']
        tasks: ['coffee:src', 'umd']
      jasmine:
        files: ['lib/**/*.js', 'specs/**/*.js']
        tasks: 'jasmine:test:build'

    jasmine:
      test:
        src: ['lib/**/*.js']
        options:
          outfile: 'spec/index.html'
          specs: 'spec/autosave-spec.js'
          vendor: [
            'vendor/bower/jquery/dist/jquery.min.js'
            'vendor/bower/simple-module/lib/module.js'
            'vendor/bower/simple-url/lib/url.js'
          ]

  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-jasmine'
  grunt.loadNpmTasks 'grunt-umd'

  grunt.registerTask 'default', ['coffee', 'umd', 'jasmine:test:build', 'watch']



