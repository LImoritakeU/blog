.PHONY: upload server clean init

clean:
	hexo clean
	cd themes/typography && npm run scss-compile

server:
	hexo server -d

upload:
	gsutil rsync  -r ./public/ gs://www.limoritakeu.tech
	# -x "^.+.(html|xml|jpg|png)$\"

init:
	npm install
	git clone https://github.com/SumiMakito/hexo-theme-typography themes/typography
	cd themes/typography && npm install
