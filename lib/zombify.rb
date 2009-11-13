# module Zombify
#   def self.included(base)
#     base.extend 
#   end
#   
#   module String
#     def zombify(*args, &block)
#       
#       
#       
#     end
#   end
#   
#   module Zombify
#     
#   end
# end
# 
# class ActiveRecord::Base
#   include Zombify
# end

require "rand.rb"

module Zombify
  def self.vocabulary
    [
      { :word => "braiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiin", :real? => true },
      { :word => "eaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaat", :real? => true },
      { :word => "AahfaheuahAgAkajafaaaghahehbgrahaaaeuuuha", :real? => false },
      { :word => "auhueeeeeaaaAAeeuhahhggakaaa", :real? => false },
      { :word => "rrsshhchhhaaaaachshhh", :real? => false },
      { :word => "hhhhhhhheeaaaaahhaaschhhh", :real? => false }
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
  
  def self.undeadize(word, percent_change_letter = 50)
    number_letter_change = word.size * percent_change_letter / 100
    STDERR.puts number_letter_change
    
    content = word.dup
    
    number_letter_change.times do
      index = Kernel.rand(content.size)
      a = Zombify::alphabet.pick
      STDERR.puts "##{content}: #{index} -> #{a}"
      
      content[index] = a
    end
    
    content
  end
  
  def self.alphabet
    %w(a e h u g k s r A E H U G K S R)
  end

  module  String

    module ZombifyHelper

      def zombify(real_word = 40)
        content = self.dup
        
        self.scan(/\w+/) do |word|
          if Kernel.rand(100) < real_word
            m = Zombify::undeadize(word)
            STDERR.puts m
            content.gsub!(word, m)
          else
            content.gsub!(word, Zombify::talk(1, word.length, word.length))
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