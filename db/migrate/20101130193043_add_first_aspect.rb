# -*- coding: utf-8 -*-
class AddFirstAspect < ActiveRecord::Migration
  def self.up
    Question.delete_all
    Answer.delete_all
    Aspect.delete_all
    Subquestion.delete_all
    QuestionScale.delete_all
    Aspect.create(:name => 'Aspectos estratégicos')
    
    # Pregunta 1
    Question.create(:number => 1,
                    :description =>
                    %{A continuación se muestran 5 enunciados con respecto a la <dfn title="La formulación de los propósitos de una organización que la distingue de otros negocios en cuanto al cubrimiento de sus opraciones, productos, mercados y el talento humano que soporta el logro de estos propósitos.">misión</dfn> y la <dfn title="Conjunto de ideas generales, que proveen el marco de referencia de lo que una empresa es y quiere ser en el futuro. No se expresa en términos numéricos, la define la alta dirección.">visión</dfn>; seleccione el que mejor describa la situación actual de su empresa},                    
                    :category => 'unique',
                    :aspect_id => Aspect.last.id)
    Answer.create(:number => 1,
                  :question_id => Question.last.id,
                  :description => %{La empresa no tiene definidas la misión y la visión corporativa.},
                  :value => 1)
    Answer.create(:number => 2,
                  :question_id => Question.last.id,
                  :description => %{La empresa tiene definidas la misión y la visión corporativa, sin embargo estas no se encuentran documentadas.},
                  :value => 2)
    Answer.create(:number => 2,
                  :question_id => Question.last.id,
                  :description => %{La empresa tiene definidas la misión y la visión corporativa, y se encuentran documentadas.},
                  :value => 3)
    Answer.create(:number => 4,
                  :question_id => Question.last.id,
                  :description => %{La empresa tiene definidas y documentadas la misión y visión corporativa. En estas, se hace explícito el tipo de productos que ofrece al mercado y el proceso de diseño y desarrollo de productos.},
                  :value => 4)
    Answer.create(:number => 5,
                  :question_id => Question.last.id,
                  :description => %{La empresa tiene definidas y documentadas la misión y visión corporativa. En estas, se hace explícito el tipo de productos que ofrece al mercado y el proceso de diseño y desarrollo de productos. La misión y visión son objeto de monitoreo periódico.},
                  :value => 5)

    # Pregunta 2
    Question.create(:number => 2,
                    :description =>
                    %{A continuación se muestran 5 enunciados con respecto a los <dfn title="Factores integradores de la tarea de la alta gerencia y, por tanto, deberán reflejarse en los planes funcionales y oprativos de cada unidad estratégica de negocio.">objetivos estratégicos</dfn>, seleccione el que mejor describa la situación actual de la empresa},
                    :aspect_id => Aspect.last.id,
                    :category => 'unique')

    Answer.create(:number => 1,
                  :question_id => Question.last.id,
                  :description => %{La empresa no tiene definidos los objetivos estratégicos.},
                  :value => 1)
    Answer.create(:number => 2,
                  :question_id => Question.last.id,
                  :description => %{La empresa tiene definidos los objetivos estratégicos, sin embargo estos no se encuentran documentados.},
                  :value => 2)
    Answer.create(:number => 3,
                  :question_id => Question.last.id,
                  :description => %{La empresa tiene definidos los objetivos estratégicos y se encuentran documentados.},
                  :value => 3)
    Answer.create(:number => 4,
                  :question_id => Question.last.id,
                  :description => %{La empresa tiene definidos los objetivos estratégicos. En estos, se hace explícito el proceso de diseño y desarrollo de productos.},
                  :value => 4)
    Answer.create(:number => 5,
                  :question_id => Question.last.id,
                  :description => %{La empresa tiene definidos los objetivos estratégicos. En estos, se hace explícito el proceso de diseño y desarrollo de productos. Los objetivos estratégicos se materializan en acciones y son objeto de monitoreo periódico.},
                  :value => 5)


    # Pregunta 3
    Question.create(:number => 3,
                    :description =>
                    %{Con respecto a la existencia de un <dfn title="Una serie de tareas, pasos y fases disciplinadas y definidas que describen el significado por el cual una compañía repetitivamente convierte ideas iniciales en productos o servicios vendibles.">plan para el proceso de diseño y desarrollo de productos</dfn> en su empresa},
                    :aspect_id => Aspect.last.id,
                    :category => 'unique')
    
    Answer.create(:number => 1,
                  :question_id => Question.last.id,
                  :description => %{No existe un plan para el proceso de diseño y desarrollo de productos.},
                  :value => 1)
    
    Answer.create(:number => 2,
               :question_id => Question.last.id,
               :description => %{Existe un plan para el proceso de diseño y desarrollo de productos, pero no se encuentra documentado.},
               :value => 2)
    
    Answer.create(:number => 3,
               :question_id => Question.last.id,
               :description => %{Existe un plan para el proceso de diseño y desarrollo de productos y está documentado.},
               :value => 3)
    
    Answer.create(:number => 4,
               :question_id => Question.last.id,
               :description => %{Existe un plan para el proceso de diseño y desarrollo de productos con estrategias y políticas definidas.},
                  :value => 4)
    
    Answer.create(:number => 5,
                  :question_id => Question.last.id,
                  :description => %{Existe un plan para el proceso de diseño y desarrollo de productos con estrategias y políticas definidas. El plan es comunicado y entendido en todos los niveles de la organización.},
                  :value => 5)
    
  end

  def self.down
    Question.delete_all
    Answer.delete_all
    Aspect.delete_all
    Subquestion.delete_all
    QuestionScale.delete_all
  end
end
