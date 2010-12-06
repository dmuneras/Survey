module SurveyRecordsHelper

  def question_additional_info(question)
    if question.category == 'nested'
      content_tag(:ul) do
        question.subquestions.inject([]) do |c, s|
          c << content_tag(:li, s.description)
        end
      end
    elsif question.category == 'scale'
      scale = question.question_scale
      content_tag(:dl) do
        content_tag(:dt, "Izquierda") <<
        content_tag(:dd, scale.lower) <<
        content_tag(:dt, "Derecha") <<
        content_tag(:dd, scale.higher)
      end
    end
  end

  def list_for_answers(answers)
    content_tag(:ul) do
      answers.inject([]) do |c, a|
        break if a.gsub(' ', '').empty?
        this_ans = Answer.find(a)
        desc = this_ans.description
        if this_ans.question.category == 'scale'
          if  desc.to_i < 0
            desc.gsub!('-', '')
            desc += " - hacia la izquierda"
          elsif desc.to_i > 0
            desc += " - hacia la derecha"
          end
        end
        c << content_tag(:li, desc)
      end
    end
  end

end
