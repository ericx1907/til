cron is a daemon to excute scheduled commands

To add scheduled jobs, type `crontab -e` and it will create a user crontab file and open a selected editor to edit the file. The file will be created at /var/spool/cron/crontabs/<user>

A example crontab file:
```cron
# This will excute command or script every 1 minute and redirect its stdout and stderr to the same file
*/1 * * * * * command/script >> path/to/file 2>&1
```
Example of job definition:

<pre>
.---------------- minute (0 - 59)  
|  .------------- hour (0 - 23)  
|  |  .---------- day of month (1 - 31)  
|  |  |  .------- month (1 - 12) OR jan,feb,mar,apr ...  
|  |  |  |  .---- day of week (0 - 6) (Sunday=0 or 7)  
|  |  |  |  |  
*  *  *  *  *     command to be executed  
</pre>

By default, cron will email the output of excuted command/script to your email using a MTA (Mail Transfer Agent) if you do not redirect its output to a file/log like the does in example. If your system does have a MTA pre-installed (e.g. Ubuntu) it will create a warning message in /var/log/syslog about no MTA. One can suppress this warning by add `MAILTO=''` on the first line of crontab.

If one does want cron to email the output then:
```bash
sudo apt install postfix
```
And follow the post-installation setup to setup your email. If you choose 'Local' then cron will write the output to `/var/mail/<user>`


