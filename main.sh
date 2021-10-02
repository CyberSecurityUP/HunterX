#!/bin/bash
while :; do
echo "Welcome to HunterX"
echo "Simple Tool based King of bug bounty Tips"
echo "Create by Joas Antonio"
echo "Version 1.0"
echo ""
echo "1 - Install Requeriments"
echo "2 - Tricks and Tips"
echo "3 - Automation Recon"
echo "4 - Credits"
echo ""
read -p "Select Options: " option
echo ""
if [ $option -eq 1 ];
then
	echo "Install Go"
	echo ""
	apt-get update && apt-get install go -y
	echo ""
	echo "Download Amass"
	echo ""
	go get -v github.com/OWASP/Amass
	cd $GOPATH/src/github.com/OWASP/Amass
	go install ./...
	echo ""
	echo "Download Anew"
	go get -u github.com/tomnomnom/anew
	echo ""
	echo "Assetfinder"
	go get -u github.com/tomnomnom/assetfinder
	echo ""
	echo "Axiom"
	bash <(curl -s https://raw.githubusercontent.com/pry0cc/axiom/master/interact/axiom-configure)
	echo ""
	echo "Chaos"
	GO111MODULE=on go get -v github.com/projectdiscovery/chaos-client/cmd/chaos
	echo ""
	echo "Findomain"
	wget https://github.com/findomain/findomain/releases/latest/download/findomain-linux
	chmod +x findomain-linux
	./findomain-linux
	echo ""
	echo "Httpx"
	GO111MODULE=on go get -v github.com/projectdiscovery/httpx/cmd/httpx
	echo ""
	echo "Waybackupurls"
	go get github.com/tomnomnom/waybackurls
	echo ""
	echo "Subfinder"
	go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
	echo ""
	echo "Ffuf"
	go get -u github.com/ffuf/ffuf
	echo ""
	echo "Hakcrawler"
	go install github.com/hakluke/hakrawler@latest
	echo ""
	echo "Gospider"
	echo ""
	GO111MODULE=on go get -u github.com/jaeles-project/gospider
elif [ $option -eq 2 ];
then
	echo "Tips and Tricks Recon"
	echo ""
        echo "1 - Oneliner Haklistgen"
        echo "2 - Using x8 to Hidden parameters discovery"
	echo "3 - Search .json gospider filter anti-burl"
	echo "4 - Search .json subdomain"
	echo "5 - Axiom Recon"
	echo "6 - Search .js using"
	echo "7 - Download all domains to bounty chaos"
	echo "8 - Search subdomains in cert.sh"
	echo "9 - Chaos to search subdomains check cloudflareip scan port"
	echo "10 - Search to files using assetfinder and ffuf"
	read -p "Select Recon option: " recon
	echo ""
	if [ $recon -eq 1 ];
	then
		echo "Oneliner Haklistgen"
		echo "----------------------------------------------------------------"
		echo "subfinder -silent -d domain | anew subdomains.txt | httpx -silent | anew urls.txt | hakrawler | anew endpoints.txt | while read url; do curl $url --insecure | haklistgen | anew wordlist.txt; done cat subdomains.txt urls.txt endpoints.txt | haklistgen | anew wordlist.txt;"
                echo "----------------------------------------------------------------"
		echo ""
	elif [ $recon -eq 2 ];
	then
		echo "Using x8 to Hidden parameters discovery"
                echo "----------------------------------------------------------------"
		echo "assetfinder domain | httpx -silent | sed -s 's/$/\//' | xargs -I@ sh -c 'x8 -u @ -w params.txt -o enumerate'"
                echo "----------------------------------------------------------------"		
		echo ""
	elif [ $recon -eq 3 ];
	then
                echo "----------------------------------------------------------------"
		echo "Search .json gospider filter anti-burl"
		echo "gospider -s https://twitch.tv --js | grep -E '\.js(?:onp?)?$' | awk '{print $4}' | tr -d '[]' | anew | anti-burl"
                echo "----------------------------------------------------------------"
		echo ""
	elif [ $recon -eq 4 ];
	then
                echo "----------------------------------------------------------------"
		echo "Search .json subdomain"
		echo "assetfinder http://tesla.com | waybackurls | grep -E '\.json(?:onp?)?$' | anew"
                echo "----------------------------------------------------------------"
		echo ""
	elif [ $recon -eq 5 ];
	then
		echo "Axiom recon"
                echo "----------------------------------------------------------------"
		echo "findomain -t domain -q -u url ; axiom-scan url -m subfinder -o subs --threads 3 ; axiom-scan subs -m httpx -o http ; axiom-scan http -m ffuf --threads 15 -o ffuf-output ; cat ffuf-output | tr "," " " | awk '{print $2}' | fff | grep 200 | sort -u"
                echo "----------------------------------------------------------------"
		echo ""
	elif [ $recon -eq 6 ];
	then
                echo "----------------------------------------------------------------"
		echo "Search .js using"
		echo "assetfinder -subs-only DOMAIN -silent | httpx -timeout 3 -threads 300 --follow-redirects -silent | xargs -I% -P10 sh -c 'hakrawler -plain -linkfinder -depth 5 -url %' | awk '{print $3}' | grep -E '\.js(?:onp?)?$' | anew"
                echo "----------------------------------------------------------------"		
		echo ""
	elif [ $recon -eq 7 ];
	then
		echo "Download all domains to bounty chaos"
                echo "----------------------------------------------------------------"
		echo "curl https://chaos-data.projectdiscovery.io/index.json | jq -M '.[] | .URL | @sh' | xargs -I@ sh -c 'wget @ -q'; mkdir bounty ; unzip '*.zip' -d bounty/ ; rm -rf *zip ; cat bounty/*.txt >> allbounty ; sort -u allbounty >> domainsBOUNTY ; rm -rf allbounty bounty/ ; echo '@OFJAAAH'"
                echo "----------------------------------------------------------------"
		echo ""
	elif [ $recon -eq 8 ];
	then
		echo "Search subdomains in cert.sh"
                echo "----------------------------------------------------------------"
		echo "'curl -s "https://crt.sh/?q=%25.att.com&output=json" | jq -r '.[].name_value' | sed 's/\*\.//g' | httpx -title -silent | anew'"
                echo "----------------------------------------------------------------"
		echo ""
	elif [ $recon -eq 9 ];
	then
		echo "Chaos to search subdomains check cloudflareip scan port"
                echo "----------------------------------------------------------------"
		echo "chaos -silent -d paypal.com | filter-resolved | cf-check | anew | naabu -rate 60000 -silent -verify | httpx -title -silent"
                echo "----------------------------------------------------------------"
		echo ""
	elif [ $recon -eq 10 ];
	then
		echo "Search to files using assetfinder and ffuf"
                echo "----------------------------------------------------------------"
		echo "'assetfinder att.com | sed 's#*.# #g' | httpx -silent -threads 10 | xargs -I@ sh -c 'ffuf -w path.txt -u @/FUZZ -mc 200 -H 'Content-Type: application/json' -t 150 -H 'X-Forwarded-For:127.0.0.1'"
                echo "----------------------------------------------------------------"
		echo ""
	else
		echo "Finish"
	fi
elif [ $option -eq 4 ];
then
	echo ""
	echo "Credits: https://github.com/KingOfBugbounty/KingOfBugBountyTips"
	echo ""
fi
done
