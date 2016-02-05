class FormEntry
  include Virtus.model

  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  class << self
    def params
      attribute_set.map { |k, _v| k.name }
    end
  end

  def merge_hash(hash)
    hash.each do |k, v|
      self[k] = v
    end
    self
  end
end
