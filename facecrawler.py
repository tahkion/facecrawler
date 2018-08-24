#!/usr/bin/python3
from icrawler import ImageDownloader
from icrawler.builtin import GoogleImageCrawler, BingImageCrawler, BaiduImageCrawler, GreedyImageCrawler
from PIL import Image
from io import BytesIO
import face_recognition, optparse, logging, time

parser = optparse.OptionParser('usage%prog')

parser.add_option('-i', dest='image', help='The image you would like to use for reference.')
parser.add_option('-q', dest='query', help='The search query you would like to use.')
parser.add_option('-u', dest='url', help='The base URL you would like to start crawling from.')
parser.add_option('-n', dest='number', help='The number of matches you would like to attempt to find.')
parser.add_option('-e', dest='engine', help='The engine/method you would like to use. Options: Google, Bing, Baidu, Greedy')
(options,args) = parser.parse_args()

image = options.image
query = options.query
url = options.url
number = options.number
engine = options.engine

#Set default for number if none set, convert to integer
number = "5" if number is None else number
num = int(number)

#Load image variable  as positvely identified image
start = time.time()
known_image = face_recognition.load_image_file(image)
known_encoding = face_recognition.face_encodings(known_image)[0]
match = face_recognition.compare_faces([known_encoding], known_encoding)
print ("Calibration Status:",match,"")
print ("Calibration Time:",(time.time() - start),"Seconds")

class MyImageDownloader(ImageDownloader):
#        def __init__(self, thread_num, signal, session, storage, log_file):
#            super(MyImageDownloader, self).__init__(thread_num, signal, session,
#                                               storage)
#            self.log_file = open(log_file, 'w')
#        def process_meta(self, task):
#            if task['success']:
#                with self.lock:
#                    self.log_file.write('{} {}\n'.format(
#                        task['filename'], task['file_url']))
        def keep_file(self, task, response, **kwargs):
            try:
                img = Image.open(BytesIO(response.content))
                img.save("out.jpg", "JPEG", quality=80, optimize=True)
                unknown_image = face_recognition.load_image_file("out.jpg")
                unknown_encoding = face_recognition.face_encodings(unknown_image)[0]
                results = face_recognition.compare_faces([known_encoding], unknown_encoding)
            except (IndexError, IOError, OSError):
                return False
            else:
                if results == (match):
                    print ("Image match")
                    return True;
                else:
                    print ("No match found")
                    return False;

if engine in ('Google', 'google'):
    google_crawler = GoogleImageCrawler(
        downloader_cls=MyImageDownloader,
        feeder_threads=1,
        parser_threads=1,
        downloader_threads=4,
        storage={'root_dir': 'matches'})
#        log_level=logging.INFO,
#        extra_downloader_args={'log_file': 'meta.txt'})
    google_crawler.crawl(keyword=(query), max_num=(num), file_idx_offset=0)

elif engine in ('Bing', 'bing'):
    bing_crawler = BingImageCrawler(
        downloader_cls=MyImageDownloader,
        feeder_threads=1,
        parser_threads=1,
        downloader_threads=4,
        storage={'root_dir': 'matches'})
#        log_level=logging.INFO,
#        extra_downloader_args={'log_file': 'meta.txt'})
    bing_crawler.crawl(keyword=(query), filters=None, offset=0, max_num=(num))

elif engine in ('Baidu', 'baidu'):
    baidu_crawler = BaiduImageCrawler(
        downloader_cls=MyImageDownloader,
        feeder_threads=1,
        parser_threads=1,
        downloader_threads=4,
        storage={'root_dir': 'matches'})
#        log_level=logging.INFO,
#        extra_downloader_args={'log_file': 'meta.txt'})
    baidu_crawler.crawl(keyword=(query), offset=0, max_num=(num), min_size=(200,200), max_size=None)

elif engine in ('Greedy', 'greedy'):
    greedy_crawler = GreedyImageCrawler(
       downloader_cls=MyImageDownloader,
        feeder_threads=1,
        parser_threads=1,
        downloader_threads=4,
        storage={'root_dir': 'matches'})
    greedy_crawler.crawl(domains=(url), max_num=(num), min_size=None, max_size=None)

#For Flickr
#from datetime import date
#from icrawler.builtin import FlickrImageCrawler

#flickr_crawler = FlickrImageCrawler('your_apikey',
#                                    storage={'root_dir': 'your_image_dir'})
#flickr_crawler.crawl(max_num=1000, tags='child,baby',
#                     group_id='68012010@N00', min_upload_date=date(2015, 5, 1))

