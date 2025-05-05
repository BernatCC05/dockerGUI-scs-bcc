# Docker GUI amb XFCE, VNC, VS Code, Python i SSH

## Autors

Sergio Cabello i Bernat Carol

## Descripció

Aquest projecte crea una imatge Docker basada en Ubuntu 24.04 que inclou:

* Entorn d'escriptori XFCE
* Servidor VNC per a accés remot a l'entorn gràfic
* Visual Studio Code
* Python
* Servidor SSH

Aquesta configuració permet iniciar un contenidor amb interfície gràfica, connectar-s'hi via VNC i desenvolupar aplicacions Python amb Visual Studio Code dins el contenidor.

## Com construir i executar el contenidor

1. Assegura't que tens Docker instal·lat.

2. Executa l'script `run.sh`:

```bash
./run.sh
```

Això farà el següent:

* Construirà la imatge Docker (nom: `dockerGUI-scs-bcc`) si no existeix.
* Aturarà i eliminarà el contenidor (nom: `container-dockerGUI-scs-bcc`) si ja existia.
* Crearà i arrencarà un nou contenidor amb els ports redirigits.

## Connexió al contenidor

* **VNC**: Connecta't amb el client Remmina (o altre client VNC) a:

  ```
  localhost:5901
  ```

  (Assegura't que has fet el redireccionament de ports a VirtualBox si cal)

* **SSH**: Connecta't al contenidor amb:

  ```bash
  ssh vncuser@localhost -p 2200
  ```

## Ports exposats

| Servei | Port contenidor | Port host |
| ------ | --------------- | --------- |
| VNC    | 5901            | 5901      |
| SSH    | 22              | 2200      |

## Notes

* L'execució de Visual Studio Code dins l'entorn gràfic funciona amb l'ordre:

```bash
code --no-sandbox &
```


> Mòdul M09 - UF2 — Activitat Docker GUI (Avaluació)
