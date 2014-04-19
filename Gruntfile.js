module.exports = function(grunt) {
  grunt.initConfig({
    copy: {
      live: {
        files: [{
          expand: true,
          cwd: "app/fonts/",
          src: "*",
          dest: "public/fonts/",
        }, {
          expand: true,
          cwd: "app/images/",
          src: "*",
          dest: "public/images/",
        }],
      },
    },
    jade: {
      compile: {
        data: {
          debug: false,
        },
      },
      files: {
        src: "app/templates/**/*.jade",
        dest: "public/index.html",
      },
    },
    compass: {
      live: {
        options: {
          sassDir: "app/stylesheets",
          cssDir: "public/stylesheets",
          imagesDir: "public/images",
          outputStyle: "compressed",
        },
      },
    },
    uglify: {
      live: {
        files: {
          src: "app/javascripts/**/*.js",
          dest: "public/javascripts/main.js",
        },
      },
    },
    watch: {
      scripts: {
        files: [
          "app/stylesheets/**/*.scss",
          "app/javascripts/**/*.js",
          "app/templates/**/*.jade",
        ],
        tasks: ["build"],
        options: {
          spawn: false,
        },
      },
    },
  });

  grunt.loadNpmTasks("grunt-contrib-copy");
  grunt.loadNpmTasks("grunt-contrib-jade");
  grunt.loadNpmTasks("grunt-contrib-compass");
  grunt.loadNpmTasks("grunt-contrib-uglify");
  grunt.loadNpmTasks("grunt-contrib-watch");

  grunt.registerTask("build", ["copy", "jade", "compass", "uglify"]);
};
