# Пример #1

## Описание

На базе простого примера показываются основные шаги (а) для создания RDF датасета из существующего источника, (б) развертывание SPARQL endpoint'а, (в) выполнение простых и (г) федеративных SPARQL запросов.

RDF датасет создается из извлеченых полных имен со страницы [Персоналии](http://www.ifmo.ru/person_list/192/66/person_spisok.htm) и с использованием онтологии [FOAF](http://www.foaf-project.org/) в RDF файл `dump.ttl` записываются имя и фамилия каждого из перечисленных на этой странице персон.

Далее мы может выполнить любые SPARQL запросы на полученных данных, в том числе мы можешь выполнять [федеративные SPARQL запросы](http://www.w3.org/TR/sparql11-federated-query/), в данном примере используется ресурс http://lod.ifmo.ru.

## Установка необходимых библиотек
Для этого примера был написан просто парсер (`parser.py`) на [Python](http://en.wikipedia.org/wiki/Python_%28programming_language%29) и с использованием следующих библиотек:
 * Scrapy (http://scrapy.org/)
 * RDFLib (https://github.com/RDFLib/rdflib)
 
 Команды для установки этих библиотек (для Linux):
 
      pip install scrapy
      pip install rdflib
      
## Запуск парсера

    python parser.py
    
В результате в текущей директории в файл `dump.ttl` будет записаны соответствующие RDF триплы в формате [Turtle](http://en.wikipedia.org/wiki/Turtle_%28syntax%29).

## Установка и запуск [Fuseki](http://jena.apache.org/documentation/serving_data/)

1. Скачиваем архив `fuseki-*VER*.distribution.zip` с http://jena.apache.org/download/index.cgi,
2. Распаковываем и, используя командную строку, переходим в распакованную папку,
3. Запускаем Fuseki: `fuseki-server --file=<пути до dump.ttl> /ds`,
4. Открываем в браузере `http://localhost:3030` и переходим в `Control Panel -> Select -> SPARQL Query`,
5. Теперь в форме `SPARQL Query` можно выполнять запросы к спаршенным данным, например, получить первые 10 триплов:

        SELECT * WHERE {
          ?x ?y ?z
        } 
        LIMIT 10

## SPARQL запросы
### Запрос #1: Перечислить имена и фамилии всех персон

      PREFIX foaf: <http://xmlns.com/foaf/0.1/>
      SELECT ?fname ?lname WHERE {
        ?x a foaf:Person ;
          foaf:firstName ?fname ;
          foaf:lastName ?lname .
      }

### Запрос #2: Перечислить имена всех однофамильцев

      PREFIX foaf: <http://xmlns.com/foaf/0.1/>
      SELECT ?x ?y ?lname ?f1name ?f2name WHERE {
        ?x a foaf:Person ;
          foaf:firstName ?f1name ;
          foaf:lastName ?lname .
        ?y a foaf:Person ;
          foaf:firstName ?f2name ;
          foaf:lastName ?lname .
      }

### Запрос #3: Перечислить людей из [Персоналия](http://www.ifmo.ru/person_list/192/66/person_spisok.htm), работающих в международных научных лабораториях ИТМО (далее - МНЛ)

      PREFIX foaf: <http://xmlns.com/foaf/0.1/>
      SELECT ?x ?y ?lname ?fname WHERE {
        ?x a foaf:Person ;
          foaf:firstName ?fname ;
          foaf:lastName ?lname .
        SERVICE <http://lod.ifmo.ru/sparql> {
          ?y foaf:firstName ?fname ;
             foaf:lastName ?lname .
        }
      }

В данном случае используется федеративный SPARQL запрос. Подзапрос, который записан в выражении `SERVICE` отправляется на удаленный SPARQL endpoint по адресу `http://lod.ifmo.ru/sparql`, где содержится информация о сотрудниках МНЛ, а далее результаты запросов "объединяются".
