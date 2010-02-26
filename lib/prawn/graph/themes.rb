require 'yaml'

module Prawn
  module Chart

    # Themes serves as a point of interaction between the user and the underlying
    # collection of themes made available to Prawn::Graph.
    #
    class Themes

      # Called once when Prawn::Graph is loaded, initializes the list of
      # themes currently bundled. If you have your own custom theme you'd
      # like to use instead, use _register_theme and give it the path to
      # your theme file.
      #
      def self.initialize_themes
        path = File.expand_path(File.dirname(__FILE__) + '/themes/')
        Dir.open(path) do |dir|
          dir.each do |file|
            _register_theme(path + '/' + file) if file.include?('.yml')
          end
        end
      end

      # Adds the theme defined by the yaml file specified to the mapping of
      # registered themes stored in +@@_themes_list+. Converts the YAML object
      # into a Theme object for use in the application.
      #
      def self._register_theme(theme_file_path)
        theme = Theme.new(YAML.load(IO.read(File.expand_path(theme_file_path))))
        if !defined? @@_themes_list
          @@_themes_list = {}
        end
        @@_themes_list[theme.name.to_sym] = theme
      end    

      protected 

      # Hook into method_missing to allow us to do things like:
      #   Prawn::Chart::Themes.theme_name
      # To return the theme object being looked for.
      #
      def self.method_missing(method, *args)
        if @@_themes_list.keys.include?(method)
          return @@_themes_list[method]
        end
      end
 
  
      class Theme
        attr_accessor :name, :title, :colours, :font_colour

        alias :colors :colours
        alias :colors= :colours=
        alias :font_color :font_colour
        alias :font_color= :font_colour=

        # Creates a new theme from a theme hash. The hash comes from the 
        # library parsing YAML definitions of a theme. 
        #
        def initialize(theme_hash)
          @name = theme_hash['name']
          @title = theme_hash['title']

          if theme_hash.keys.include?('colours') 
            @colours = theme_hash['colours']        
          elsif theme_hash.keys.include?('colors')
            @colours = theme_hash['colors']        
          end

          if theme_hash.keys.include?('font_colour') 
            @font_colour = theme_hash['font_colour']        
          elsif theme_hash.keys.include?('font_color')
            @font_colour = theme_hash['font_color']        
          end
        end
      end
    end

  end
end