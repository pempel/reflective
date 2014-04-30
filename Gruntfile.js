module.exports = function(grunt) {

  grunt.initConfig({
    "clean": {
      "live": ["public"]
    },

    "copy": {
      "live": {
        "files": [{
          "cwd": "app/documents",
          "src": "**",
          "dest": "public/documents",
          "expand": true
        }, {
          "cwd": "app/fonts",
          "src": "**",
          "dest": "public/fonts",
          "expand": true
        }, {
          "cwd": "app/images",
          "src": "**",
          "dest": "public/images",
          "expand": true
        }]
      }
    },

    "merge-json": {
      "live": {
        "files": {
          "public/index.json": ["app/contents/**/*.json"]
        }
      }
    },

    "jade": {
      "live": {
        "compile": {
          "data": {
            "debug": false
          }
        },
        "options": {
          "data": function() {
            return grunt.file.readJSON("public/index.json");
          }
        },
        "files": {
          "public/index.html": ["app/templates/index.jade"]
        }
      }
    },

    "compass": {
      "live": {
        "options": {
          "sassDir": "app/stylesheets",
          "cssDir": "public/stylesheets",
          "imagesDir": "public/images",
          //"outputStyle": "compressed"
        }
      }
    },

    "uglify": {
      "live": {
        "files": {
          "public/javascripts/main.js": ["app/javascripts/**/*.js"]
        }
      }
    }
  });

  grunt.loadNpmTasks("grunt-contrib-clean");
  grunt.loadNpmTasks("grunt-contrib-copy");
  grunt.loadNpmTasks("grunt-merge-json");
  grunt.loadNpmTasks("grunt-contrib-jade");
  grunt.loadNpmTasks("grunt-contrib-compass");
  grunt.loadNpmTasks("grunt-contrib-uglify");

  grunt.registerTask("build", ["clean", "copy", "merge-json", "jade", "compass", "uglify"]);
  grunt.registerTask("default", "build");
};
