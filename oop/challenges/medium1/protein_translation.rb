# require 'pry'
# class Translation
#   CODON_PROTEIN = {
#     'AUG' => 'Methionine',
#     'UGG' => 'Tryptophan',
#     'UUU' => 'Phenylalanine', 'UUC' => 'Phenylalanine',
#     'UAU' => 'Tyrosine',      'UAC' => 'Tyrosine',
#     'UGU' => 'Cysteine',      'UGC' => 'Cysteine',
#     'UUA' => 'Leucine',       'UUG' => 'Leucine',
#     'UCU' => 'Serine',        'UCC' => 'Serine',
#     'UCA' => 'Serine',        'UCG' => 'Serine',
#     'UAA' => 'STOP',          'UAG' => 'STOP',
#     'UGA' => 'STOP'
#   }


#   def self.of_codon(codon)
#     CODON_PROTEIN[codon]
#   end

#   def self.of_rna(strand)
#     raise InvalidCodonError if CODON_PROTEIN[codon].nil?
#     amino_acids = []
#     strand.scan(/.../).each do |codon|
#       break if of_codon(codon) == 'STOP'
#       amino_acids << of_codon(codon)
#     end

#     amino_acids
#   end
# end

# puts Translation.of_codon('UGG')

# %w(UGU UGC).each do |codon|
#   puts Translation.of_codon(codon)
# end

# Translation.of_rna('AUGUUUUGG')
# strand = 'AUGUUUUAA'
# p Translation.of_rna(strand)

# # input : codon as string object
# # output : Protein as string object

# # role : of_codon => input certain codons and the referencing protein will be translated
#      # : of_rna   => input a series of codeon and translate it
# # special note :stop codon terminates the translation and the final methionine is not translated into the protein sequence

# # class method 在內部就不寫self了是吧？反正class invoke也是一樣


# def self.of_codon(codon)
#   CODON_PROTEIN.fetch(codon) { fail InvalidCodonError }
# end

# def self.of_rna(strand)
#   strand.scan(/.../).take_while { |codon| of_codon(codon) != 'STOP' }
#                     .map { |codon| of_codon(codon) }
# end


























class InvalidCodonError < StandardError; end

class Translation
  CODON_PROTEIN = {
    'AUG' => 'Methionine',
    'UGG' => 'Tryptophan',
    'UUU' => 'Phenylalanine', 'UUC' => 'Phenylalanine',
    'UAU' => 'Tyrosine',      'UAC' => 'Tyrosine',
    'UGU' => 'Cysteine',      'UGC' => 'Cysteine',
    'UUA' => 'Leucine',       'UUG' => 'Leucine',
    'UCU' => 'Serine',        'UCC' => 'Serine',
    'UCA' => 'Serine',        'UCG' => 'Serine',
    'UAA' => 'STOP',          'UAG' => 'STOP',
    'UGA' => 'STOP'
  }


  def self.of_codon(codon)
    CODON_PROTEIN[codon]
  end

  def self.of_rna(strand)
    result = []
    strand.scan(/.../).each do |codon|
      raise InvalidCodonError if CODON_PROTEIN[codon].nil?
      break if CODON_PROTEIN[codon] == 'STOP'
      result << CODON_PROTEIN[codon]
    end

    result
  end
end















