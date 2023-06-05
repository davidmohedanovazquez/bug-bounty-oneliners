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
