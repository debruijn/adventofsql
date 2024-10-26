DAY=1
YEAR=2024

create_day_folder:
	mkdir ${YEAR}
	mkdir ${YEAR}/${DAY}

create_day: create_day_folder
	# TODO: copy everything in template folder
	# TODO: use sed to replace strings to use year/day - if needed in final version

create_aos_db:
	createdb adventofsql  # TODO: for this day? add to create_day?

create_venv:
	python3 -m venv .venv

activate_venv:  # Use as utility in other makefile commands - by itself, it's useless
	. .venv/bin/activate

install_psycopg: activate_venv
	.venv/bin/pip3 install psycopg[binary]