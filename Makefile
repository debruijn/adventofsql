DAY=22
YEAR=2024

create_year_folder:
	mkdir ${YEAR}

create_day_folder:
	mkdir ${YEAR}/${DAY}

clear_day:
	rm -r ${YEAR}/${DAY}/

create_day: create_day_folder
	cp template/main.sql ${YEAR}/${DAY}/

create_aos_db:
	createdb adventofsql

create_venv:
	python3 -m venv .venv

activate_venv:  # Use as utility in other makefile commands - by itself, it's useless
	. .venv/bin/activate

install_psycopg: activate_venv
	.venv/bin/pip3 install psycopg[binary]

run_py:
	.venv/bin/python3 main.py

run_rs:
	cargo run

run_both: run_py run_rs