# -*- coding: utf-8 -*-
class AddMoreTestData < ActiveRecord::Migration
 def self.up
    Question.delete_all
    Answer.delete_all
    Aspect.delete_all
    Aspect.create(:name => 'Aspectos Estratégicos')
    Question.create(:number => 1,
                    :description =>
                    %{A continuación se muestran 5 enunciados con respecto a la misión y la visión; seleccione el que mejor describa la situación actual de su empresa},                    
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

    Question.create(:number => 2,
                    :description =>
                    %{A continuación se muestran 5 enunciados con respecto a los objetivos estratégicos, seleccione el que mejor describa la situación actual de la empresa},
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

    Question.create(:number => 3,
                    :description =>
                    %{Con respecto a la existencia de un plan para el proceso de diseño y desarrollo de productos en su empresa},
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
    
    Aspect.create(:name => %{Aspectos del proceso, diseño y desarrollo de nuevos productos})

    Question.create(:number => 4,
                    :description => %{Señale TODOS los aspectos que se consideran o se describen en el plan del proyecto de desarrollo de NUEVOS productos (en caso de ser necesario, puede señalar más de un tema)},
                    :aspect_id => Aspect.last.id,
                    :category => 'multiple')

    Answer.create(:number => 1,
                  :question_id => Question.last.id,
                  :description => 'Mercado objetivo',
                  :value => 1)
    Answer.create(:number => 2,
                  :question_id => Question.last.id,
                  :description => 'Beneficios del producto',
                  :value => 1)
    Answer.create(:number => 3,
                  :question_id => Question.last.id,
                  :description => 'Objetivos del proyecto',
                  :value => 1)

   Aspect.create(:name => 'Aspectos de la estructura de la organización')
   
   Question.create(:number => 5,
                   :description => %{Con respecto a la toma de decisiones en el proceso de diseño y desarrollo de productos, señale de los siguientes aspectos el que más se acerca a la situaciín actual de su empresa},
                   :aspect_id => Aspect.last.id,
                   :category => 'nested')

   Subquestion.create(:number => 1,
                      :description => 'Para dar prioridad a los proyectos',
                      :question_id => Question.last.id)
   Subquestion.create(:number => 2,
                      :description => 'Para asignar recursos',
                      :question_id => Question.last.id)
   Subquestion.create(:number => 3,
                      :description => 'Para decidir el tiempo de desarrollo de los productos',
                      :question_id => Question.last.id)

   Answer.create(:number => 1,
                 :question_id => Question.last.id,
                 :description => 'No es posible identificar un responsable',
                 :value => 1)

   Answer.create(:number => 2,
                 :question_id => Question.last.id,
                 :description => 'Una persona (jefe) de las áreas',
                 :value => 2)

   Answer.create(:number => 3,
                 :question_id => Question.last.id,
                 :description => 'La dirección de la empresa',
                 :value => 3)

  end

  def self.down
    Question.delete_all
    Answer.delete_all
    Aspect.delete_all
  end 

end

