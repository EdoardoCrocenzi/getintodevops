# Utilizza un'immagine base con vulnerabilità note
FROM python:3.7-slim

# Installazione di pacchetti senza aggiornare prima l'indice (errore di best practice)
RUN apt-get install -y git wget

# Non specifica un utente non privilegiato (tutto viene eseguito come root)
RUN mkdir /app
WORKDIR /app

# Copia di file sensibili non necessari nell'immagine
COPY ./secret_keys.txt /app/

# Esecuzione di una versione di Flask vulnerabile
RUN pip install flask==0.12

# Non vengono eseguite ottimizzazioni per ridurre le dimensioni dell'immagine
RUN apt-get install -y \
    gcc

# Comando CMD poco chiaro e non ottimizzato
CMD python app.py
