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