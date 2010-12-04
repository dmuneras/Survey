# -*- coding: utf-8 -*-
class AddFourthAspect < ActiveRecord::Migration
  def self.up
    Aspect.create(:name => 'Aspectos del proceso, diseño y desarrollo de nuevos productos')

    # Pregunta 8
    Question.create(:number => 8,
                    :aspect_id => Aspect.last.id,
                    :description => %{A continuación se muestran 5 enunciados con respecto a la descripción general del <dfn title="Una serie de tareas, pasos y fases disciplinadas y definidas que describen el significado por el cual una compañía repetitivamente convierte ideas iniciales en productos o servicios vendibles.">plan de diseño y desarrollo de productos</dfn>; seleccione el que mejor describa la situación actual de su empresa},
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
    descs << %{<dfn title="Segmento del mercado al que está dirigido un bien, ya sea producto o servicio. Generalmente, se define en términos de edad, género o variables socioeconómicas.">Mercado objetivo</dfn>}
    descs << %{<dfn title="Los beneficios son las necesidades del cliente satisfechas por las características o rasgos de un producto. Algunos rasgos son: tamaño, color, potencia, funcionalidad, diseño, horas de servicio y contenido estructural. Los beneficios son menos tangibles, pero siempre responden a la pregunta del cliente: ¿En qué me beneficia?">Beneficios del producto</dfn>}
    descs << %{<dfn title="<dl><dt>Objetivo general:</dt><dd>Descripción objetiva y concisa que se pretende alcanzar con la intervención que se está planeando o ejecutando.</dd><dt>Objetivo específico:</dt><dd>Detalla, desglosa, y define con mayor precisión las metas que se pretende alcanzar.</dd></dl>">Objetivos del proyecto</dfn>}
    descs << %{<dfn title="Planteamiento de objetivos de diseño y funciones, lo que debe lograr o hacer un diseño, especificaciones técnicas, económicas, de diseño, etc.">Especificaciones de diseño</dfn>}
    descs << %{<dfn title="Calendario de trabajo, lista de todos los elementos terminales de un proyecto con sus fechas previstas de comienzo y final.">Cronograma</dfn>}
    descs << %{<dfn title="Fin a que se dirigen las acciones o deseos de la compañía, son la base para el conjunto de metas de un negocio.">Metas comerciales</dfn>}
    descs << %{<dfn title="Determinación en cuanto a la probabilidad de éxito y una descripción de cómo esa determinación fue alcanzada.">Análisis de viabilidad</dfn> económica}
    descs << 'Análisis de viabilidad técnica'
    descs << 'Análisis de viabilidad mercado'
    descs << %{Definición del <dfn title="Se refiere a un conjunto de personas interrelacionadas que se van a organizar para llevar a cabo una determinada tarea.">equipo de trabajo</dfn>}
    descs << %{<dfn title="Sustentar con argumentos convincentes la realización de un proyecto, es decir, señalar por qué y para qué se va a llevar a cabo señalando quiénes se benefician de él.">Justificación</dfn>}
    descs << %{<dfn title="Clientes potenciales y reales. Hay que investigar cuáles son sus necesidades, deseos, hábitos de compra, capacidad de compra, etc.">Definición del usuario</dfn>}
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
                    :description => %{A continuación se muestran 5 enunciados con respecto al <dfn title="Documento escrito que detalla las acciones necesarias para alcanzar un objetivo específico de mercadeo.<ul><li>Describir y explicar la situación actual del producto.</li><li>Especificar los resultados esperados.</li><li>Identificar los recursos que se necesitarán.</li></ul>">plan de mercado</dfn> de nuevos productos; seleccione el que mejor describa la situación actual de su empresa},
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
    descs << %{En la empresa está definida la <dfn title="Se refiere a la distribución de las partes del proceso, es decir, todas las etapas que se llevan a cabo para analizar, sintetizar y evaluar todas las etapas del proceso.">estructura del proceso de diseño y desarrollo de nuevos productos</dfn>, sin embargo esta no se encuentra documentada}
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
    descs << %{La empresa no tiene definido un <dfn title="Programa oficial dentro de una empresa en donde el diseño es una actividad estratégica. Implica entender y comunicar la relevancia del diseño dentro de los objetivos a largo plazo y coordinar todos los recursos destinados a la actividad de diseño en todos los niveles y en todas las actividades que se realizan en la empresa para alcanzar los objetivos corporativos propuestos.">modelo de gestión</dfn>}
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
    
    descs = [-3,-2,-1,0,1,2,3]
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

    descs = [-3,-2,-1,0,1,2,3]
    vals = [5,4,4,3,2,2,1]
    
    i = 1
    for d in descs do
      Answer.create(:number => i,
                    :description => d.to_s,
                    :question_id => Question.last.id,
                    :value => vals[i-1])
      i += 1
    end
    
    # Pregunta 17
    Question.create(:number => 17,
                    :aspect_id => Aspect.last.id,
                    :description => %{A continuación se muestran 2 situaciones extremas en relación a la <strong>tecnología; seleccione en la escala</strong> el escenario que corresponda con la situación actual de su empresa},
                    :category => 'scale')

    QuestionScale.create(:question_id => Question.last.id,
                         :lower => %{Los productos utilizan tecnología convencional, similar a la de la competencia},
                         :higher => %{La tecnología utilizada hace posible proponer productos nuevos y diferenciados al mercado})

    descs = [-3,-2,-1,0,1,2,3]
    vals = [1,2,2,3,4,4,5]

    i = 1
    for d in descs do
      Answer.create(:number => i,
                    :description => d.to_s,
                    :value => vals[i-1],
                    :question_id => Question.last.id)
      i += 1
    end

    # Pregunta 18
    Question.create(:number => 18,
                    :aspect_id => Aspect.last.id,
                    :description => %{A continuación se muestran 2 situaciones extremas con relación a la <strong>calidad técnica (confiabilidad, durabilidad, etc)</strong>; seleccione en la escala el escenario que corresponda con la situación actual de su empresa},
                    :category => 'scale')

    QuestionScale.create(:question_id => Question.last.id,
                         :lower => %{La ingeniería involucrada en los productos es un diferenciador clave con respecto a la competencia},
                         :higher => %{La ingeniería involucrada es similar a la competencia})

    descs = [-3,-2,-1,0,1,2,3]
    vals = [5,4,4,3,2,2,1]

    i = 1
    for d in descs do
      Answer.create(:number => i,
                    :description => d,
                    :value => vals[i-1],
                    :question_id => Question.last.id)
      i += 1
    end

    # Pregunta 19
    Question.create(:number => 19,
                    :aspect_id => Aspect.last.id,
                    :description => %{A continuación se presentan 2 situaciones extremas con relación a la <strong>estética (formas, colores y texturas)</strong>; seleccione en la escala el escenario que corresponda con la situación actual de su empresa},
                    :category => 'scale')

    QuestionScale.create(:question_id => Question.last.id,
                         :lower => %{La estética de los productos es similar a la de la competencia},
                         :higher => %{Los aspectos estéticos de los productos son novedosos y constituyen un diferenciador clave frente a la competencia})

    descs = [-3,-2,-1,0,1,2,3]
    vals = [1,2,2,3,4,4,5]

    i = 1
    for d in descs do
      Answer.create(:number => i,
                    :description => d,
                    :question_id => Question.last.id,
                    :value => vals[i-1])
      i += 1
    end

    # Pregunta 20
    Question.create(:number => 20,
                    :aspect_id => Aspect.last.id,
                    :description => %{A continuación se muestran 2 situaciones extremas con relación a <strong>usabilidad (relación usuario.producto)</strong>; seleccione en la escala el escenario que corresponda con la situación actual de su empresa},
                    :category => 'scale')

    QuestionScale.create(:question_id => Question.last.id,
                         :lower => %{La interfaz o manera como los productos comunican la manera en que pueden ser utilizados constituyen un diferenciador clave frente a la competencia},
                         :higher => %{La interfaz o manera como los productos comunican la manera en que pueden ser utilizados es similar al de la competencia})

    descs = [-3,-2,-1,0,1,2,3]
    vals = [5,4,4,3,2,2,1]

    i = 1
    for d in descs do
      Answer.create(:number => i,
                    :description => d,
                    :question_id => Question.last.id,
                    :value => vals[i-1])
      i += 1
    end

    # Pregunta 21
    Question.create(:number => 21,
                    :aspect_id => Aspect.last.id,
                    :description => %{A continuación se muestran 2 situaciones extremas con relación a los <strong>materiales</strong>; seleccione en la escala el escenario que corresponda con la situación actual de su empresa},
                    :category => 'scale')

    QuestionScale.create(:question_id => Question.last.id,
                         :lower => %{Los productos emplean materiales similares a los de la competencia},
                         :higher => %{Los productos emplean materiales novedosos que constituyen un aspecto diferenciador frente a los productos de la competencia})

    descs = [-3,-2,-1,0,1,2,3]
    vals = [1,2,2,3,4,4,5]

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
