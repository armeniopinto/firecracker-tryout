import logging
logging.getLogger("werkzeug").disabled = True

import flask.cli
flask.cli.show_server_banner = lambda *args: None

from flask import Flask, request

app = Flask(__name__)
app.logger.dsabled = True

hellos = ['\N{wavy dash}'] * 32
#hellos = ['\N{cross mark}'] * 32

@app.route("/hello")
def hello():
    vmm_id = int(request.remote_addr.split(".")[2])
    #hellos[vmm_id] = '\N{grinning face}'
    hellos[vmm_id] = '\N{fire}'
    print(''.join(hellos))
    return "", 200
