if [ `id -u` -ne 0 ]; then
    echo "You need root privileges to run this script(try sudo)"
    exit 1
fi
if [ `/usr/lib/jvm/java-1.8.0-openjdk-amd64/bin/jps |  grep "NameNode" | wc -l` -gt 0 ] ; then  
    echo "Hadoop Already running."
    exit 0
fi
echo "\n" | ssh-keygen -q -t rsa -P "" -f /root/.ssh/id_rsa
cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys
echo "StrictHostKeyChecking=no" >> /etc/ssh/ssh_config
echo 'Defaults        secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin:/opt/mdp/hbase-2.0.0/bin:/opt/mdp/hadoop-2.7.6/sbin:/opt/mdp/hadoop-2.7.6/bin:/opt/mdp/pig-0.16.0/bin:/opt/mdp/apache-hive-2.1.0-bin/bin"' > /etc/sudoers.d/exconf
echo 'Defaults env_keep += "JAVA_HOME"' >> /etc/sudoers.d/exconf
service ssh restart

hdfs namenode -format
sudo start-dfs.sh 
sudo start-yarn.sh 
hdfs dfs -mkdir -p /user/hive/warehouse
hdfs dfs -mkdir /tmp
hdfs dfs -chmod g+w /user/hive/warehouse
hdfs dfs -chmod g+w /tmp

echo done
