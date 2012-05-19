require 'net/http'
require 'rexml/document'
require 'bing_translator'

desc "Translate your YAML files using Bing."
task :translate_acts_as_translatable_models => :environment do
  @class = ENV["class"]
  raise "need to specify class=Category or class=Category,Product" unless @class
  
  @from_locale = ENV["from"]
  raise "need to specify from=<locale>" unless @from_locale
  
  @to_locale = ENV["to"]
  raise "need to specify to=<locale>" unless @to_locale
  
  @force_translation = (ENV["force_translation"] == "true")
  
  @app_id = ENV["app_id"]
  raise "need to specify app_id=<Your Bing API key>" unless @app_id
  
  puts "Translating..."

  @class.split(",").each do |c|
    model = c.constantize
    model.enable_locale_fallbacks = false
    
    model.all.each do |record|
      model_translated = false
      model.translatable_fields.each do |field|
        source = record.send("#{field}_#{@from_locale}")
        dest = record.send("#{field}_#{@to_locale}")
        
        # only translate if not already translated
        if !source.blank? && (@force_translation || dest.blank?)
          dest = translate_string(source)
          puts "#{source} => #{dest}"
          
          unless dest.blank?
            record.send "#{field}_#{@to_locale}=", dest
            model_translated = true
          end
        end
      end
      
      # only save model if it has been translated
      if model_translated
        puts "Saving #{model}..."
        record.save
      end
    end
  end
  
  puts "Done!"
end

def translate_string(source)
  return "" unless source
  
  # translate using Microsoft Bing
  begin
    dest = translator.translate(source, :from => @from_locale, :to => @to_locale)
  rescue
    dest = ""
  end
  
  dest
end

def translator
  @translator ||= BingTranslator.new @app_id
end