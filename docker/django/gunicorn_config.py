import multiprocessing

from uvicorn.workers import UvicornWorker

bind = '0.0.0.0:8000'
workers = multiprocessing.cpu_count() * 2 + 1
worker_class = UvicornWorker

max_requests = 2000
max_requests_jitter = 400

log_file = '-'
chdir = '/code'
worker_tmp_dir = '/dev/shm'
