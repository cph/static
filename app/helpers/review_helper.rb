require "digest/md5"

module ReviewHelper
  
  
  LIKERT_RESPONSES = {
    -2 => "Strongly Disagree",
    -1 => "Disagree",
     0 => "Netural",
     1 => "Agree",
     2 => "Strongly Agree",
    "" => "Not Applicable"
  }.freeze
  
  
  def likert_table(questions)
    <<-HTML.html_safe
    <table class="likert-fields">
      #{likert_table_header}
      <tbody>
        #{questions.map { |question| likert_field(question) }.join}
      </tbody>
    </table>
    HTML
  end
  
  
  def likert_table_header
    <<-HTML.html_safe
    <thead>
      <tr>
        <td class="blank">&nbsp;</td>
        #{LIKERT_RESPONSES.map { |value, text| "<th class=\"likert-field-response\">#{text}</th>" }.join}
      </tr>
    </thead>
    HTML
  end
  
  
  def likert_field(question)
    id = Digest::MD5.hexdigest(question)
    
    <<-HTML.html_safe
      <tr class="likert-field">
        <th class="likert-field-question">#{question}</th>
        #{LIKERT_RESPONSES.map { |value, text| likert_response(id, value, text) }.join}
      </tr>
    HTML
  end
  
  
  def likert_response(id, value, text)
    <<-HTML.html_safe
    <td class="likert-field-response">
      <label for="question_#{id}_#{value}"> </label>
      <input type="radio" id="question_#{id}_#{value}" name="results[#{id}]" value="#{value}" title="#{text}" />
    </td>
    HTML
  end
  
  
  def offset(score)
    ((score + 2) / 0.04) * 0.8 + 10
  end
  
  
end
