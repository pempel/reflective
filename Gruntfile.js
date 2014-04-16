module.exports = function(grunt) {
  grunt.initConfig({
    compass: {
      live: {
        options: {
          sassDir: "public/stylesheets",
          cssDir: "public/stylesheets",
          imagesDir: "public/images",
          outputStyle: "compressed",
        }
      }
    },
    uglify: {
      live: {
        files: {
          "public/javascripts/main.min.js": [
            "public/javascripts/**/*.js",
            "!public/javascripts/**/*.min.js",
          ]
        }
      }
    },
    watch: {
      scripts: {
        files: [
          "public/stylesheets/**/*.scss",
          "public/javascripts/**/*.js",
          "!public/javascripts/**/*.min.js",
        ],
        tasks: ["build"],
        options: {
          spawn: false,
        }
      }
    },
  });

  grunt.loadNpmTasks("grunt-contrib-compass");
  grunt.loadNpmTasks("grunt-contrib-uglify");
  grunt.loadNpmTasks("grunt-contrib-watch");

  grunt.registerTask("build", ["compass", "uglify"]);
};
