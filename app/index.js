'use strict';
var util = require('util');
var path = require('path');
var yeoman = require('yeoman-generator');
var yosay = require('yosay');
var chalk = require('chalk');
var grunt = require('grunt');
var _ = require('underscore');
var _str = require('underscore.string');
var wrench = require('wrench');

var FxPrototypeGenerator = yeoman.generators.Base.extend({
  init: function () {
    this.pkg = require('../package.json');

    this.on('end', function () {
      if (!this.options['skip-install']) {
        this.installDependencies({
          callback: function(){this.emit('dependenciesInstalled')}.bind(this)
        });
      }
    });

    this.on('dependenciesInstalled', function(){
      this.spawnCommand('grunt', ['build']);
    })
  },

  askFor: function () {
    var done = this.async();

    // Have Yeoman greet the user.
    this.log(yosay('Welcome to the marvelous FxPrototype generator!'));

    var prompts = [
    // Get the name of the prototype
    {
      name: 'prototypeName',
      message: 'What is the name of the protoype?',
    },
    // Target webGL or 2d
    /*
    {
      name: 'canvasContext',
      message: 'What is the rendering context',
    },
    */
    // Is this project going to use grunt2svg for asset management?
    {
      name:'hasSVG',
      message:'Will this prototype be based off svgs?',
      type:'confirm'
    },
    {
      name:'isSketch',
      message:'Will this prototype use sketch.js?',
      type:'confirm'
    },
    // d3?
    {
      name:'isD3',
      message:'Will this prototype use d3?',
      type:'confirm'
    },
    {
      name:'isThreeJS',
      message:'Will this prototype use Three.js?',
      type:'confirm'
    },
    {
      name:'isPhysics',
      message:'Will this prototype use physics?',
      type:'confirm'
    }];


    this.prompt(prompts, function (props) {
      this.prototypeName = props.prototypeName;
      this.renderingContext = props.canvasContext;
      this.isD3 = props.isD3;
      this.isThreeJS = props.isThreeJS;
      this.isPhysics = props.isPhysics;
      this.isSketch = props.isSketch;
      this.hasSVG = props.hasSVG;

      done();
    }.bind(this));
  },

  app: function () {
    var self = this,
        dir = _str.slugify(this.prototypeName);

    this.mkdir(dir);
    this.destinationRoot(dir);

    grunt.file.setBase( this.src._destBase );

    this.mkdir('src');
    this.mkdir('src/coffee');

    this.mkdir('public');
    this.mkdir('public/javascripts');
    this.mkdir('public/javascripts/vendor');
    this.mkdir('public/images');
    this.mkdir('public/stylesheets');
    this.mkdir('public/json');

    if (this.hasSVG){
      var svgs = grunt.file.expand(path.join( '../', '*.svg'));
      var hasImageFolder = grunt.file.isDir('../images');

      this.mkdir('svg');

      if (svgs !== undefined && svgs.length > 0){
        _.each(svgs, function(file){
          var tmpStr = file.replace('../', '');
          grunt.file.copy( file, 'svg/' + tmpStr );
        })
      }
      if(hasImageFolder){
        wrench.copyDirSyncRecursive(path.join(this.src._destBase, '../images'), 'svg/images');
      }

    }

    this.template('_package.json', 'package.json');
    this.template('_Gruntfile.coffee', 'Gruntfile.coffee');

    if (this.isPhysics){
      this.copy('_physics.min.js', 'public/javascripts/vendor/physics.min.js');
      this.copy('coffeephysics.coffee', 'src/coffee/coffeephysics.coffee');
    }

    this.template('index.html', 'public/index.html');
    this.template('main.coffee', 'src/coffee/main.coffee')
    this.template('_bower.json', 'bower.json');
  },

  runtime: function(){
    this.copy('bowerrc', '.bowerrc');
    this.copy('gitignore', '.gitignore');

  },

  projectfiles: function () {
    this.copy('editorconfig', '.editorconfig');
    this.copy('jshintrc', '.jshintrc');
  }
});

module.exports = FxPrototypeGenerator;
