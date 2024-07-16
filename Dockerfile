FROM python:3.9-slim-bullseye

COPY install.sh /install.sh

RUN /install.sh

COPY app /app
RUN python /app/setup.py install

EXPOSE 80/tcp

LABEL version="1.0.1"
# TODO: Add a Volume for persistence across boots
LABEL permissions='\
  {\
  "ExposedPorts": {\
  "80/tcp": {}\
  },\
  "HostConfig": {\
  "Privileged": true,\
  "Binds":["/root/.config:/root/.config"],\
  "PortBindings": {\
  "80/tcp": [\
  {\
  "HostPort": ""\
  }\
  ]\
  }\
  }\
  }'
LABEL authors='[\
  {\
  "name": "J Wenger",\
  "email": "jwenger@mit.edu"\
  }\
  ]'
LABEL company='{\
  "about": "",\
  "name": "MIT",\
  "email": "jwenger@mit.edu"\
  }'
LABEL type="example"
LABEL tags='[\
  "interaction"\
  ]'
LABEL readme='https://raw.githubusercontent.com/jerWenger/blue-gpio-testing/tree/master/Readme.md'
LABEL links='{\
  "website": "https://github.com/jerWenger/blue-gpio-testing/tree/master",\
  }'
LABEL requirements="core >= 1.1"

ENTRYPOINT ["/bin/sh", "-c", "pigpiod && cd /app && GPIOZERO_PIN_FACTORY=pigpio python main.py"]
