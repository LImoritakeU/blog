.PHONY: upload server clean

clean:
	hexo clean
	cd themes/typography && npm run scss-compile

server:
	hexo server -d

upload:
	gsutil rsync -x "^.+.(html|xml|jpg|png)$\" -r ./public/ gs://www.limoritakeu.tech

build:
	npm install
	git clone https://github.com/SumiMakito/hexo-theme-typography themes/typography
	cd themes/typography && npm install
