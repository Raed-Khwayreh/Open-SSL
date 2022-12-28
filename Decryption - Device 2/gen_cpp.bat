@echo off
openssl req -newkey rsa:2048 -nodes -keyout task3/%1PrivateKey.pem -x509 -days 365 -out task3/%1Certificate.pem
openssl x509 -pubkey -noout -in task3/%1Certificate.pem  > task3/%1PublicKey.pem
start notepad task3/%1PrivateKey.pem
start notepad task3/%1PublicKey.pem
start notepad task3/%1Certificate.pem 
 