#define RandomData as a module bc it is a standalone library
module RandomData
#define random_paragraph, set sentences to array, create 4-6 random sentences
#append to sentences. call join to combine each sentence in array, passing a space to separate
#each sentence, join combines to full paragraph as string
 def self.random_paragraph
   sentences = []
   rand(4..6).times do
     sentences << random_sentence
   end

   sentences.join(" ")
 end

#same as paragraph. after generated, capitalize and append period
#capitalize returns a copy of sentence w/ first character to up case
 def self.random_sentence
   strings = []
   rand(3..8).times do
     strings << random_word
   end

   sentence = strings.join(" ")
   sentence.capitalize << "."
 end

#define random_word and set letters to an array of letters
#call shuffle! on letters in place
#join 0-nth item in letters. nth item is result of rand
#returns a random number >= 3 and <8
 def self.random_word
   letters = ('a'..'z').to_a
   letters.shuffle!
   letters[0,rand(3..8)].join
 end

 def random_integer
   rand(1..100)
 end
end
