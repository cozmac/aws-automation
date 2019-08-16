#!/bin/bash
ssh -o "StrictHostKeyChecking no" ec2-user@$1 'sudo -S cat /etc/httpd/logs/access_log' > /tmp/test
ssh -o "StrictHostKeyChecking no" ec2-user@$1 'sudo sh -c "cat /dev/null > /etc/httpd/logs/access_log"'

ssh -o "StrictHostKeyChecking no" ec2-user@$2 'sudo -S cat /etc/httpd/logs/access_log' >> /tmp/test
ssh -o "StrictHostKeyChecking no" ec2-user@$2 'sudo sh -c "cat /dev/null > /etc/httpd/logs/access_log"'

ssh -o "StrictHostKeyChecking no" ec2-user@$3 'sudo -S cat /etc/httpd/logs/access_log' >> /tmp/test
ssh -o "StrictHostKeyChecking no" ec2-user@$3 'sudo sh -c "cat /dev/null > /etc/httpd/logs/access_log"'


sleep 5
ip=($(awk -F ' '  '{print $1}' /tmp/test))
time=($(awk -F ' '  '{print substr($2, 2)}' /tmp/test))
accessPoint=($(awk -F ' ' '{print $4$5$6$7$8$9$10$11$12$13$14$15$16$17$18$19$20$21$22$23$24$25$26$27$28$29$30}' /tmp/test))

for((i=0;i<${#ip[@]};i++))
do
  /usr/local/bin/aws dynamodb put-item \
--table-name HTTP  \
--item \
    '{"IP": {"S": "'${ip[i]}'"}, "TIME": {"S": "'${time[i]}'"}, "AccessPoint": {"S": '${accessPoint[i]}'}}' \
--return-consumed-capacity TOTAL
  echo ${accessPoint[i]}
done
