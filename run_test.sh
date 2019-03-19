docker run -it --rm --runtime nvidia -v `pwd`:`pwd` -w `pwd` hassanmohsin/dl-docker:gpu python benchmark.py gpu 10000
