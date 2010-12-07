class AddAnswersToQuestionsEvaluation < ActiveRecord::Migration
  def self.up
    survey = Survey.last
    for answer in survey.questions do 
      answer.update_attributes(:category => "unique")
    end
    
    #RESPUESTAS 1,2,4,7 y 8  PREGUNTA
    a = ['Inadecuado','Aceptable', 'Adecuado', 'Muy adecuado']
    
    (1..4).each do | i | 
      Answer.create(:question_id => survey.questions.first.id ,:number => i, :description => a[i-1])
      Answer.create(:question_id => survey.questions[1].id ,:number => i, :description => a[i-1])
      Answer.create(:question_id => survey.questions[3].id ,:number => i, :description => a[i-1])
      Answer.create(:question_id => survey.questions[6].id ,:number => i, :description => a[i-1])
      Answer.create(:question_id => survey.questions.last.id ,:number => i, :description => a[i-1])
    end
    
    #RESPUESTAS 3,5,6 PREGUNTA
    ans = ['Si','No']
    (1..2).each do |j|
      Answer.create(:question_id => survey.questions[2].id ,:number => j, :description => ans[j-1])
      Answer.create(:question_id => survey.questions[4].id ,:number => j, :description => ans[j-1])
      Answer.create(:question_id => survey.questions[5].id ,:number => j, :description => ans[j-1])
    end
    
  end

  def self.down
    for question in Survey.last.questions do
      for answer in question.answers do
        answer.destroy
      end
      question.destroy
    end
    Survey.last.destroy
  end
end
