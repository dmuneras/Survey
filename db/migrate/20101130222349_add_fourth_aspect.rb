# -*- coding: utf-8 -*-
class AddFourthAspect < ActiveRecord::Migration
  def self.up
    Aspect.create(:name => 'Aspectos del proceso, diseño y desarrollo de nuevos productos')

    # Pregunta 8
    Question.create(:number => 8,
                    :aspect_id => Aspect.last.id,
                    :description => %{A continuación se muestran 5 enunciados con respecto a la descripción general del plan de diseño y desarrollo de productos; seleccione el que mejor describa la situación actual de su empresa},
                    :category => 'unique')

    descs = []
    descs << %{La empresa no elabora planes para ninguno de sus proyectos}
    descs << %{La empresa elabora planes para sus proyectos, pero no los documenta}
    descs << %{La empresa elabora planes para algunos de sus proyectos, normalmente los que la empresa considera necesarios}
    descs << %{La empresa elabora planes para todos sus proyectos}
    descs << %{La empresa elabora planes para todos sus proyectos, los documenta y son objeto de revisión y actualización periódica}

    vals = [1,2,3,4,5]

    i = 1
    for d in descs do
      Answer.create(:number => i,
                    :question_id => Question.last.id,
                    :description => d,
                    :value => vals[i-1])

      i += 1
    end
    
    # Pregunta 9
    Question.create(:number => 9,
                    :aspect_id => Aspect.last.id,
                    :description => %{Señale TODOS los aspectos que se consideran o se describen en el plan de proyecto de desarrollo de NUEVOS producto (en caso de ser necesario, puede señalar más de un tema)},
                    :category => 'multiple')

    descs = []
    descs << 'Mercado objetivo'
    descs << 'Beneficios del producto'
    descs << 'Objetivos del proyecto'
    descs << 'Especificaciones de diseño'
    descs << 'Cronograma'
    descs << 'Metas comerciales'
    descs << 'Análisis de viabilidad económica'
    descs << 'Análisis de viabilidad técnica'
    descs << 'Análisis de viabilidad mercado'
    descs << 'Definición del equipo de trabajo'
    descs << 'Justificación'
    descs << 'Definición del usuario'
    descs << 'Identificación de mercados'
    descs << 'Definición de clientes'

    i = 1
    for d in descs do
      Answer.create(:number => i,
                    :description => d,
                    :value => 1,
                    :question_id => Question.last.id)
      i += 1
    end

    # Pregunta 10
    Question.create(:number => 10,
                    :description => %{A continuación se muestran 5 enunciados con respecto al plan de mercado de nuevos productos; seleccione el que mejor describa la situación actual de su empresa},
                    :aspect_id => Aspect.last.id,
                    :category => 'unique')

    descs = []
    descs << %{La empresa no tiene definido el plan de mercadeo de nuevos productos}
    descs << %{La empresa tiene definido el plan de mercadeo de los nuevos productos desarrollados, sin embargo este no se encuentra documentado}
    descs << %{La empresa tiene definido el plan de mercadeo de los nuevos productos desarrollados, solamente para algunos de sus nuevos productos}
    descs << %{La empresa tiene definido el plan de mercadeo de los nuevos productos desarrollados, para todos y cada uno de los nuevos productos}
    descs << %{La empresa tiene definido el plan de mercadeo de los nuevos productos desarrollados para todos y cada uno de sus nuevos productos, está documentado y es objeto de monitoreo periódico}

    vals = [1,2,3,4,5]

    i = 1
    for d in descs do
      Answer.create(:number => i,
                    :description => d,
                    :question_id => Question.last.id,
                    :value => vals[i-1])
      i += 1
    end

    # Pregunta 11
    Question.create(:number => 11,
                    :aspect_id => Aspect.last.id,
                    :description => %{A continuación se muestran 5 enunciados con relación al proceso de diseño y desarrollo de productos (pasos, etapas, fases); seleccione el que mejor describa la situación actual de su empresa},
                    :category => 'unique')
                    
    descs = []
    descs << %{La empresa no tiene definido un proceso de diseño y desarrollo de nuevos productos}
    descs << %{En la empresa está definida la estructura del proceso de diseño y desarrollo de nuevos productos, sin embargo esta no se encuentra documentada}
    descs << %{En la empresa está definida la estructura del proceso de diseño y desarrollo de nuevos productos, solamente para algunos de los nuevos productos}
    descs << %{En la empresa está definida la estructura del proceso de diseño y desarrollo de nuevos productos, para todos y cada uno de estos, además se utilizan métodos y herramientas para el desarrollo del proceso de diseño y desarrollo de nuevos productos}
    descs << %{En la empresa está definida la estructura del proceso de diseño y desarrollo de nuevos productos, para todos y cada uno de estos, además se utlizan métodos y herramientas para el desarrollo del proceso de diseño y desarrollo de nuevos productos y la estructura es objeto de monitoreo periódico}

    vals = [1,2,3,4,5]
    
    i = 1
    for d in descs do
      Answer.create(:number => i,
                    :description => d,
                    :value => vals[i-1],
                    :question_id => Question.last.id)
      i += 1
    end

    # Pregunta 12
    Question.create(:number => 12,
                    :description => %{Señale TODOS los aspectos que se consideran o se describen actualmente en su empresa en el proceso de diseño y desarrollo de nuevos productos},
                    :aspect_id => Aspect.last.id,
                    :category => 'multiple')

    descs = []
    descs << 'Investigación de necesidades del usuario'
    descs << 'Segmentación del mercado'
    descs << 'Participación del usuario en el proceso'
    descs << 'Análisis competitivo del producto'
    descs << 'Lista de requerimientos del producto'
    descs << 'Generación de conceptos'
    descs << 'Elaboración de modelos para pruebas de usuario'
    descs << 'Evaluación y selección de conceptos'
    descs << 'Diseño para la manufactura y el ensamble'
    descs << 'Elaboración de prototipo para evaluaciones técnicas y económicas'

    i = 1
    for d in descs do
      Answer.create(:number => i,
                    :description => d,
                    :question_id => Question.last.id,
                    :value => 1)
      i += 1
    end

    # Pregunta 13
    Question.create(:number => 13,
                    :aspect_id => Aspect.last.id,
                    :description => %{A continuación se muestran 5 enunciados con relación a la gestión (gerencia) del proceso de diseño y desarrollo de productos, seleccione el que mejor describa la situación actual de su empresa},
                    :category => 'unique')

    descs = []
    descs << %{La empresa no tiene definido un modelo de gestión}
    descs << %{La empresa tiene definido un modelo de gestión, pero no está documentado}
    descs << %{La empresa tiene definido un modelo de gestión que lo utiliza cuando lo considera necesario y está documentado}
    descs << %{La empresa tiene definido un modelo de gestión para todos los procesos de diseño y desarrollo de productos y está documentado}
    descs << %{La empresa tiene definido un modelo de gestión para todos los procesos de diseño y desarrollo de productos, en este se incluye una revisión de objetivos vs resultados vs tiempo, y son objetos de monitoreo periódico}

    vals = [1,2,3,4,5]
    
    i = 1
    for d in descs do
      Answer.create(:number => i,
                    :description => d,
                    :value => vals[i-1],
                    :question_id => Question.last.id)
      i += 1
    end

    # Pregunta 14
    Question.create(:number => 14,
                    :aspect_id => Aspect.last.id,
                    :description => %{Seleccione las áreas con las que el equipo responsable del proceso de diseño y desarrollo de productos realiza los trabajos en paralelo},
                    :category => 'multiple')

    descs = []
    descs << 'Área de mercadeo'
    descs << 'Área de producción'
    descs << 'Área de ventas'
    descs << 'Área financiera y contable'
    descs << 'Área de gestión del recurso humano'
    descs << 'Área jurídica'
    descs << 'Área de investigación y desarrollo'
    descs << 'Dirección de la empresa'

    i = 1
    for d in descs do
      Answer.create(:number => i,
                    :description => d,
                    :question_id => Question.last.id,
                    :value => 1)
      i += 1
    end

    # Pregunta 15
    Question.create(:number => 15,
                    :description => %{A continuación se muestran 2 situaciones extremas con relación a los beneficios <strong>beneficios de los productos; seleccione en la escala</strong> el escenario que corresponda con la situación actual de la empresa},
                    :aspect_id => Aspect.last.id,
                    :category => 'scale')

    QuestionScale.create(:question_id => Question.last.id,
                         :lower => %{Los productos presentan diferenciadores genéricos similares a los de la competencia},
                         :higher => %{Los productos ofrecen aspectos diferenciadores claves, presentan beneficios únicos al tenerlos o usarlos})
    
    descs = [3,2,1,0,1,2,3]
    vals = [1,2,2,3,4,4,5]

    i = 1
    for d in descs do
      Answer.create(:number => i,
                    :description => d.to_s,
                    :value => vals[i-1],
                    :question_id => Question.last.id)
      i += 1
    end
    
    # Pregunta 16
    Question.create(:number => 16,
                    :aspect_id => Aspect.last.id,
                    :description => %{A continuación se muestran 2 situaciones extremas con relación a las <strong>funciones y características; seleccione en la escala</strong> el escenario que corresponda con la situación actual de su empresa},
                    :category => 'scale')

    QuestionScale.create(:question_id => Question.last.id,
                         :lower => %{Los productos ofrecen nuevas soluciones a problemas de una manera interesante},
                         :higher => %{Los productos presentan funciones y precios similares la competencia})

    descs = [3,2,1,0,1,2,3]
    vals = [5,4,4,3,2,2,1]
    
    i = 1
    for d in descs do
      Answer.create(:number => i,
                    :description => d.to_s,
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
