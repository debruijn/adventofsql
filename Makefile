DAY=00
YEAR=2024

create_year_folder:
	mkdir ${YEAR}

create_day_folder:
	mkdir ${YEAR}/${DAY}
	mkdir ${YEAR}/${DAY}/src

clear_day:
	rm -r ${YEAR}/${DAY}/

create_day: create_day_folder
	cp -r template/src/* ${YEAR}/${DAY}/src/
	cp template/Cargo.lock ${YEAR}/${DAY}/
	cp template/Cargo.toml ${YEAR}/${DAY}/
	cp template/main.py ${YEAR}/${DAY}/
	cp template/main.sql ${YEAR}/${DAY}/
	cp template/Makefile ${YEAR}/${DAY}/
	sed -i 's/yyyy_dd/${YEAR}_${DAY}/g' ${YEAR}/${DAY}/Cargo.toml

create_aos_db:
	createdb adventofsql

create_venv:
	python3 -m venv .venv

activate_venv:  # Use as utility in other makefile commands - by itself, it's useless
	. .venv/bin/activate

install_psycopg: activate_venv
	.venv/bin/pip3 install psycopg[binary]