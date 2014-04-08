module.exports = function(grunt) {
  grunt.initConfig({
    compass: {
      live: {
        options: {
          sassDir: "assets/stylesheets",
          cssDir: "public/stylesheets",
          imagesDir: "public/images",
          outputStyle: "compressed"
        }
      }
    },
    uglify: {
      live: {
        files: {
          "public/javascripts/main.js": ["assets/javascripts/**/*.js"]
        }
      }
    }
  });
  grunt.loadNpmTasks("grunt-contrib-compass");
  grunt.loadNpmTasks("grunt-contrib-uglify");
  grunt.registerTask("default", ["compass", "uglify"]);
};
