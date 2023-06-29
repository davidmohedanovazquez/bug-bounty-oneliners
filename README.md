# bug-bounty-oneliners
One-line commands to bug bounty

## Commands

- Command that (to be executed **once a week** -more or less-):
  - looks for subdomains from a list of domains.
  - look for those that are active and have a web available
  - for those that are new (that have not been previously scanned) run nuclei
  - notify using the service you have configured

```bash
today=$(date '+%Y-%m-%d'); cat domains.txt | subfinder --silent | tee subdomains_$today.txt | httpx --silent | anew active_subdomains.txt | nuclei -silent -exclude-severity info,low | tee nuclei_$today.txt | notify
```

<br>

- Command that (to be executed **once a month** -more or less-):
  -  read subdomains from file (you can also do a subdomain discovery as before)
  - look for those that are active and have a web available (saving all the information)
  - check those that have a change in any of their fields
  - check if the size has changed by more than a certain size (using the `check_changed.sh` script)
  - run nuclei on those that have been modified
  - notify using the service you have configured
 
```bash
today=$(date '+%Y-%m-%d'); cat subdomains.txt | httpx -follow-redirects -json -silent | tee active_subdomains_$today.json | jq -r '[.url,.content_length,.title,.host,.status_code] | @csv' | tee urls_modified_raw_$today.csv | anew -d urls_modified_raw_old.csv | cut -d',' -f1 | sed 's/"//g' | ./program active_subdomains_clean_$today.csv active_subdomains_clean_old.csv | tee urls_modified_clean_$today.txt | nuclei -silent -exclude-severity info,low | tee nuclei_urls_modified_$today.txt | notify; cp urls_modified_raw_{$today,old}.csv
```
