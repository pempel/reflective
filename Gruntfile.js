module.exports = function(grunt) {
  grunt.initConfig({
    compass: {
      live: {
        options: {
          sassDir: "public/stylesheets",
          cssDir: "public/stylesheets",
          imagesDir: "public/images",
          outputStyle: "compressed"
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
    }
  });
  grunt.loadNpmTasks("grunt-contrib-compass");
  grunt.loadNpmTasks("grunt-contrib-uglify");
  grunt.registerTask("default", ["compass", "uglify"]);
};
