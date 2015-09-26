proc_name = "gunicorn"
#bind = 'unix:/tmp/{0}.sock'.format(proc_name)
bind = "127.0.0.1:8080"
backlog = 2048
workers = 1
worker_class = 'sync'
worker_connections = 1000
timeout = 30
keepalive = 2

daemon = True
errorlog = '/var/log/gunicorn/error.log'
