module AbilityHelper
  
  def format_ability(ability)
    ability.to_s
      .gsub(/`([^`]*)`/, '<code>\1</code>')
      .gsub(/\b([\w]+) \(([^()]*)\)/, '<a class="with-explanation" rel="tooltip" title="\2">\1</a>')
      .html_safe
  end
  
end
