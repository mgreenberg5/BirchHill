module.exports = function(grunt) {

  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-connect');
  grunt.loadNpmTasks('grunt-contrib-compass');
  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-coffeelint');
  grunt.loadNpmTasks('grunt-contrib-copy');
  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-contrib-jade');
  grunt.loadNpmTasks('grunt-contrib-uglify');

  grunt.registerTask("default", ["build", "connect", "watch"]);

  grunt.registerTask(
    'build',
    'Compiles all of the assets and copies the files to the build directory.',
    ['clean:all', 'copy', 'styles', 'scripts', 'markup']
  );
  grunt.registerTask(
    'styles',
    'Compiles the stylesheets',
    ['compass']
  );
  grunt.registerTask(
    'scripts',
    'Compiles the JavaScript files.',
    ['coffeelint', 'coffee', 'uglify', 'clean:uncompressed']
  );
  grunt.registerTask(
    'markup',
    'Compiles the markup',
    ['jade']
  );

  grunt.initConfig({
    jade: {
      build: {
        options: {
          pretty: true
        },
        files: [ {
          cwd: "src/",
          src: "**/*.jade",
          dest: "bin/",
          expand: true,
          ext: ".html"
        } ]
      }
    },
    compass: {
      options: {
        config: "config.rb",
        outputStyle: 'compressed'
      },
      css: {
        options: {
          sassDir: "src/styles/",
          cssDir: "bin/css/"
        }
      }
    },
    coffee: {
      build: {
        options: {
          bare: true
        },
        files: {
          "bin/javascripts/main.js": [
            "src/javascripts/*.coffee",
            "src/javascripts/prequalification/**/*.coffee"
          ]
        }
      }
    },
    uglify: {
      build: {
        options: {
        },
        'files': {
          'bin/javascripts/main.min.js': 'bin/javascripts/main.js'
        }
      }
    },
    clean: {
      uncompressed: {
        src: ['bin/javascripts/main.js']
      },
      all: {
        src: [
          "bin/javascripts/**/*.js",
          "bin/images/**/*.png",
          "bin/images/**/*.jpg",
          "bin/images/**/*.gif",
          "bin/images/**/*.svg",
          "bin/pdfs/*.pdf",
          "bin/css/**/*.css",
          "bin/**/*.html"
        ]
      }
    },
    copy: {
      images: {
        files: [{
          expand: true,
          cwd: 'src/images',
          src: ["**/*.png", "**/*.jpg"],
          dest: 'bin/images'
        }]
      },
      pdfs: {
        files: [{
          expand: true,
          cwd: 'src/pdfs',
          src: ["*.pdf"],
          dest: 'bin/pdfs'
        }]
      },
      styles: {
        files: [{
          expand: true,
          cwd: 'src/styles/vendor',
          src: ["**/*.css"],
          dest: 'bin/css/vendor'
        }]
      },
      javascripts: {
        files: [{
          expand: true,
          cwd: 'src/javascripts',
          src: ["**/*.js"],
          dest: 'bin/javascripts'
        }]
      }
    },
    coffeelint: {
      options: {
        arrow_spacing: {
          level: "warn"
        },
        camel_case_classes: {
          level: "warn"
        },
        coffeescript_error: {
          level: "error"
        },
        cyclomatic_complexity: {
          level: "ignore"
        },
        duplicate_key: {
          level: "warn"
        },
        empty_constructor_needs_parens: {
          level: "warn"
        },
        no_implicit_parens: {
          level: "warn"
        },
        indentation: {
          level: "warn"
        },
        line_endings: {
          level: "warn"
        },
        max_line_length: {
          level: "ignore"
        },
        newlines_after_classes: {
          level: "ignore"
        },
        no_backticks: {
          level: "error"
        },
        no_empty_param_list: {
          level: "ignore"
        },
        no_implicit_braces: {
          level: "ignore"
        },
        no_plusplus: {
          level: "ignore"
        },
        no_stand_alone_at: {
          level: "ignore"
        },
        no_tabs: {
          level: "warn"
        },
        no_throwing_strings: {
          level: "warn"
        },
        no_trailing_semicolons: {
          level: "warn"
        },
        no_trailing_whitespace: {
          level: "warn"
        },
        non_empty_constructor_needs_parens: {
          level: "warn"
        },
        space_operators: {
          level: "ignore"
        }
      },
      lint: "src/javascripts/**/*.coffee"
    },
    connect: {
      server: {
        options: {
          hostname: '*',
          port: 4000,
          base: "bin"
        }
      }
    },
    watch: {
      options: {
        npspawn: true,
        livereload: true
      },
      styles: {
        files: 'src/styles/**/*.sass',
        tasks: 'styles'
      },
      scripts: {
        files: 'src/javascripts/**/*.coffee',
        tasks: 'scripts'
      },
      markup: {
        files: '**/*.jade',
        tasks: 'markup'
      },
      images: {
        files: ['src/images/**/*.jpg', 'src/images/**/*.png'],
        tasks: ['clean', 'copy']
      },
      pdfs: {
        files: ['src/pdfs/*.pdf'],
        tasks: ['clean', 'copy']
      }
    }
  });
};
