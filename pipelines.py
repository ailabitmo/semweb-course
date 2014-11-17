from scrapy import log
from rdflib import Graph, URIRef, Literal
from rdflib.namespace import RDF, FOAF

class PersonPipeline(object):

    def __init__(self):
        self.base = 'http://example.com/person/'
        self.count = 0
        self.repo = Graph(store='default')
        self.repo.bind('foaf', FOAF)

    def process_item(self, item, spider):
        self.count += 1
        resource = URIRef(self.base + str(self.count))
        self.repo.add((resource, RDF.type, FOAF.Person))
        self.repo.add((resource, FOAF.firstName, Literal(item['firstName'], lang='ru')))
        self.repo.add((resource, FOAF.lastName, Literal(item['lastName'], lang='ru')))

    def close_spider(self, spider):
        f = open('dump.ttl', 'w')
        self.repo.serialize(f, format='turtle')
        self.repo.close()
