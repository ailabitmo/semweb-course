# Пример #1

## Установка необходимых библиотек
Для работы данного примера потребуется установка следующих библиотек:
 * Scrapy (http://scrapy.org/)
 * RDFLib (https://github.com/RDFLib/rdflib)
 
 Команды для установки этих библиотек (для Linux):
 
      pip install scrapy
      pip install rdflib
      
## Запуск парсера

    python parser.py
    
В результате в текущей директории в файл `dump.ttl` будет записаны соответствующие RDF триплы в формате [turtle](http://en.wikipedia.org/wiki/Turtle_%28syntax%29).

## Установка и запуск [Fuseki](http://jena.apache.org/documentation/serving_data/)
