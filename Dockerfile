FROM python:3.6
ENV PYTHONUNBUFFERED 1

# Install sudo and apt-transport-https
RUN apt-get update
RUN apt-get install git libsasl2-dev python-dev libldap2-dev libssl-dev -y
RUN apt-get install apt-transport-https sudo supervisor -y
RUN apt-get install xvfb libfontconfig wkhtmltopdf node-less -y

# Create User docker
RUN useradd -ms /bin/bash odoo
RUN echo "odoo ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# create env valies
ENV PROJECT_DIR /home/odoo/public
ENV PROJECT_CUSTOM_ADDONS_DIR /home/odoo/public/custom_addons
ENV PROJECT_LOG_DIR /home/odoo/logs
ENV REQUIREMENTS_DIR /home/odoo/public/requirements.txt

# Clone odoo
RUN git clone --single-branch -b 11.0 --depth 3 https://github.com/odoo/odoo.git $PROJECT_DIR

# Create Folders
RUN mkdir $PROJECT_LOG_DIR
RUN mkdir $PROJECT_CUSTOM_ADDONS_DIR

# Change owner and group
RUN chown -R odoo:odoo $PROJECT_DIR
RUN chown -R odoo:odoo $PROJECT_LOG_DIR

# Install requeriments
RUN pip install -r $REQUIREMENTS_DIR

# Init Project
WORKDIR $PROJECT_DIR
USER odoo
