#!/bin/bash

## Se non viene passata una cartella con i file necessari:
if [ ! -f /config/amule.conf ]; then
  ## Si creano le tre cartelle richieste 
  mkdir /config
  mkdir /incomplete
  mkdir /finished

  ## Si prendono i file base dalla cartella setup e si mettono:
  ##   - direi per ora solo la amule.conf, con i parametri default
  ##   - punta alle cartelle /config per i file di configurazione
  ##   - punta alla cartella /finished per i download
  ##   - punta alla cartella /incomplete per i file temporanei
  ##   - password amule per le connessioni rpc e rpc abilitato (per mettere le passord hashate serve echo -n yourpasswordhere | md5sum | cut -d ' ' -f 1)
  ##   - amuleweb disabilitato per ora - se lo vogliamo servirà anche mettere un altro file di config
  ##   - porte standard esportate nel dockerfile -> 4712 per RPC, 4662 porta ingresso TCP, 4672 porta ingresso KAD, 4665 seconda porta UDP in ingresso - se abilitiamo amuleweb serve anche la 4711
  ##	[UPDATE] si aggiunge anche il file adunanza.conf con i fix per i problemi sull'aggiornamento dei file dei nodi KAD
  ## Metto una cartella config dentro alla tua cartella setup, in questo modo bisogna far girare solo 
  cp /setup/config/amule.conf.default /config/amule.conf
  cp /setup/config/adunanza.conf /config/adunanza.conf
  cp /setup/config/server.met /config/server.met
  cp /setup/config/nodes.dat /config/nodes.dat
fi

## A quel punto lanciamo il demone in foreground con le flag
##	-o per l'output in console
##	-c per fargli leggere la conf da /config
/usr/bin/amuled -o -c /config
