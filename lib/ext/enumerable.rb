module Enumerable
  
  def average(&block)
    if block_given?
      map(&block).average
    else
      inject(0.0, &:+) / count
    end
  end
  alias :avg :average
  
  def histogram
    Hash[*group_by { |v| v }.flat_map { |k, v| [k, v.size] }]
  end
  
end
