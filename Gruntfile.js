module.exports = function(grunt) {
  grunt.initConfig({
    copy: {
      live: {
        files: [
          {expand: true, cwd: "app/documents", src: "*", dest: "public/documents"},
          {expand: true, cwd: "app/fonts",     src: "*", dest: "public/fonts"},
          {expand: true, cwd: "app/images",    src: "*", dest: "public/images"},
        ],
      },
    },
    jade: {
      compile: {
        data: {
          debug: false,
        },
      },
      files: {
        src:  "app/templates/index.jade",
        dest: "public/index.html",
      },
    },
    compass: {
      live: {
        options: {
          sassDir:     "app/stylesheets",
          cssDir:      "public/stylesheets",
          imagesDir:   "public/images",
          outputStyle: "compressed",
        },
      },
    },
    uglify: {
      live: {
        files: {
          "public/javascripts/main.js": ["app/javascripts/**/*.js"],
        },
      },
    },
  });

  grunt.loadNpmTasks("grunt-contrib-copy");
  grunt.loadNpmTasks("grunt-contrib-jade");
  grunt.loadNpmTasks("grunt-contrib-compass");
  grunt.loadNpmTasks("grunt-contrib-uglify");

  grunt.registerTask("build", ["copy", "jade", "compass", "uglify"]);
  grunt.registerTask("default", "build");
};
