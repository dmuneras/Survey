# -*- coding: utf-8 -*-
class AddFifthAspect < ActiveRecord::Migration
  def self.up
    Aspect.create(:name => 'Aspectos relacionados con reconocimientos')

    # Pregunta 22
    Question.create(:number => 22,
                    :aspect_id => Aspect.last.id,
                    :description => %{A continuación se muestran 5 enunciados con relación al <dfn title="(Cualitativo) La acción de distinguir a una persona o cosa entre las demás como consecuencia de sus características y rasgos.">reconocimiento</dfn> y <dfn title="(Monetario) Es la contrapestación que recibe el trabajador por haber puesto a disposición del empleador su fuerza de trabajo.">remuneración</dfn> sobre los logros alcanzados en el proceso de diseño y desarrollo de proyectos, productos y negocios; seleccione el que mejor describa la situación actual de su empresa},
                    :category => 'unique')

    descs = []
    descs << %{La empresa no tiene reconocimiento ni remuneración sobre los logros alcanzados}
    descs << %{La empresa casi nunca reconoce los logros alcanzados}
    descs << %{La empresa reconoce en algunos casos los logros alcanzados}
    descs << %{La empresa reconoce siempre los logros alcanzados}
    descs << %{La empresa reconoce siempre los logros alcanzados ya que existe una política de reconocimiento y remuneración y es objeto de revisión periódica}

    vals = [1,2,3,4,5]
    
    i = 1
    for d in descs do
      Answer.create(:number => i,
                    :description => d,
                    :question_id => Question.last.id,
                    :value => vals[i-1])
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
