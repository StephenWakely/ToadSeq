// Generated on 2013-08-03 using generator-jekyllrb 0.3.6. Yo Jekyll!
'use strict';
var liveReloadPort = 35729;
var lrSnippet = require('connect-livereload')({port: liveReloadPort});
var mountFolder = function (connect, dir) {
  return connect.static(require('path').resolve(dir));
};
var yeomanConfig = {
  app: 'app',
  dist: 'dist'
};

// Directory reference:
//   css: css
//   compass: _scss
//   javascript: js
//   images: img
//   fonts: fonts

module.exports = function (grunt) {

  // Configuration
  grunt.initConfig({
    yeoman: yeomanConfig,

    watch: {
      compass: {
        files: ['<%= yeoman.app %>/_scss/**/*.{scss,sass}'],
        tasks: ['compass:server']
      },
      jekyll: {
        files: ['<%= yeoman.app %>/**/*.{html,yml,md,mkd,markdown}',
                '_config.yml',
                '!<%= yeoman.app %>/_bower_components'],
        tasks: ['jekyll:server']
      },
      livereload: {
        options: {
          livereload: liveReloadPort
        },
        files: [
          '.jekyll/**/*.html',
          '{.tmp,<%= yeoman.app %>}/css/**/*.css',
          '{.tmp,<%= yeoman.app %>}/<%= js %>/**/*.js',
          '<%= yeoman.app %>/img/**/*.{gif,jpg,jpeg,png,svg,webp}'
        ]
      }
    },
    connect: {
      options: {
        port: 9000,
        // Change hostname to null to access the server from outside.
        hostname: 'localhost'
      },
      livereload: {
        options: {
          middleware: function (connect) {
            return [
              lrSnippet,
              mountFolder(connect, '.tmp'),
              mountFolder(connect, '.jekyll'),
              mountFolder(connect, yeomanConfig.app)
            ];
          }
        }
      },
      test: {
        options: {
          middleware: function (connect) {
            return [
              mountFolder(connect, '.tmp'),
              mountFolder(connect, 'test')
            ];
          }
        }
      },
      dist: {
        options: {
          middleware: function (connect) {
            return [
              mountFolder(connect, yeomanConfig.dist)
            ];
          }
        }
      }
    },
    open: {
      server: {
        path: 'http://localhost:<%= connect.options.port %>'
      }
    },
    // Running Jekyll also cleans all non-git files from the target directory
    // If you've added anything to Jekyll's 'keep_files', add them here as well.
    clean: {
      dist: {
        files: [{
          dot: true,
          src: [
            '.tmp',
            '<%= yeoman.dist %>/*',
            '!<%= yeoman.dist %>/.git*'
          ]
        }]
      },
      server: ['.tmp', '.jekyll']
    },
    compass: {
      options: {
        // If you're using global Sass gems, require them here, e.g.:
        // require: ['singularity', 'jacket'],
        bundleExec: true,
        sassDir: '<%= yeoman.app %>/_scss',
        cssDir: '.tmp/css',
        imagesDir: '<%= yeoman.app %>/img',
        fontsDir: '<%= yeoman.app %>/fonts',
        javascriptsDir: '<%= yeoman.app %>/js',
        relativeAssets: false,
        httpImagesPath: '/img',
        httpGeneratedImagesPath: '/img/generated',
        outputStyle: 'expanded',
        raw: 'asset_cache_buster :none \nextensions_dir = "<%= yeoman.app %>/_bower_components"\n'
      },
      dist: {
        options: {
          generatedImagesDir: '<%= yeoman.dist %>/img/generated'
        }
      },
      server: {
        options: {
          debugInfo: true,
          generatedImagesDir: '.tmp/img/generated'
        }
      }
    },
    jekyll: {
      options: {
        bundleExec: true,
        src : '<%= yeoman.app %>'
      },
      dist: {
        options: {
          dest: '<%= yeoman.dist %>',
          config: '_config.yml,_config.build.yml'
        }
      },
      server: {
        options: {
          dest: '.jekyll',
          config: '_config.yml'
        }
      }
    },
    jshint: {
      options: {
        jshintrc: '.jshintrc'
      },
      all: [
        'Gruntfile.js',
        '{.tmp,<%= yeoman.app %>}/js/**/*.js',
        'test/spec/**/*.js',
        '!<%= yeoman.app %>/js/vendor/**/*',
        '!<%= yeoman.app %>/_bower_components/**/*'
      ],
      report: [
        '{.tmp,<%= yeoman.app %>}/js/**/*.js',
        '!<%= yeoman.app %>/js/vendor/**/*'
      ]
    },
    csscss: {
      options: {
        bundleExec: true,
        minMatch: 2,
        ignoreSassMixins: false,
        compass: true,
        colorize: true,
        shorthand: false,
        verbose: true
      },
      // Add files to be tested here
      report: {
       src: ['<%= yeoman.app %>/css/**/*.css',
             '<%= yeoman.app %>/_scss/**/*.scss']
      }
    },
    csslint: {
      options: {
        csslintrc: '.csslintrc'
      },
      report: {
        src: ['{.tmp,<%= yeoman.app %>}/css/**/*.css']
      }
    },
    // UseminPrepare will only scan one page for usemin blocks. If you have
    // usemin blocks that aren't used in index.html, create a usemin manifest
    // page (hackery!) and point this task there.
    useminPrepare: {
      options: {
        dest: '<%= yeoman.dist %>'
      },
      html: '<%= yeoman.dist %>/index.html'
    },
    usemin: {
      options: {
          basedir: '<%= yeoman.dist %>',
          dirs: ['<%= yeoman.dist %>/**/*']
      },
      html: ['<%= yeoman.dist %>/**/*.html'],
      css: ['<%= yeoman.dist %>/css/**/*.css']
    },
    htmlmin: {
      dist: {
        options: {
          collapseWhitespace: true,
          collapseBooleanAttributes: true,
          removeAttributeQuotes: true,
          removeRedundantAttributes: true,
          removeOptionalTags: true
        },
        files: [{
          expand: true,
          cwd: '<%= yeoman.dist %>',
          src: '**/*.html',
          dest: '<%= yeoman.dist %>'
        }]
      }
    },
    // Usemin adds files to concat
    concat: {},
    // Usemin adds files to uglify
    uglify: {},
    // Usemin adds files to cssmin
    cssmin: {
      dist: {
        options: {
          report: 'gzip'
        }
      }
    },
    imagemin: {
      dist: {
        options: {
          progressive: true
        },
        files: [{
          expand: true,
          cwd: '<%= yeoman.dist %>',
          src: '**/*.{jpg,jpeg,png}',
          dest: '<%= yeoman.dist %>'
        }]
      }
    },
    svgmin: {
      dist: {
        files: [{
          expand: true,
          cwd: '<%= yeoman.dist %>',
          src: '**/*.svg',
          dest: '<%= yeoman.dist %>'
        }]
      }
    },
    copy: {
      dist: {
        files: [{
          expand: true,
          dot: true,
          cwd: '<%= yeoman.app %>',
          src: [
            // Jekyll moves all html and text files. Usemin moves css and js
            // files with concat. Add other files and patterns your site
            // reqires for distrobution here, e.g., Bower components that
            // aren't in a usemin block.
            // '_bower_components/jquery.min.js',
            // Copy moves asset files and directories
            '*.{ico,png}',
            'img/**/*',
            'fonts/**/*'
          ],
          dest: '<%= yeoman.dist %>'
        }]
      }
    },
    rev: {
      options: {
        length: 4
      },
      dist: {
        files: {
          src: [
            '<%= yeoman.dist %>/js/**/*.js',
            '<%= yeoman.dist %>/css/**/*.css',
            '<%= yeoman.dist %>/img/**/*.{gif,jpg,jpeg,png,svg,webp}',
            '<%= yeoman.dist %>/fonts/**/*.{eot*,svg,ttf,woff}'
          ]
        }
      }
    },
    concurrent: {
      server: [
        'compass:server',
        'jekyll:server'
      ],
      dist: [
        'compass:dist',
        'copy:dist'
      ]
    }
  });

  // Load plugins
  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks);

  // Define Tasks
  grunt.registerTask('server', function (target) {
    if (target === 'dist') {
      return grunt.task.run(['build', 'open', 'connect:dist:keepalive']);
    }

    grunt.task.run([
      'clean:server',
      'concurrent:server',
      'connect:livereload',
      'open',
      'watch'
    ]);
  });

  // No real tests yet. Add your own.
  // grunt.registerTask('test', [
  //   'clean:server',
  //   'concurrent:test',
  //   'connect:test'
  // ]);

  grunt.registerTask('report', [
    'clean:server',
    'compass:server',
    'jshint:report',
    'csscss:report',
    'csslint:report'
  ]);

  grunt.registerTask('build', [
    'clean:dist',
    // Jekyll cleans all non-git files from the target directory, so must run first
    'jekyll:dist',
    'concurrent:dist',
    'useminPrepare',
    'concat',
    'cssmin',
    'uglify',
    'imagemin',
    'svgmin',
    'rev',
    'usemin',
    'htmlmin'
    ]);

  grunt.registerTask('default', [
    'report',
    'build'
  ]);
};
