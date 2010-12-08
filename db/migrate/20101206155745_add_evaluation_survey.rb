# -*- coding: utf-8 -*-
class AddEvaluationSurvey < ActiveRecord::Migration
  def self.up

    Survey.create(:name => 'Principal')
    for question in Question.all do
      question.update_attributes(:survey_id => Survey.last.id)
    end

    Survey.create(:name => "Evaluation")

    Question.create(:number => 1, :description => "¿Cómo califica el tiempo total de respuesta?", 
                    :survey_id => Survey.last.id)

    Question.create(:number => 2, :description => "¿Encuentra fácil los botones para ir a las funciones de la encuesta?", 
                    :survey_id => Survey.last.id)

    Question.create(:number => 3, :description => "¿Encuentra útiles las instrucciones de la encuesta?", 
                    :survey_id => Survey.last.id)

    Question.create(:number => 4, :description => "¿Cómo califica la interfaz de la pagina?",
                    :survey_id => Survey.last.id)

    Question.create(:number => 5, :description => "¿Cree usted que las imágenes aportan valor a la encuesta?",
                    :survey_id => Survey.last.id)

    Question.create(:number => 6, :description => "¿Cree usted que la cantidad de preguntas de cada encuesta es adecuada?",
                    :survey_id => Survey.last.id)

    Question.create(:number => 7, :description => "Si se tuvo la oportunidad de obtener y leer los resultados de la encuesta. ¿Cómo percibe usted la forma como se entregan los resultados?", :survey_id => Survey.last.id)

    Question.create(:number => 8, :description => "¿Cuál es su percepción respecto a la página de la encuesta en general?",
                    :survey_id => Survey.last.id)
    
    

  end

  def self.down
    for question in Survey.last.questions do
      question.destroy
    end
    Survey.last.destroy
  end
end
