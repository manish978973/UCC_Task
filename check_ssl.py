import  OpenSSL
import ssl, socket
import argparse

#Fetching argument
parser = argparse.ArgumentParser()
parser.add_argument("server")
args = parser.parse_args()
server = args.server


#small validation by obtaining the domain name
connection = server.split('://')
if len(connection)>1:
    fin = connection[1]
else:
    fin = connection[0]

#fetching certificate of the domain
port=443

cert_file = ssl.get_server_certificate((fin, port))
x509 = OpenSSL.crypto.load_certificate(OpenSSL.crypto.FILETYPE_PEM, cert_file)
certificateinfo = x509.get_notAfter()

expiry_date = str(certificateinfo[6:8]) + "." + str(certificateinfo[4:6]) + "." + str(certificateinfo[:4])

print("Expiry_date:" + expiry_date)
