# -*- coding: utf-8 -*-
class AddThirdAspect < ActiveRecord::Migration
  def self.up
    Aspect.create(:name => 'Aspectos relacionados con las personas de la organización')

    # Pregunta 7
    Question.create(:number => 7,
                    :aspect_id => Aspect.last.id,
                    :description => %{A continuación se encuentran 5 enunciados con respecto al desarrollo de <dfn title="Capacidad individual de hacer en contexto.">competencias individuales</dfn> para el proceso de diseño y desarrollo de productos; seleccione el que mejor describa la situación actual de su empresa},
                    :category => 'unique')

    descs = []
    descs << %{La empresa no se preocupa por el desarrollo de competencias individuales}
    descs << %{La empresa se preocupa por el desarrollo de competencias individuales, además se destina tiempo laboral para este fin}
    descs << %{La empresa se preocupa por el desarrollo de competencias individuales, además se destina tiempo laboral, <dfn title="Disponibilidad de la organización en términos de persona, infraestructura y dinero.">recursos</dfn> y dinero para este fin}
    descs << %{La empresa se preocupa por el desarrollo de competencias individuales; se destina tiempo laboral, recursos y dinero para este fin. Además existen <dfn title="Límites establecidos por la organización en los cuales las personas pueden desempeñar su labor de acuerdo con sus capacidades.">reglas de juego</dfn> establecidas para el desarrollo de competencias}
    descs << %{La empresa se preocupa por el desarrollo de competencias individuales; se destina tiempo laboral, recursos y dinero para este fin. Además existen reglas de juego establecidas para el desarrollo de competencias y son objeto de monitoreo periódico}
    
    vals = [1,2,3,4,5]

    i = 1
    for d in descs do
      Answer.create(:number => i,
                    :description => d,
                    :value => vals[i-1],
                    :question_id => Question.last.id)
      i += 1
    end    
    
  end
  
  def self.down
    aspect = Aspect.last
    questions = aspect.questions
    for q in questions do
      answers = q.answers
      subquestions = q.subquestions
      for a in answers do
        a.delete
      end
      for s in subquestions do
        s.delete
      end      
      qs = QuestionScale.find_by_question_id(q.id)
      qs.delete if qs
      q.delete
    end
    aspect.delete
  end
end
