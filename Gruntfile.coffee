module.exports = (grunt) ->
  # config
  fileConfig =
    dir:
      tmp: 'tmp/'
      dist: 'dist/'

    dist:
      client: 'dist/js/lolita.js'
      css: 'dist/css/lolita.css'

    files:
      client: [
        'src/js/lolita.*'
      ]
      css: [
        'src/css/lolita.css'
      ]
      img: [
        'src/img/**'
      ]

  # load tasks
  require('load-grunt-tasks')(grunt)

  # task config
  taskConfig =
    # `package.json` file read to access meta data
    pkg: grunt.file.readJSON 'package.json'

    # banner placed at top of compiled source files
    meta:
      '/** \n' +
      ' * <%= pkg.name %> - v<%= pkg.version %> - ' +
      '<%= grunt.template.today("yyyy-mm-dd") %>\n' +
      ' * <%= pkg.homepage %> \n' +
      ' * \n' +
      ' * Copyright (c) <%= grunt.template.today("yyyy") %> ' +
      '<%= pkg.author %>\n' +
      ' * Licensed <%= pkg.licenses.type %> <<%= pkg.licenses.url %>>\n' +
      ' * */\n'

    concurrent:
      dev:
        options:
          logConcurrentOutput: true
        tasks: [
          'watch'
          'nodemon:dev'
        ]

    nodemon:
      dev:
        options:
          file: 'app.js'

    # watch files for changes
    watch:
      client:
        files: [
          '<%= files.client %>'
        ]
        tasks: [
          'build:client'
        ]
      css:
        tasks: [
          'build:css'
        ]
        files: [
          '<%= files.css %>'
        ]
      assets:
        tasks: [
          'build:assets'
        ]
        files: [
          '<%= files.img %>'
        ]

    # increments version number, etc
    bump:
      options:
        files: [
          'package.json'
          'bower.json'
        ]
        commit: true
        commitMessage: 'chore(release): v%VERSION%'
        commitFiles: [
          'package.json'
          'bower.json'
        ]
        createTag: false
        tagName: 'v%VERSION%'
        tagMessage: 'Version %VERSION%'
        push: false
        pushTo: 'origin'

    copy:
      img:
        files: [
          src: [
            '<%= files.img %>'
          ]
          dest: '<%= dir.dist %>/img'
          cwd: '.'
        ]

    # directories to clean when `grunt clean` is executed
    clean:
      tmp: [
        '<%= dir.tmp %>'
      ]
      dist: [
        '<%= dir.dist %>'
      ]

    mkdir:
      tmp:
        options:
          create: [ 'dist/tmp' ]

    # compile coffeescript files
    coffee:
      client:
        options:
          bare: true
          join: true
          sourceMap: true
        cwd: '.'
        src: [
          '<%= files.client %>'
        ]
        dest: '<%= dir.dist %>/js/lolita.js'
        ext: '.js'
        filter: (filename) ->
          split = filename.split '.'
          ext = split[split.length - 1]
          return ext is 'coffee'

    # lint + minify CSS
    recess:
      app:
        src: [
          '<%= files.css %>'
        ]
        dest: '<%= dir.dist %>/css/lolita.css'
        options:
          compile: true
          compress: false
          noUnderscores: false
          noIDs: false
          zeroUnits: false

    todos:
      src:
        options:
          priorities:
            low: /TODO/
            med: /FIXME/
            high: null
          reporter:
            header: () ->
              return '-- BEGIN TASK LIST --\n\n'
            fileTasks: (file, tasks, options) ->
              return '' if !tasks.length

              result = ''
              result += '* ' + file + '\n'

              tasks.forEach (task) ->
                result += '[' + task.lineNumber + ' - ' + task.priority +
                  '] ' + task.line.trim() + '\n'

              result += '\n\n'
            footer: () ->
              return '-- END TASK LIST --\n'
        files:
          'TODO.md': [
            '<%= files.client %>'
            '<%= files.css %>'
            '!TODO.md'
            '!Gruntfile.coffee'
          ]

    # lint *.coffee files
    coffeelint:
      gruntfile:
        files:
          src: [
            'Gruntfile.coffee'
          ]

      client:
        src: [
          '<%= files.client %>'
        ]
        filter: (filename) ->
          split = filename.split '.'
          ext = split[split.length - 1]
          return ext is 'coffee'

  # merge, init config
  grunt.initConfig(grunt.util._.extend(taskConfig, fileConfig))

  grunt.registerTask 'default', [
    'concurrent:dev'
  ]

  grunt.registerTask 'build:client', [
    'coffeelint:client'
    'coffee:client'
  ]

  grunt.registerTask 'build:css', [
    'recess:app'
  ]

  grunt.registerTask 'build:assets', [
    'copy:img'
  ]

  grunt.registerTask 'build', [
    'clean'
    'todos'

    'build:client'
    'build:css'
    'build:assets'
  ]

  grunt.registerTask 'build:prod', [
    'build'
    'bump'
  ]
