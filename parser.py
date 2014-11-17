from twisted.internet import reactor
from scrapy import Spider, Item, Field, log, signals
from scrapy.crawler import Crawler
from scrapy.utils.project import get_project_settings

class Person(Item):
    firstName = Field()
    lastName = Field()

class PersonSpider(Spider):
    name = 'personspider'
    start_urls = [
        "http://www.ifmo.ru/person_list/192/letter_192.htm",
        "http://www.ifmo.ru/person_list/193/letter_193.htm",
        "http://www.ifmo.ru/person_list/194/letter_194.htm",
        "http://www.ifmo.ru/person_list/195/letter_195.htm",
        "http://www.ifmo.ru/person_list/196/letter_196.htm",
        "http://www.ifmo.ru/person_list/197/letter_197.htm",
        "http://www.ifmo.ru/person_list/198/letter_198.htm",
        "http://www.ifmo.ru/person_list/199/letter_199.htm",
        "http://www.ifmo.ru/person_list/200/letter_200.htm",
        "http://www.ifmo.ru/person_list/202/letter_202.htm",
        "http://www.ifmo.ru/person_list/203/letter_203.htm",
        "http://www.ifmo.ru/person_list/204/letter_204.htm",
		"http://www.ifmo.ru/person_list/205/letter_205.htm",
		"http://www.ifmo.ru/person_list/206/letter_206.htm",
		"http://www.ifmo.ru/person_list/207/letter_207.htm",
		"http://www.ifmo.ru/person_list/208/letter_208.htm",
		"http://www.ifmo.ru/person_list/209/letter_209.htm",
		"http://www.ifmo.ru/person_list/210/letter_210.htm",
		"http://www.ifmo.ru/person_list/211/letter_211.htm",
		"http://www.ifmo.ru/person_list/212/letter_212.htm",
		"http://www.ifmo.ru/person_list/213/letter_213.htm",
		"http://www.ifmo.ru/person_list/214/letter_214.htm",
		"http://www.ifmo.ru/person_list/215/letter_215.htm",
		"http://www.ifmo.ru/person_list/216/letter_216.htm",
		"http://www.ifmo.ru/person_list/217/letter_217.htm",
		"http://www.ifmo.ru/person_list/221/letter_221.htm",
		"http://www.ifmo.ru/person_list/222/letter_222.htm",
		"http://www.ifmo.ru/person_list/223/letter_223.htm"]

    def parse(self, response):
        for sel in response.xpath('//ul/li/a[starts-with(@href, "/person/")]/text()'):
            item = Person()
            fullName = sel.extract().split(' ')
            item['firstName'] = fullName[1]
            item['lastName'] = fullName[0]
            yield item

def main():
    spider = PersonSpider()
    settings = get_project_settings()
    settings.set("ITEM_PIPELINES", {
        'pipelines.PersonPipeline': 0
    })
    crawler = Crawler(settings)
    crawler.signals.connect(reactor.stop, signal=signals.spider_closed)
    crawler.configure()
    crawler.crawl(spider)
    crawler.start()
    log.start()
    reactor.run()

if __name__ == "__main__":
    main()
