require "rand.rb"
#require "zombify_controller.rb"

module Zombify
  # Courtesy of http://wiki.urbandead.com/index.php/Guides:The_Zombie_Lexicon
  def self.vocabulary
    [
      { :word => "braiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiin", :real? => true },
      { :word => "braiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiin", :real? => true },
      { :word => "braiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiin", :real? => true },
      { :word => "braiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiin", :real? => true },
      { :word => "eaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaat", :real? => true },
      { :word => "eaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaat", :real? => true },
      { :word => "GraaaaghMrh?RamgangGraaaaghbaggazMrh?raHabbahmGrhAAGHZZgrabbarh", :real? => false },
      { :word => "GagarazhanzHangangzharMrh?BrnhrGrhbaggazMrh?HarmanzambrazBarhah", :real? => false },
      { :word => "ZgrabbarhGrhzharRamgangramGagarazhanzMrh?", :real? => false },
      { :word => "HabbahzharAAGHZMrh?baggazHangangGrhBrnhrMarrahBarhahmazanmarrahBarhannagah", :real? => false }
    ]
  end

  def self.talk(word_count = 30, min_length = 2, max_length = 13)
    content = ""

    word_count.times do
      letter_count = (min_length == max_length) ? min_length : (Kernel.rand(max_length) % (max_length - min_length)) + min_length
      word = Zombify::vocabulary.pick

      if word[:real?]

        content += word[:word][0,letter_count-1] + word[:word][-1,1] + " "
      else
        begin_letter = Kernel.rand(word[:word].size - letter_count)

        content += word[:word][begin_letter, letter_count] + " "
      end
    end

    content.strip
  end

  def self.undeadize(word, percent_change_letter = 30)
    number_letter_change = (word.size * percent_change_letter / 100.0).ceil

    content = word.dup

    index = Kernel.rand(content.size)
    a = Zombify::alphabet["#{(number_letter_change%4).to_s}"].pick

    content[index,number_letter_change%4] = a

    content
  end

  def self.alphabet
    {
      "1" => %w(a A),
      "2" => %w(aA ar gh am aa gA au),
      "3" => %w(arg eug aag agh Grh Hag),
      "4" => %W(Gang Grab harm Harm)
    }
  end
  
  def render(options = nil, extra_options = {}, &block) #:doc:
    super  
    doc = Nokogiri::HTML(response.body)
    doc.css('h1, h2, h3, h4, h5, p, span, li, a, blockquote').each do |header|
      content = HTML::WhiteListSanitizer.new.sanitize(header.content)
      logger.debug "header > " + content
      content.scan(/\b[a-zA-Z]{2,}\b/).each do |word|
        logger.debug "word >>> " + word
        response.body = response.body.gsub(" #{word} ", " #{zombify(word)} ")
      end
    end
  end

  module  String

    module ZombifyHelper

      def zombify(real_word = 40)
        content = self.dup

        self.scan(/\w+/) do |word|
          if Kernel.rand(100) < real_word
            m = Zombify::undeadize(word.mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n,'').downcase.to_s)
            content.sub!(word, m)
          else
            content.sub!(word, Zombify::talk(1, word.length, word.length))
          end
        end
        content
      end
    end
  end
end

class String
  include Zombify::String::ZombifyHelper
end
