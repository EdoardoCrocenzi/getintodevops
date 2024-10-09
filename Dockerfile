# Utilizza una versione di base obsoleta
FROM ubuntu:16.04

# Non specifica l'utente, esegue i comandi come root
RUN apt-get update && apt-get install -y \
    curl \
    vim \
    python3-pip

# Espone una porta senza specificare chiaramente l'uso (rischi di sicurezza)
EXPOSE 8080

# Copia un file da una directory errata (errore di percorso)
COPY ./non_esistente/file.py /app/

# Installa una dipendenza direttamente senza hash per la verifica dell'integrità
RUN pip3 install flask==1.0.2

# Non esegue cleanup dei pacchetti temporanei per ridurre la dimensione dell'immagine
RUN apt-get update && apt-get install -y build-essential

# Non imposta variabili d'ambiente critiche
ENV APP_ENV=development

# Comando ENTRYPOINT mancante
CMD ["python3", "/app/app.py"]
