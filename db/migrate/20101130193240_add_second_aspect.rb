# -*- coding: utf-8 -*-
class AddSecondAspect < ActiveRecord::Migration
  def self.up
    Aspect.create(:name => 'Aspectos de la estructura de la organización')
    
    # Pregunta 4
    Question.create(:number => 4,
                    :aspect_id => Aspect.last.id,
                    :description => %{A continuación se muestran 5 enunciados con respecto a la existencia y conformación de equipos de trabajo para el proceso de diseño y desarrollo de productos; seleccione el que mejor describa la situación actual de su empresa},
                    :category => 'unique')


    descs = []
    descs << %{No existe un equipo de trabajo para el proceso de disño y desarrollo de productos. Las personas trabajan de manera independiente}
    descs << %{Las personas que participan en el proceso de diseño y desarrollo de productos trabajan de manera secuencial e independiente y hay poca comunicación entre las diferentes áreas}
    descs << %{Las personas que participan en el proceso de diseño y desarrollo de productos trabajan en paralelo de manera independiente y se reúnen únicamente para coordinar acciones en el proceso}
    descs << %{La empresa tiene un equipo de trabajo conformado por personas de diferentes áreas o departamentos que participan de manera paralela y no tiene dedicación exclusiva en el proceso}
    descs << %{La empresa tiene un equipo de trabajo conformado por personas de diferentes áreas y disciplinas que se comunican e interrelacionan de manera permanente y se dedican exclusivamente a este proceso}

    vals = [1,2,3,4,5]

    i = 1
    for desc in descs do
      Answer.create(:number => i,
                    :question_id => Question.last.id,
                    :description => desc,
                    :value => vals[i-1])
      i += 1
    end

    # Pregunta 5
    Question.create(:number => 5,
                    :aspect_id => Aspect.last.id,
                    :description => %{Con respecto a la toma de decisiones en el proceso de diseño y desarrollo de productos, señale de los siguientes aspectos el que más se acerca a la situación actual de su empresa},
                    :category => 'nested')

    descs = []
    descs << 'No es posible identificar un responsable'
    descs << 'Una persona (jefe) de las áreas'
    descs << 'La dirección de la empresa'
    descs << 'Los jefes de área'
    descs << 'Hay un equipo de desarrollo de productos encargado de la toma de decisiones'

    vals = [1,2,3,4,5]
    
    i = 1
    for desc in descs do
      Answer.create(:number => i,
                    :description => desc,
                    :question_id => Question.last.id,
                    :value => vals[i-1])
      i += 1
    end

    descs = []
    descs << 'Para dar prioridad a los proyectos'
    descs << 'Para asignar los recursos'
    descs << 'Para decidir el tiempo de desarrollo de los productos'
    descs << 'Para tomar decisiones de continuar o abandonar los proyectos'
    descs << 'Para definir una alternativa de producto a desarrollar'
    descs << 'Para buscar solución a problemas de manufactura'
    descs << 'Para buscar soluciones a problemas de desarrollo del mercado'

    i = 1
    for desc in descs do
      Subquestion.create(:number => i,
                         :description => desc,
                         :question_id => Question.last.id)
      i += 1
    end

    # Pregunta 6
    Question.create(:number => 6,
                    :aspect_id => Aspect.last.id,
                    :description => %{Señale con qué frecuencia se involucran especialistas externos que apoyen el proceso de diseño y desarrollo de productos a la empresa para el desarrollo de productos en su empresa},
                    :category => 'unique')

    descs = []
    descs << 'No aplica'
    descs << 'Siempre'
    descs << 'Casi siempre'
    descs << 'Algunas veces'
    descs << 'Casi nunca'
    descs << 'Nunca'
    
    vals = [0,4,3,2,1,0]

    i = 1
    for desc in descs do
      Answer.create(:number => i,
                    :question_id => Question.last.id,
                    :description => desc,
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
